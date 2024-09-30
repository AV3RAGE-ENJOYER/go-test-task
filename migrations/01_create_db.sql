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


INSERT INTO public.songs_details (id, release_date, text, link) VALUES
(1, '10.10.2002', 'Obie Trice, real name, no gimmicks
Ra—


Two trailer-park girls go round the outside
Round the outside, round the outside
Two trailer-park girls go round the outside
Round the outside, round the outside
Woo! (Ooh, ooh)

Guess who''s back, back again?
Shady''s back, tell a friend
Guess who''s back? Guess who''s back?
Guess who''s back? Guess who''s back?
Guess who''s back? Guess who''s back?
Guess who''s back?
(Da-da-da, da, da, da, da, da, da)
(Da-da-da, da, da, da, da)

I''ve created a monster
''Cause nobody wants to see Marshall no more, they want Shady, I''m chopped liver
Well, if you want Shady, this is what I''ll give ya
A little bit of weed mixed with some hard liquor
Some vodka that''ll jump-start my heart quicker
Than a shock when I get shocked at the hospital
By the doctor when I''m not cooperating
When I''m rockin'' the table while he''s operating (Hey)
You waited this long, now stop debating
''Cause I''m back, I''m on the rag and ovulating
I know that you got a job, Ms. Cheney
But your husband''s heart problem''s complicating
So the FCC won''t let me be
Or let me be me, so let me see
They tried to shut me down on MTV
But it feels so empty without me
So come on and dip, bum on your lips
Fuck that, cum on your lips and some on your tits
And get ready, ''cause this shit''s about to get heavy
I just settled all my lawsuits (Fuck you, Debbie)

Now, this looks like a job for me
So everybody, just follow me
''Cause we need a little controversy
''Cause it feels so empty without me
I said this looks like a job for me
So everybody, just follow me
''Cause we need a little controversy
''Cause it feels so empty without me

Little hellions, kids feeling rebellious
Embarrassed, their parents still listen to Elvis
They start feelin'' like prisoners, helpless
''Til someone comes along on a mission and yells, "Bitch"
A visionary, vision is scary
Could start a revolution, pollutin'' the airwaves
A rebel, so just let me revel and bask
In the fact that I got everyone kissin'' my ass
And it''s a disaster, such a catastrophe
For you to see so damn much of my ass, you asked for me?
Well, I''m back, da-na-na-na, na-na-na-na-na-na
Fix your bent antenna, tune it in, and then I''m gonna
Enter in and up under your skin like a splinter
The center of attention, back for the winter
I''m interesting, the best thing since wrestling
Infesting in your kid''s ears and nesting
Testing, "Attention, please"
Feel the tension soon as someone mentions me
Here''s my ten cents, my two cents is free
A nuisance, who sent? You sent for me?

Now, this looks like a job for me
So everybody, just follow me
''Cause we need a little controversy
''Cause it feels so empty without me
I said this looks like a job for me
So everybody, just follow me
''Cause we need a little controversy
''Cause it feels so empty without me

A tisket, a tasket, I''ll go tit-for-tat wit''
Anybody who''s talkin'', "This shit, that shit"
Chris Kirkpatrick, you can get your ass kicked
Worse than them little Limp Bizkit bastards
And Moby? You can get stomped by Obie
You thirty-six-year-old bald-headed fag, blow me
You don''t know me, you''re too old, let go
It''s over, nobody listens to techno
Now, let''s go, just give me the signal
I''ll be there with a whole list full of new insults
I''ve been dope, suspenseful with a pencil
Ever since Prince turned himself into a symbol
But, sometimes, the shit just seems
Everybody only wants to discuss me
So this must mean I''m disgusting
But it''s just me, I''m just obscene (Yeah)
Though I''m not the first king of controversy
I am the worst thing since Elvis Presley
To do Black music so selfishly
And use it to get myself wealthy (Hey)
There''s a concept that works
Twenty million other white rappers emerge
But no matter how many fish in the sea
It''d be so empty without me

Now, this looks like a job for me
So everybody, just follow me
''Cause we need a little controversy
''Cause it feels so empty without me
I said this looks like a job for me
So everybody, just follow me
''Cause we need a little controversy
''Cause it feels so empty without me

Hum, dei-dei, la-la
La-la, la-la-la
La-la, la-la-la
La-la, la-la
Hum, dei-dei, la-la
La-la, la-la-la
La-la, la-la-la
La-la, la-la
Kids', 'https://www.youtube.com/watch?v=YVkUvmDQ3HY'),
(2, '01.08.1999', 'Hi, my name is, what? My name is, who?
My name is, chka-chka, Slim Shady
Hi, my name is, huh? My name is, what?
My name is, chka-chka, Slim Shady
Hi, my name is, what? (Excuse me) My name is, who?
My name is, chka-chka, Slim Shady
(Can I have the attention of the class for one second?)
Hi, my name is, huh? My name is, what?
My name is, chka-chka, Slim Shady

Hi, kids, do you like violence? (Yeah, yeah, yeah)
Wanna see me stick nine-inch nails through each one of my eyelids? (Uh-huh)
Wanna copy me and do exactly like I did? (Yeah, yeah)
Try ''cid and get fucked up worse than my life is? (Huh?)
My brain''s dead weight, I''m tryna get my head straight
But I can''t figure out which Spice Girl I want to impregnate (Oh)
And Dr. Dre said, "Slim Shady, you a basehead" (Uh-uh)
"Then why''s your face red? Man, you wasted"
Well, since age 12, I felt like I''m someone else
''Cause I hung my original self from the top bunk with a belt
Got pissed off and ripped Pamela Lee''s tits off
And smacked her so hard I knocked her clothes backwards like Kris Kross
I smoke a fat pound of grass, and fall on my ass
Faster than a fat bitch who sat down too fast
Come here, slut; "Shady, wait a minute, that''s my girl, dawg"
I don''t give a fuck, God sent me to piss the world off

Hi, my name is, what? My name is, who?
My name is, chka-chka, Slim Shady
Hi, my name is, huh? My name is, what?
My name is, chka-chka, Slim Shady
Hi, my name is, what? My name is, who?
My name is, chka-chka, Slim Shady
Hi, my name is, huh? My name is, what?
My name is, chka-chka, Slim Shady

My English teacher wanted to flunk me in junior high (Shh)
Thanks a lot, next semester I''ll be 35
I smacked him in his face with an eraser, chased him with a stapler
And stapled his nuts to a stack of paper (Ow)
Walked in the strip club, had my jacket zipped up
Flashed the bartender, then stuck my dick in the tip cup
Extraterrestrial, running over pedestrians in a spaceship While they''re screaming at me, "Let''s just be friends"
99 percent of my life, I was lied to
I just found out my mom does more dope than I do (Damn)
I told her I''d grow up to be a famous rapper
Make a record about doin'' drugs and name it after her
(Oh, thank you)
You know you blew up when the women rush your stands
And try to touch your hands like some screamin'' Usher fans
(Ahh, ahh, ahh)
This guy at White Castle asked for my autograph (Dude, can I get your autograph?)
So I signed it, "Dear Dave, thanks for the support, asshole"
[Chorus: Eminem]
Hi, my name is, huh? My name is, who?
My name is, chka-chka, Slim Shady
Hi, my name is, what? My name is, who?
My name is, chka-chka, Slim Shady
Hi, my name is, huh? My name is, who?
My name is, chka-chka, Slim Shady
Hi, my name is, what? My name is, who?
My name is, chka-chka, Slim Shady

Stop the tape, this kid needs to be locked away (Get him)
Dr. Dre, don''t just stand there, operate
I''m not ready to leave, it''s too scary to die (Fuck that)
I''ll have to be carried inside the cemetery and buried alive
(Huh, yup)
Am I comin'' or goin''? I can barely decide
I just drank a fifth of vodka, dare me to drive? (Go ahead)
All my life I was very deprived
I ain''t had a woman in years and my palms are too hairy to hide (Whoops)
Clothes ripped like the Incredible Hulk
I spit when I talk, I''ll fuck anything that walks (Come here)
When I was little, I used to get so hungry I would throw fits
How you gonna breastfeed me, Mom? You ain''t got no tits
I lay awake and strap myself in the bed
With a bulletproof vest on and shoot myself in the head (Bang)
''Cause I''m steamin'' mad (Grr)
And by the way, when you see my dad (Yeah?)
Tell him that I slit his throat in this dream I had
[Chorus: Eminem]
Hi, my name is, what? My name is, who?
My name is, chka-chka, Slim Shady
Hi, my name is, huh? My name is, what?
My name is, chka-chka, Slim Shady
Hi, my name is, who? My name is, huh?
My name is, chka-chka, Slim Shady
Hi, my name is, huh? My name is, who?
My name is, chka-chka, Slim Shady', 'https://www.youtube.com/watch?v=sNPnbI1arSE'),
(3, '10.10.2021', 'Знакомьтесь, месье - это моя муза
Своими карими глазами жалит, как медуза
Я знаю, что на свете ни одна гламурная коза
Не будет меня так любить, как любит она
Моя муза - богиня, её имя - победа
Она готовит мои строки, чтоб ты ими отобедал
Нежная, как плед, создатель каждого куплета
Сильная, как ветер, поклонница чёрного цвета
Верность её кредо, изящная пантера
Разрывает вас на части, пробирает как холера
В этих городских притонах муза - моя вера
Одновременно нищенка, одновременно королева
Её кожа, её тело, шоколадные куски
Волосы, как амазонка, заплетает в колоски
Пока вы, блять, сношаетесь друг с другом от тоски
Моя муза в стороне забивает косяки
Произноси её фамилию как заклинание
Только она одна способна исполнять желания
Приоткрывает губы, происходит замыкание
Муза, если окочурюсь, я скажу тебе заранее
Неважно расстояние, она внутри меня
Пусть только выделяет сок, и не нужно нихуя
Это изысканная похоть, вам сюда нельзя
Удары в её сторону я принимаю на себя
Даже дворами темными всегда меня искала
На её фоне ваши чувства сделаны из кала
Среди толпы грязных людей себя не замарала
Она шагала по шакалам, как по полотнам Шагала
Знакомьтесь, месье - это моя муза
Своими карими глазами жалит, как медуза
Моя муза, моя муза', 'https://www.youtube.com/watch?v=Oq_HGEzkMKg');

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