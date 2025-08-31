import type { IPage } from './models/IPage';
import type { IManga } from './models/IManga';

const api = 'http://localhost:5000';

function getParamsFromUrl(): { mangaId: number | null, chapterNumber: number | null } {
  const params = new URLSearchParams(window.location.search);
  const mangaId = params.get('mangaId');
  const chapterNumber = params.get('chapterNumber');
  return {
    mangaId: mangaId ? Number(mangaId) : null,
    chapterNumber: chapterNumber ? Number(chapterNumber) : null
  };
}

async function fetchPages(mangaId: number, chapterNumber: number): Promise<IPage[]> {
  const response = await fetch(`${api}/Page/by-chapter/${mangaId}/${chapterNumber}`);
  if (!response.ok) throw new Error('Network response was not ok');
  return await response.json() as IPage[];
}

async function fetchMangaUnit(mangaId: number): Promise<IManga> {
  const response = await fetch(`${api}/MangaUnit/${mangaId}`);
  if (!response.ok) throw new Error('Network response was not ok');
  return await response.json() as IManga;
}

function renderPages(pages: IPage[]) {
  const container = document.getElementById('read-pages-list');
  if (!container) return;
  container.innerHTML = pages.map(page => {
    const fileName = page.imageUrl.split('/').pop();
    return `<img class="read-page-img" src="img/pages/${fileName}" alt="Page ${page.pageNumber + 1}">`;
  }).join('');
}

function setChapterNavButtons(mangaId: number, chapterNumber: number, chapters: IManga['chapters']) {
  const prevBtn = document.getElementById('prev-chapter-btn') as HTMLButtonElement | null;
  const nextBtn = document.getElementById('next-chapter-btn') as HTMLButtonElement | null;
  if (!chapters) return;

  // Знайти індекс поточного розділу
  const idx = chapters.findIndex(ch => ch.chapterNumber === chapterNumber);
  // Минулий розділ
  if (prevBtn) {
    if (idx > 0) {
      const prev = chapters[idx - 1];
      prevBtn.disabled = false;
      prevBtn.onclick = () => {
        window.location.href = `read.html?mangaId=${mangaId}&chapterNumber=${prev.chapterNumber}`;
      };
    } else {
      prevBtn.disabled = true;
      prevBtn.onclick = null;
    }
  }
  // Наступний розділ
  if (nextBtn) {
    if (idx < chapters.length - 1 && idx !== -1) {
      const next = chapters[idx + 1];
      nextBtn.disabled = false;
      nextBtn.onclick = () => {
        window.location.href = `read.html?mangaId=${mangaId}&chapterNumber=${next.chapterNumber}`;
      };
    } else {
      nextBtn.disabled = true;
      nextBtn.onclick = null;
    }
  }
}

window.addEventListener('DOMContentLoaded', async () => {
  const { mangaId, chapterNumber } = getParamsFromUrl();
  if (!mangaId || !chapterNumber) {
    document.getElementById('read-pages-list')!.innerHTML = '<p>Розділ не знайдено</p>';
    return;
  }
  try {
    const [pages, manga] = await Promise.all([
      fetchPages(mangaId, chapterNumber),
      fetchMangaUnit(mangaId)
    ]);
    if (!pages.length) {
      document.getElementById('read-pages-list')!.innerHTML = '<p>Сторінки не знайдено</p>';
      return;
    }
    renderPages(pages);
    setChapterNavButtons(mangaId, chapterNumber, manga.chapters ?? []);
  } catch (e) {
    document.getElementById('read-pages-list')!.innerHTML = '<p>Помилка завантаження сторінок</p>';
  }

  // Кнопка "До манги"
  const backBtn = document.getElementById('back-to-manga-btn');
  if (backBtn && mangaId) {
    backBtn.onclick = () => {
      window.location.href = `manga.html?id=${mangaId}`;
    };
  }
});
