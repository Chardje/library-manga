import Swiper from 'swiper';
import { Navigation, Pagination } from 'swiper/modules';
import 'swiper/swiper-bundle.css';
import type { IMangaTitleShort } from './models/IMangaTitleShort';

const api = 'http://localhost:5000';

async function initSwiper() {
  try {
    const response = await fetch(`${api}/MangaList/random?count=20`);
    if (!response.ok) throw new Error('Network response was not ok');
    const mangaList: IMangaTitleShort[] = await response.json();

    const slidesHtml = mangaList.map(manga => `
      <div class="swiper-slide swiper-slide-custom">
        <div class="swiper-slide-content">
          <div class="aspect-ratio-wrapper">
            <div class="aspect-ratio-inner">
              <a class="aspect-ratio-link" href="/manga/${manga.id}">
                <img
                  alt="Poster"
                  loading="lazy"
                  width="150"
                  height="225"
                  decoding="async"
                  class="aspect-ratio-img"
                  src="${manga.picture}"
                >
              </a>
            </div>
          </div>
          <a class="mt-1 truncate swiper-slide-title" href="/manga/${manga.id}">
            <label class="swiper-slide-label truncate-2-lines">${manga.title}</label>
            <div class="mt-1 cursor-pointer items-center gap-2 swiper-slide-info">
              <label class="swiper-slide-chapters">${manga.chapters ?? '0'} Розділів</label>
              <label class="swiper-slide-status">${manga.status}</label>
            </div>
          </a>
        </div>
      </div>
    `).join('');

    document.querySelector('.swiper-wrapper')!.innerHTML = slidesHtml;

    new Swiper('.swiper', {
      loop: true,
      autoplay: { delay: 2500 },
      modules: [Navigation, Pagination],
      slidesPerView: 6,
      speed: 800,
      spaceBetween: 10,
      setWrapperSize: true,
      breakpoints: {
        320: { slidesPerView: 2 },
        640: { slidesPerView: 4 },
        1024: { slidesPerView: 6 },
        1280: { slidesPerView: 8 }
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
    });
  } catch (error) {
    console.error('Failed to fetch manga list:', error);
  }
}

window.addEventListener('DOMContentLoaded', initSwiper);
 

window.addEventListener('DOMContentLoaded', () => {
  initSwiper();
});
