--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Ubuntu 14.17-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.17 (Ubuntu 14.17-0ubuntu0.22.04.1)

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
-- Name: cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cases (
    id integer NOT NULL,
    name text NOT NULL,
    brand text NOT NULL,
    form_factor text NOT NULL,
    gpu_length_limit integer,
    cooler_height_limit integer,
    price numeric
);


ALTER TABLE public.cases OWNER TO postgres;

--
-- Name: cases_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cases_id_seq OWNER TO postgres;

--
-- Name: cases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cases_id_seq OWNED BY public.cases.id;


--
-- Name: coolers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coolers (
    id integer NOT NULL,
    name text NOT NULL,
    brand text NOT NULL,
    type text NOT NULL,
    tdp_support integer,
    socket_support text[],
    price numeric
);


ALTER TABLE public.coolers OWNER TO postgres;

--
-- Name: coolers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coolers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coolers_id_seq OWNER TO postgres;

--
-- Name: coolers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coolers_id_seq OWNED BY public.coolers.id;


--
-- Name: cpus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cpus (
    id integer NOT NULL,
    name text NOT NULL,
    brand text NOT NULL,
    cores integer NOT NULL,
    threads integer NOT NULL,
    base_clock numeric,
    boost_clock numeric,
    tdp integer,
    socket text NOT NULL,
    price numeric
);


ALTER TABLE public.cpus OWNER TO postgres;

--
-- Name: cpus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cpus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cpus_id_seq OWNER TO postgres;

--
-- Name: cpus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cpus_id_seq OWNED BY public.cpus.id;


--
-- Name: gpus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gpus (
    id integer NOT NULL,
    name text NOT NULL,
    brand text NOT NULL,
    vram integer NOT NULL,
    tdp integer,
    price numeric
);


ALTER TABLE public.gpus OWNER TO postgres;

--
-- Name: gpus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gpus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gpus_id_seq OWNER TO postgres;

--
-- Name: gpus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gpus_id_seq OWNED BY public.gpus.id;


--
-- Name: motherboards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motherboards (
    id integer NOT NULL,
    name text NOT NULL,
    brand text NOT NULL,
    socket text NOT NULL,
    chipset text,
    form_factor text NOT NULL,
    ram_type text NOT NULL,
    ram_slots integer,
    max_ram integer,
    price numeric
);


ALTER TABLE public.motherboards OWNER TO postgres;

--
-- Name: motherboards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.motherboards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.motherboards_id_seq OWNER TO postgres;

--
-- Name: motherboards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.motherboards_id_seq OWNED BY public.motherboards.id;


--
-- Name: psus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.psus (
    id integer NOT NULL,
    name text NOT NULL,
    brand text NOT NULL,
    wattage integer NOT NULL,
    certification text,
    modular boolean,
    price numeric
);


ALTER TABLE public.psus OWNER TO postgres;

--
-- Name: psus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.psus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.psus_id_seq OWNER TO postgres;

--
-- Name: psus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.psus_id_seq OWNED BY public.psus.id;


--
-- Name: rams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rams (
    id integer NOT NULL,
    name text NOT NULL,
    brand text NOT NULL,
    type text NOT NULL,
    capacity integer NOT NULL,
    speed integer NOT NULL,
    price numeric
);


ALTER TABLE public.rams OWNER TO postgres;

--
-- Name: rams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rams_id_seq OWNER TO postgres;

--
-- Name: rams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rams_id_seq OWNED BY public.rams.id;


--
-- Name: storages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.storages (
    id integer NOT NULL,
    name text NOT NULL,
    brand text NOT NULL,
    type text NOT NULL,
    capacity integer NOT NULL,
    interface text NOT NULL,
    price numeric
);


ALTER TABLE public.storages OWNER TO postgres;

--
-- Name: storages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.storages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.storages_id_seq OWNER TO postgres;

--
-- Name: storages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.storages_id_seq OWNED BY public.storages.id;


--
-- Name: cases id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases ALTER COLUMN id SET DEFAULT nextval('public.cases_id_seq'::regclass);


--
-- Name: coolers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coolers ALTER COLUMN id SET DEFAULT nextval('public.coolers_id_seq'::regclass);


--
-- Name: cpus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus ALTER COLUMN id SET DEFAULT nextval('public.cpus_id_seq'::regclass);


--
-- Name: gpus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gpus ALTER COLUMN id SET DEFAULT nextval('public.gpus_id_seq'::regclass);


--
-- Name: motherboards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards ALTER COLUMN id SET DEFAULT nextval('public.motherboards_id_seq'::regclass);


--
-- Name: psus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.psus ALTER COLUMN id SET DEFAULT nextval('public.psus_id_seq'::regclass);


--
-- Name: rams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rams ALTER COLUMN id SET DEFAULT nextval('public.rams_id_seq'::regclass);


--
-- Name: storages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storages ALTER COLUMN id SET DEFAULT nextval('public.storages_id_seq'::regclass);


