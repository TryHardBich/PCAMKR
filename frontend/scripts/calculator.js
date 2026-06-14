/* eslint-disable no-undef */
/* eslint-disable quotes */
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
  document.getElementById("mbSelected").textContent = "Не выбрано";
  document.getElementById("motherboardSelect").value = "";
  document.querySelectorAll(".mb-filters button").forEach(b => b.classList.remove("active"));
  document.getElementById("cpuSelected").textContent = "Не выбрано";
  document.getElementById("cpuSelect").value = "";
  document.querySelectorAll(".cpu-filters button").forEach(b => b.classList.remove("active"));
  document.getElementById("gpuSelected").textContent = "Не выбрано";
  document.getElementById("gpuSelect").value = "";
  document.querySelectorAll(".gpu-filters button").forEach(b => b.classList.remove("active"));

  renderMotherboardList();
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

// фильтры процессоров 

let cpuData = [];
let activeFiltersCPU = { socket: null };

// загрузка CPU
async function loadCPUsCustom() {
  const res = await fetch(`${API}/cpus`);
  const data = await res.json();
  cpuData = data;

  // заполняем скрытый select
  const select = document.getElementById("cpuSelect");
  select.innerHTML = `<option value="">Не выбрано</option>`;
  data.forEach(cpu => {
    select.innerHTML += `<option value="${cpu.tdp}">${cpu.name}</option>`;
  });

  renderCPUList();
}

// рендер списка
function renderCPUList() {
  const list = document.getElementById("cpuList");
  const search = document.getElementById("cpuSearch").value.toLowerCase();

  list.innerHTML = "";

  cpuData
    .filter(cpu => cpu.name.toLowerCase().includes(search))

    // фильтр по сокету
    .filter(cpu => {
      if (!activeFiltersCPU.socket) return true;

      const socket = cpu.socket
        .replace(/socket/i, "")
        .replace(/\s+/g, "")
        .trim()
        .toUpperCase();

      return socket === activeFiltersCPU.socket;
    })

    .forEach(cpu => {
      const div = document.createElement("div");
      div.className = "cpu-item";
      div.textContent = cpu.name;

      div.onclick = () => {
        document.getElementById("cpuSelected").textContent = cpu.name;
        document.getElementById("cpuDropdown").classList.remove("open");

        document.getElementById("cpuSelect").value = cpu.tdp;

        calculatePSU();
      };

      list.appendChild(div);
    });
}

// открытие/закрытие
document.getElementById("cpuSelected").onclick = () => {
  document.getElementById("cpuDropdown").classList.toggle("open");
};

// поиск
document.getElementById("cpuSearch").oninput = renderCPUList;

// фильтры
document.querySelectorAll(".cpu-filters button").forEach(btn => {
  btn.onclick = () => {
    const value = btn.dataset.filter;

    if (btn.classList.contains("active")) {
      btn.classList.remove("active");
      activeFiltersCPU.socket = null;
      renderCPUList();
      return;
    }

    btn.parentElement.querySelectorAll("button").forEach(b => b.classList.remove("active"));
    btn.classList.add("active");

    activeFiltersCPU.socket = value;

    renderCPUList();
  };
});

// запуск
loadCPUsCustom();

// фильтры видюх
let gpuData = [];
let activeFiltersGPU = { brand: null };

// загрузка GPU
async function loadGPUsCustom() {
  const res = await fetch(`${API}/gpus`);
  const data = await res.json();
  gpuData = data;

  // заполняем скрытый select
  const select = document.getElementById("gpuSelect");
  select.innerHTML = `<option value="">Не выбрано</option>`;
  data.forEach(gpu => {
    select.innerHTML += `<option value="${gpu.tdp}">${gpu.name}</option>`;
  });

  renderGPUList();
}

// рендер списка
function renderGPUList() {
  const list = document.getElementById("gpuList");
  const search = document.getElementById("gpuSearch").value.toLowerCase();

  list.innerHTML = "";

  gpuData
    .filter(gpu => gpu.name.toLowerCase().includes(search))

    // фильтр по бренду
    .filter(gpu => {
      if (!activeFiltersGPU.brand) return true;

      const brand = gpu.brand
        .trim()
        .toUpperCase();

      return brand === activeFiltersGPU.brand;
    })

    .forEach(gpu => {
      const div = document.createElement("div");
      div.className = "gpu-item";
      div.textContent = gpu.name;

      div.onclick = () => {
        document.getElementById("gpuSelected").textContent = gpu.name;
        document.getElementById("gpuDropdown").classList.remove("open");

        document.getElementById("gpuSelect").value = gpu.tdp;

        calculatePSU();
      };

      list.appendChild(div);
    });
}




