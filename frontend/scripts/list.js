/* eslint-disable no-undef */

// ===============================
// Константы и глобальные переменные
// ===============================
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

const FILTER_SETS = {
    cpu: ["brand", "socket", "generation", "price"],
    motherboard: ["brand", "socket", "chipset", "price"],
    gpu: ["brand", "series", "vram", "price"],
    ram: ["brand", "type", "frequency", "capacity", "price"],
    storage: ["brand", "type", "capacity", "interface", "price"],
    psu: ["brand", "power", "certificate", "modular", "price"],
    cooler: ["brand", "height", "type", "price"],
    case: ["brand", "formfactor", "gpu_length_limit", "cooler_height_limit", "price"]
};

const RU_NAMES = {
    cpu: "Процессоры",
    gpu: "Видеокарты",
    motherboard: "Материнские платы",
    ram: "Оперативная память",
    psu: "Блоки питания",
    case: "Корпуса",
    cooler: "Кулеры",
    storage: "Накопители"
};

// URL‑параметры
const params = new URLSearchParams(window.location.search);
const category = params.get("category");
const returnTo = params.get("return");
const forcedType = params.get("type");

// Заголовок
document.getElementById("title").textContent =
    RU_NAMES[category] || (category ? category.toUpperCase() : "Каталог");

// Глобальные данные
let allItems = [];
let filteredItems = [];
let showOnlyCompatible = false;

// Пагинация
let currentPage = 1;
const itemsPerPage = 12;

// Модалка совместимости
let pendingCategory = null;
let pendingItem = null;

const modal = document.getElementById("compatModal");
const modalText = document.getElementById("compatModalText");
const modalClose = document.getElementById("compatModalClose");
const modalForce = document.getElementById("compatForceAdd");

modalClose.onclick = () => (modal.style.display = "none");
window.onclick = e => {
    if (e.target === modal) modal.style.display = "none";
};

function showCompatibilityError(text, item) {
    pendingCategory = category;
    pendingItem = item;
    modalText.textContent = text;
    modal.style.display = "flex";
}

modalForce.onclick = () => {
    if (!pendingCategory || !pendingItem) return;

    localStorage.setItem("selected_" + pendingCategory, JSON.stringify(pendingItem));
    modal.style.display = "none";

    const item = pendingItem;
    pendingCategory = null;
    pendingItem = null;

    if (returnTo === "builder") {
        window.location.href = "builder.html";
        return;
    }

    window.location.href = `product.html?id=${item.id}&category=${category}`;
};

// ===============================
// Хелперы
// ===============================
function detectStorageType(item) {
    const name = (item.name || "").toLowerCase();
    if (name.includes("ssd") || name.includes("nvme") || name.includes("m.2") || name.includes("m2")) {
        return "SSD";
    }
    return "HDD";
}

function detectCpuGeneration(name) {
    const lower = (name || "").toLowerCase();

    const intelMatch = lower.match(/i[3579]-?\s*(\d{4,5})/);
    if (intelMatch) {
        const num = Number(intelMatch[1]);
        return "Intel " + Math.floor(num / 1000);
    }

    const ryzenMatch = lower.match(/ryzen\s+(\d)/);
    if (ryzenMatch) {
        return "Ryzen " + ryzenMatch[1];
    }

    return "";
}

function applyFilterVisibility() {
    const active = FILTER_SETS[category] || [];

    document.querySelectorAll(".filter-block").forEach(block => {
        const filterName = block.dataset.filter;
        block.style.display = active.includes(filterName) ? "block" : "none";
    });
}

