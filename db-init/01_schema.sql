


-- Types
CREATE TYPE public.author_role AS ENUM ('author', 'artist', 'other');

CREATE TYPE public.manga_status AS ENUM ('Онгоїнг', 'Завершена');

CREATE TYPE public.manga_vidget AS ENUM ('carousel', 'popular', 'latest');

-- Tables
CREATE TABLE
    public.authors (
        id integer NOT NULL,
        name character varying(255) NOT NULL
    );

CREATE TABLE
    public.chapters (
        id integer NOT NULL,
        manga_id integer,
        chapter_number integer NOT NULL,
        title character varying(255),
        release_date date
    );

CREATE TABLE
    public.genres (
        id integer NOT NULL,
        name character varying(100) NOT NULL
    );

CREATE TABLE
    public.manga_authors (
        manga_id integer NOT NULL,
        author_id integer NOT NULL,
        role public.author_role NOT NULL
    );

CREATE TABLE
    public.manga_genres (
        manga_id integer NOT NULL,
        genre_id integer NOT NULL
    );

CREATE TABLE
    public.mangas (
        id integer NOT NULL,
        picture character varying(255),
        background_picture character varying(255),
        name character varying(255) NOT NULL,
        name_ua character varying(255),
        release_date date,
        status public.manga_status NOT NULL,
        number_of_chapters integer DEFAULT 0,
        description text,
        vidget public.manga_vidget NOT NULL DEFAULT 'carousel'
    );

CREATE TABLE
    public.pages (
        id integer NOT NULL,
        chapter_id integer,
        page_number integer NOT NULL,
        image_url character varying(255) NOT NULL
    );

-- Sequences
CREATE SEQUENCE public.authors_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE SEQUENCE public.chapters_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE SEQUENCE public.genres_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE SEQUENCE public.mangas_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE SEQUENCE public.pages_id_seq AS integer START
WITH
    1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

-- Sequence ownership
ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;

ALTER SEQUENCE public.chapters_id_seq OWNED BY public.chapters.id;

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;

ALTER SEQUENCE public.mangas_id_seq OWNED BY public.mangas.id;

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;

-- Defaults
ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);
ALTER TABLE ONLY public.chapters ALTER COLUMN id SET DEFAULT nextval('public.chapters_id_seq'::regclass);
ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);
ALTER TABLE ONLY public.mangas ALTER COLUMN id SET DEFAULT nextval('public.mangas_id_seq'::regclass);
ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);

-- Sequence set values
SELECT
    pg_catalog.setval ('public.authors_id_seq', 34, true);

SELECT
    pg_catalog.setval ('public.chapters_id_seq', 1, false);

SELECT
    pg_catalog.setval ('public.genres_id_seq', 20, true);

SELECT
    pg_catalog.setval ('public.mangas_id_seq', 46, true);

SELECT
    pg_catalog.setval ('public.pages_id_seq', 1, false);

-- Constraints
ALTER TABLE ONLY public.authors ADD CONSTRAINT authors_name_key UNIQUE (name);

ALTER TABLE ONLY public.authors ADD CONSTRAINT authors_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.chapters ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.genres ADD CONSTRAINT genres_name_key UNIQUE (name);

ALTER TABLE ONLY public.genres ADD CONSTRAINT genres_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.manga_authors ADD CONSTRAINT manga_authors_pkey PRIMARY KEY (manga_id, author_id, role);

ALTER TABLE ONLY public.manga_genres ADD CONSTRAINT manga_genres_pkey PRIMARY KEY (manga_id, genre_id);

ALTER TABLE ONLY public.mangas ADD CONSTRAINT mangas_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.pages ADD CONSTRAINT pages_pkey PRIMARY KEY (id);

-- Indexes
CREATE INDEX idx_chapters_manga_id ON public.chapters USING btree (manga_id);

CREATE INDEX idx_pages_chapter_id ON public.pages USING btree (chapter_id);

-- Foreign keys
ALTER TABLE ONLY public.chapters ADD CONSTRAINT chapters_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.mangas (id) ON DELETE CASCADE;

ALTER TABLE ONLY public.manga_authors ADD CONSTRAINT manga_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors (id) ON DELETE CASCADE;

ALTER TABLE ONLY public.manga_authors ADD CONSTRAINT manga_authors_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.mangas (id) ON DELETE CASCADE;

ALTER TABLE ONLY public.manga_genres ADD CONSTRAINT manga_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres (id) ON DELETE CASCADE;

ALTER TABLE ONLY public.manga_genres ADD CONSTRAINT manga_genres_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.mangas (id) ON DELETE CASCADE;

ALTER TABLE ONLY public.pages ADD CONSTRAINT pages_chapter_id_fkey FOREIGN KEY (chapter_id) REFERENCES public.chapters (id) ON DELETE CASCADE;