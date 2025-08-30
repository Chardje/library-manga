import type { IManga } from './models/IManga';

const api = 'http://localhost:5000';

function getIdFromUrl(): string | null {
  const params = new URLSearchParams(window.location.search);
  return params.get('id');
}

async function fetchMangaUnit(id: string): Promise<IManga> {
  const response = await fetch(`${api}/MangaUnit/${id}`);
  if (!response.ok) throw new Error('Network response was not ok');
  return await response.json() as IManga;
}

function renderManga(manga: IManga) {
  // Назва, рік, оригінал
  document.getElementById('manga-title-main')!.textContent = manga.title;
  document.getElementById('manga-title')!.textContent = manga.title;
  document.getElementById('manga-title-year')!.textContent = manga.releaseDate ? `(${new Date(manga.releaseDate).getFullYear()})` : '';
  document.getElementById('manga-title-original')!.textContent = manga.titleUa ?? '';

  // Постер
  document.getElementById('manga-poster')!.setAttribute('src', manga.picture ?? '');
  document.getElementById('manga-poster')!.setAttribute('alt', manga.title);

  // Жанри
  document.getElementById('manga-genres-row')!.innerHTML = (manga.mangaGenres ?? [])
    .map(g => `<span class="manga-genre">${g.genre?.name ?? ''}</span>`).join('');

  // Опис
  document.getElementById('manga-description')!.textContent = manga.description ?? '';

  // Деталі
  document.getElementById('manga-details-table')!.innerHTML = `
    <tr><td>Статус:</td><td>${manga.status ?? ''}</td></tr>
    <tr><td>Автори:</td><td>${manga.mangaAuthors?.map(a => a.author?.name).filter(Boolean).join(', ') ?? ''}</td></tr>
    <tr><td>Розділів:</td><td>${manga.numberOfChapters ?? manga.chapters?.length ?? 0}</td></tr>
  `;

  // Дата виходу
  document.getElementById('manga-release-date')!.textContent = manga.releaseDate
    ? new Date(manga.releaseDate).toLocaleDateString('uk-UA')
    : '-';

  // Оновлений список розділів
  document.getElementById('manga-chapters-list')!.innerHTML = (manga.chapters ?? [])
    .map(ch => `<li>
      <b>${ch.chapterNumber}. ${ch.title}</b>
      <span style="color:var(--color-gray);font-size:0.95em;">
        (${ch.releaseDate ? new Date(ch.releaseDate).toLocaleDateString('uk-UA') : '-'})
      </span>
    </li>`).join('');
}

window.addEventListener('DOMContentLoaded', async () => {
  const id = getIdFromUrl();
  if (!id) {
    document.getElementById('manga-title-main')!.textContent = 'Манга не знайдена';
    return;
  }
  try {
    const manga = await fetchMangaUnit(id);
    renderManga(manga);
  } catch (e) {
    document.getElementById('manga-title-main')!.textContent = 'Помилка завантаження манги';
  }
});