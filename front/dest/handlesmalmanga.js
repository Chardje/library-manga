console.log('handlesmalmanga.js loaded');
const api = 'http://localhost:5000';
document.querySelector('#app').innerHTML =
    `
<h1>Library Manga</h1>
<button id="random" type="button" onclick="getListManga()">RaNdOm</button>
<h2 id="greeting"></h2>
<div id="manga-list"></div>`;
getListManga();
function getListManga() {
    fetch(api + '/MangaList/random')
        .then(response => response.json())
        .then(data => {
        const appElem = document.querySelector('#app');
        if (appElem) {
            let mangaList = data;
            appElem.innerHTML = mangaList.map(manga => `
            <div class="manga">
              <h3>${manga.title}</h3>
              <img src="${manga.coverImage}" alt="${manga.title} cover">
              <p>Status: ${manga.status}</p>
              <p>Chapters: ${manga.chapters}</p>
            </div>
          `).join('');
        }
    });
}
;
export {};
