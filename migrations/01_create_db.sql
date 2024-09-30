-- +goose Up
CREATE TABLE public.songs_details (
    id integer NOT NULL,
    release_date text,
    text text,
    link text
);

ALTER TABLE public.songs_details OWNER TO postgres;

CREATE SEQUENCE public.songs_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.songs_details_id_seq OWNER TO postgres;

ALTER SEQUENCE public.songs_details_id_seq OWNED BY public.songs_details.id;

CREATE TABLE public.songs_list (
    id integer NOT NULL,
    song text,
    "group" text
);

ALTER TABLE public.songs_list OWNER TO postgres;

CREATE SEQUENCE public.songs_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.songs_list_id_seq OWNER TO postgres;

ALTER SEQUENCE public.songs_list_id_seq OWNED BY public.songs_list.id;

ALTER TABLE ONLY public.songs_details ALTER COLUMN id SET DEFAULT nextval('public.songs_details_id_seq'::regclass);

ALTER TABLE ONLY public.songs_list ALTER COLUMN id SET DEFAULT nextval('public.songs_list_id_seq'::regclass);


-- 'Obie Trice, real name, no gimmicks Ra—\n\nTwo trailer-park girls go round the outside\nRound the outside, round the outside\nTwo trailer-park girls go round the outside\nRound the outside, round the outside\nWoo! (Ooh, ooh)\nGuess who\'s back, back again?\nShady\'s back, tell a friend\nGuess who\'s back? Guess who\'s back?\nGuess who\'s back\nGuess who\'s back?\nGuess who\'s back? Guess who\'s back?\nGuess who\'s back?\n(Da-da-da, da, da, da, da, da, da)\n(Da-da-da, da, da, da, da)\n\nI\'ve created a monster\n\'Cause nobody wants to see Marshall no more, they want Shady, I\'m chopped liver\nWell, if you want Shady, this is what I\'ll give ya\nA little bit of weed mixed with some hard liquor\nSome vodka that\'ll jump-start my heart quicker\nThan a shock when I get shocked at the hospital\nBy the doctor when I\'m not cooperating\nWhen I\'m rockin\' the table while he\'s operating (Hey)\nYou waited this long, now stop debating\n\'Cause I\'m back, I\'m on the rag and ovulating\nI know that you got a job, Ms. Cheney\nBut your husband\'s heart problem\'s complicating\nSo the FCC won\'t let me be\nOr let me be me, so let me see\nThey tried to shut me down on MTV\nBut it feels so empty without me\nSo come on and dip, bum on your lips\nFuck that, cum on your lips and some on your tits\nAnd get ready, \'cause this shit\'s about to get heavy\nI just settled all my lawsuits (Fuck you, Debbie)'
INSERT INTO public.songs_details (id, release_date, text, link) VALUES
(1, '10.10.2002', 'text', 'https://youtube.com'),
(2, '01.08.1999', 'text', 'https://youtube.com'),
(3, '10.10.2021', 'text', 'https://youtube.com');

INSERT INTO public.songs_list (id, song, "group") VALUES
(1,	'Without Me', 'Eminem'),
(2, 'My Name Is', 'Eminem'),
(3,	'Муза', 'УННВ');

SELECT pg_catalog.setval('public.songs_details_id_seq', 1, false);

SELECT pg_catalog.setval('public.songs_list_id_seq', 7, true);

ALTER TABLE ONLY public.songs_list
    ADD CONSTRAINT songs_list_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.songs_details
    ADD CONSTRAINT id FOREIGN KEY (id) REFERENCES public.songs_list(id) ON DELETE CASCADE;

-- +goose Down
DROP TABLE public.songs_details;

DROP TABLE public.songs_list;