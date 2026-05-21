// =====================================
// ГЛОБАЛЬНЫЕ НАСТРОЙКИ
// =====================================

const API_BASE = '/api';

// Список категорий и соответствующих роутов
const CATEGORIES = {
    cpu: 'cpus',
    gpu: 'gpus',
    motherboard: 'motherboards',
    ram: 'rams',
    psu: 'psus',
    case: 'cases',
    cooler: 'coolers',
    storage: 'storages'
};

// =====================================
// ЗАГРУЗКА КАТЕГОРИИ
// =====================================

async function loadCategory(category) {
    const endpoint = CATEGORIES[category];
    if (!endpoint) return;

    try {
        const res = await fetch(`${API_BASE}/${endpoint}`);
        const items = await res.json();
        renderCatalog(category, items);
    } catch (err) {
        console.error(`Ошибка загрузки категории ${category}:`, err);
    }
}

// =====================================
// РЕНДЕР КАТАЛОГА
// =====================================

function renderCatalog(category, items) {
    const container = document.getElementById('catalogContainer');
    const title = document.getElementById('catalogTitle');

    if (!container || !title) return;

    title.textContent = getCategoryName(category);
    container.innerHTML = '';

    items.forEach(item => {
        const card = document.createElement('div');
        card.className = 'catalog-card';

        card.innerHTML = `
            <div class="card-name">${item.name}</div>
            <div class="card-info">${item.info || ''}</div>
            <div class="card-price">${item.price} ₽</div>

            <div class="card-actions">
                <button class="details-btn">Подробнее</button>
                <button class="select-btn">Выбрать</button>
            </div>
        `;

        // Кнопка "Подробнее"
        card.querySelector('.details-btn').addEventListener('click', () => {
            openDetails(item);
        });

        // Кнопка "Выбрать"
        card.querySelector('.select-btn').addEventListener('click', () => {
            selectPart(category, item);
        });

        container.appendChild(card);
    });
}

// =====================================
// ОТКРЫТИЕ ПОДРОБНОЙ ИНФОРМАЦИИ
// =====================================

function openDetails(item) {
    const modal = document.getElementById('detailsModal');
    const content = document.getElementById('detailsContent');

    if (!modal || !content) return;

    content.innerHTML = `
        <h2>${item.name}</h2>
        <p>${item.info || 'Нет описания'}</p>
        <p><strong>Цена:</strong> ${item.price} ₽</p>
        <button id="closeDetails">Закрыть</button>
    `;

    modal.style.display = 'block';

    document.getElementById('closeDetails').addEventListener('click', () => {
        modal.style.display = 'none';
    });
}

// =====================================
// ВЫБОР КОМПОНЕНТА ДЛЯ КОНФИГУРАТОРА
// =====================================

function selectPart(category, item) {
    localStorage.setItem(category, JSON.stringify(item));
    window.location.href = 'builder.html';
}

// =====================================
// ПОЛУЧЕНИЕ ЧЕЛОВЕЧЕСКОГО НАЗВАНИЯ КАТЕГОРИИ
// =====================================

function getCategoryName(key) {
    const names = {
        cpu: 'Процессоры',
        gpu: 'Видеокарты',
        motherboard: 'Материнские платы',
        ram: 'Оперативная память',
        psu: 'Блоки питания',
        case: 'Корпуса',
        cooler: 'Кулеры',
        storage: 'Накопители'
    };
    return names[key] || key;
}

// =====================================
// ИНИЦИАЛИЗАЦИЯ
// =====================================

function initCatalog() {
    const params = new URLSearchParams(window.location.search);
    const category = params.get('category') || 'cpu';

    loadCategory(category);
}

initCatalog();
