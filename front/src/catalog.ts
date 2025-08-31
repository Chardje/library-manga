import { IGenre } from './models/IGenre';
import { IMangaTitleShort } from './models/IMangaTitleShort';

fetch('header.html').then(r => r.text()).then(t => {
  const headerEl = document.getElementById('header');
  if (headerEl) headerEl.innerHTML = t;
});
fetch('footer.html').then(r => r.text()).then(t => {
  const footerEl = document.getElementById('footer');
  if (footerEl) footerEl.innerHTML = t;
});

async function loadGenres(): Promise<void> {
  const res = await fetch('http://localhost:5000/Dump/genres');
  if (!res.ok) return;
  const genres: IGenre[] = await res.json();
  const genresList = document.getElementById('catalog-genres-list');
  if (!genresList) return;
  genresList.innerHTML = genres.map((g) =>
    `<label style="display:block;margin-bottom:2px;">
      <input type="checkbox" name="genres" value="${g.name}"> ${g.name}
    </label>`
  ).join('');
}
loadGenres();

async function searchManga(params: Record<string, string | string[]> = {}): Promise<void> {
  const results = document.getElementById('catalog-results');
  if (results) {
    results.innerHTML = '<div style="grid-column:span 5;color:#888;">Завантаження...</div>';
  }
  const url = new URL('http://localhost:5000/MangaSearch');
  Object.entries(params).forEach(([k, v]) => {
    if (v !== undefined && v !== null && v !== '') {
      if (Array.isArray(v)) {
        v.forEach(val => url.searchParams.append(k, val));
      } else {
        url.searchParams.append(k, v as string);
      }
    }
  });
  url.searchParams.set('count', '50');
  const res = await fetch(url.toString());
  if (!results) return;
  results.innerHTML = '';
  if (!res.ok) {
    results.innerHTML = '<div style="grid-column:span 5;color:#d16e6e;">Нічого не знайдено</div>';
    return;
  }
  const mangas: IMangaTitleShort[] = await res.json();
  // Обмежуємо до 50 манг
  const limitedMangas = mangas.slice(0, 50);
  const rows: string[] = [];
  for (let i = 0; i < 10; i++) {
    const cols: string[] = [];
    for (let j = 0; j < 5; j++) {
      const idx = i * 5 + j;
      const m = limitedMangas[idx];
      if (m) {
        cols.push(
          `<td>
            <div class="catalog-slide shadow">
              <div class="catalog-slide-content">
                <div class="aspect-ratio-wrapper">
                  <div class="aspect-ratio-inner">
                    <a class="aspect-ratio-link" href="manga.html?id=${m.id}">
                      <img
                        alt="Poster"
                        loading="lazy"
                        width="150"
                        height="225"
                        decoding="async"
                        class="aspect-ratio-img"
                        src="${m.picture || 'default-poster.png'}"
                      >
                    </a>
                  </div>
                </div>
                <a class="mt-1 truncate catalog-slide-title" href="manga.html?id=${m.id}">
                  <label class="catalog-slide-label truncate-2-lines">${m.title}</label>
                  <div class="mt-1 cursor-pointer items-center gap-2 catalog-slide-info">
                    <label class="catalog-slide-chapters">${m.chapters ?? '0'} Розділів</label>
                    <label class="catalog-slide-status">${m.status ?? ''}</label>
                  </div>
                </a>
              </div>
            </div>
          </td>`
        );
      } else {
        cols.push('<td></td>');
      }
    }
    rows.push(`<tr>${cols.join('')}</tr>`);
  }
  results.innerHTML = `<table style="width:100%;border-collapse:separate;border-spacing:18px 18px;"><tbody>${rows.join('')}</tbody></table>`;
}

const searchForm = document.getElementById('catalog-search-form') as HTMLFormElement | null;
if (searchForm) {
  searchForm.onsubmit = function(e: SubmitEvent) {
    e.preventDefault();
    const fd = new FormData(searchForm);
    const params: Record<string, string | string[]> = {};
    fd.forEach((v, k) => {
      if (k === 'genres') {
        if (!params.genres) params.genres = [];
        (params.genres as string[]).push(v.toString());
      } else {
        params[k] = v.toString();
      }
    });
    const results = document.getElementById('catalog-results');
    if (results) results.innerHTML = '<div style="grid-column:span 5;color:#888;">Завантаження...</div>';
    searchManga(params);
  };
}

// initial load
searchManga();
