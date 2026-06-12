/* eslint-disable no-undef */

const PARTS = [
  { key: "cpu",         name: "Процессор" },
  { key: "motherboard", name: "Материнская плата" },
  { key: "gpu",         name: "Видеокарта" },
  { key: "ram",         name: "Оперативная память" },
  { key: "storage",     name: "Накопитель" },
  { key: "psu",         name: "Блок питания" },
  { key: "cooler",      name: "Охлаждение" },
  { key: "case",        name: "Корпус" }
];

let selectedParts = {};

function init() {
  loadFromLocalStorage();

  const partsList = document.getElementById("partsList");

  PARTS.forEach(p => {
    const item = selectedParts[p.key];

    const row = document.createElement("tr");
    row.innerHTML = `
      <td>${p.name}</td>
      <td>
        <button class="select-btn" onclick="openList('${p.key}')">Выбрать</button>
        <button class="remove-btn" onclick="removePart('${p.key}')">✖</button>
      </td>
      <td id="price-${p.key}">${item ? Number(item.price) + " ₽" : "—"}</td>
    `;
    partsList.appendChild(row);
  });

  updateSummary();
}

function openList(category) {
  window.location.href = `list.html?category=${category}&return=builder`;
}

function removePart(category) {
  delete selectedParts[category];
  localStorage.removeItem("selected_" + category);
  document.getElementById(`price-${category}`).textContent = "—";
  updateSummary();
}

function loadFromLocalStorage() {
  PARTS.forEach(p => {
    const saved = localStorage.getItem("selected_" + p.key);
    if (saved) {
      selectedParts[p.key] = JSON.parse(saved);
    }
  });
}

function updateSummary() {
  const table = document.getElementById("summaryTable");
  table.innerHTML = "";

  let total = 0;

  PARTS.forEach(p => {
    const item = selectedParts[p.key];
    const price = item ? Number(item.price) : null;

    if (item) total += price;

    const row = document.createElement("tr");
    row.innerHTML = `
      <td>${p.name}</td>
      <td>${item ? item.name : "Не выбрано"}</td>
      <td>
        ${item ? price + " ₽" : "—"}
        ${item ? `<button class="remove-btn-small" onclick="removePart('${p.key}')">✖</button>` : ""}
      </td>
    `;
    table.appendChild(row);
  });

  document.getElementById("totalPrice").textContent = total + " ₽";
}

init();

// ===============================
// МОДАЛКА
// ===============================
const compatModal = document.getElementById("compatModal");
const compatModalText = document.getElementById("compatModalText");
const compatModalClose = document.getElementById("compatModalClose");

compatModalClose.onclick = () => compatModal.style.display = "none";
window.onclick = e => { if (e.target === compatModal) compatModal.style.display = "none"; };

// ===============================
// ПОКАЗАТЬ ОШИБКУ
// ===============================
function showCompatibilityError(text) {
    compatModalText.textContent = text;
    compatModal.style.display = "flex";
}

// ===============================
// ПРОВЕРКА СОВМЕСТИМОСТИ
// ===============================
function validateCompatibility() {
    const cpu = build.cpu;
    const mb = build.motherboard;
    const ram = build.ram;
    const gpu = build.gpu;
    const psu = build.psu;
    const cooler = build.cooler;
    const pcCase = build.case;

    // CPU ↔ Motherboard
    if (cpu && mb) {
        if (cpu.socket !== mb.socket) {
            showCompatibilityError("Процессор и материнская плата имеют разные сокеты");
            return false;
        }
    }

    // Motherboard ↔ RAM
    if (ram && mb) {
        if (ram.type !== mb.memory_type) {
            showCompatibilityError("Тип оперативной памяти не подходит к материнской плате");
            return false;
        }
    }

    // GPU ↔ Case
    if (gpu && pcCase) {
        if (gpu.length > pcCase.gpu_max_length) {
            showCompatibilityError("Видеокарта слишком длинная для корпуса");
            return false;
        }
    }

    // Cooler ↔ Case
    if (cooler && pcCase) {
        if (cooler.height > pcCase.cooler_max_height) {
            showCompatibilityError("Кулер слишком высокий для корпуса");
            return false;
        }
    }

    // PSU ↔ GPU
    if (gpu && psu) {
        if (psu.power < gpu.recommended_psu) {
            showCompatibilityError("Мощности блока питания недостаточно для видеокарты");
            return false;
        }
    }

    return true;
}
function selectPart(category, item) {

    // временно подставляем, чтобы проверить
    const old = build[category];
    build[category] = item;

    if (!validateCompatibility()) {
        build[category] = old; // откат
        return;
    }

    // сохраняем
    localStorage.setItem(category, JSON.stringify(item));

    updateSlot(category);
    updateSidePanel();
    updatePrice();
}
