import type { IMangaTitleShort } from './models/IMangaTitleShort';

const api = 'http://localhost:5000';

async function fetchManga(id: string) {
  const response = await fetch(`${api}/MangaUnit/${id}`);
  if (!response.ok) throw new Error('Network response was not ok');
  return await response.json();
}

function getIdFromUrl(): string | null {
  const params = new URLSearchParams(window.location.search);
  return params.get('id');
}

function renderManga(manga: any) {
  document.getElementById('manga-title')!.textContent = manga.title;
  document.getElementById('manga-details')!.innerHTML = `
    <div class="manga-details">
      <div class="manga-details-cover">
        <img src="${manga.picture}" alt="${manga.title}" width="200" height="300" style="border-radius:12px;">
      </div>
      <div class="manga-details-info">
        <h2>${manga.title} ${manga.year ?? ''}</h2>
        <p><b>Статус:</b> ${manga.status}</p>
        <p><b>Автори:</b> ${manga.mangaAuthors?.map((a: any) => a.author?.name).join(', ') ?? ''}</p>
        <p><b>Кількість розділів:</b> ${manga.chapters?.length ?? 0}</p>
        <p><b>Опис:</b> ${manga.description ?? ''}</p>
      </div>
    </div>
  `;
}

window.addEventListener('DOMContentLoaded', async () => {
  const id = getIdFromUrl();
  if (!id) {
    document.getElementById('manga-details')!.textContent = 'Манга не знайдена';
    return;
  }
  try {
    const manga = await fetchManga(id);
    renderManga(manga);
  } catch (e) {
    document.getElementById('manga-details')!.textContent = 'Помилка завантаження манги';
  }
});
