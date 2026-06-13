const API = "http://localhost:3001/api";

// загрузка из бд
async function loadOptions(endpoint, selectId) {
  try {
    const res = await fetch(`${API}/${endpoint}`);
    const data = await res.json();

    const select = document.getElementById(selectId);
    select.innerHTML = `<option value="">Не выбрано</option>`;

    data.forEach(item => {
      select.innerHTML += `<option value="${item.tdp}">${item.name} (${item.tdp} Вт)</option>`;
    });

  } catch (err) {
    console.error("Ошибка загрузки:", endpoint, err);
  }
}

// автоапдейт
function autoUpdate() {
  calculatePSU();
}
window.addEventListener("DOMContentLoaded", () => {
  document.querySelector(".page-layout").classList.add("loaded");
});

// рассчет мощности
function calculatePSU() {
  const cpu = Number(document.getElementById("cpuSelect").value) || 0;
  const gpu = Number(document.getElementById("gpuSelect").value) || 0;
  const motherboard = Number(document.getElementById("motherboardSelect").value) || 0;

  const ramModules = Number(document.getElementById("ramModules").value) || 0;
  const ramWatts = ramModules * 5;

  const drives = Number(document.getElementById("drives").value) || 0;
  const drivesWatts = drives * 5;

  const fans = Number(document.getElementById("fans").value) || 0;
  const fansWatts = fans * 3;

  let extrasWatts = 0;
  document.querySelectorAll(".extra-part:checked").forEach(ch => {
    extrasWatts += Number(ch.dataset.watt);
  });

  const sum = cpu + gpu + motherboard + ramWatts + drivesWatts + fansWatts + extrasWatts;

  if (sum <= 0) {
    showResult("Вы ничего не выбрали");
    return;
  }

  // Точный расчёт + запас 25%
  const withHeadroom = Math.round(sum * 1.25);

  showResult(`${withHeadroom} Вт`);
}

// вывод
function showResult(text) {
  document.getElementById("resultValue").textContent = text;
}

// удалить
function clearAll() {
  document.querySelectorAll("select").forEach(s => s.value = "");
  document.querySelectorAll("input").forEach(i => i.value = "");
  document.querySelectorAll(".extra-part").forEach(ch => ch.checked = false);

  showResult("Вы ничего не выбрали");
}

// аккордеон
function toggleFilter(headerEl) {
  const group = headerEl.parentElement;
  group.classList.toggle("open");
}
// инициализация
document.addEventListener("DOMContentLoaded", async () => {
  await loadOptions("cpus", "cpuSelect");
  await loadOptions("gpus", "gpuSelect");
  await loadOptions("motherboards", "motherboardSelect");

  document.querySelectorAll("select, input").forEach(el => {
    el.addEventListener("input", autoUpdate);
    el.addEventListener("change", autoUpdate);
  });

  document.getElementById("clearBtn").addEventListener("click", clearAll);
});

 // запрет уйти в отрицательные значения
document.querySelectorAll("input[type=number]").forEach(inp => {
  inp.addEventListener("input", () => {
    if (inp.value < 0) inp.value = 0;
  });
});
