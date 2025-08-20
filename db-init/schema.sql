-- Types
CREATE TYPE public.author_role AS ENUM (
    'author',
    'artist',
    'other'
);

CREATE TYPE public.manga_status AS ENUM (
    'Онгоїнг',
    'Завершена'
);

-- Tables
CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);

CREATE TABLE public.chapters (
    id integer NOT NULL,
    manga_id integer,
    chapter_number integer NOT NULL,
    title character varying(255),
    release_date date
);

CREATE TABLE public.genres (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);

CREATE TABLE public.manga_authors (
    manga_id integer NOT NULL,
    author_id integer NOT NULL,
    role public.author_role NOT NULL
);

CREATE TABLE public.manga_genres (
    manga_id integer NOT NULL,
    genre_id integer NOT NULL
);

CREATE TABLE public.mangas (
    id integer NOT NULL,
    picture character varying(255),
    background_picture character varying(255),
    name character varying(255) NOT NULL,
    name_ua character varying(255),
    release_date date,
    status public.manga_status NOT NULL,
    number_of_chapters integer DEFAULT 0,
    description text
);

CREATE TABLE public.pages (
    id integer NOT NULL,
    chapter_id integer,
    page_number integer NOT NULL,
    image_url character varying(255) NOT NULL
);

-- Sequences
CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.chapters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.mangas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

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

-- Data
--INSERT INTO public.authors (id, name) VALUES
-- (додайте дані якщо є, зараз порожньо)
--;

--INSERT INTO public.chapters (id, manga_id, chapter_number, title, release_date) VALUES
-- (додайте дані якщо є, зараз порожньо)
--;

INSERT INTO public.genres (id, name) VALUES
(1, 'Дія'),
(2, 'Пригоди'),
(3, 'Комедія'),
(4, 'Драма'),
(5, 'Фантастика'),
(6, 'Жахи'),
(7, 'Романтика'),
(8, 'Наукова фантастика'),
(9, 'Сейнен'),
(10, 'Шонен'),
(11, 'Шоджо'),
(12, 'Надприродне'),
(13, 'Спорт'),
(14, 'Історія'),
(15, 'Психологічний'),
(16, 'Містика'),
(17, 'Шматок життя'),
(18, 'Музичний'),
(19, 'Меха'),
(20, 'Фентезі')
;

--INSERT INTO public.manga_authors (manga_id, author_id, role) VALUES
-- (додайте дані якщо є, зараз порожньо)
--;

INSERT INTO public.manga_genres (manga_id, genre_id) VALUES
(1,1),(1,2),(1,4),(1,5),(1,6),(1,15),
(2,1),(2,2),(2,12),(2,10),
(3,1),(3,4),(3,14),(3,9),
(4,1),(4,2),(4,3),(4,5),(4,10),
(5,2),(5,4),(5,6),(5,10),
(6,1),(6,7),(6,8),(6,12),(6,14),
(7,3),(7,5),(7,9),
(8,1),(8,2),(8,6),(8,11),(8,15),
(9,4),(9,7),(9,10),(9,13),
(10,1),(10,2),(10,9),(10,12),
(11,3),(11,6),(11,8),(11,15),
(12,1),(12,2),(12,4),(12,11),
(13,5),(13,7),(13,9),(13,13),
(14,2),(14,6),(14,10),
(15,1),(15,3),(15,4),(15,12),(15,14),
(16,2),(16,5),(16,7),(16,15),
(17,1),(17,6),(17,8),(17,13),
(18,3),(18,4),(18,9),(18,10),
(19,2),(19,5),(19,11),(19,12),
(20,1),(20,4),(20,7),(20,15),
(21,3),(21,6),(21,8),(21,14),
(22,2),(22,5),(22,9),(22,13),
(23,1),(23,3),(23,6),(23,11),(23,12),
(24,2),(24,4),(24,7),(24,15),
(25,1),(25,5),(25,9),(25,13),
(26,3),(26,6),(26,8),(26,14),
(27,2),(27,4),(27,10),(27,12),
(28,1),(28,7),(28,11),(28,15),
(29,3),(29,6),(29,9),(29,13),
(30,2),(30,4),(30,8),(30,14),
(31,1),(31,3),(31,5),(31,12),
(32,2),(32,6),(32,7),(32,15),
(33,1),(33,4),(33,8),(33,13),
(34,3),(34,5),(34,9),(34,14),
(35,2),(35,6),(35,10),(35,11),
(36,1),(36,7),(36,12),(36,15),
(37,3),(37,4),(37,8),(37,13),
(38,2),(38,5),(38,9),(38,14),
(39,1),(39,6),(39,10),(39,11),
(40,3),(40,7),(40,12),(40,15),
(41,2),(41,4),(41,8),(41,13),
(42,1),(42,5),(42,9),(42,14),
(43,3),(43,6),(43,10),(43,11),
(44,2),(44,7),(44,12),(44,15),
(45,1),(45,4),(45,8),(45,13),
(46,3),(46,5),(46,9),(46,14)
;

