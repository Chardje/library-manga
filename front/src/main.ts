import Swiper from 'swiper';
import 'swiper/swiper-bundle.css';

const swiper = new Swiper('.swiper', {
  loop: true,
  autoplay: { delay: 2500 },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
});
