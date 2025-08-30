import type { IMangaTitleShort } from './models/IMangaTitleShort';

const api = 'http://localhost:5000';

async function getListManga() {
  try {
    const response = await fetch(`${api}/MangaList/random?count=1`);
    if (!response.ok) throw new Error('Network response was not ok');
    const mangaList = await response.json() as IMangaTitleShort[];
    const appElem = document.querySelector('#manga-list');
    if (appElem) {
      appElem.innerHTML = mangaList.map(manga => `
        <div class="popular-manga-item" style="justify-content: flex-start;">
          <img class="popular-manga-cover" src="${manga.picture}" alt="${manga.title} cover">
          <div style="text-align: left;">
            <h4 class="truncate-2-lines">${manga.title}</h4>
            <p>Status: ${manga.status}</p>
            <p>Chapters: ${manga.chapters}</p>
          </div>
        </div>
      `).join('');
    }
  } catch (error) {
    console.error('Failed to fetch manga:', error);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  document.querySelector<HTMLDivElement>('#app')!.innerHTML =
    `
      <h1>Library Manga</h1>
      <button id="random" type="button">random</button>
      <div id="manga-list"></div>
    `;
  document.querySelector('#random')!.addEventListener('click', getListManga);
});