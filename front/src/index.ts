import Swiper from 'swiper';
import { Navigation, Pagination} from 'swiper/modules';
import 'swiper/swiper-bundle.css';
import type { IMangaTitleShort } from './models/IMangaTitleShort';

const api = 'http://localhost:5000'; // замініть на ваш API




async function initSwiper() {
  const response = await fetch(api + '/MangaList/random?count=20');
  const data = await response.json();
  const mangaList: IMangaTitleShort[] = data.$values;

  const slidesHtml = mangaList.map(manga => `
    <div class="swiper-slide">
      <h3>${manga.title}</h3>
      <img src="${manga.picture}" alt="${manga.title} cover" style="width:100%;height:220px;object-fit:cover;">
      <p>Status: ${manga.status}</p>
      <p>Chapters: ${manga.chapters}</p>
    </div>
  `).join('');

  document.querySelector('.swiper-wrapper')!.innerHTML = slidesHtml;

  const swiper = new Swiper('.swiper', {
    loop: true,
    autoplay: { delay: 2500 },
    modules: [Navigation, Pagination],
    slidesPerView: 9,
    speed: 800,
    spaceBetween: 10,
    setWrapperSize: true,
    a11y: {
      slideRole: '.swiper-slide'
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
 
}

window.addEventListener('DOMContentLoaded', () => {
  initSwiper();
});
