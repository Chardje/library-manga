import type { IMangaTitleShort } from './models/IMangaTitleShort';

const api = 'http://localhost:5000'; // замініть на ваш API

export async function fetchPopularManga(): Promise<IMangaTitleShort[]> {
  const response = await fetch(api + '/MangaList/random?count=20');
  const data = await response.json();
  return data.$values;
}

export async function renderPopularMangaTable() {
  const mangaList = await fetchPopularManga();
  const container = document.getElementById('popular-manga');
  if (!container) return;

  // Візьмемо лише перші 9 манг
  const popular = mangaList.slice(0, 9);

  // Створюємо таблицю 3x3
  let tableHtml = '<table class="popular-table">';
  for (let row = 0; row < 3; row++) {
    tableHtml += '<tr>';
    for (let col = 0; col < 3; col++) {
      const idx = row * 3 + col;
      const manga = popular[idx];
      if (manga) {
        tableHtml += `
          <td>
            <div class="popular-manga-item" style="display: flex; align-items: center;">
              <img src="${manga.picture}" alt="${manga.title} cover" style="width:80px; height:auto; margin-right:10px;">
              <div>
                <h4 style="margin:3; color: var(--color-gray)">${manga.title}</h4>
                <p style="margin:3; color: var(--color-gray)">Status: ${manga.status}</p>
              </div>
            </div>
          </td>
        `;
      } else {
        tableHtml += '<td></td>';
      }
    }
    tableHtml += '</tr>';
  }
  tableHtml += '</table>';

  container.innerHTML = tableHtml;
}

window.addEventListener('DOMContentLoaded', () => {
  renderPopularMangaTable();
});