function fillFilterOptions(items) {
    const brandSelect = document.getElementById("brandFilter");
    const socketSelect = document.getElementById("socketFilter");
    const seriesSelect = document.getElementById("seriesFilter");
    const generationSelect = document.getElementById("generationFilter");

    if (brandSelect) brandSelect.innerHTML = '<option value="">Все</option>';
    if (socketSelect) socketSelect.innerHTML = '<option value="">Все</option>';
    if (seriesSelect) seriesSelect.innerHTML = '<option value="">Все</option>';
    if (generationSelect) generationSelect.innerHTML = '<option value="">Все</option>';

    const brands = new Set();
    const sockets = new Set();
    const series = new Set();
    const generations = new Set();

    items.forEach(i => {
        if (i.brand) brands.add(i.brand);
        if (i.socket) sockets.add(i.socket);

        const parts = (i.name || "").split(" ");
        if (parts.length > 1) series.add(parts[0] + " " + parts[1]);

        if (i.generation) generations.add(i.generation);
    });

    brands.forEach(b => {
        if (brandSelect) brandSelect.innerHTML += `<option value="${b}">${b}</option>`;
    });

    const allSockets = [...sockets];
    const intel = allSockets.filter(s => s.toUpperCase().startsWith("LGA"));
    const amd = allSockets.filter(s => s.toUpperCase().startsWith("AM"));
    const tr = allSockets.filter(s => s.toUpperCase().startsWith("TR"));
    const str = allSockets.filter(s => s.toUpperCase().startsWith("STR"));

    const sortByNum = (a, b) =>
        (parseInt(a.replace(/\D/g, "")) || 0) - (parseInt(b.replace(/\D/g, "")) || 0);

    intel.sort(sortByNum);
    amd.sort(sortByNum);
    tr.sort(sortByNum);
    str.sort(sortByNum);

    [...intel, ...amd, ...tr, ...str].forEach(s => {
        if (socketSelect) socketSelect.innerHTML += `<option value="${s}">${s}</option>`;
    });

    series.forEach(s => {
        if (seriesSelect) seriesSelect.innerHTML += `<option value="${s}">${s}</option>`;
    });

    [...generations].sort().forEach(g => {
        if (generationSelect) generationSelect.innerHTML += `<option value="${g}">${g}</option>`;
    });
}