INSERT INTO public.mangas (id, picture, background_picture, name, name_ua, release_date, status, number_of_chapters, description) VALUES
(1,'placeholder/berserk.jpg','background/berserk.jpg','Berserk','Берсерк','1989-08-25','Завершена',374,'Guts, a mercenary, fights in a dark fantasy world filled with demons and apost les.'),
(2,'placeholder/steel_ball_run.jpg','background/steel_ball_run.jpg','JoJo no Kimyou na Bouken Part 7: Steel Ball Run','JоJo: Steel Ball Run','2004-01-19','Завершена',95,'A horse race across America with supernatural powers.'),
(3,'placeholder/vagabond.jpg','background/vagabond.jpg','Vagabond','Вагабонд','1998-03-23','Онгоїнг',327,'The life of samurai Miyamoto Musashi.'),
(4,'placeholder/one_piece.jpg','background/one_piece.jpg','One Piece','Ван Піс','1997-07-22','Онгоїнг',1100,'Pirate Monkey D. Luffy searches for the One Piece treasure.'),
(5,'placeholder/monster.jpg','background/monster.jpg','Monster','Монстр','1994-12-05','Завершена',162,'Dr. Tenma hunts a serial killer he saved.'),
(6,'placeholder/guimi_zhi_zhu.jpg','background/guimi_zhi_zhu.jpg','Guimi Zhi Zhu','Гуімі Чжі Чжу','2023-01-01','Завершена',50,'Mystery story about friends and spiders.'),
(7,'placeholder/vinland_saga.jpg','background/vinland_saga.jpg','Vinland Saga','Сага про Вінланд','2005-04-13','Онгоїнг',212,'Viking Thorfinn seeks revenge and a peaceful life.'),
(8,'placeholder/slam_dunk.jpg','background/slam_dunk.jpg','Slam Dunk','Слем Данк','1990-10-01','Завершена',276,'Hanamichi Sakuragi joins basketball team.'),
(9,'placeholder/fullmetal_alchemist.jpg','background/fullmetal_alchemist.jpg','Fullmetal Alchemist','Сталевий Алхімік','2001-07-12','Завершена',116,'Brothers search for the Philosopher''s Stone.'),
(10,'placeholder/omniscient_readers_viewpoint.jpg','background/omniscient_readers_viewpoint.jpg','Omniscient Reader''s Viewpoint','Всезнаючий Читач','2020-05-26','Завершена',200,'Kim Dokja enters the world of his favorite novel.'),
(11,'placeholder/grand_blue.jpg','background/grand_blue.jpg','Grand Blue','Гранд Блю','2014-04-07','Онгоїнг',90,'College life with diving club and comedy.'),
(12,'placeholder/kingdom.jpg','background/kingdom.jpg','Kingdom','Королівство','2006-01-26','Онгоїнг',780,'War orphan Xin becomes a great general.'),
(13,'placeholder/tian_guan_cifu.jpg','background/tian_guan_cifu.jpg','Tian Guan Cifu','Благословіння Небесних Чиновників','2017-10-31','Завершена',244,'God and ghost king romance.'),
(14,'placeholder/oyasumi_punpun.jpg','background/oyasumi_punpun.jpg','Oyasumi Punpun','На добраніч, Пунпун','2007-03-15','Завершена',147,'Coming-of-age story with psychological depth.'),
(15,'placeholder/houseki_no_kuni.jpg','background/houseki_no_kuni.jpg','Houseki no Kuni','Країна Самоцвітів','2012-10-25','Онгоїнг',108,'Gem beings fight lunarians.'),
(16,'placeholder/real.jpg','background/real.jpg','Real','Реал','1999-01-01','Онгоїнг',95,'Wheelchair basketball and personal growth.'),
(17,'placeholder/20th_century_boys.jpg','background/20th_century_boys.jpg','20th Century Boys','Хлопці 20-го Століття','1999-09-27','Завершена',249,'Friends stop a cult leader''s world domination.'),
(18,'placeholder/ashita_no_joe.jpg','background/ashita_no_joe.jpg','Ashita no Joe','Завтрашній Джо','1968-01-01','Завершена',171,'Boxer Joe Yabuki''s rise.'),
(19,'placeholder/yotsuba_to.jpg','background/yotsuba_to.jpg','Yotsuba to!','Йоцуба!','2003-03-21','Онгоїнг',110,'Adventures of energetic girl Yotsuba.'),
(20,'placeholder/monogatari_first_season.jpg','background/monogatari_first_season.jpg','Monogatari Series: First Season','Серія Моногатарі: Перший Сезон','2006-07-28','Завершена',200,'Vampires and oddities in high school.'),
(21,'placeholder/umineko_episode_8.jpg','background/umineko_episode_8.jpg','Umineko no Naku Koro ni Chiru - Episode 8','Уміне ко: Епізод 8','2010-12-31','Завершена',22,'Mystery on island with witches.'),
(22,'placeholder/monogatari_second_season.jpg','background/monogatari_second_season.jpg','Monogatari Series: Second Season','Серія Моногатарі: Другий Сезон','2012-07-06','Завершена',150,'Continuation of supernatural stories.'),
(23,'placeholder/kaguya_sama.jpg','background/kaguya_sama.jpg','Kaguya-sama wa Kokurasetai','Кагуя-сама: Любов це Війна','2015-05-19','Завершена',281,'Student council romance comedy.'),
(24,'placeholder/mo_dao_zu_shi.jpg','background/mo_dao_zu_shi.jpg','Mo Dao Zu Shi','Засновник Дияволізму','2015-10-31','Завершена',126,'Cultivator Wei Wuxian''s revival.'),
(25,'placeholder/mikkakan_no_koufuku.jpg','background/mikkakan_no_koufuku.jpg','Mikkakan no Koufuku','Три Дні Щастя','2013-06-25','Завершена',1,'Selling lifespan for money.'),
(26,'placeholder/sousou_no_frieren.jpg','background/sousou_no_frieren.jpg','Sousou no Frieren','Фрірен: За Межами Кінця Подорожі','2020-04-28','Онгоїнг',130,'Elf mage reflects on life after hero''s death.'),
(27,'placeholder/gto.jpg','background/gto.jpg','GTO','Великий Вчитель Онідзука','1997-02-14','Завершена',208,'Former delinquent becomes teacher.'),
(28,'placeholder/haikyuu.jpg','background/haikyuu.jpg','Haikyuu!!','Волейбол!!','2012-02-20','Завершена',407,'High school volleyball team.'),
(29,'placeholder/3_gatsu_no_lion.jpg','background/3_gatsu_no_lion.jpg','3-gatsu no Lion','Березневий Лев','2007-07-13','Онгоїнг',200,'Shogi player Rei''s life.'),
(30,'placeholder/koe_no_katachi.jpg','background/koe_no_katachi.jpg','Koe no Katachi','Форма Голосу','2013-08-07','Завершена',64,'Bullying and redemption with deaf girl.'),
(31,'placeholder/attack_on_titan.jpg','background/attack_on_titan.jpg','Attack on Titan','Атака Титанів','2009-09-09','Завершена',139,'Humanity fights giants.'),
(32,'placeholder/naruto.jpg','background/naruto.jpg','Naruto','Наруто','1999-09-21','Завершена',700,'Ninja boy with fox spirit.'),
(33,'placeholder/bleach.jpg','background/bleach.jpg','Bleach','Бліч','2001-08-07','Завершена',705,'Soul reaper Ichigo fights hollows.'),
(34,'placeholder/dragon_ball.jpg','background/dragon_ball.jpg','Dragon Ball','Драконяча Перлина','1984-11-20','Завершена',519,'Goku searches for dragon balls.'),
(35,'placeholder/my_hero_academia.jpg','background/my_hero_academia.jpg','My Hero Academia','Моя Геройська Академія','2014-07-07','Завершена',430,'Superhero school for quirk users.'),
(36,'placeholder/demon_slayer.jpg','background/demon_slayer.jpg','Demon Slayer','Вбивця Демонів','2016-02-15','Завершена',205,'Tanjiro fights demons to save sister.'),
(37,'placeholder/jujutsu_kaisen.jpg','background/jujutsu_kaisen.jpg','Jujutsu Kaisen','Магічна Битва','2018-03-05','Онгоїнг',250,'Yuji Itadori eats cursed finger.'),
(38,'placeholder/spy_x_family.jpg','background/spy_x_family.jpg','Spy x Family','Шпигунська Сім''я','2019-03-25','Онгоїнг',90,'Spy forms family with assassin and telepath.'),
(39,'placeholder/chainsaw_man.jpg','background/chainsaw_man.jpg','Chainsaw Man','Людина-Бензопила','2018-12-03','Онгоїнг',150,'Denji becomes devil hunter with chainsaw powers.'),
(40,'placeholder/made_in_abyss.jpg','background/made_in_abyss.jpg','Made in Abyss','Створено в Безодні','2012-10-20','Онгоїнг',70,'Explorers descend into the Abyss.'),
(41,'placeholder/akira.jpg','background/akira.jpg','Akira','Акіра','1982-12-06','Завершена',120,'Psychic powers in post-apocalyptic Tokyo.'),
(42,'placeholder/ghost_in_the_shell.jpg','background/ghost_in_the_shell.jpg','Ghost in the Shell','Привид в Оболонці','1989-05-01','Завершена',11,'Cyberpunk major Kusanagi fights hackers.'),
(43,'placeholder/evangelion.jpg','background/evangelion.jpg','Neon Genesis Evangelion','Неоновий Генезис Євангеліон','1994-12-01','Завершена',97,'Teens pilot mechs against angels.'),
(44,'placeholder/tokyo_ghoul.jpg','background/tokyo_ghoul.jpg','Tokyo Ghoul','Токійський Гуль','2011-09-08','Завершена',143,'Ken Kaneki стає напів-гуля.'),
(45,'placeholder/promised_neverland.jpg','background/promised_neverland.jpg','The Promised Neverland','Обіцяний Неврленд','2016-08-01','Завершена',181,'Діти втікають з сирітського притулку.'),
(46,'placeholder/dr_stone.jpg','background/dr_stone.jpg','Dr. Stone','Доктор Стоун','2017-03-06','Завершена',232,'Senku revives civilization after petrification.')
;

