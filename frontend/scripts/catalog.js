/* eslint-disable no-undef */
const API_BASE = 'http://172.20.171.15:3001/api';

const CATEGORY_ENDPOINTS = {
    cpu: 'cpus',
    gpu: 'gpus',
    motherboard: 'motherboards',
    ram: 'rams',
    psu: 'psus',
    case: 'cases',
    cooler: 'coolers',
    storage: 'storages'
};

// Открытие модалки
async function openModal(category) {
    const modal = document.getElementById('modal');
    const title = document.getElementById('modalTitle');
    const list = document.getElementById('modalList');

    modal.style.display = 'flex';
    modal.dataset.category = category;

    title.textContent = 'Категория: ' + getCategoryName(category);
    list.innerHTML = '<p class=\'loading\'>Загрузка...</p>';

    try {
        const endpoint = CATEGORY_ENDPOINTS[category];
        const res = await fetch(`${API_BASE}/${endpoint}`);
        const items = await res.json();
        renderModalList(items, category);
    } catch (err) {
        list.innerHTML = '<p>Ошибка загрузки</p>';
        console.error(err);
    }
}

// Закрытие модалки
function closeModal() {
    document.getElementById('modal').style.display = 'none';
}

// Рендер списка
function renderModalList(items, category) {
    const list = document.getElementById('modalList');
    list.innerHTML = '';

    items.forEach(item => {
        const row = document.createElement('div');
        row.className = 'modal-item';

        row.innerHTML = `
            <div>
                <div>${item.name}</div>
                <div style="opacity:0.7">${item.info || ''}</div>
            </div>

            <button class="select-btn">Выбрать</button>
        `;

        row.querySelector('.select-btn').addEventListener('click', () => {
            saveSelected(category, item);
            closeModal();
        });

        list.appendChild(row);
    });
}

// Сохранение выбранного
function saveSelected(category, item) {
    localStorage.setItem('cat_' + category, JSON.stringify(item));
    updateSelectedPanel();
}

// Обновление правой панели
function updateSelectedPanel() {
    const box = document.getElementById('selectedParts');
    box.innerHTML = '';

    Object.keys(CATEGORY_ENDPOINTS).forEach(cat => {
        const saved = localStorage.getItem('cat_' + cat);
        if (!saved) return;

        const item = JSON.parse(saved);

        const div = document.createElement('div');
        div.className = 'selected-item';

        div.innerHTML = `
            <span>${item.name}</span>
            <button class="sel-remove" onclick="removeSelected('${cat}')">✖</button>
        `;

        box.appendChild(div);
    });
}

// Удаление
function removeSelected(category) {
    localStorage.removeItem('cat_' + category);
    updateSelectedPanel();
}

// Названия категорий
function getCategoryName(key) {
    const names = {
        cpu: 'Процессоры',
        gpu: 'Видеокарты',
        motherboard: 'Материнские платы',
        ram: 'Оперативная память',
        psu: 'Блоки питания',
        case: 'Корпуса',
        cooler: 'Охлаждение',
        storage: 'Накопители'
    };
    return names[key] || key;
}

// Инициализация
document.querySelectorAll('.cell').forEach(cell => {
    cell.addEventListener('click', () => openModal(cell.dataset.category));
});

updateSelectedPanel();