--
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cases (id, name, brand, form_factor, gpu_length_limit, cooler_height_limit, price) FROM stdin;
1	NZXT H510	NZXT	ATX	380	165	80
2	Corsair 4000D Airflow	Corsair	ATX	360	170	95
3	Fractal Meshify C	Fractal	ATX	340	170	100
\.


--
-- Data for Name: coolers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coolers (id, name, brand, type, tdp_support, socket_support, price) FROM stdin;
1	Cooler Master Hyper 212	Cooler Master	Air	150	{AM4,LGA1700}	35
2	Noctua NH-D15	Noctua	Air	250	{AM4,LGA1700}	100
3	DeepCool AK620	DeepCool	Air	260	{AM4,LGA1700}	70
\.


--
-- Data for Name: cpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cpus (id, name, brand, cores, threads, base_clock, boost_clock, tdp, socket, price) FROM stdin;
1	Ryzen 5 5600	AMD	6	12	3.5	4.4	65	AM4	120
2	Core i5-12400F	Intel	6	12	2.5	4.4	65	LGA1700	150
3	Ryzen 5 5600	AMD	6	12	3.5	4.4	65	AM4	120
4	Ryzen 7 5800X	AMD	8	16	3.8	4.7	105	AM4	220
5	Core i5-12400F	Intel	6	12	2.5	4.4	65	LGA1700	150
6	Core i7-12700K	Intel	12	20	3.6	5.0	125	LGA1700	350
\.


--
-- Data for Name: gpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gpus (id, name, brand, vram, tdp, price) FROM stdin;
1	RTX 3060	NVIDIA	12	170	300
2	RTX 4070	NVIDIA	12	200	600
3	RX 6600	AMD	8	132	220
4	RX 7800 XT	AMD	16	263	500
\.


--
-- Data for Name: motherboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motherboards (id, name, brand, socket, chipset, form_factor, ram_type, ram_slots, max_ram, price) FROM stdin;
1	MSI B550 Tomahawk	MSI	AM4	B550	ATX	DDR4	4	128	160
2	ASUS ROG Strix B550-F	ASUS	AM4	B550	ATX	DDR4	4	128	180
3	Gigabyte Z690 UD	Gigabyte	LGA1700	Z690	ATX	DDR4	4	128	200
4	ASUS Prime Z690-P	ASUS	LGA1700	Z690	ATX	DDR5	4	128	250
\.


--
-- Data for Name: psus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.psus (id, name, brand, wattage, certification, modular, price) FROM stdin;
1	Corsair RM650x	Corsair	650	80+ Gold	t	110
2	Be Quiet Pure Power 11	Be Quiet	600	80+ Gold	f	90
3	Seasonic Focus GX-750	Seasonic	750	80+ Gold	t	130
\.


--
-- Data for Name: rams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rams (id, name, brand, type, capacity, speed, price) FROM stdin;
1	Corsair Vengeance LPX	Corsair	DDR4	16	3200	50
2	G.Skill Ripjaws V	G.Skill	DDR4	32	3600	90
3	Kingston Fury Beast	Kingston	DDR5	16	5200	80
4	Corsair Dominator Platinum	Corsair	DDR5	32	6000	160
\.


--
-- Data for Name: storages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.storages (id, name, brand, type, capacity, interface, price) FROM stdin;
1	Samsung 970 EVO Plus	Samsung	SSD	500	NVMe	60
2	Samsung 980 PRO	Samsung	SSD	1000	NVMe	120
3	WD Blue HDD	Western Digital	HDD	2000	SATA	50
4	Crucial MX500	Crucial	SSD	1000	SATA	70
\.


--
-- Name: cases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cases_id_seq', 3, true);


--
-- Name: coolers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coolers_id_seq', 3, true);


--
-- Name: cpus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cpus_id_seq', 6, true);


--
-- Name: gpus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gpus_id_seq', 4, true);


--
-- Name: motherboards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motherboards_id_seq', 4, true);


--
-- Name: psus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.psus_id_seq', 3, true);


--
-- Name: rams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rams_id_seq', 4, true);


--
-- Name: storages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.storages_id_seq', 4, true);


--
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: coolers coolers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coolers
    ADD CONSTRAINT coolers_pkey PRIMARY KEY (id);


--
-- Name: cpus cpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_pkey PRIMARY KEY (id);


--
-- Name: gpus gpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gpus
    ADD CONSTRAINT gpus_pkey PRIMARY KEY (id);


--
-- Name: motherboards motherboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_pkey PRIMARY KEY (id);


--
-- Name: psus psus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.psus
    ADD CONSTRAINT psus_pkey PRIMARY KEY (id);


--
-- Name: rams rams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rams
    ADD CONSTRAINT rams_pkey PRIMARY KEY (id);


--
-- Name: storages storages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storages
    ADD CONSTRAINT storages_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

