import * as React from "react";
import { createRoot } from "react-dom/client";
// Виправлений шлях імпорту
import HeaderSearchDialog from "./react/HeaderSearchDialog";


export function mountHeaderReactSearch() {
  const searchRoot = document.getElementById('react-header-search-root');
  if (searchRoot) {
    createRoot(searchRoot).render(React.createElement(HeaderSearchDialog));
  }

  // Додаємо обробник для кнопки "Рандом" після вставки хедера
  const btn = document.getElementById('random-manga-btn');
  if (btn) {
    btn.onclick = async () => {
      const res = await fetch('http://localhost:5000/MangaList/random?count=1');
      if (res.ok) {
        const data = await res.json();
        const manga = Array.isArray(data) ? data[0] : data;
        if (manga && (manga.id || manga.mangaId))
          window.location.href = `manga.html?id=${manga.id ?? manga.mangaId}`;
      }
    };
  }
}

// Автоматичний запуск після вставки хедера на будь-якій сторінці
if (document.readyState === "complete" || document.readyState === "interactive") {
  setTimeout(mountHeaderReactSearch, 0);
} else {
  window.addEventListener("DOMContentLoaded", () => {
    setTimeout(mountHeaderReactSearch, 0);
  });
}