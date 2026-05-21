/* eslint-disable no-undef */
// ===============================
// API
// ===============================
const API_BASE = 'http://172.29.167.229:3001/api';

const CATEGORY_ENDPOINTS = {
    cpu: 'cpus',
    gpu: 'gpus',
    motherboard: 'motherboards',
    ram: 'rams',
    psu: 'psus',
    case: 'cases',
    storage: 'storages',
    cooler: 'coolers'
};

// ===============================
// ТЕКУЩАЯ СБОРКА
// ===============================
const build = {
    cpu: null,
    gpu: null,
    motherboard: null,
    ram: null,
    psu: null,
    case: null,
    storage: null,
    cooler: null
};

// ===============================
// ОТКРЫТИЕ МОДАЛКИ
// ===============================
async function openModal(category) {
    const modal = document.getElementById('partsModal');
    const title = document.getElementById('modalTitle');
    const list = document.getElementById('modalList');

    modal.classList.add('show');
    modal.dataset.category = category;

    title.textContent = 'Выбор: ' + getCategoryName(category);
    list.innerHTML = 'Загрузка...';

    try {
        const endpoint = CATEGORY_ENDPOINTS[category];
        const res = await fetch(`${API_BASE}/${endpoint}`);
        const items = await res.json();
        renderModalList(category, items);
    } catch (err) {
        list.innerHTML = 'Ошибка загрузки';
        console.error(err);
    }
}

// ===============================
// ЗАКРЫТИЕ МОДАЛКИ
// ===============================
function closeModal() {
    document.getElementById('partsModal').classList.remove('show');
}

// ===============================
// СПИСОК В МОДАЛКЕ
// ===============================
function renderModalList(category, items) {
    const list = document.getElementById('modalList');
    list.innerHTML = '';

    items.forEach(item => {
        const row = document.createElement('div');
        row.className = 'modal-item';

        row.innerHTML = `
            <div class="modal-left">
                <div class="modal-name">${item.name}</div>
                <div class="modal-info">${item.info || ''}</div>
            </div>

            <button class="select-btn">Выбрать</button>
        `;

        row.querySelector('.select-btn').addEventListener('click', () => {
            selectPart(category, item);
            closeModal();
        });

        list.appendChild(row);
    });
}

// ===============================
// ВЫБОР КОМПОНЕНТА
// ===============================
function selectPart(category, item) {
    build[category] = item;
    localStorage.setItem(category, JSON.stringify(item));

    updateSlot(category);
    updateSidePanel();
    updatePrice();
    validateCompatibility();
}

// ===============================
// ОБНОВЛЕНИЕ СЛОТА
// ===============================
function updateSlot(category) {
    const slot = document.getElementById(category + 'Slot');
    const item = build[category];

    if (!item) {
        slot.innerHTML = 'Не выбрано';
        return;
    }

    slot.innerHTML = `
        <div class="part-left">
            <div class="part-name">${item.name}</div>
            <div class="part-info">${item.info || ''}</div>
        </div>

        <div class="part-right">
            <div class="part-price">${Number(item.price).toLocaleString('ru-RU')} ₽</div>
            <button class="delete-btn" onclick="removePart('${category}')">Удалить</button>
        </div>
    `;
}

// ===============================
// УДАЛЕНИЕ КОМПОНЕНТА
// ===============================
function removePart(category) {
    build[category] = null;
    localStorage.removeItem(category);

    updateSlot(category);
    updateSidePanel();
    updatePrice();
    validateCompatibility();
}

// ===============================
// ПРАВАЯ ПАНЕЛЬ
// ===============================
function updateSidePanel() {
    const box = document.getElementById('sideBuildInfo');
    box.innerHTML = '';

    Object.keys(build).forEach(cat => {
        const item = build[cat];
        if (!item) return;

        const div = document.createElement('div');
        div.className = 'side-item';

        div.innerHTML = `
            <div>${item.name}</div>
            <div>${Number(item.price).toLocaleString('ru-RU')} ₽</div>
        `;

        box.appendChild(div);
    });
}

// ===============================
// ЦЕНА
// ===============================
function updatePrice() {
    let total = 0;

    Object.values(build).forEach(item => {
        if (item) total += Number(item.price);
    });

    document.getElementById('totalPrice').textContent =
        total.toLocaleString('ru-RU') + ' ₽';
}

// ===============================
// ПРОВЕРКА СОВМЕСТИМОСТИ
// ===============================
function validateCompatibility() {
    const box = document.getElementById('errorBox');
    const errors = [];

    if (build.cpu && build.motherboard) {
        if (build.cpu.socket !== build.motherboard.socket) {
            errors.push('❌ Процессор и материнская плата имеют разные сокеты');
        }
    }

    box.innerHTML = errors.length ? errors.join('<br>') : 'Ошибок нет';
}

// ===============================
// ЗАГРУЗКА ИЗ LOCALSTORAGE
// ===============================
function loadSavedBuild() {
    Object.keys(build).forEach(cat => {
        const saved = localStorage.getItem(cat);
        if (saved) build[cat] = JSON.parse(saved);
        updateSlot(cat);
    });

    updateSidePanel();
    updatePrice();
    validateCompatibility();
}

// ===============================
// ОЧИСТКА СБОРКИ
// ===============================
document.getElementById('clearBuild').addEventListener('click', () => {
    Object.keys(build).forEach(cat => {
        build[cat] = null;
        localStorage.removeItem(cat);
        updateSlot(cat);
    });

    updateSidePanel();
    updatePrice();
    validateCompatibility();
});

// ===============================
// INIT
// ===============================
document.addEventListener('DOMContentLoaded', loadSavedBuild);

// ===============================
// НАЗВАНИЯ КАТЕГОРИЙ
// ===============================
function getCategoryName(key) {
    const names = {
        cpu: 'Процессоры',
        gpu: 'Видеокарты',
        motherboard: 'Материнские платы',
        ram: 'Оперативная память',
        psu: 'Блоки питания',
        case: 'Корпуса',
        storage: 'Накопители',
        cooler: 'Охлаждение'
    };
    return names[key] || key;
}
