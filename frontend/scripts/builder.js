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

/* Модалка совместимости */
const compatModal = document.getElementById("compatModal");
const compatModalText = document.getElementById("compatModalText");
const compatModalClose = document.getElementById("compatModalClose");

compatModalClose.onclick = () => compatModal.style.display = "none";
window.onclick = e => { if (e.target === compatModal) compatModal.style.display = "none"; };

function showCompatibilityError(text) {
    compatModalText.textContent = text;
    compatModal.style.display = "flex";
}

/* Проверка совместимости */
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

/* Загрузка выбранных компонентов */
function loadSelectedParts() {
    const parts = {};
    Object.keys(CATEGORY_NAMES).forEach(key => {
        const saved = localStorage.getItem("selected_" + key);
        if (saved) parts[key] = JSON.parse(saved);
    });
    return parts;
}

/* Удаление компонента */
function deletePart(key) {
    localStorage.removeItem("selected_" + key);
    renderBuilder();
}

/* Изменение компонента*/
function editPart(key) {
    window.location.href = `list.html?category=${key}&return=builder`;
}

/* Рендер строки */ 
function renderBuilder() {
    const partsList = document.getElementById("partsList");
    const summaryTable = document.getElementById("summaryTable");
    const totalPriceEl = document.getElementById("totalPrice");

    partsList.innerHTML = "";
    summaryTable.innerHTML = "";

    const selectedParts = loadSelectedParts();
    let total = 0;

    /* Левая панель */
    Object.keys(CATEGORY_NAMES).forEach(key => {
        const item = selectedParts[key];
        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${CATEGORY_NAMES[key]}</td>
            <td>${item ? item.name : "—"}</td>
            <td>${item && item.price ? item.price + " ₽" : "—"}</td>
        `;

        summaryTable.appendChild(row);

        if (item && item.price) {
            total += Number(item.price.toString().replace(/\D/g, "")); // тут короче ниче не работало, пришлось букавы туда сюда делать
}

    });

    totalPriceEl.textContent = total + " ₽";

    /* Правая таблица*/
    Object.keys(CATEGORY_NAMES).forEach(key => {
        const item = selectedParts[key];
        const row = document.createElement("tr");
        row.classList.add("animate-in");

        if (!item) {
            row.innerHTML = `
                <td>${CATEGORY_NAMES[key]}</td>
                <td><button onclick="editPart('${key}')">Выбрать</button></td>
                <td>—</td>
                <td>—</td>
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

                <td>${item.price ? item.price + " ₽" : "—"}</td>
            `;
        }

        partsList.appendChild(row);
    });
}

renderBuilder();
