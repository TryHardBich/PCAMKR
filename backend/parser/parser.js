import { parse } from "node-html-parser";

import * as puppeteer from "puppeteer";

import { db } from "../db.js";

import { keywordsMap } from "./keywordsMap.js";

import { booleanMap } from "./booleanMap.js";

import cron from "node-cron";

const MIN_LINKS_ON_LOADED_PAGE = 30;

const LINKS_ON_LAST_PAGE = 32;

const BASE_URL = "https://www.citilink.ru";

const CPU_URL = "https://www.citilink.ru/catalog/processory?p=";
const GPU_URL = "https://www.citilink.ru/catalog/videokarty?p=";
const RAM_URL = "https://www.citilink.ru/catalog/moduli-pamyati?p=";
const MOTHERBOARD_URL = "https://www.citilink.ru/catalog/materinskie-platy?p=";
const SSD_URL = "https://www.citilink.ru/catalog/ssd-nakopiteli?p=";
const HDD_URL = "https://www.citilink.ru/catalog/zhestkie-diski?p=";
const PSU_URL = "https://www.citilink.ru/catalog/bloki-pitaniya?p=";
const COOLERS_URL =
  "https://www.citilink.ru/catalog/sistemy-ohlazhdeniya-kompyutera?p=";
const CASES_URL = "https://www.citilink.ru/catalog/korpusa?p=";

const browser = await puppeteer.launch();

const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const waitForLoad = async (page, selector) => {
  try {
    await page.waitForFunction(
      (sel) => {
        if (sel) {
          return (
            document.querySelectorAll(".react-loading-skeleton").length < 2 &&
            document.querySelectorAll(sel).length > 0
          );
        } else {
          return (
            document.querySelectorAll(".react-loading-skeleton").length < 2
          );
        }
      },
      { timeout: 10000 },
      selector,
    );
  } catch (error) {
    console.log(await page.content());
    console.log("time limit exceeded for: \n", page);
  }

  const linksCount = await page.evaluate(() => {
    return document.querySelectorAll('a[href*="/product/"]').length;
  });
  console.log(linksCount);

  const isLastPage = !(linksCount >= LINKS_ON_LAST_PAGE);

  return !isLastPage;
};

