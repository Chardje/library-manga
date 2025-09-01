// @ts-ignore-next-line: Fix for missing types
import * as React from "react";
// @ts-ignore-next-line: Fix for missing types
import * as AlertDialog from "@radix-ui/react-alert-dialog";
import type { IMangaTitleShort } from "./models/IMangaTitleShort";

export default function HeaderSearchDialog() {
  const [open, setOpen] = React.useState(false);
  const [query, setQuery] = React.useState("");
  const [results, setResults] = React.useState<IMangaTitleShort[]>([]);
  const [loading, setLoading] = React.useState(false);
  let timer: any = null;

  React.useEffect(() => {
    if (!query) {
      setResults([]);
      setLoading(false);
      return;
    }
    setLoading(true);
    if (timer) clearTimeout(timer);
    timer = setTimeout(async () => {
      const res = await fetch(`http://localhost:5000/MangaSearch?title=${encodeURIComponent(query)}`);
      if (res.ok) {
        const data = await res.json();
        if (Array.isArray(data)) {
          setResults(data);
        } else if (Array.isArray(data.results)) {
          setResults(data.results);
        } else if (Array.isArray(data.items)) {
          setResults(data.items);
        } else {
          setResults([]);
        }
      } else {
        setResults([]);
      }
      setLoading(false);
    }, 1000);
    return () => {
      if (timer) clearTimeout(timer);
    };
  }, [query]);

  return (
    <>
      <div className="header-search-block">
        <input
          type="text"
          className="header-search-input"
          placeholder="Пошук..."
          readOnly
          style={{ cursor: "pointer", background: "#eee" }}
          onClick={() => setOpen(true)}
        />
      </div>
      <AlertDialog.Root open={open} onOpenChange={setOpen}>
        <AlertDialog.Portal>
          <AlertDialog.Overlay
            style={{
              background: "rgba(0,0,0,0.55)",
              position: "fixed",
              inset: 0,
              zIndex: 1000,
              opacity: open ? 1 : 0,
              transition: "opacity 0.35s cubic-bezier(.4,0,.2,1)"
            }}
            onClick={() => setOpen(false)}
          />
          <AlertDialog.Content
            style={{
              background: "#fff",
              borderRadius: 8,
              padding: 24,
              maxWidth: 550,
              width: "100%",
              boxSizing: "border-box",
              margin: "0 auto",
              position: "fixed",
              left: "50%",
              top: "8%",
              zIndex: 1001,
              boxShadow: "0 8px 32px rgba(0,0,0,0.25)",
              opacity: open ? 1 : 0,
              transform: open
                ? "translate(-50%, 0) translateY(0) scale(1)"
                : "translate(-50%, 0) translateY(80px) scale(0.98)",
              transition:
                "opacity 0.7s cubic-bezier(.4,0,.2,1), " +
                "transform 0.7s cubic-bezier(.4,0,.2,1)",
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              willChange: "opacity, transform",
              pointerEvents: open ? "auto" : "none"
            }}
            onClick={(e: React.MouseEvent<HTMLDivElement>) => e.stopPropagation()}
          >
            <AlertDialog.Title style={{ color: "var(--color-accent)" }}>Пошук манги</AlertDialog.Title>
            <input
              autoFocus
              type="text"
              className="header-search-input"
              placeholder="Введіть назву..."
              value={query}
              onChange={(e: React.ChangeEvent<HTMLInputElement>) => setQuery(e.target.value)}
              style={{
                width: "100%",
                maxWidth: 400,
                marginTop: 12,
                marginBottom: 12,
                marginLeft: "auto",
                marginRight: "auto",
                display: "block"
              }}
            />
            {loading && <div>Завантаження...</div>}
            {!loading && results.length > 0 && (
              <ul style={{ marginTop: 12, paddingLeft: 0 }}>
                {results.map((manga: IMangaTitleShort) => (
                  <li key={manga.id} style={{ listStyle: "none", marginBottom: 8 }}>
                    <a href={`manga.html?id=${manga.id}`} style={{ textDecoration: "none" }}>
                      <div className="popular-manga-item" style={{ display: "flex", alignItems: "center", gap: "16px", padding: "12px", borderRadius: "10px", marginBottom: "8px", maxWidth: "300px", color: "var(--color-bg)", boxShadow: "0 2px 8px rgba(0, 0, 0, 0.04)" }}>
                        <div>
                          <h4 className="truncate-2-lines" style={{ margin: 0, fontSize: "1.1em", color: "var(--color-accent)", fontWeight: 600 }}>{manga.title}</h4>
                          <p style={{ margin: 0, fontSize: "0.95em", color: "var(--color-gray)" }}>Статус: {manga.status}</p>
                        </div>
                        <img className="popular-manga-cover" src={manga.picture} alt={`${manga.title} cover`} style={{ borderRadius: "6px", width: "80px", height: "120px", objectFit: "cover", background: "var(--color-bg)", boxShadow: "0 1px 4px rgba(0, 0, 0, 0.08)" }} />
                      </div>
                    </a>
                  </li>
                ))}
              </ul>
            )}
            {!loading && query && results.length === 0 && (
              <div style={{ marginTop: 12, color: "#888" }}>Нічого не знайдено</div>
            )}
          </AlertDialog.Content>
        </AlertDialog.Portal>
      </AlertDialog.Root>
    </>
  );
}