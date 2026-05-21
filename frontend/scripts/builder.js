/* eslint-disable no-undef */
// ===============================
// ГЛОБАЛЬНОЕ СОСТОЯНИЕ СБОРКИ
// ===============================

const build = {
    cpu: null,
    gpu: null,
    motherboard: null,
    ram: null,
    psu: null,
    case: null,
    cooler: null,
    storage: null
};

// ===============================
// ОТКРЫТИЕ / ЗАКРЫТИЕ МОДАЛКИ
// ===============================

function openModal(type) {
    const modal = document.getElementById('partsModal');
    const title = document.getElementById('modalTitle');
    const list = document.getElementById('modalList');

    title.textContent = getCategoryName(type);
    list.innerHTML = 'Загрузка...';

    modal.style.display = 'flex';

    loadPartsToModal(type);
}

function closeModal() {
    document.getElementById('partsModal').style.display = 'none';
}

// ===============================
// ЗАГРУЗКА ДЕТАЛЕЙ В МОДАЛКУ
// ===============================

async function loadPartsToModal(type) {
    const endpoints = {
        cpu: 'cpus',
        gpu: 'gpus',
        motherboard: 'motherboards',
        ram: 'rams',
        psu: 'psus',
        case: 'cases',
        cooler: 'coolers',
        storage: 'storages'
    };

    try {
        const res = await fetch(`http://172.29.167.229:3001/api/${endpoints[type]}`);
        const parts = await res.json();
        renderModalList(type, parts);
    } catch (err) {
        document.getElementById('modalList').innerHTML = 'Ошибка загрузки';
        console.error(err);
    }
}

// ===============================
// РЕНДЕР СПИСКА В МОДАЛКЕ
// ===============================

function renderModalList(type, parts) {
    const list = document.getElementById('modalList');
    list.innerHTML = '';

    parts.forEach(part => {
        const item = document.createElement('div');
        item.className = 'modal-item';

        item.innerHTML = `
            <div>
                <div class="part-name">${part.name}</div>
                <div class="part-info">${part.info || ''}</div>
            </div>

            <div class="part-right">
                <div class="part-price">${part.price} ₽</div>
                <button class="select-btn">Выбрать</button>
            </div>
        `;

        item.querySelector('.select-btn').addEventListener('click', () => {
            selectPart(type, part);
            closeModal();
        });

        list.appendChild(item);
    });
}

// ===============================
// ВЫБОР КОМПОНЕНТА
// ===============================

function selectPart(type, part) {
    build[type] = part;
    updateSelectedUI(type);
    validateCompatibility();
    updatePrice();
}

// ===============================
// ОБНОВЛЕНИЕ СЛОТА
// ===============================

function updateSelectedUI(type) {
    const slot = document.getElementById(`${type}Slot`);
    const part = build[type];

    if (!part) {
        slot.innerHTML = 'Не выбрано';
        return;
    }

    slot.innerHTML = `
        <div class="part-left">
            <div class="part-name">${part.name}</div>
            <div class="part-info">${part.info || ''}</div>
        </div>

        <div class="part-right">
            <div class="part-price">${part.price} ₽</div>
            <button class="delete-btn">Удалить</button>
        </div>
    `;

    slot.querySelector('.delete-btn').addEventListener('click', () => {
        build[type] = null;
        updateSelectedUI(type);
        validateCompatibility();
        updatePrice();
    });
}

// ===============================
// ПРОВЕРКА СОВМЕСТИМОСТИ
// ===============================

function validateCompatibility() {
    const errors = [];

    const { cpu, motherboard, ram, gpu, psu, case: pcCase, cooler } = build;

    if (cpu && motherboard && cpu.socket !== motherboard.socket)
        errors.push('Процессор и материнская плата несовместимы (разные сокеты)');

    if (ram && motherboard && ram.type !== motherboard.ram_type)
        errors.push('Оперативная память несовместима с материнской платой');

    if (gpu && pcCase && gpu.length > pcCase.gpu_max_length)
        errors.push('Видеокарта не помещается в корпус');

    if (gpu && psu && psu.wattage < gpu.power)
        errors.push('Блока питания недостаточно для видеокарты');

    if (cpu && cooler && cooler.tdp < cpu.tdp)
        errors.push('Кулер не справляется с тепловыделением процессора');

    renderErrors(errors);
    highlightSlots(errors);
}

// ===============================
// ПОДСВЕТКА СЛОТОВ С ОШИБКАМИ
// ===============================

function highlightSlots(errors) {
    document.querySelectorAll('.selected-part').forEach(el => {
        el.classList.remove('error-slot');
    });

    if (errors.length === 0) return;

    errors.forEach(err => {
        if (err.includes('сокеты')) {
            mark('cpuSlot');
            mark('motherboardSlot');
        }

        if (err.includes('Оперативная память')) {
            mark('ramSlot');
            mark('motherboardSlot');
        }

        if (err.includes('не помещается')) {
            mark('gpuSlot');
            mark('caseSlot');
        }

        if (err.includes('Блока питания')) {
            mark('gpuSlot');
            mark('psuSlot');
        }

        if (err.includes('Кулер')) {
            mark('cpuSlot');
            mark('coolerSlot');
        }
    });

    function mark(id) {
        const el = document.getElementById(id);
        if (el) el.classList.add('error-slot');
    }
}

// ===============================
// ОТОБРАЖЕНИЕ ОШИБОК
// ===============================

function renderErrors(errors) {
    const box = document.getElementById('errorBox');

    if (errors.length === 0) {
        box.style.display = 'none';
        box.innerHTML = '';
        return;
    }

    box.style.display = 'block';
    box.innerHTML = errors.map(e => `<div class="error">${e}</div>`).join('');
}

// ===============================
// РАСЧЁТ ЦЕНЫ
// ===============================

function updatePrice() {
    const total = Object.values(build)
        .filter(Boolean)
        .reduce((sum, part) => sum + Number(part.price), 0);

    document.getElementById('totalPrice').textContent = total + ' ₽';
}


// ===============================
// НАЗВАНИЯ КАТЕГОРИЙ
// ===============================

function getCategoryName(type) {
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
    return names[type] || type;
}