// ===============================
// Загрузка данных
// ===============================
async function loadItems() {
    const list = document.getElementById("itemsList");
    list.innerHTML = "<p>Загрузка...</p>";

    try {
        const endpoint = CATEGORY_ENDPOINTS[category];
        const res = await fetch(`${API_BASE}/${endpoint}`);
        const data = await res.json();

        allItems = data.map(i => ({
            ...i,
            price: Number(i.price) || 0,
            type: category === "storage" ? detectStorageType(i) : null,
            generation: category === "cpu" ? detectCpuGeneration(i.name) : ""
        }));

        filteredItems = [...allItems];

        fillFilterOptions(allItems);
        applyFilterVisibility();
        currentPage = 1;
        renderItems();
        enableLiveFilters();
    } catch (err) {
        list.innerHTML = "<p>Ошибка загрузки</p>";
        console.error(err);
    }
}
// ===============================
// Пагинация
// ===============================
function paginate(items) {
    const start = (currentPage - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    return items.slice(start, end);
}

function renderPagination(totalItems) {
    const container = document.getElementById("pagination");
    if (!container) return;

    container.innerHTML = "";

    const totalPages = Math.ceil(totalItems / itemsPerPage);
    if (totalPages <= 1) return;

    for (let i = 1; i <= totalPages; i++) {
        const btn = document.createElement("button");
        btn.textContent = i;
        btn.className = "page-btn" + (i === currentPage ? " active" : "");

        btn.onclick = () => {
            currentPage = i;
            renderItems();
        };

        container.appendChild(btn);
    }
}

// ===============================
// Совместимость
// ===============================
function getSelectedPartsFromStorage() {
    const parts = {};
    Object.keys(CATEGORY_ENDPOINTS).forEach(key => {
        const saved = localStorage.getItem("selected_" + key);
        if (saved) parts[key] = JSON.parse(saved);
    });
    return parts;
}

function checkCompatibility(categoryKey, item, selectedParts) {
    const cpu = selectedParts.cpu;
    const mb = selectedParts.motherboard;
    const ram = selectedParts.ram;
    const gpu = selectedParts.gpu;
    const psu = selectedParts.psu;

    if (categoryKey === "motherboard" && cpu && item.socket !== cpu.socket)
        return "Сокет материнской платы не подходит";

    if (categoryKey === "cpu" && mb && item.socket !== mb.socket)
        return "Сокет процессора не подходит";

    if (categoryKey === "ram" && mb && item.type !== mb.memory_type)
        return "Тип памяти не подходит";

    if (categoryKey === "psu" && gpu && item.power < gpu.tdp)
        return "БП слабый для видеокарты";

    if (categoryKey === "gpu" && psu && gpu.tdp > psu.power)
        return "БП слабый для этой видеокарты";

    return null;
}

// ===============================
// Фильтры
// ===============================
function enableLiveFilters() {
    const ids = [
        "priceMin",
        "priceMax",
        "brandFilter",
        "socketFilter",
        "seriesFilter",
        "typeFilter",
        "generationFilter",
        "searchInput"
    ];

    ids.forEach(id => {
        const el = document.getElementById(id);
        if (!el) return;

        const eventName = el.tagName === "SELECT" ? "change" : "input";

        el.addEventListener(eventName, () => {
            currentPage = 1;
            applyFilters();
        });
    });
}

function applyFilters() {
    const min = Number(document.getElementById("priceMin")?.value) || 0;
    const max = Number(document.getElementById("priceMax")?.value) || Infinity;

    const brand = document.getElementById("brandFilter")?.value || "";
    const socket = document.getElementById("socketFilter")?.value || "";
    const series = document.getElementById("seriesFilter")?.value || "";
    const type = document.getElementById("typeFilter")?.value || "";
    const generation = document.getElementById("generationFilter")?.value || "";
    const q = (document.getElementById("searchInput")?.value || "").toLowerCase();

    filteredItems = allItems.filter(i => {
        if (forcedType && i.type !== forcedType) return false;
        if (type && i.type !== type) return false;

        if (i.price < min || i.price > max) return false;

        if (brand && i.brand !== brand) return false;

        if (socket && i.socket !== socket) return false;

        if (series && !i.name.includes(series)) return false;

        if (generation && i.generation !== generation) return false;

        if (q && !i.name.toLowerCase().includes(q)) return false;

        return true;
    });

    currentPage = 1;
    renderItems();
}

// Кнопка "только совместимые"
document.getElementById("toggleCompatible").onclick = () => {
    showOnlyCompatible = !showOnlyCompatible;

    document.getElementById("toggleCompatible").textContent =
        showOnlyCompatible ? "Показать все" : "Показать только совместимые";

    currentPage = 1;
    renderItems();
};

// Кнопка "сбросить фильтры"
document.getElementById("clearFilters").onclick = () => {
    const ids = [
        "priceMin",
        "priceMax",
        "brandFilter",
        "socketFilter",
        "seriesFilter",
        "typeFilter",
        "generationFilter",
        "searchInput"
    ];

    ids.forEach(id => {
        const el = document.getElementById(id);
        if (!el) return;
        if (el.tagName === "SELECT" || el.tagName === "INPUT") el.value = "";
    });

    showOnlyCompatible = false;
    document.getElementById("toggleCompatible").textContent =
        "Показать только совместимые";

    filteredItems = [...allItems];
    currentPage = 1;
    renderItems();
};

// ===============================
// Рендер списка
// ===============================
function renderItems() {
    const list = document.getElementById("itemsList");
    list.innerHTML = "";

    const selectedParts = getSelectedPartsFromStorage();
    const pageItems = paginate(filteredItems);

    pageItems.forEach(item => {
        const reason = checkCompatibility(category, item, selectedParts);
        if (showOnlyCompatible && reason) return;

        const img = item.image || PLACEHOLDERS[category];

        const div = document.createElement("div");
        div.className = "product-card";

        if (reason) {
            div.classList.add("incompatible");
            div.setAttribute("data-reason", reason);
        }

        div.innerHTML = `
            <img src="${img}" alt="">
            <h3>${item.name}</h3>
            <p>${item.price} ₽</p>
        `;

        div.onclick = () => {
            if (reason) {
                showCompatibilityError(reason, item);
                return;
            }
            selectItem(item);
        };

        list.appendChild(div);
    });

    renderPagination(filteredItems.length);
}

// ===============================
// Выбор товара
// ===============================
function selectItem(item) {
    localStorage.setItem("selected_" + category, JSON.stringify(item));

    if (returnTo === "builder") {
        window.location.href = "builder.html";
        return;
    }

    window.location.href = `product.html?id=${item.id}&category=${category}`;
}

// ===============================
// Старт
// ===============================
loadItems();
