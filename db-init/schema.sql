--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 16.9 (Debian 16.9-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    admin_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: admins_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_admin_id_seq OWNER TO postgres;

--
-- Name: admins_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_admin_id_seq OWNED BY public.admins.admin_id;


--
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    author_id integer NOT NULL,
    name character varying(100) NOT NULL,
    bio text
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- Name: authors_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_author_id_seq OWNER TO postgres;

--
-- Name: authors_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_author_id_seq OWNED BY public.authors.author_id;


--
-- Name: manga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manga (
    manga_id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    release_date date,
    author_id integer,
    pack_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cover_image text DEFAULT 'image\Broken-icon.png'::text,
    status character varying(20) DEFAULT 'ended'::character varying
);


ALTER TABLE public.manga OWNER TO postgres;

--
-- Name: mangas_manga_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mangas_manga_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mangas_manga_id_seq OWNER TO postgres;

--
-- Name: mangas_manga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mangas_manga_id_seq OWNED BY public.manga.manga_id;


--
-- Name: chapter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chapter (
    chapter_id integer DEFAULT nextval('public.mangas_manga_id_seq'::regclass) NOT NULL,
    manga_id integer,
    num integer,
    time_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.chapter OWNER TO postgres;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    comment_id integer NOT NULL,
    user_id integer NOT NULL,
    manga_id integer NOT NULL,
    content text NOT NULL,
    posted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_comment_id_seq OWNER TO postgres;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_comment_id_seq OWNED BY public.comments.comment_id;


--
-- Name: packs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.packs (
    pack_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.packs OWNER TO postgres;

--
-- Name: packs_pack_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.packs_pack_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.packs_pack_id_seq OWNER TO postgres;

--
-- Name: packs_pack_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.packs_pack_id_seq OWNED BY public.packs.pack_id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ratings (
    rating_id integer NOT NULL,
    user_id integer NOT NULL,
    manga_id integer NOT NULL,
    rating integer,
    rated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ratings_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.ratings OWNER TO postgres;

--
-- Name: ratings_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ratings_rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ratings_rating_id_seq OWNER TO postgres;

--
-- Name: ratings_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ratings_rating_id_seq OWNED BY public.ratings.rating_id;


--
-- Name: user_manga_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_manga_status (
    status_id integer NOT NULL,
    user_id integer NOT NULL,
    manga_id integer NOT NULL,
    status character varying(50) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_manga_status_status_check CHECK (((status)::text = ANY ((ARRAY['want to read'::character varying, 'reading'::character varying, 'completed'::character varying, 'dropped'::character varying])::text[])))
);


ALTER TABLE public.user_manga_status OWNER TO postgres;

--
-- Name: user_manga_status_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_manga_status_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_manga_status_status_id_seq OWNER TO postgres;

--
-- Name: user_manga_status_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_manga_status_status_id_seq OWNED BY public.user_manga_status.status_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: views; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.views (
    view_id integer NOT NULL,
    user_id integer,
    manga_id integer NOT NULL,
    viewed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.views OWNER TO postgres;

--
-- Name: views_view_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.views_view_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.views_view_id_seq OWNER TO postgres;

--
-- Name: views_view_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.views_view_id_seq OWNED BY public.views.view_id;


--
-- Name: admins admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN admin_id SET DEFAULT nextval('public.admins_admin_id_seq'::regclass);


--
-- Name: authors author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN author_id SET DEFAULT nextval('public.authors_author_id_seq'::regclass);


--
-- Name: comments comment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN comment_id SET DEFAULT nextval('public.comments_comment_id_seq'::regclass);


--
-- Name: manga manga_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manga ALTER COLUMN manga_id SET DEFAULT nextval('public.mangas_manga_id_seq'::regclass);


--
-- Name: packs pack_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.packs ALTER COLUMN pack_id SET DEFAULT nextval('public.packs_pack_id_seq'::regclass);


--
-- Name: ratings rating_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings ALTER COLUMN rating_id SET DEFAULT nextval('public.ratings_rating_id_seq'::regclass);


--
-- Name: user_manga_status status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_manga_status ALTER COLUMN status_id SET DEFAULT nextval('public.user_manga_status_status_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: views view_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.views ALTER COLUMN view_id SET DEFAULT nextval('public.views_view_id_seq'::regclass);


--
-- Name: admins admins_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_key UNIQUE (email);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (admin_id);


--
-- Name: admins admins_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_username_key UNIQUE (username);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (author_id);


--
-- Name: chapter chapter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chapter
    ADD CONSTRAINT chapter_pkey PRIMARY KEY (chapter_id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);


--
-- Name: manga mangas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manga
    ADD CONSTRAINT mangas_pkey PRIMARY KEY (manga_id);


--
-- Name: packs packs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.packs
    ADD CONSTRAINT packs_pkey PRIMARY KEY (pack_id);


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (rating_id);


--
-- Name: user_manga_status user_manga_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_manga_status
    ADD CONSTRAINT user_manga_status_pkey PRIMARY KEY (status_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: views views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_pkey PRIMARY KEY (view_id);


--
-- Name: comments comments_manga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.manga(manga_id);


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: manga mangas_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manga
    ADD CONSTRAINT mangas_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(author_id);


--
-- Name: manga mangas_pack_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manga
    ADD CONSTRAINT mangas_pack_id_fkey FOREIGN KEY (pack_id) REFERENCES public.packs(pack_id);


--
-- Name: ratings ratings_manga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.manga(manga_id);


--
-- Name: ratings ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_manga_status user_manga_status_manga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_manga_status
    ADD CONSTRAINT user_manga_status_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.manga(manga_id);


--
-- Name: user_manga_status user_manga_status_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_manga_status
    ADD CONSTRAINT user_manga_status_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: views views_manga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.manga(manga_id);


--
-- Name: views views_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.views
    ADD CONSTRAINT views_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);



-- Вставка 10 рядків у таблицю packs
INSERT INTO public.packs (pack_id, name, description)
VALUES
(1, 'Shonen Jump', 'Popular shonen manga pack'),
(2, 'Grand Line', 'Pirate adventure pack'),
(3, 'Soul Society', 'Spiritual action pack'),
(4, 'Titan Pack', 'Survival and action pack'),
(5, 'Mystery Pack', 'Thriller and mystery manga'),
(6, 'Martial Arts', 'Classic martial arts stories'),
(7, 'Hero School', 'Superhero training stories'),
(8, 'Demon Hunt', 'Dark fantasy and demon hunting'),
(9, 'Cursed Energy', 'Supernatural battles pack'),
(10, 'Chainsaw Action', 'Unique action manga');


-- Вставка 10 рядків у таблицю authors
INSERT INTO public.authors (name, bio)
VALUES
('Masashi Kishimoto', 'Author of Naruto. Japanese manga artist.'),
('Eiichiro Oda', 'Author of One Piece. Japanese manga artist.'),
('Tite Kubo', 'Author of Bleach. Japanese manga artist.'),
('Hajime Isayama', 'Author of Attack on Titan. Japanese manga artist.'),
('Tsugumi Ohba', 'Author of Death Note. Japanese manga writer.'),
('Akira Toriyama', 'Author of Dragon Ball. Japanese manga artist.'),
('Kohei Horikoshi', 'Author of My Hero Academia. Japanese manga artist.'),
('Koyoharu Gotouge', 'Author of Demon Slayer. Japanese manga artist.'),
('Gege Akutami', 'Author of Jujutsu Kaisen. Japanese manga artist.'),
('Tatsuki Fujimoto', 'Author of Chainsaw Man. Japanese manga artist.');
--
-- Вставка 10 рядків у таблицю manga
INSERT INTO public.manga (title, description, release_date, author_id, pack_id, cover_image, status)
VALUES
('Naruto', 'Ninja adventures in Konoha', '2002-10-03', 1, 1, 'image/naruto.png', 'ended'),
('One Piece', 'Pirate journey for treasure', '1999-10-20', 2, 2, 'image/onepiece.png', 'ongoing'),
('Bleach', 'Soul reapers and hollows', '2004-10-05', 3, 3, 'image/bleach.png', 'ended'),
('Attack on Titan', 'Humanity vs Titans', '2013-04-07', 4, 4, 'image/aot.png', 'ended'),
('Death Note', 'Notebook of death', '2006-10-04', 5, 5, 'image/deathnote.png', 'ended'),
('Dragon Ball', 'Martial arts and dragons', '1986-02-26', 6, 6, 'image/dragonball.png', 'ended'),
('My Hero Academia', 'Superpowers in school', '2016-04-03', 7, 7, 'image/mha.png', 'ongoing'),
('Demon Slayer', 'Demon hunting siblings', '2019-04-06', 8, 8, 'image/demonslayer.png', 'ended'),
('Jujutsu Kaisen', 'Cursed energy battles', '2020-10-03', 9, 9, 'image/jujutsu.png', 'ongoing'),
('Chainsaw Man', 'Chainsaw devil hunter', '2022-10-12', 10, 10, 'image/chainsawman.png', 'ongoing');

-- Вставка 10 рядків у таблицю users
INSERT INTO public.users (user_id, username, email, password_hash)
VALUES
(1, 'user1', 'user1@example.com', 'hash1'),
(2, 'user2', 'user2@example.com', 'hash2'),
(3, 'user3', 'user3@example.com', 'hash3'),
(4, 'user4', 'user4@example.com', 'hash4'),
(5, 'user5', 'user5@example.com', 'hash5'),
(6, 'user6', 'user6@example.com', 'hash6'),
(7, 'user7', 'user7@example.com', 'hash7'),
(8, 'user8', 'user8@example.com', 'hash8'),
(9, 'user9', 'user9@example.com', 'hash9'),
(10, 'user10', 'user10@example.com', 'hash10');

-- Вставка 10 рядків у таблицю ratings
INSERT INTO public.ratings (user_id, manga_id, rating)
VALUES
(1, 1, 5),
(2, 2, 4),
(3, 3, 5),
(4, 4, 3),
(5, 5, 5),
(6, 6, 4),
(7, 7, 5),
(8, 8, 4),
(9, 9, 5),
(10, 10, 3);

-- Вставка 10 рядків у таблицю chapter
INSERT INTO public.chapter (manga_id, num)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1);



--
-- PostgreSQL database dump complete
--