--INSERT INTO public.pages (id, chapter_id, page_number, image_url) VALUES
-- (додайте дані якщо є, зараз порожньо)
--;

-- Sequence set values
SELECT pg_catalog.setval('public.authors_id_seq', 34, true);
SELECT pg_catalog.setval('public.chapters_id_seq', 1, false);
SELECT pg_catalog.setval('public.genres_id_seq', 20, true);
SELECT pg_catalog.setval('public.mangas_id_seq', 46, true);
SELECT pg_catalog.setval('public.pages_id_seq', 1, false);

-- Constraints
ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_name_key UNIQUE (name);
ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);
ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.manga_authors
    ADD CONSTRAINT manga_authors_pkey PRIMARY KEY (manga_id, author_id);

ALTER TABLE ONLY public.manga_genres
    ADD CONSTRAINT manga_genres_pkey PRIMARY KEY (manga_id, genre_id);

ALTER TABLE ONLY public.mangas
    ADD CONSTRAINT mangas_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);

-- Indexes
CREATE INDEX idx_chapters_manga_id ON public.chapters USING btree (manga_id);
CREATE INDEX idx_pages_chapter_id ON public.pages USING btree (chapter_id);

-- Foreign keys
ALTER TABLE ONLY public.chapters
    ADD CONSTRAINT chapters_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.mangas(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.manga_authors
    ADD CONSTRAINT manga_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.manga_authors
    ADD CONSTRAINT manga_authors_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.mangas(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.manga_genres
    ADD CONSTRAINT manga_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE CASCADE;
ALTER TABLE ONLY public.manga_genres
    ADD CONSTRAINT manga_genres_manga_id_fkey FOREIGN KEY (manga_id) REFERENCES public.mangas(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_chapter_id_fkey FOREIGN KEY (chapter_id) REFERENCES public.chapters(id) ON DELETE CASCADE;