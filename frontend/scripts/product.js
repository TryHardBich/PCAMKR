/* eslint-disable no-undef */
const API_BASE = 'http://localhost:3001/api';

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

const PLACEHOLDERS = {
    cpu: "images/placeholders/cpu.svg",
    gpu: "images/placeholders/gpu.svg",
    motherboard: "images/placeholders/motherboard.svg",
    ram: "images/placeholders/ram.svg",
    psu: "images/placeholders/psu.svg",
    case: "images/placeholders/case.svg",
    cooler: "images/placeholders/cooler.svg",
    storage: "images/placeholders/storage.svg"
};

const FIELD_NAMES = {
    brand: "Бренд",
    cores: "Ядер",
    threads: "Потоков",
    base_clock: "Базовая частота",
    boost_clock: "Макс. частота",
    tdp: "TDP",
    socket: "Сокет",
    memory: "Память",
    type: "Тип",
    speed: "Скорость",
    capacity: "Объём",
    chipset: "Чипсет",
    form_factor: "Форм‑фактор",
    interface: "Интерфейс",
    size: "Размер",
    power: "Мощность",
    connector: "Разъёмы",
    cache: "Кэш",
    ram_type: "Тип памяти",
    ram_slots: "Максимальное количество модулей памяти",
    max_ram: "Максимальный объем памяти",
    socket_support: "Поддержка сокетов",
    gpu_length_limit: "Максимальная длина видеокарты",
    cooler_height_limit: "Максимальная высота кулера"
};

const params = new URLSearchParams(window.location.search);
const id = params.get("id");
const category = params.get("category");

async function loadItem() {
    const res = await fetch(`${API_BASE}/${CATEGORY_ENDPOINTS[category]}`);
    const items = await res.json();
    const item = items.find(i => i.id == id);

    document.getElementById("name").textContent = item.name;
    document.getElementById("price").textContent = item.price + " ₽";
    document.getElementById("productImage").src = item.img_url || PLACEHOLDERS[category];

    const specsBox = document.getElementById("specs");
    specsBox.innerHTML = "";

    const ignore = ["id", "name", "price", "img_url", "description"];

    Object.keys(item).forEach(key => {
        if (ignore.includes(key)) return;
        if (!item[key]) return;

        const row = document.createElement("div");
        row.className = "spec-row";

        row.innerHTML = `
            <div class="spec-name">${FIELD_NAMES[key] || key}</div>
            <div class="spec-value">${item[key]}</div>
        `;

        specsBox.appendChild(row);
    });

    document.getElementById("description").textContent =
        item.description || "Описание отсутствует";
}

function showAddedModal() {
    const modal = document.getElementById("addedModal");
    if (modal) {
        modal.classList.add("show");
    }
}

document.getElementById("addToBuild").onclick = () => {
    const build = JSON.parse(localStorage.getItem("build")) || {};
    build[category] = id;
    localStorage.setItem("build", JSON.stringify(build));
    showAddedModal();
};

loadItem();
