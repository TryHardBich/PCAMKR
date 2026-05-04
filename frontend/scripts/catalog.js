// Простейшие данные для примера
const catalogData = {
  cpu: [
    { name: "Ryzen 5 5600", info: "AM4, 6 ядер, 12 потоков", price: "9 990 ₽" },
    { name: "Core i5-12400F", info: "LGA1700, 6 ядер, 12 потоков", price: "11 500 ₽" }
  ],
  gpu: [
    { name: "RTX 3060", info: "12 ГБ, GDDR6", price: "24 990 ₽" },
    { name: "RX 6600", info: "8 ГБ, GDDR6", price: "19 990 ₽" }
  ],
  motherboard: [
    { name: "MSI B550-A PRO", info: "AM4, ATX", price: "10 990 ₽" },
    { name: "ASUS PRIME B660M-A", info: "LGA1700, mATX", price: "9 990 ₽" }
  ],
  ram: [
    { name: "16 ГБ DDR4", info: "2×8 ГБ, 3200 МГц", price: "4 500 ₽" },
    { name: "32 ГБ DDR4", info: "2×16 ГБ, 3600 МГц", price: "8 900 ₽" }
  ],
  psu: [
    { name: "650W 80+ Bronze", info: "Полумодульный", price: "5 500 ₽" }
  ],
  case: [
    { name: "ATX корпус с стеклом", info: "3 вентилятора в комплекте", price: "4 200 ₽" }
  ],
  cooler: [
    { name: "Башенный кулер", info: "120 мм, до 150W TDP", price: "2 300 ₽" }
  ],
  ssd: [
    { name: "SSD 500 ГБ", info: "NVMe, PCIe 3.0", price: "3 500 ₽" }
  ],
  hdd: [
    { name: "HDD 1 ТБ", info: "7200 об/мин", price: "3 000 ₽" }
  ]
};

const modal = document.getElementById("modal");
const modalTitle = document.getElementById("modalTitle");
const modalList = document.getElementById("modalList");
const closeBtn = document.querySelector(".close-modal");

// Открыть модалку с товарами категории
function openModal(category, title) {
  modalTitle.textContent = title;
  modalList.innerHTML = "";

  const items = catalogData[category] || [];

  if (!items.length) {
    modalList.innerHTML = "<p>Товары этой категории пока не добавлены.</p>";
  } else {
    items.forEach(item => {
      const div = document.createElement("div");
      div.className = "modal-item";
        div.innerHTML = `
          <div class="left-block">
            <div class="item-name">${item.name}</div>
            <div class="item-desc">${item.info}</div>
          </div>

          <div class="right-block">
            <div class="item-price">${item.price}</div>

            <div class="btn-row">
              <button class="choose-btn">Выбрать</button>
            </div>
`;
      div.querySelector(".choose-btn").addEventListener("click", () => {
        selectItem(category, item);
      });

      modalList.appendChild(div);
    });
  }

  modal.classList.add("open");
}

// Закрыть модалку
function closeModal() {
  modal.classList.remove("open");
}

// Сохранить выбор и перейти в конфигуратор
function selectItem(category, item) {
  // маппинг для твоего билдера: ssd/hdd → memory
  let key = category;
  if (category === "ssd" || category === "hdd") {
    key = "memory";
  }

  localStorage.setItem(key, JSON.stringify(item));
  window.location.href = "/builder"; // замени на свой URL конфигуратора
}

// Навешиваем обработчики
document.addEventListener("DOMContentLoaded", () => {
  const cells = document.querySelectorAll(".cell");

  cells.forEach(cell => {
    cell.addEventListener("click", (e) => {
      e.preventDefault();
      const category = cell.dataset.category;
      const title = cell.textContent.trim();
      openModal(category, title);
    });
  });

  closeBtn.addEventListener("click", closeModal);

  modal.addEventListener("click", (e) => {
    if (e.target === modal) closeModal();
  });
});
