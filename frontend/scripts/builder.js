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

    if (!slot) return;

    if (data) {
        slot.innerHTML = `
            <div class="part-left">
                <div class="part-name">${data.name}</div>
                <div class="part-info">${data.info}</div>
            </div>

            <div class="part-right">
                <div class="part-price">${data.price}</div>
                <button class="delete-btn">Удалить</button>
            </div>
        `;

        slot.querySelector(".delete-btn").addEventListener("click", () => {
            localStorage.removeItem(key);
            slot.innerHTML = "Не выбрано";
        });

    } else {
        slot.innerHTML = "Не выбрано";
    }
}


// Запуск
loadConfig();
