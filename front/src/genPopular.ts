import type { IMangaTitleShort } from './models/IMangaTitleShort';

const api = 'http://localhost:5000';

export async function fetchPopularManga(): Promise<IMangaTitleShort[]> {
  const response = await fetch(`${api}/MangaList/random?count=20`);
  if (!response.ok) throw new Error('Network response was not ok');
  return (await response.json()) as IMangaTitleShort[];
}

export async function renderPopularMangaTable() {
  try {
    const mangaList = await fetchPopularManga();
    const container = document.getElementById('popular-manga');
    if (!container) return;

    const popular = mangaList.slice(0, 16);
    let tableHtml = '<table class="popular-table">';
    for (let row = 0; row < 4; row++) {
      tableHtml += '<tr>';
      for (let col = 0; col < 4; col++) {
        const idx = row * 4 + col;
        const manga = popular[idx];
        tableHtml += manga
          ? `<td>
              <a href="manga.html?id=${manga.id}" style="text-decoration:none;">
                <div class="popular-manga-item">
                  <div>
                    <h4 class="truncate-2-lines">${manga.title}</h4>
                    <p>Статус: ${manga.status}</p>
                  </div>
                  <img class="popular-manga-cover" src="${manga.picture}" alt="${manga.title} cover">
                </div>
              </a>
            </td>`
          : '<td></td>';
      }
      tableHtml += '</tr>';
    }
    tableHtml += '</table>';
    container.innerHTML = tableHtml;
  } catch (error) {
    console.error('Failed to fetch popular manga:', error);
  }
}

window.addEventListener('DOMContentLoaded', renderPopularMangaTable);