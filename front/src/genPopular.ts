import type { IMangaTitleShort } from './models/IMangaTitleShort';
import * as React from "react";
import { createRoot } from "react-dom/client";
import { MangaPopover } from "./react/MangaPopover";

const api = 'http://localhost:5000';

export async function fetchPopularManga(): Promise<IMangaTitleShort[]> {
  const response = await fetch(`${api}/MangaList/random?count=20`);
  if (!response.ok) throw new Error('Network response was not ok');
  return (await response.json()) as IMangaTitleShort[];
}

export async function renderPopularMangaTable() {
  try {
    const mangaList = await fetchPopularManga();
    const container = document.getElementById('popular-manga');
    if (!container) return;

    const popular = mangaList.slice(0, 16);
    let tableHtml = '<table class="popular-table">';
    for (let row = 0; row < 4; row++) {
      tableHtml += '<tr>';
      for (let col = 0; col < 4; col++) {
        const idx = row * 4 + col;
        const manga = popular[idx];
        tableHtml += manga
          ? `<td>
              <div id="popular-manga-popover-root-${idx}"></div>
            </td>`
          : '<td></td>';
      }
      tableHtml += '</tr>';
    }
    tableHtml += '</table>';
    container.innerHTML = tableHtml;

    // Монтуємо MangaPopover для кожної популярної манги (тільки коротка інфа)
    popular.forEach((manga, idx) => {
      const rootElem = document.getElementById(`popular-manga-popover-root-${idx}`);
      if (rootElem) {
        createRoot(rootElem).render(
          React.createElement(MangaPopover, {
            manga,
            side: "right",
            children: React.createElement(
              "a",
              {
                href: `manga.html?id=${manga.id}`,
                style: { textDecoration: "none", display: "block" }
              },
              React.createElement(
                "div",
                {
                  className: "popular-manga-item",
                  style: { cursor: "pointer" }
                },
                React.createElement(
                  "div",
                  null,
                  React.createElement("h4", { className: "truncate-2-lines" }, manga.title),
                  React.createElement("p", null, `Статус: ${manga.status}`)
                ),
                React.createElement("img", {
                  className: "popular-manga-cover",
                  src: manga.picture,
                  alt: `${manga.title} cover`
                })
              )
            )
          })
        );
      }
    });
  } catch (error) {
    console.error('Failed to fetch popular manga:', error);
  }
}

window.addEventListener('DOMContentLoaded', renderPopularMangaTable);