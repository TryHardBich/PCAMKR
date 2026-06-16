/* eslint-disable quotes */
/* eslint-disable no-undef */

const API_BASE = "http://localhost:3001/api";

const CATEGORY_ENDPOINTS = {
  cpu: "cpus",
  gpu: "gpus",
  motherboard: "motherboards",
  ram: "rams",
  psu: "psus",
  case: "cases",
  cooler: "coolers",
  storage: "storages",
};

const PLACEHOLDERS = {
  cpu: "images/placeholders/cpu.svg",
  gpu: "images/placeholders/gpu.svg",
  motherboard: "images/placeholders/motherboard.svg",
  ram: "images/placeholders/ram.svg",
  psu: "images/placeholders/psu.svg",
  case: "images/placeholders/case.svg",
  cooler: "images/placeholders/cooler.svg",
  storage: "images/placeholders/storage.svg",
};

const FILTER_SETS = {
  cpu: ["brand", "socket", "generation", "price"],
  motherboard: ["brand", "socket", "chipset", "price"],
  gpu: ["brand", "model", "price"],
  ram: ["brand", "type", "frequency", "capacity", "price"],
  storage: ["brand", "type", "capacity", "interface", "price"],
  psu: ["brand", "power", "certificate", "modular", "price"],
  cooler: ["brand", "height", "type", "price"],
  case: [
    "brand",
    "formfactor",
    "gpu_length_limit",
    "cooler_height_limit",
    "price",
  ],
};

