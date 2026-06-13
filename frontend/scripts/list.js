/* eslint-disable no-undef */

const API_BASE = 'http://localhost:3001/api';

let pendingCategory = null;
let pendingItem = null;

/* набор фильтров */
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

/* эндпоинты */
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

/* плейсхолдеры */
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

/* параметры */
const params = new URLSearchParams(window.location.search);
const category = params.get("category");
const returnTo = params.get("return");
const forcedType = params.get("type");

/* названия */
const RU_NAMES = {
    cpu: "Процессоры",
    gpu: "Видеокарты",
    motherboard: "Материнские платы",
    ram: "Оперативная память",
    psu: "Блоки питания",
    case: "Корпуса",
    cooler: "Кулеры",
    storage: forcedType === "SSD" ? "SSD‑накопители" :
             forcedType === "HDD" ? "HDD‑накопители" :
             "Накопители"
};

document.getElementById("title").textContent = RU_NAMES[category] || category.toUpperCase();

let allItems = [];
let showOnlyCompatible = false;

/* модалка */
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

/* определение SSD/HDD */
function detectStorageType(item) {
    const name = item.name.toLowerCase();
    if (name.includes("ssd") || name.includes("nvme") || name.includes("m.2") || name.includes("m2"))
        return "SSD";
    return "HDD";
}

/* определение поколения CPU */
function detectCpuGeneration(name) {
    name = name.toLowerCase();

    // Intel
    if (name.includes("i3") || name.includes("i5") || name.includes("i7") || name.includes("i9")) {
        const match = name.match(/(\d{4,5})/);
        if (match) {
            const num = Number(match[1]);
            const gen = Math.floor(num / 1000);
            return "Intel " + gen;
        }
    }

    // Ryzen
    if (name.includes("ryzen")) {
        const match = name.match(/ryzen\s+(\d)/);
        if (match) {
            return "Ryzen " + match[1];
        }
    }

    return "";
}

/* загрузка */
async function loadItems() {
  const list = document.getElementById("itemsList");
  if (!list) return;
  list.innerHTML = "<p>Загрузка...</p>";

  try {
    const endpoint = CATEGORY_ENDPOINTS[category];
    if (!endpoint) {
      list.innerHTML = "<p>Неизвестная категория</p>";
      return;
    }

    const res = await fetch(`${API_BASE}/${endpoint}`);
    if (!res.ok) {
      list.innerHTML = `<p>Ошибка сервера: ${res.status}</p>`;
      return;
    }

    const data = await res.json();

    allItems = (Array.isArray(data) ? data : []).map(i => ({
      ...i,
      price: Number(i.price) || 0,
      gpu_length_limit: Number(i.gpu_length_limit || i.gpu_max_length || i.length || 0),
      cooler_height_limit: Number(i.cooler_height_limit || i.cooler_max_height || i.height || 0),
      tdp: Number(i.tdp || 0),
      power: Number(i.power || 0),
      recommended_psu: Number(i.recommended_psu || i.recommended_power || 0),
      type: category === "storage" ? detectStorageType(i) : null,
      generation: category === "cpu" ? detectCpuGeneration(i.name) : ""
    }));

    fillFilterOptions(allItems);
    applyFilterVisibility();
    renderItems(allItems);

  } catch (err) {
    list.innerHTML = "<p>Ошибка загрузки</p>";
  }
}

/* включение/выключение фильтров */
function applyFilterVisibility() {
    const active = FILTER_SETS[category] || [];

    document.querySelectorAll(".filter-block").forEach(block => {
        const filterName = block.dataset.filter;
        block.style.display = active.includes(filterName) ? "block" : "none";
    });
}

/* заполнение фильтров */
function fillFilterOptions(items) {
    const brandSelect = document.getElementById("brandFilter");
    const socketSelect = document.getElementById("socketFilter");
    const seriesSelect = document.getElementById("seriesFilter");
    const generationSelect = document.getElementById("generationFilter");

    const brands = new Set();
    const sockets = new Set();
    const series = new Set();
    const generations = new Set();

    items.forEach(i => {
        if (i.brand) brands.add(i.brand);
        if (i.socket) sockets.add(i.socket);

        if (i.name) {
            const parts = i.name.split(" ");
            if (parts.length > 1) series.add(parts[0] + " " + parts[1]);
        }

        if (i.generation) generations.add(i.generation);
    });

    brands.forEach(b => brandSelect.innerHTML += `<option value="${b}">${b}</option>`);
    sockets.forEach(s => socketSelect.innerHTML += `<option value="${s}">${s}</option>`);
    series.forEach(s => seriesSelect.innerHTML += `<option value="${s}">${s}</option>`);

    /* фильтруем только реальные поколения */
    const sorted = [...generations]
        .filter(g => /^Intel \d+$/.test(g) || /^Ryzen \d+$/.test(g))
        .sort((a, b) => {
            const [ab, ag] = a.split(" ");
            const [bb, bg] = b.split(" ");
            if (ab !== bb) return ab.localeCompare(bb);
            return Number(ag) - Number(bg);
        });

    sorted.forEach(g => generationSelect.innerHTML += `<option value="${g}">${g}‑е</option>`);
}

