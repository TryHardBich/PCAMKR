/* eslint-disable no-undef */
const API_BASE = 'http://localhost:3001/api';

document.querySelectorAll('.cell').forEach(cell => {
    cell.addEventListener('click', () => {
        const category = cell.dataset.category;
        window.location.href = `list.html?category=${category}`;
    });
});
