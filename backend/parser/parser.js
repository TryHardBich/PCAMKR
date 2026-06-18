import { parse } from 'node-html-parser';
import puppeteer from 'puppeteer';
import { db } from '../db.js';
import { keywordsMap } from './keywordsMap.js';
import { booleanMap } from './booleanMap.js';
import cron from 'node-cron';

const BASE_URL = 'https://www.citilink.ru';

const CPU_URL = 'https://www.citilink.ru/catalog/processory?p=';
const GPU_URL = 'https://www.citilink.ru/catalog/videokarty?p=';
const RAM_URL = 'https://www.citilink.ru/catalog/moduli-pamyati?p=';
const MOTHERBOARD_URL = 'https://www.citilink.ru/catalog/materinskie-platy?p=';
const SSD_URL = 'https://www.citilink.ru/catalog/ssd-nakopiteli?p=';
const HDD_URL = 'https://www.citilink.ru/catalog/zhestkie-diski?p=';
const PSU_URL = 'https://www.citilink.ru/catalog/bloki-pitaniya?p=';
const COOLERS_URL =
  'https://www.citilink.ru/catalog/sistemy-ohlazhdeniya-kompyutera?p=';
const CASES_URL = 'https://www.citilink.ru/catalog/korpusa?p=';

const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const waitForLoad = async (page, selector) => {
  /* global document */  // <-- Только один раз в начале функции
  try {
    await page.waitForFunction(
      (sel) => {
        const skeletonCount = document.querySelectorAll('.react-loading-skeleton').length;
        if (skeletonCount < 2) {
          if (sel) {
            return document.querySelectorAll(sel).length > 0;
          }
          return true;
        }
        return false;
      },
      { timeout: 15000 },
      selector,
    );
  } catch (error) {
    console.warn('Wait for load timeout or error:', error.message);
    return false;
  }

  // Больше не нужно писать /* global document */ здесь
  const linksCount = await page.evaluate(() => {
    return document.querySelectorAll('a[href*="/product/"]').length;
  });

  const LINKS_ON_LAST_PAGE = 32;
  const isLastPage = !(linksCount >= LINKS_ON_LAST_PAGE);
  return !isLastPage;
};



const parsePipeline = async (pageNumber, pages) => {
  console.log('Parsing page ${pageNumber}...');
  
  await Promise.all([
    pages.cpu.page.goto(CPU_URL + pageNumber),
    pages.gpu.page.goto(GPU_URL + pageNumber),
    pages.ram.page.goto(RAM_URL + pageNumber),
    pages.motherboard.page.goto(MOTHERBOARD_URL + pageNumber),
    pages.ssd.page.goto(SSD_URL + pageNumber),
    pages.hdd.page.goto(HDD_URL + pageNumber),
    pages.psu.page.goto(PSU_URL + pageNumber),
    pages.coolers.page.goto(COOLERS_URL + pageNumber),
    pages.cases.page.goto(CASES_URL + pageNumber),
  ]);

  const checks = await Promise.all([
    waitForLoad(pages.cpu.page),
    waitForLoad(pages.gpu.page),
    waitForLoad(pages.ram.page),
    waitForLoad(pages.motherboard.page),
    waitForLoad(pages.ssd.page),
    waitForLoad(pages.hdd.page),
    waitForLoad(pages.psu.page),
    waitForLoad(pages.coolers.page),
    waitForLoad(pages.cases.page),
  ]);

  if (!checks.some((c) => c)) {
    console.warn('Page does not exist or failed to load.');
    return false;
  }

  for (let j = 0; j < pages.list.length; j++) {
    const currentPageObj = pages.list[j];
    const html = await currentPageObj.page.content();
    const root = parse(html, {
      blockTextElements: {
        script: false,
        noscript: true,
        style: false,
        pre: true,
      },
      fixNestedATags: false,
      parseNoneClosedTags: true,
      preserveTagNesting: true,
      voidTag: { closingSlash: true },
    });

    const partElements = root.querySelectorAll('[class*="SnippetProduct"]');
    const itemPage = await pages.browser.newPage();

    for (let k = 0; k < partElements.length; k++) {
      await delay(Math.random() * 3 * 1000);
      
      const titleEl = partElements[k].querySelector('a[href*="/product/"]');
      const priceEl = partElements[k].querySelector('[class*="MainPrice"]');
      
      if (!titleEl || !priceEl) continue;

      const href = titleEl._attrs.href;
      const itemPageUrl = BASE_URL + href + 'properties';
      
      try {
        await itemPage.goto(itemPageUrl, { waitUntil: 'networkidle0', timeout: 30000 });
        await waitForLoad(itemPage, '[class*="PropertiesItem-components"]');
        
        const itemHtml = await itemPage.content();
        const itemRoot = parse(itemHtml, {
          blockTextElements: { script: false, noscript: true, style: false, pre: true },
          fixNestedATags: false,
          parseNoneClosedTags: true,
          preserveTagNesting: true,
          voidTag: { closingSlash: true },
        });

        const properties = itemRoot.querySelectorAll('[class*="PropertiesItem-components"]');
        const img = itemRoot.querySelector('[src*="width:400/height:400"]');
        const imgUrl = img?._attrs?.src;

        const columns = [];
        const values = [];

        properties.forEach((propertyContainer) => {
          const propertyNameEl = propertyContainer.querySelector('[class*="PropertiesName"]');
          const valueContainer = propertyContainer.querySelector('[class*="PropertiesValue"]');
          const rawValue = valueContainer?.children?.text;
          const rawName = propertyNameEl?.innerText?.toLowerCase().trim();

          if (!rawName || !rawValue) return;

          const mapEntry = keywordsMap[rawName];
          if (!mapEntry) return;

          let formattedValue = rawValue.trim();
          
          columns.push(mapEntry.column);

          switch (mapEntry.type) {
            case 'integer': {
              const tmpArray = formattedValue.split(' ');
              formattedValue = tmpArray.join('');
              formattedValue = parseInt(formattedValue, 10);
              if (isNaN(formattedValue)) formattedValue = null;
              values.push(formattedValue);
              break;
            }
            case 'boolean': {
              formattedValue = booleanMap[formattedValue] ?? null;
              values.push(formattedValue);
              break;
            }
            case 'textArray': {
              formattedValue = formattedValue.split(', ');
              values.push(JSON.stringify(formattedValue)); // Сохраняем как JSON строку
              break;
            }
            case 'numeric': {
              const tmp = formattedValue.split(' ');
              formattedValue = tmp.join('');
              formattedValue = parseInt(formattedValue, 10);
              if (isNaN(formattedValue)) formattedValue = null;
              values.push(formattedValue);
              break;
            }
            case 'text': {
              values.push(formattedValue);
              break;
            }
            default: {
              values.push(formattedValue);
            }
          }
        });

        if (titleEl._attrs?.title) {
          columns.push('name');
          values.push(titleEl._attrs.title);
        }

        const priceText = priceEl.textContent;
        const formattedPrice = priceText
          ?.split('₽')
          ?.replace(/\s+/g, '') // Удаляем все пробелы
          ?.trim();

        if (formattedPrice) {
          const priceNum = parseInt(formattedPrice, 10);
          if (!isNaN(priceNum)) {
            columns.push('price');
            values.push(priceNum);
          }
        }

        if (imgUrl) {
          columns.push('img_url');
          values.push(imgUrl);
        }

        if (columns.length > 0 && values.length > 0) {
          const placeholders = values.map((_, i) => `$${i + 1}`).join(', ');
          const columnNames = columns.join(', ');
          
          await db.query(
            `INSERT INTO ${currentPageObj.pageTitle} (${columnNames}) VALUES (\${placeholders}) ON CONFLICT (name) DO UPDATE SET price = EXCLUDED.price`,
            values,
          ).catch((err) => {
            console.error('DB Error for ${titleEl._attrs.title}:', err.message);
          });
        }
      } catch (err) {
        console.error('Error processing item ${itemPageUrl}:', err.message);
      } finally {
        // Не закрываем itemPage здесь, чтобы не спамить созданием страниц, 
        // но в продакшене лучше закрывать или использовать пул страниц.
        // Для простоты оставим сборщику мусора, либо можно раскомментировать:
        // await itemPage.close(); 
      }
    }
  }
  return true;
};

