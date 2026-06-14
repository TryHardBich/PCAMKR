/* eslint-disable quotes */
/* eslint-disable no-undef */

const CATEGORY_NAMES = {
    cpu: "Процессор",
    motherboard: "Материнская плата",
    gpu: "Видеокарта",
    ram: "Оперативная память",
    storage: "Накопитель",
    psu: "Блок питания",
    cooler: "Охлаждение",
    case: "Корпус"
};

// модалка совместимости
const compatModal = document.getElementById("compatModal");
const compatModalText = document.getElementById("compatModalText");
const compatModalClose = document.getElementById("compatModalClose");

compatModalClose.onclick = () => compatModal.style.display = "none";
window.onclick = e => { if (e.target === compatModal) compatModal.style.display = "none"; };

// функция очистки всех компонентов
function clearAllComponents() {
    Object.keys(CATEGORY_NAMES).forEach(key => {
        localStorage.removeItem("selected_" + key);
    });
    renderBuilder();
}

// Кнопка очистки
const clearAllBtn = document.getElementById("clearAllBtn");
if (clearAllBtn) {
    clearAllBtn.onclick = clearAllComponents;
}

function showCompatibilityError(text) {
    compatModalText.textContent = text;
    compatModal.style.display = "flex";
}

function checkCompatibility(categoryKey, item, selectedParts) {
  const cpu = selectedParts.cpu;
  const mb = selectedParts.motherboard;
  const ram = selectedParts.ram;
  const gpu = selectedParts.gpu;
  const psu = selectedParts.psu;
  const cooler = selectedParts.cooler;
  const pcCase = selectedParts.case;

  // сокеты и память — без изменений
  if (categoryKey === "motherboard" && cpu && item.socket && cpu.socket && item.socket !== cpu.socket)
    return "Сокет материнской платы не подходит к процессору";
  if (categoryKey === "cpu" && mb && item.socket && mb.socket && item.socket !== mb.socket)
    return "Сокет процессора не подходит к материнской плате";
  if (categoryKey === "ram" && mb && item.type && mb.memory_type && item.type !== mb.memory_type)
    return "Тип оперативной памяти не подходит к материнской плате";

  // Нормализуем мощности и TDP
  const itemPower = Number(item.power || item.watt || item.max_power || 0);
  const gpuTdp = Number(gpu ? (gpu.tdp || gpu.recommended_psu || gpu.recommended_power || 0) : 0);
  const psuPower = Number(psu ? (psu.power || psu.watt || psu.max_power || 0) : 0);

  // PSU выбранный vs GPU
  if (categoryKey === "psu" && gpu) {
    if (itemPower > 0 && gpuTdp > 0 && itemPower < gpuTdp)
      return "Мощности блока питания недостаточно для видеокарты";
  }

  // GPU выбранный vs PSU
  if (categoryKey === "gpu" && psu) {
    if (psuPower > 0 && Number(item.tdp || item.recommended_psu || item.recommended_power || 0) > psuPower)
      return "Текущий блок питания слабый для этой видеокарты";
  }

  return null;
}


// загрузка выбранных компонентов
function loadSelectedParts() {
    const parts = {};
    Object.keys(CATEGORY_NAMES).forEach(key => {
        const saved = localStorage.getItem("selected_" + key);
        if (saved) parts[key] = JSON.parse(saved);
    });
    return parts;
}

// удаление компонента
function deletePart(key) {
    localStorage.removeItem("selected_" + key);
    renderBuilder();
}

// изменение компонента
function editPart(key) {
    window.location.href = `list.html?category=${key}&return=builder`;
}

// форматирование цены
function formatPrice(price) {
    if (!price && price !== 0) return "—";
    // Очищаем от нецифровых символов и форматируем
    const cleanPrice = String(price).replace(/\D/g, "");
    if (!cleanPrice || cleanPrice === "0") return "—";
    return new Intl.NumberFormat('ru-RU').format(Number(cleanPrice)) + " ₽";
}

// рендер строки
function renderBuilder() {
    const partsList = document.getElementById("partsList");
    const summaryTable = document.getElementById("summaryTable");
    const totalPriceEl = document.getElementById("totalPrice");

    partsList.innerHTML = "";
    summaryTable.innerHTML = "";

    const selectedParts = loadSelectedParts();
    let total = 0;

    // левая панель (сводка)
    Object.keys(CATEGORY_NAMES).forEach(key => {
        const item = selectedParts[key];
        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${CATEGORY_NAMES[key]}</td>
            <td>${item ? item.name : "—"}</td>
            <td class="price-cell">${item && item.price ? formatPrice(item.price) : "—"}</td>
        `;

        summaryTable.appendChild(row);

        if (item && item.price) {
            const cleanPrice = String(item.price).replace(/\D/g, "");
            if (cleanPrice) total += Number(cleanPrice);
        }
    });

    totalPriceEl.textContent = formatPrice(total);

    // правая таблица
    Object.keys(CATEGORY_NAMES).forEach(key => {
        const item = selectedParts[key];
        const row = document.createElement("tr");
        row.classList.add("animate-in");

        if (!item) {
            row.innerHTML = `
                <td>${CATEGORY_NAMES[key]}</td>
                <td><button onclick="editPart('${key}')">Выбрать</button></td>
                <td>—</td>
                <td class="price-cell">—</td>
            `;
        } else {
            const reason = checkCompatibility(key, item, selectedParts);
            const compatText = reason ? `${reason}` : "Совместимо";
            const compatClass = reason ? "incompat" : "compat";

            row.innerHTML = `
                <td>${CATEGORY_NAMES[key]}</td>
                <td>
                    <button onclick="editPart('${key}')">Изменить</button>
                    <button onclick="deletePart('${key}')">Удалить</button>
                </td>
                <td class="${compatClass}">${compatText}</td>
                <td class="price-cell">${item.price ? formatPrice(item.price) : "—"}</td>
            `;
        }

        partsList.appendChild(row);
    });
}

renderBuilder();
