create TABLE users (
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    login character varying(50) COLLATE pg_catalog."default" NOT NULL,
    email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    password character varying(30) COLLATE pg_catalog."default" NOT NULL,
    is_admin boolean DEFAULT false,
    is_block boolean DEFAULT false,
    last_post_id integer DEFAULT 0,
    CONSTRAINT users_pkey PRIMARY KEY (id)
);

create TABLE post
(
     id integer NOT NULL DEFAULT nextval('post_id_seq'::regclass),
    user_id integer,
    text text COLLATE pg_catalog."default" NOT NULL,
    date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    CONSTRAINT post_pkey PRIMARY KEY (id),
    CONSTRAINT user_id FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL
        NOT VALID
);

CREATE TABLE likes
(
    id integer NOT NULL DEFAULT nextval('post_id_seq'::regclass),
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    CONSTRAINT "Likes_pkey" PRIMARY KEY (id),
    CONSTRAINT post FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT user_id FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);