import * as React from "react";
import * as Popover from "@radix-ui/react-popover";
import type { IManga } from "../models/IManga";
import type { IMangaTitleShort } from "../models/IMangaTitleShort";
import type { IGenre } from "../models/IGenre";

interface MangaPopoverProps {
  manga: IManga | IMangaTitleShort;
  side?: "left" | "right";
  children: React.ReactNode;
}

const api = 'http://localhost:5000';

// Простий кеш для відповідей по mangaId
const mangaUnitCache = new Map<number, IManga>();

function getMangaId(manga: IManga | IMangaTitleShort): number {
  return "mangaId" in manga ? manga.mangaId : manga.id;
}

function getChaptersCount(manga: IManga | IMangaTitleShort): number {
  if ("numberOfChapters" in manga && manga.numberOfChapters !== undefined) return manga.numberOfChapters;
  if ("chapters" in manga && Array.isArray(manga.chapters)) return manga.chapters.length;
  if ("chapters" in manga && typeof manga.chapters === "number") return manga.chapters;
  return 0;
}

export function MangaPopover({ manga, side = "right", children }: MangaPopoverProps) {
  const [open, setOpen] = React.useState(false);
  const [fullManga, setFullManga] = React.useState<IManga | null>(null);
  const timerRef = React.useRef<number | null>(null);

  const handleMouseEnter = () => {
    timerRef.current = window.setTimeout(async () => {
      setOpen(true);
      // Якщо це коротка манга, завантажити повну інформацію з кешем
      if (!("description" in manga)) {
        const id = getMangaId(manga);
        if (mangaUnitCache.has(id)) {
          setFullManga(mangaUnitCache.get(id)!);
        } else {
          try {
            const res = await fetch(`${api}/MangaUnit/${id}`);
            if (res.ok) {
              const data = await res.json();
              mangaUnitCache.set(id, data);
              setFullManga(data);
            }
          } catch {}
        }
      }
    }, 1500); // затримка 1.5 секунди
  };
  const handleMouseLeave = () => {
    if (timerRef.current) {
      clearTimeout(timerRef.current);
      timerRef.current = null;
    }
    setOpen(false);
  };

  const info = fullManga ?? manga;

  // Витягуємо жанри як масив IGenre (з урахуванням різниці типів)
  let genres: string[] = [];
  if ("mangaGenres" in info && Array.isArray(info.mangaGenres)) {
    genres = info.mangaGenres
      .map((g) => {
        // IManga: g.genre.name, IMangaTitleShort: g.name
        if (g && typeof g === "object") {
          if ("genre" in g && g.genre && typeof g.genre.name === "string") {
            return g.genre.name;
          }
          if ("name" in g && typeof g.name === "string") {
            return g.name;
          }
        }
        return "";
      })
      .filter(Boolean);
  }

  return (
    <Popover.Root open={open} onOpenChange={setOpen}>
      <Popover.Trigger asChild>
        <div
          onMouseEnter={handleMouseEnter}
          onMouseLeave={handleMouseLeave}
          style={{ display: "inline-block" }}
        >
          {children}
        </div>
      </Popover.Trigger>
      <Popover.Portal>
        <Popover.Content
          side={side}
          align="center"
          style={{
            background: "#fff",
            borderRadius: 8,
            boxShadow: "0 8px 32px rgba(0,0,0,0.18)",
            padding: 20,
            minWidth: 260,
            maxWidth: 350,
            zIndex: 2000,
            color: "#222",
            outline: "none",
            opacity: open ? 1 : 0,
            transform: open
              ? "scale(1) translateY(0)"
              : "scale(0.96) translateY(20px)",
            transition:
              "opacity 0.35s cubic-bezier(.4,0,.2,1), transform 0.35s cubic-bezier(.4,0,.2,1)",
            willChange: "opacity, transform",
          }}
          tabIndex={-1}
        >
          <div style={{ fontWeight: 700, fontSize: "1.2em", marginBottom: 8, color: "var(--color-accent)" }}>
            {info.title}
          </div>
          <div
            style={{
              fontSize: "0.98em",
              marginBottom: 8,
              color: "var(--color-gray)",
              display: "-webkit-box",
              WebkitLineClamp: 3,
              WebkitBoxOrient: "vertical",
              overflow: "hidden",
              textOverflow: "ellipsis",
              maxHeight: "4.5em",
              lineHeight: "1.5em",
              whiteSpace: "normal",
            }}
          >
            {"description" in info
              ? info.description || "Опис відсутній"
              : "Опис завантажується..."}
          </div>
          <div style={{ marginBottom: 8 }}>
            <b>Розділів:</b> {getChaptersCount(info)}
          </div>
          <div>
            <b>Жанри:</b>{" "}
            {genres.length > 0
              ? genres.join(", ")
              : "—"}
          </div>
        </Popover.Content>
      </Popover.Portal>
    </Popover.Root>
  );
}
