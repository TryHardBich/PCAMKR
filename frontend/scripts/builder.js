// Загружаем все компоненты при открытии конфигуратора
function loadConfig() {
    loadPart("cpu", "cpuSlot");
    loadPart("gpu", "gpuSlot");
    loadPart("motherboard", "motherboardSlot");
    loadPart("ram", "ramSlot");
    loadPart("psu", "psuSlot");
    loadPart("case", "caseSlot");
    loadPart("memory", "memorySlot");
    loadPart("cooler", "coolerSlot");
}

// Универсальная функция загрузки компонента
function loadPart(key, slotId) {
    const data = JSON.parse(localStorage.getItem(key));
    const slot = document.getElementById(slotId);

    if (!slot) return; // если слота нет — выходим

    if (data) {
        slot.innerHTML = `
            <b>${data.name}</b><br>
            ${data.info}<br>
            <span style="color:#ffd27f">${data.price}</span>
        `;
    } else {
        slot.innerHTML = "Не выбрано";
    }
}

// Запуск
loadConfig();