const parsePipeline = async (pageNumber) => {
  console.log(CPU_URL + pageNumber);
  await Promise.all([
    cpuPage.goto(CPU_URL + pageNumber),

    gpuPage.goto(GPU_URL + pageNumber),

    ramPage.goto(RAM_URL + pageNumber),

    motherboardPage.goto(MOTHERBOARD_URL + pageNumber),

    ssdPage.goto(SSD_URL + pageNumber),

    hddPage.goto(HDD_URL + pageNumber),

    psuPage.goto(PSU_URL + pageNumber),

    coolersPage.goto(COOLERS_URL + pageNumber),

    casesPage.goto(CASES_URL + pageNumber),
  ]);
  const cpuLoaded = await waitForLoad(cpuFullPage.page);

  const gpuLoaded = await waitForLoad(gpuFullPage.page);

  const ramLoaded = await waitForLoad(ramFullPage.page);

  const motherboardLoaded = await waitForLoad(motherboardFullPage.page);

  const ssdLoaded = await waitForLoad(ssdFullPage.page);

  const hddLoaded = await waitForLoad(hddFullPage.page);

  const psuLoaded = await waitForLoad(psuFullPage.page);

  const coolersLoaded = await waitForLoad(coolersFullPage.page);

  if (
    !cpuLoaded &&
    !gpuLoaded &&
    !ramLoaded &&
    !motherboardLoaded &&
    !ssdLoaded &&
    !hddLoaded &&
    !psuLoaded &&
    !coolersLoaded
  ) {
    console.warn(
      "page does not exist, it might be due to exceeding max count of pages on site",
    );
    return false;
  }

  for (var j = 0; j < pages.length; j++) {
    {
      const html = await pages[j].page.content();
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
        voidTag: {
          closingSlash: true,
        },
      });
      const partElements = root.querySelectorAll('[class*="SnippetProduct"]');
      const itemPage = await browser.newPage();

      for (var k = 0; k < partElements.length; k++) {
        await delay(Math.random() * 3 * 1000);
        const title = partElements[k].querySelector('a[href*="/product/"]');
        const price = partElements[k].querySelector('[class*="MainPrice"]');
        const href = title._attrs.href;
        const itemPageUrl = BASE_URL + href + "properties";
        console.log(itemPageUrl);

        await itemPage.goto(itemPageUrl);

        const itemPageLoaded = await waitForLoad(
          itemPage,
          '[class*="PropertiesItem-components"]',
        );

        const itemHtml = await itemPage.content();

        const itemRoot = parse(itemHtml, {
          blockTextElements: {
            script: false,
            noscript: true,
            style: false,
            pre: true,
          },
          fixNestedATags: false,
          parseNoneClosedTags: true,
          preserveTagNesting: true,
          voidTag: {
            closingSlash: true,
          },
        });

        const properties = itemRoot.querySelectorAll(
          '[class*="PropertiesItem-components"]',
        );

        const img = itemRoot.querySelector('[src*="width:400/height:400"]');

        const img_url = img?._attrs?.src;

        console.log(img_url, img);

        console.log("pr", properties.length);

        const columns = [];
        const values = [];

        properties.forEach((propertyContainer) => {
          const property = propertyContainer.querySelector(
            '[class*="PropertiesName"]',
          );
          const valueContainer = propertyContainer.querySelector(
            `[class*=PropertiesValue]`,
          );

          const value = valueContainer?.children[0]?.text;

          if (keywordsMap[property?.innerText?.toLowerCase().trim()]) {
            var formattedValue = value.trim();
            columns.push(
              keywordsMap[property?.innerText?.toLowerCase().trim()].column,
            );
            switch (
              keywordsMap[property?.innerText?.toLowerCase().trim()].type
            ) {
              case "integer":
                const tmpArray = formattedValue.split(" ");
                formattedValue = tmpArray.join("");
                formattedValue = parseInt(formattedValue);
                break;
              case "boolean":
                formattedValue = booleanMap[formattedValue];
                break;
              case "textArray":
                console.log(formattedValue);
                formattedValue = formattedValue.split(", ");
                /* formattedValue = formattedValue.map((value) => {
                  return '"' + value + '"';
                }); */
                break;
              case "numeric":
                const tmp = formattedValue.split(" ");
                formattedValue = tmp.join("");
                formattedValue = parseInt(formattedValue);
                break;
              case "text":
                /* formattedValue = '"' + value + '"'; */
                break;
            }

            console.log(
              keywordsMap[property?.innerText.toLowerCase().trim()].column,
              formattedValue,
            );
            console.log("");
            values.push(formattedValue);
          }
        });

        if (title?._attrs?.title) {
          columns.push("name");
          values.push(title?._attrs?.title);
        }
        const formattedPrice = price?.textContent
          ?.split("₽")[0]
          .split(" ")
          .join("");
        if (formattedPrice) {
          columns.push("price");
          values.push(parseInt(formattedPrice));
        }
        if (img_url) {
          columns.push("img_url");
          values.push(img_url);
        }
        /*       console.log(
        title?._attrs?.title,
        parseInt(price?.textContent?.split("₽")[0]?.trim()),
      ); */

        console.log(formattedPrice);
        const partInfo = {
          name: title?._attrs?.title,
          price: parseInt(formattedPrice),
        };
        if (partInfo.name && partInfo.price) {
          const placeholders = values.map((_, i) => `$${i + 1}`).join(", ");

          const insertRes = await db.query(
            `INSERT INTO ${pages[j].pageTitle} (${columns.join(
              ", ",
            )}) VALUES (${placeholders}) ON CONFLICT (name) DO UPDATE SET price = EXCLUDED.price`,
            values,
            (err) => {
              console.log(err);
              db.query("ROLLBACK");
            },
          );
          /* console.log(partInfo.name, partInfo.price); */
        }
      }
    }
  }

  return true;
};

const cpuPage = await browser.newPage();
const gpuPage = await browser.newPage();
const ramPage = await browser.newPage();
const motherboardPage = await browser.newPage();
const ssdPage = await browser.newPage();
const hddPage = await browser.newPage();
const psuPage = await browser.newPage();
const coolersPage = await browser.newPage();
const casesPage = await browser.newPage();

const cpuFullPage = {
  pageTitle: "cpus",
  page: cpuPage,
};
const gpuFullPage = {
  pageTitle: "gpus",
  page: gpuPage,
};

const psuFullPage = {
  pageTitle: "psus",
  page: psuPage,
};

const hddFullPage = {
  pageTitle: "storages",
  page: hddPage,
};

const ssdFullPage = {
  pageTitle: "storages",
  page: ssdPage,
};

const ramFullPage = {
  pageTitle: "rams",
  page: ramPage,
};

const motherboardFullPage = {
  pageTitle: "motherboards",
  page: motherboardPage,
};
const coolersFullPage = {
  pageTitle: "coolers",
  page: coolersPage,
};
const casesFullPage = {
  pageTitle: "cases",
  page: casesPage,
};

const pages = [
  cpuFullPage,
  gpuFullPage,
  ramFullPage,
  motherboardFullPage,
  ssdFullPage,
  hddFullPage,
  psuFullPage,
  coolersFullPage,
  casesFullPage,
];

var isRunning = false;

try {
  var i = 1;
  isRunning = true;
  while (true) {
    const result = await parsePipeline(i);
    if (!result) {
      console.log("stopped parsing");
      break;
    }
    i++;
  }
} finally {
  isRunning = false;
}

cron.schedule("0 0 */2 * * *", async () => {
  if (isRunning) {
    console.log("процесс уже запущен");
    return;
  }
  var i = 1;
  isRunning = true;
  try {
    while (true) {
      const result = await parsePipeline(i);
      if (!result) {
        console.log("stopped parsing");
        break;
      }
      i++;
    }
  } finally {
    isRunning = false;
  }
});
