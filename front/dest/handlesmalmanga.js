const api = 'http://localhost:5000';
function getListManga() {
    fetch(api + '/RandomManga/random?count=8')
        .then(response => response.json())
        .then(data => {
        const appElem = document.querySelector('#manga-list');
        if (appElem) {
            let mangaList = data;
            appElem.innerHTML = mangaList.map(manga => `
          <div class="manga">
            <h3>${manga.title}</h3>
            <img src="${manga.coverImage}" alt="${manga.title} cover">
            <img src="data:image/jpeg;base64,https://manga.in.ua/uploads/posts/2025-06/1751094153_poster_112.png" alt="${123123} cover">
            
            <p>Status: ${manga.status}</p>
            <p>Chapters: ${manga.chapters}</p>
          </div>
        `).join('');
        }
    });
}
;
document.addEventListener('DOMContentLoaded', () => {
    document.querySelector('#app').innerHTML =
        `
      <h1>Library Manga</h1>
      <button id="random" type="button">random</button>
      <div id="manga-list"></div>
    `;
    document.querySelector('#random').addEventListener('click', getListManga);
});
export {};