/* применение фильтров */
document.getElementById("applyFilters").onclick = () => {
    const min = Number(document.getElementById("priceMin").value) || 0;
    const max = Number(document.getElementById("priceMax").value) || Infinity;
    const brand = document.getElementById("brandFilter").value;
    const socket = document.getElementById("socketFilter").value;
    const series = document.getElementById("seriesFilter").value;
    const type = document.getElementById("typeFilter")?.value || "";
    const generation = document.getElementById("generationFilter")?.value || "";

    const filtered = allItems.filter(i => {
        if (forcedType && i.type !== forcedType) return false;
        if (type && i.type !== type) return false;
        if (generation && i.generation !== generation) return false;
        if (i.price < min || i.price > max) return false;
        if (brand && i.brand !== brand) return false;
        if (socket && i.socket !== socket) return false;
        if (series && !i.name.includes(series)) return false;
        return true;
    });

    renderItems(filtered);
};

/* сброс */
document.getElementById("clearFilters").onclick = () => {
    document.getElementById("priceMin").value = "";
    document.getElementById("priceMax").value = "";
    document.getElementById("brandFilter").value = "";
    document.getElementById("socketFilter").value = "";
    document.getElementById("seriesFilter").value = "";
    if (document.getElementById("typeFilter")) document.getElementById("typeFilter").value = "";
    if (document.getElementById("generationFilter")) document.getElementById("generationFilter").value = "";

    showOnlyCompatible = false;
    document.getElementById("toggleCompatible").textContent = "Показать только совместимые";

    renderItems(allItems);
};

/* совместимость */
document.getElementById("toggleCompatible").onclick = () => {
    showOnlyCompatible = !showOnlyCompatible;

    const btn = document.getElementById("toggleCompatible");
    btn.textContent = showOnlyCompatible
        ? "Показать все"
        : "Показать только совместимые";

    renderItems(allItems);
};

/* чтение сборки */
function getSelectedPartsFromStorage() {
    const parts = {};
    Object.keys(CATEGORY_ENDPOINTS).forEach(key => {
        const saved = localStorage.getItem("selected_" + key);
        if (saved) parts[key] = JSON.parse(saved);
    });
    return parts;
}

/* проверка совместимости */
function checkCompatibility(categoryKey, item, selectedParts) {
  const cpu = selectedParts.cpu;
  const mb = selectedParts.motherboard;
  const ram = selectedParts.ram;
  const gpu = selectedParts.gpu;
  const psu = selectedParts.psu;

  if (categoryKey === "motherboard" && cpu && item.socket && cpu.socket !== item.socket)
    return "Сокет материнской платы не подходит";

  if (categoryKey === "cpu" && mb && item.socket && mb.socket !== item.socket)
    return "Сокет процессора не подходит";

  if (categoryKey === "ram" && mb && item.type && mb.memory_type && item.type !== mb.memory_type)
    return "Тип памяти не подходит";

  const itemPower = Number(item.power || 0);
  const gpuTdp = Number(gpu ? gpu.tdp : 0);
  const psuPower = Number(psu ? psu.power : 0);

  if (categoryKey === "psu" && gpu && itemPower < gpuTdp)
      return "БП слабый для видеокарты";

  if (categoryKey === "gpu" && psu && gpuTdp > psuPower)
      return "БП слабый для этой видеокарты";

  return null;
}

/* рендер */
function renderItems(items) {
    const list = document.getElementById("itemsList");
    list.innerHTML = "";
    list.style.opacity = "0";
    setTimeout(() => list.style.opacity = "1", 10);

    const selectedParts = getSelectedPartsFromStorage();

    items.forEach(item => {
        if (forcedType && item.type !== forcedType) return;

        const reason = checkCompatibility(category, item, selectedParts);
        if (showOnlyCompatible && reason) return;

        const img = item.image || PLACEHOLDERS[category];

        const div = document.createElement("div");
        div.className = "product-card";

        if (reason) {
            div.classList.add("incompatible");
            div.setAttribute("data-reason", reason);
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

/* поиск */
const searchInput = document.getElementById("searchInput");

searchInput.addEventListener("input", () => {
    const query = searchInput.value.toLowerCase();
    const filtered = allItems.filter(item =>
        item.name.toLowerCase().includes(query)
    );
    renderItems(filtered);
});

/* выбор */
function selectItem(item) {
    localStorage.setItem("selected_" + category, JSON.stringify(item));

    if (returnTo === "builder") {
        window.location.href = "builder.html";
        return;
    }

    window.location.href = `product.html?id=${item.id}&category=${category}`;
}

loadItems();
