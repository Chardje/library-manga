export interface IManga {
  mangaId: number;
  picture?: string;
  backgroundPicture?: string;
  title: string;
  titleUa?: string;
  releaseDate?: string; // ISO string
  status: string;
  numberOfChapters?: number;
  description?: string;
  vidget: string;
  mangaAuthors?: {
    mangaId: number;
    manga: string;
    authorId: number;
    author: {
      authorId: number;
      name: string;
      mangaAuthors: string[];
    };
    role: string;
  }[];
  mangaGenres?: {
    mangaId: number;
    manga: string;
    genreId: number;
    genre: {
      genreId: number;
      name: string;
      mangaGenres: string[];
    };
  }[];
  chapters?: {
    chapterId: number;
    mangaId: number;
    chapterNumber: number;
    title: string;
    releaseDate: string;
  }[];
}