const RU_NAMES = {
  cpu: "Процессоры",
  gpu: "Видеокарты",
  motherboard: "Материнские платы",
  ram: "Оперативная память",
  psu: "Блоки питания",
  case: "Корпуса",
  cooler: "Кулеры",
  storage: "Накопители",
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
window.onclick = (e) => {
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

  localStorage.setItem(
    "selected_" + pendingCategory,
    JSON.stringify(pendingItem),
  );
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

// функция извлечения модели видеокарты
function extractGpuModel(name) {
  if (!name) return "Другое";

  const upperName = name.toUpperCase();

  // RTX серия
  if (upperName.includes("RTX 5090")) return "RTX 5090";
  if (upperName.includes("RTX 5080")) return "RTX 5080";
  if (upperName.includes("RTX 5070 TI")) return "RTX 5070 Ti";
  if (upperName.includes("RTX 5070")) return "RTX 5070";
  if (upperName.includes("RTX 5060 TI")) return "RTX 5060 Ti";
  if (upperName.includes("RTX 5060")) return "RTX 5060";
  if (upperName.includes("RTX 4090")) return "RTX 4090";
  if (upperName.includes("RTX 4080")) return "RTX 4080";
  if (upperName.includes("RTX 4070 TI")) return "RTX 4070 Ti";
  if (upperName.includes("RTX 4070")) return "RTX 4070";
  if (upperName.includes("RTX 4060 TI")) return "RTX 4060 Ti";
  if (upperName.includes("RTX 4060")) return "RTX 4060";
  if (upperName.includes("RTX 3090")) return "RTX 3090";
  if (upperName.includes("RTX 3080")) return "RTX 3080";
  if (upperName.includes("RTX 3070")) return "RTX 3070";
  if (upperName.includes("RTX 3060")) return "RTX 3060";
  if (upperName.includes("RTX 3050")) return "RTX 3050";

  // RX серия
  if (upperName.includes("RX 7900")) return "RX 7900";
  if (upperName.includes("RX 7800 XT")) return "RX 7800 XT";
  if (upperName.includes("RX 7700")) return "RX 7700";
  if (upperName.includes("RX 7600")) return "RX 7600";
  if (upperName.includes("RX 6900")) return "RX 6900";
  if (upperName.includes("RX 6800")) return "RX 6800";
  if (upperName.includes("RX 6700")) return "RX 6700";
  if (upperName.includes("RX 6600")) return "RX 6600";
  if (upperName.includes("RX 6500")) return "RX 6500";

  // GTX серия
  if (upperName.includes("GTX 1660")) return "GTX 1660";
  if (upperName.includes("GTX 1650")) return "GTX 1650";
  if (upperName.includes("GTX 1080")) return "GTX 1080";
  if (upperName.includes("GTX 1070")) return "GTX 1070";
  if (upperName.includes("GTX 1060")) return "GTX 1060";

  return "Другое";
}

// Функция сортировки моделей по возрастанию
function sortModelsByNumber(models) {
  const order = [
    "GTX 1060",
    "GTX 1070",
    "GTX 1080",
    "GTX 1650",
    "GTX 1660",
    "RTX 3050",
    "RTX 3060",
    "RTX 3070",
    "RTX 3080",
    "RTX 3090",
    "RTX 4060",
    "RTX 4060 Ti",
    "RTX 4070",
    "RTX 4070 Ti",
    "RTX 4080",
    "RTX 4090",
    "RTX 5060",
    "RTX 5060 Ti",
    "RTX 5070",
    "RTX 5070 Ti",
    "RTX 5080",
    "RTX 5090",
    "RX 6500",
    "RX 6600",
    "RX 6700",
    "RX 6800",
    "RX 6900",
    "RX 7600",
    "RX 7700",
    "RX 7800 XT",
    "RX 7900",
    "Другое",
  ];

  return models.sort((a, b) => {
    const indexA = order.indexOf(a);
    const indexB = order.indexOf(b);
    if (indexA === -1 && indexB === -1) return a.localeCompare(b);
    if (indexA === -1) return 1;
    if (indexB === -1) return -1;
    return indexA - indexB;
  });
}

// Функция заполнения фильтра моделей

function fillModelFilter(items) {
  const modelSelect = document.getElementById("modelFilter");
  if (!modelSelect) {
    console.log("modelFilter not found");
    return;
  }

  modelSelect.innerHTML = '<option value="">Все</option>';

  const models = new Set();

  items.forEach((item) => {
    const model = extractGpuModel(item.name);
    models.add(model);
  });

  const sortedModels = sortModelsByNumber([...models]);

  console.log("Found models:", sortedModels);

  sortedModels.forEach((model) => {
    const option = document.createElement("option");
    option.value = model;
    option.textContent = model;
    modelSelect.appendChild(option);
  });
}

function detectStorageType(item) {
  const name = (item.name || "").toLowerCase();
  if (
    name.includes("ssd") ||
    name.includes("nvme") ||
    name.includes("m.2") ||
    name.includes("m2")
  ) {
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

  document.querySelectorAll(".filter-block").forEach((block) => {
    const filterName = block.dataset.filter;
    block.style.display = active.includes(filterName) ? "block" : "none";
  });
}

function fillFilterOptions(items) {
  const brandSelect = document.getElementById("brandFilter");
  const socketSelect = document.getElementById("socketFilter");
  const generationSelect = document.getElementById("generationFilter");

  if (brandSelect) brandSelect.innerHTML = '<option value="">Все</option>';
  if (socketSelect) socketSelect.innerHTML = '<option value="">Все</option>';
  if (generationSelect)
    generationSelect.innerHTML = '<option value="">Все</option>';

  const brands = new Set();
  const sockets = new Set();
  const generations = new Set();

  items.forEach((i) => {
    if (i.brand) brands.add(i.brand);
    if (i.socket) sockets.add(i.socket);
    if (i.generation) generations.add(i.generation);
  });

  brands.forEach((b) => {
    if (brandSelect)
      brandSelect.innerHTML += `<option value="${b}">${b}</option>`;
  });

  const allSockets = [...sockets];
  const trimmedSockets = allSockets.map((socket) => {
    if (socket.startsWith("Socket")) {
      const socketDivided = socket.split("Socket ");
      return socketDivided[1];
    }
    return socket;
  });
  const intel = trimmedSockets.filter((s) => s.toUpperCase().includes("LGA"));
  const amd = trimmedSockets.filter((s) => s.toUpperCase().includes("AM"));
  const tr = trimmedSockets.filter((s) => s.toUpperCase().includes("TR"));
  const str = trimmedSockets.filter((s) => s.toUpperCase().includes("STR"));

  const sortByNum = (a, b) =>
    (parseInt(a.replace(/\D/g, "")) || 0) -
    (parseInt(b.replace(/\D/g, "")) || 0);

  intel.sort(sortByNum);
  amd.sort(sortByNum);
  tr.sort(sortByNum);
  str.sort(sortByNum);

  [...intel, ...amd, ...tr, ...str].forEach((s) => {
    if (socketSelect)
      socketSelect.innerHTML += `<option value="${s}">${s}</option>`;
  });

  [...generations].sort().forEach((g) => {
    if (generationSelect)
      generationSelect.innerHTML += `<option value="${g}">${g}</option>`;
  });

  // Заполняем фильтр моделей только для видеокарт

  if (category === "gpu") {
    fillModelFilter(items);
  }
}

// загрузка данных

async function loadItems() {
  const list = document.getElementById("itemsList");
  list.innerHTML = "<p>Загрузка...</p>";

  try {
    const endpoint = CATEGORY_ENDPOINTS[category];
    const res = await fetch(`${API_BASE}/${endpoint}`);
    const data = await res.json();

    allItems = data.map((i) => ({
      ...i,
      price: Number(i.price) || 0,
      type: category === "storage" ? detectStorageType(i) : null,
      generation: category === "cpu" ? detectCpuGeneration(i.name) : "",
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

// пагинация

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

  function addButton(label, page, disabled = false, active = false) {
    const btn = document.createElement("button");
    btn.textContent = label;

    btn.className = "page-btn";
    if (active) btn.classList.add("active");
    if (disabled) btn.disabled = true;

    if (!disabled && !active) {
      btn.onclick = () => {
        currentPage = page;
        renderItems();
      };
    }

    container.appendChild(btn);
  }

  addButton("←", currentPage - 1, currentPage === 1);
  addButton(1, 1, false, currentPage === 1);

  if (currentPage > 4) {
    addButton("...", null, true);
  }

  for (let p = currentPage - 1; p <= currentPage + 1; p++) {
    if (p > 1 && p < totalPages) {
      addButton(p, p, false, p === currentPage);
    }
  }

  if (currentPage < totalPages - 3) {
    addButton("...", null, true);
  }

  if (totalPages > 1) {
    addButton(totalPages, totalPages, false, currentPage === totalPages);
  }

  addButton("→", currentPage + 1, currentPage === totalPages);
}

// совместимость

function getSelectedPartsFromStorage() {
  const parts = {};
  Object.keys(CATEGORY_ENDPOINTS).forEach((key) => {
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

  const needsTrimming = item.socket && item.socket.startsWith("Socket");

  if (needsTrimming) {
    const socketDivided = item.socket.split("Socket ");
    item.socket = socketDivided[1];
  }

  if (mb && mb.socket.startsWith("Socket")) {
    console.log(mb);
    const mbToBeTrimmed = mb.socket.split("Socket ");
    mb.socket = mbToBeTrimmed[1];
  }

  if (categoryKey === "motherboard" && cpu && item.socket !== cpu.socket) {
    return "Сокет материнской платы не подходит";
  }

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

// фильтры

function enableLiveFilters() {
  const ids = [
    "priceMin",
    "priceMax",
    "brandFilter",
    "socketFilter",
    "modelFilter",
    "typeFilter",
    "generationFilter",
    "searchInput",
  ];

  ids.forEach((id) => {
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
  const model = document.getElementById("modelFilter")?.value || "";
  const type = document.getElementById("typeFilter")?.value || "";
  const generation = document.getElementById("generationFilter")?.value || "";
  const q = (document.getElementById("searchInput")?.value || "").toLowerCase();

  filteredItems = allItems.filter((i) => {
    if (forcedType && i.type !== forcedType) return false;
    if (type && i.type !== type) return false;
    if (i.price < min || i.price > max) return false;
    if (brand && i.brand !== brand) return false;
    if (socket && i.socket !== socket) return false;

    if (model && category === "gpu") {
      const itemModel = extractGpuModel(i.name);
      if (itemModel !== model) return false;
    }

    if (generation && i.generation !== generation) return false;
    if (q && !i.name.toLowerCase().includes(q)) return false;
    return true;
  });

  currentPage = 1;
  renderItems();
}

// Кнопка "только совместимые"

const toggleBtn = document.getElementById("toggleCompatible");
if (toggleBtn) {
  toggleBtn.onclick = () => {
    showOnlyCompatible = !showOnlyCompatible;
    toggleBtn.textContent = showOnlyCompatible
      ? "Показать все"
      : "Показать только совместимые";
    currentPage = 1;
    renderItems();
  };
}

// Кнопка "сбросить фильтры"

const clearBtn = document.getElementById("clearFilters");
if (clearBtn) {
  clearBtn.onclick = () => {
    const ids = [
      "priceMin",
      "priceMax",
      "brandFilter",
      "socketFilter",
      "modelFilter",
      "typeFilter",
      "generationFilter",
      "searchInput",
    ];

    ids.forEach((id) => {
      const el = document.getElementById(id);
      if (!el) return;
      if (el.tagName === "SELECT" || el.tagName === "INPUT") el.value = "";
    });

    showOnlyCompatible = false;
    const toggleBtn = document.getElementById("toggleCompatible");
    if (toggleBtn) toggleBtn.textContent = "Показать только совместимые";

    filteredItems = [...allItems];
    currentPage = 1;
    renderItems();
  };
}

// рендер списка

function renderItems() {
  const list = document.getElementById("itemsList");
  list.innerHTML = "";

  const selectedParts = getSelectedPartsFromStorage();
  const pageItems = paginate(filteredItems);

  pageItems.forEach((item) => {
    const reason = checkCompatibility(category, item, selectedParts);
    if (showOnlyCompatible && reason) return;

    const img = item.img_url || PLACEHOLDERS[category];

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

// выбор товара
function selectItem(item) {
  localStorage.setItem("selected_" + category, JSON.stringify(item));

  if (returnTo === "builder") {
    window.location.href = "builder.html";
    return;
  }

  window.location.href = `product.html?id=${item.id}&category=${category}`;
}

loadItems();
