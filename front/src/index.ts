import Swiper from 'swiper';
import { Navigation, Pagination } from 'swiper/modules';
import 'swiper/swiper-bundle.css';
import type { IMangaTitleShort } from './models/IMangaTitleShort';

// Додаємо імпорт для React і MangaPopover
import * as React from "react";
import { createRoot } from "react-dom/client";
import { MangaPopover } from "./react/MangaPopover";

const api = 'http://localhost:5000';

async function initSwiper() {
  try {
    const response = await fetch(`${api}/MangaList/random?count=20`);
    if (!response.ok) throw new Error('Network response was not ok');
    const mangaList: IMangaTitleShort[] = await response.json();

    // Додаємо контейнер для React root у кожен слайд
    const slidesHtml = mangaList.map((manga, idx) => `
      <div class="swiper-slide swiper-slide-custom shadow" data-manga-idx="${idx}">
        <div class="swiper-slide-content" style="cursor:pointer;" data-manga-id="${manga.id}">
          <div class="aspect-ratio-wrapper">
            <div class="aspect-ratio-inner">
              <img
                alt="Poster"
                loading="lazy"
                width="150"
                height="225"
                decoding="async"
                class="aspect-ratio-img"
                src="${manga.picture}"
              >
            </div>
          </div>
          <div class="mt-1 truncate swiper-slide-title">
            <label class="swiper-slide-label truncate-2-lines">${manga.title}</label>
            <div class="mt-1 cursor-pointer items-center gap-2 swiper-slide-info">
              <label class="swiper-slide-chapters">${manga.chapters ?? '0'} Розділів</label>
              <label class="swiper-slide-status">${manga.status}</label>
            </div>
          </div>
          <div id="manga-popover-root-${idx}"></div>
        </div>
      </div>
    `).join('');

    document.querySelector('.swiper-wrapper')!.innerHTML = slidesHtml;

    // Додаємо обробник кліку для переходу на сторінку манги
    document.querySelectorAll('.swiper-slide-content').forEach(el => {
      el.addEventListener('click', function (e) {
        // Не переходити, якщо клік був по поповеру (можна додати перевірку, якщо потрібно)
        const mangaId = (el as HTMLElement).getAttribute('data-manga-id');
        if (mangaId) {
          window.location.href = `manga.html?id=${mangaId}`;
        }
      });
    });

    // Монтуємо MangaPopover для кожної манги
    mangaList.forEach((manga, idx) => {
      const rootElem = document.getElementById(`manga-popover-root-${idx}`);
      const slideElem = rootElem?.closest('.swiper-slide');
      if (rootElem && slideElem) {
        createRoot(rootElem).render(
          React.createElement(MangaPopover, {
            manga,
            side: "right",
            children: React.createElement(
              "div",
              {
                style: {
                  position: "absolute",
                  top: 0,
                  left: 0,
                  width: "100%",
                  height: "100%",
                  cursor: "pointer",
                  zIndex: 10,
                  background: "transparent"
                }
              }
            )
          })
        );
        (slideElem as HTMLElement).style.position = "relative";
      }
    });

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
