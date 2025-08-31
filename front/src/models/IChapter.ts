export interface IChapter {
  chapterId: number;
  mangaId: number;
  chapterNumber: number;
  title: string;
  releaseDate: string;
  manga: null; // або тип Manga, якщо буде використовуватись
}
