toc.dat                                                                                             0000600 0004000 0002000 00000014460 14155613141 0014445 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       	    .                y         	   laba3node    14.0    14.0                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                    0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         	           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         
           1262    16395 	   laba3node    DATABASE     f   CREATE DATABASE laba3node WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE laba3node;
                postgres    false         ?            1259    16415    post    TABLE     ?   CREATE TABLE public.post (
    id integer NOT NULL,
    user_id integer,
    text text NOT NULL,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
    DROP TABLE public.post;
       public         heap    postgres    false         ?            1259    16414    post_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.post_id_seq;
       public          postgres    false    212                    0    0    post_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.post_id_seq OWNED BY public.post.id;
          public          postgres    false    211         ?            1259    24579    likes    TABLE     ?   CREATE TABLE public.likes (
    id integer DEFAULT nextval('public.post_id_seq'::regclass) NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL
);
    DROP TABLE public.likes;
       public         heap    postgres    false    211         ?            1259    16397    users    TABLE     %  CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(30) NOT NULL,
    is_admin boolean DEFAULT false,
    is_block boolean DEFAULT false,
    last_post_id integer DEFAULT 0
);
    DROP TABLE public.users;
       public         heap    postgres    false         ?            1259    16396    users_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    210                    0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    209         i           2604    16418    post id    DEFAULT     b   ALTER TABLE ONLY public.post ALTER COLUMN id SET DEFAULT nextval('public.post_id_seq'::regclass);
 6   ALTER TABLE public.post ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    212    212         e           2604    16400    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    209    210                   0    24579    likes 
   TABLE DATA           5   COPY public.likes (id, user_id, post_id) FROM stdin;
    public          postgres    false    213       3332.dat           0    16415    post 
   TABLE DATA           7   COPY public.post (id, user_id, text, date) FROM stdin;
    public          postgres    false    212       3331.dat           0    16397    users 
   TABLE DATA           ]   COPY public.users (id, login, email, password, is_admin, is_block, last_post_id) FROM stdin;
    public          postgres    false    210       3329.dat            0    0    post_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.post_id_seq', 71, true);
          public          postgres    false    211                    0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 7, true);
          public          postgres    false    209         q           2606    24583    likes Likes_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "Likes_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.likes DROP CONSTRAINT "Likes_pkey";
       public            postgres    false    213         o           2606    16423    post post_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.post DROP CONSTRAINT post_pkey;
       public            postgres    false    212         m           2606    16404    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    210         s           2606    24589 
   likes post    FK CONSTRAINT     ?   ALTER TABLE ONLY public.likes
    ADD CONSTRAINT post FOREIGN KEY (post_id) REFERENCES public.post(id) ON UPDATE CASCADE ON DELETE CASCADE;
 4   ALTER TABLE ONLY public.likes DROP CONSTRAINT post;
       public          postgres    false    213    3183    212         t           2606    24584    likes user_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.likes
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;
 7   ALTER TABLE ONLY public.likes DROP CONSTRAINT user_id;
       public          postgres    false    210    3181    213         r           2606    24600    post user_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.post
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL NOT VALID;
 6   ALTER TABLE ONLY public.post DROP CONSTRAINT user_id;
       public          postgres    false    3181    212    210                                                                                                                                                                                                                        3332.dat                                                                                            0000600 0004000 0002000 00000000045 14155613141 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        57	1	56
59	5	46
60	6	56
71	1	62
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3331.dat                                                                                            0000600 0004000 0002000 00000001271 14155613141 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        56	\N	Привет, я пользователь 1	2021-11-09 11:57:54
46	1	 Привет, я Админ	2021-11-08 23:37:28
62	1	<img src=x onerror=alert(1)//>	2021-11-15 12:17:29
63	5	привет !!	2021-12-02 10:41:19
64	5	Меня сегодня разблокировали\nчтобы потом заблокировать(	2021-12-02 10:41:42
65	6	я пишу сообщение	2021-12-02 10:42:19
66	6	Чтобы нагнать трафику	2021-12-02 10:42:34
67	6	еще 3 сообщения	2021-12-02 10:44:06
68	1	3 more\n	2021-12-02 10:44:30
69	1	more more	2021-12-02 10:44:42
70	1	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	2021-12-02 10:44:56
\.


                                                                                                                                                                                                                                                                                                                                       3329.dat                                                                                            0000600 0004000 0002000 00000000154 14155613141 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        6	test	test@test.ru	test	f	f	70
5	user2	user2@mail.com	user2	f	f	66
1	admin	admin@mail.ru	admin	t	f	70
\.


                                                                                                                                                                                                                                                                                                                                                                                                                    restore.sql                                                                                         0000600 0004000 0002000 00000012755 14155613141 0015377 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

DROP DATABASE laba3node;
--
-- Name: laba3node; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE laba3node WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE laba3node OWNER TO postgres;

\connect laba3node

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
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    id integer NOT NULL,
    user_id integer,
    text text NOT NULL,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.post OWNER TO postgres;

--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_id_seq OWNER TO postgres;

--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_id_seq OWNED BY public.post.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.likes (
    id integer DEFAULT nextval('public.post_id_seq'::regclass) NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL
);


ALTER TABLE public.likes OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(30) NOT NULL,
    is_admin boolean DEFAULT false,
    is_block boolean DEFAULT false,
    last_post_id integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: post id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post ALTER COLUMN id SET DEFAULT nextval('public.post_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.likes (id, user_id, post_id) FROM stdin;
\.
COPY public.likes (id, user_id, post_id) FROM '$$PATH$$/3332.dat';

--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post (id, user_id, text, date) FROM stdin;
\.
COPY public.post (id, user_id, text, date) FROM '$$PATH$$/3331.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, login, email, password, is_admin, is_block, last_post_id) FROM stdin;
\.
COPY public.users (id, login, email, password, is_admin, is_block, last_post_id) FROM '$$PATH$$/3329.dat';

--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_id_seq', 71, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- Name: likes Likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "Likes_pkey" PRIMARY KEY (id);


--
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: likes post; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT post FOREIGN KEY (post_id) REFERENCES public.post(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: likes user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: post user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL NOT VALID;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   