// открытие/закрытие
document.getElementById("gpuSelected").onclick = () => {
  document.getElementById("gpuDropdown").classList.toggle("open");
};

// поиск
document.getElementById("gpuSearch").oninput = renderGPUList;

// фильтры
document.querySelectorAll(".gpu-filters button").forEach(btn => {
  btn.onclick = () => {
    const value = btn.dataset.filter;

    if (btn.classList.contains("active")) {
      btn.classList.remove("active");
      activeFiltersGPU.brand = null;
      renderGPUList();
      return;
    }

    btn.parentElement.querySelectorAll("button").forEach(b => b.classList.remove("active"));
    btn.classList.add("active");

    activeFiltersGPU.brand = value;

    renderGPUList();
  };
});

// запуск
loadGPUsCustom();


// фильтры материнок

// ===== КАСТОМНЫЙ SELECT ДЛЯ МАТЕРИНОК =====

let motherboardsData = [];
let activeFiltersMB = { socket: null, form: null };

// Загружаем материнки из API
async function loadMotherboardsCustom() {
  const res = await fetch(`${API}/motherboards`);
  const data = await res.json();
  motherboardsData = data;

  // Заполняем скрытый select (для расчёта)
  const select = document.getElementById("motherboardSelect");
  select.innerHTML = `<option value="">Не выбрано</option>`;
  data.forEach(mb => {
    select.innerHTML += `<option value="${mb.tdp}">${mb.name}</option>`;
  });

  renderMotherboardList();
}

// Рендер списка
function renderMotherboardList() {
  const list = document.getElementById("mbList");
  const search = document.getElementById("mbSearch").value.toLowerCase();

  list.innerHTML = "";

  motherboardsData
    .filter(mb => mb.name.toLowerCase().includes(search))

    // ФИЛЬТР ТОЛЬКО ПО СОКЕТУ
    .filter(mb => {
      if (!activeFiltersMB.socket) return true;

      const socket = mb.socket
        .replace(/socket/i, "")   // убираем "Socket"
        .replace(/\s+/g, "")      // убираем пробелы внутри
        .trim()
        .toUpperCase();           // нормализуем

      return socket === activeFiltersMB.socket;
    })

    // РЕНДЕР СПИСКА
    .forEach(mb => {
      const div = document.createElement("div");
      div.className = "mb-item";
      div.textContent = mb.name;

      div.onclick = () => {
        document.getElementById("mbSelected").textContent = mb.name;
        document.getElementById("mbDropdown").classList.remove("open");

        document.getElementById("motherboardSelect").value = mb.tdp;

        calculatePSU();
      };

      list.appendChild(div);
    });
}



// Открытие/закрытие
document.getElementById("mbSelected").onclick = () => {
  document.getElementById("mbDropdown").classList.toggle("open");
};

// Поиск
document.getElementById("mbSearch").oninput = renderMotherboardList;

// Фильтры
document.querySelectorAll(".mb-filters button").forEach(btn => {
  btn.onclick = () => {
    const value = btn.dataset.filter;

    // если кнопка уже активна → снимаем выбор
    if (btn.classList.contains("active")) {
      btn.classList.remove("active");

      if (["AM4","AM5","LGA1700"].includes(value)) {
        activeFiltersMB.socket = null;
      } else {
        activeFiltersMB.form = null;
      }

      renderMotherboardList();
      return;
    }

    // если кнопка НЕ активна → активируем
    // но снимаем активность только в этой группе
    btn.parentElement.querySelectorAll("button").forEach(b => b.classList.remove("active"));
    btn.classList.add("active");

    if (["AM4","AM5","LGA1700"].includes(value)) {
      activeFiltersMB.socket = value;
    } else {
      activeFiltersMB.form = value;
    }

    renderMotherboardList();
  };
});


document.getElementById("mbSelected").onclick = () => {
  document.getElementById("mbDropdown").classList.toggle("open");
};


// Запуск
loadMotherboardsCustom();



 // запрет уйти в отрицательные значения
document.querySelectorAll("input[type=number]").forEach(inp => {
  inp.addEventListener("input", () => {
    if (inp.value < 0) inp.value = 0;
  });
});