const startParser = async () => {
  let browser;
  let isRunning = false;

  try {
    browser = await puppeteer.launch({
      headless: 'new', // Явное указание нового режима headless
      args: ['--no-sandbox', '--disable-setuid-sandbox'],
    });

    const cpuPage = await browser.newPage();
    const gpuPage = await browser.newPage();
    const ramPage = await browser.newPage();
    const motherboardPage = await browser.newPage();
    const ssdPage = await browser.newPage();
    const hddPage = await browser.newPage();
    const psuPage = await browser.newPage();
    const coolersPage = await browser.newPage();
    const casesPage = await browser.newPage();

    const pages = {
      cpu: { pageTitle: 'cpus', page: cpuPage },
      gpu: { pageTitle: 'gpus', page: gpuPage },
      ram: { pageTitle: 'rams', page: ramPage },
      motherboard: { pageTitle: 'motherboards', page: motherboardPage },
      ssd: { pageTitle: 'storages', page: ssdPage },
      hdd: { pageTitle: 'storages', page: hddPage },
      psu: { pageTitle: 'psus', page: psuPage },
      coolers: { pageTitle: 'coolers', page: coolersPage },
      cases: { pageTitle: 'cases', page: casesPage },
      list: [
        { pageTitle: 'cpus', page: cpuPage },
        { pageTitle: 'gpus', page: gpuPage },
        { pageTitle: 'rams', page: ramPage },
        { pageTitle: 'motherboards', page: motherboardPage },
        { pageTitle: 'storages', page: ssdPage },
        { pageTitle: 'storages', page: hddPage },
        { pageTitle: 'psus', page: psuPage },
        { pageTitle: 'coolers', page: coolersPage },
        { pageTitle: 'cases', page: casesPage },
      ],
      browser,
    };

    // Ручной запуск (для тестов)
    let i = 1;
    isRunning = true;
    try {
      while (true) {
        const result = await parsePipeline(i, pages);
        if (!result) {
          console.log('Stopped parsing: no more pages or error.');
          break;
        }
        i++;
      }
    } catch (e) {
      console.error('Manual run error:', e);
    } finally {
      isRunning = false;
    }

    // Cron запуск (каждые 2 часа)
    cron.schedule('0 0 */2 * * *', async () => {
      if (isRunning) {
        console.log('Process already running, skipping cron job.');
        return;
      }
      isRunning = true;
      let cronI = 1;
      try {
        while (true) {
          const result = await parsePipeline(cronI, pages);
          if (!result) {
            console.log('Cron stopped parsing.');
            break;
          }
          cronI++;
        }
      } catch (e) {
        console.error('Cron job error:', e);
      } finally {
        isRunning = false;
      }
    });

  } catch (error) {
    console.error('Failed to start parser:', error);
  } finally {
    // Важно: не закрываем браузер сразу, если хотим, чтобы cron работал.
    // В реальном приложении лучше управлять жизненным циклом иначе.
    // process.on('SIGINT', () => browser?.close());
  }
};

// Экспортируем функцию, чтобы можно было вызвать из server.js
export { startParser };
