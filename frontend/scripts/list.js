/* eslint-disable no-undef */

const API_BASE = 'http://localhost:3001/api';

let pendingCategory = null;
let pendingItem = null;

const CATEGORY_ENDPOINTS = {
    cpu: 'cpus',
    gpu: 'gpus',
    motherboard: 'motherboards',
    ram: 'rams',
    psus: 'psus',
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

const params = new URLSearchParams(window.location.search);
const category = params.get("category");
const returnTo = params.get("return");

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

document.getElementById("title").textContent = RU_NAMES[category] || category.toUpperCase();

let allItems = [];
let showOnlyCompatible = false;

/* ===============================
   МОДАЛКА
================================= */
const modal = document.getElementById("compatModal");
const modalText = document.getElementById("compatModalText");
const modalClose = document.getElementById("compatModalClose");
const modalForce = document.getElementById("compatForceAdd");

modalClose.onclick = () => modal.style.display = "none";
window.onclick = e => { if (e.target === modal) modal.style.display = "none"; };

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

/* ===============================
   ЗАГРУЗКА ТОВАРОВ
================================= */
async function loadItems() {
    const list = document.getElementById("itemsList");

    try {
        const url = `${API_BASE}/${CATEGORY_ENDPOINTS[category]}`;
        const res = await fetch(url);
        allItems = await res.json();

        fillFilterOptions(allItems);
        renderItems(allItems);

    } catch (err) {
        console.error("Ошибка загрузки:", err);
        list.innerHTML = "<p>Ошибка загрузки данных</p>";
    }
}

/* ===============================
   ФИЛЬТРЫ
================================= */
function fillFilterOptions(items) {
    const brandSelect = document.getElementById("brandFilter");
    const socketSelect = document.getElementById("socketFilter");
    const seriesSelect = document.getElementById("seriesFilter");

    const brands = new Set();
    const sockets = new Set();
    const series = new Set();

    items.forEach(i => {
        if (i.brand) brands.add(i.brand);
        if (i.socket) sockets.add(i.socket);
        if (i.name) {
            const parts = i.name.split(" ");
            if (parts.length > 1) series.add(parts[0] + " " + parts[1]);
        }
    });

    brands.forEach(b => brandSelect.innerHTML += `<option value="${b}">${b}</option>`);
    sockets.forEach(s => socketSelect.innerHTML += `<option value="${s}">${s}</option>`);
    series.forEach(s => seriesSelect.innerHTML += `<option value="${s}">${s}</option>`);
}

document.getElementById("applyFilters").onclick = () => {
    const min = Number(document.getElementById("priceMin").value) || 0;
    const max = Number(document.getElementById("priceMax").value) || Infinity;
    const brand = document.getElementById("brandFilter").value;
    const socket = document.getElementById("socketFilter").value;
    const series = document.getElementById("seriesFilter").value;

    const filtered = allItems.filter(i => {
        if (i.price < min || i.price > max) return false;
        if (brand && i.brand !== brand) return false;
        if (socket && i.socket !== socket) return false;
        if (series && !i.name.includes(series)) return false;
        return true;
    });

    renderItems(filtered);
};

document.getElementById("clearFilters").onclick = () => {
    document.getElementById("priceMin").value = "";
    document.getElementById("priceMax").value = "";
    document.getElementById("brandFilter").value = "";
    document.getElementById("socketFilter").value = "";
    document.getElementById("seriesFilter").value = "";

    showOnlyCompatible = false;
    document.getElementById("toggleCompatible").textContent = "Показать только совместимые";

    renderItems(allItems);
};

/* ===============================
   КНОПКА "ТОЛЬКО СОВМЕСТИМЫЕ"
================================= */
document.getElementById("toggleCompatible").onclick = () => {
    showOnlyCompatible = !showOnlyCompatible;

    const btn = document.getElementById("toggleCompatible");
    btn.textContent = showOnlyCompatible
        ? "Показать все"
        : "Показать только совместимые";

    renderItems(allItems);
};

/* ===============================
   ЧТЕНИЕ ТЕКУЩЕЙ СБОРКИ
================================= */
function getSelectedPartsFromStorage() {
    const parts = {};
    Object.keys(CATEGORY_ENDPOINTS).forEach(key => {
        const saved = localStorage.getItem("selected_" + key);
        if (saved) {
            parts[key] = JSON.parse(saved);
        }
    });
    return parts;
}

/* ===============================
   ПРОВЕРКА СОВМЕСТИМОСТИ
================================= */
function checkCompatibility(categoryKey, item, selectedParts) {
    const cpu = selectedParts.cpu;
    const mb = selectedParts.motherboard;
    const ram = selectedParts.ram;
    const gpu = selectedParts.gpu;
    const psu = selectedParts.psu;
    const cooler = selectedParts.cooler;
    const pcCase = selectedParts.case;

    if (categoryKey === "motherboard" && cpu && item.socket !== cpu.socket)
        return "Сокет материнской платы не подходит к процессору";

    if (categoryKey === "cpu" && mb && item.socket !== mb.socket)
        return "Сокет процессора не подходит к материнской плате";

    if (categoryKey === "ram" && mb && item.type !== mb.memory_type)
        return "Тип оперативной памяти не подходит к материнской плате";

    if (categoryKey === "motherboard" && ram && ram.type !== item.memory_type)
        return "Материнская плата не поддерживает выбранную память";

    if (categoryKey === "gpu" && pcCase && item.length > pcCase.gpu_max_length)
        return "Видеокарта слишком длинная для корпуса";

    if (categoryKey === "case" && gpu && gpu.length > item.gpu_max_length)
        return "Корпус слишком маленький для видеокарты";

    if (categoryKey === "cooler" && pcCase && item.height > pcCase.cooler_max_height)
        return "Кулер слишком высокий для корпуса";

    if (categoryKey === "case" && cooler && cooler.height > item.cooler_max_height)
        return "Корпус слишком низкий для кулера";

    if (categoryKey === "psu" && gpu && item.power < gpu.recommended_psu)
        return "Мощности блока питания недостаточно для видеокарты";

    if (categoryKey === "gpu" && psu && psu.power < item.recommended_psu)
        return "Текущий блок питания слабый для этой видеокарты";

    return null;
}

/* ===============================
   РЕНДЕР КАРТОЧЕК
================================= */
function renderItems(items) {
    const list = document.getElementById("itemsList");
    list.innerHTML = "";
    list.style.opacity = "0";
    setTimeout(() => list.style.opacity = "1", 10);

    const selectedParts = getSelectedPartsFromStorage();

    items.forEach(item => {
        const reason = checkCompatibility(category, item, selectedParts);

        if (showOnlyCompatible && reason) return;

        const img = item.image || PLACEHOLDERS[category];

        const div = document.createElement("div");
        div.className = "product-card";

        if (reason) {
            div.classList.add("incompatible");
            div.setAttribute("data-reason", "❌ " + reason);
        } else if (Object.keys(selectedParts).length > 0) {
            div.classList.add("compatible");
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
}
const searchInput = document.getElementById("searchInput");

searchInput.addEventListener("input", () => {
    const query = searchInput.value.toLowerCase();

    const filtered = allItems.filter(item =>
        item.name.toLowerCase().includes(query)
    );

    renderItems(filtered);
});

/* ===============================
   ВЫБОР КОМПОНЕНТА
================================= */
function selectItem(item) {
    localStorage.setItem("selected_" + category, JSON.stringify(item));

    if (returnTo === "builder") {
        window.location.href = "builder.html";
        return;
    }

    window.location.href = `product.html?id=${item.id}&category=${category}`;
}

loadItems();
