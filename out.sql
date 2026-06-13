--
-- PostgreSQL database dump
--

-- Dumped from database version 17.9 (Debian 17.9-1.pgdg13+1)
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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


ALTER SEQUENCE public.cases_id_seq OWNER TO postgres;

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


ALTER SEQUENCE public.coolers_id_seq OWNER TO postgres;

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
    price numeric,
    ram_type text
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


ALTER SEQUENCE public.cpus_id_seq OWNER TO postgres;

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
    price numeric,
    interface text
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


ALTER SEQUENCE public.gpus_id_seq OWNER TO postgres;

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


ALTER SEQUENCE public.motherboards_id_seq OWNER TO postgres;

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


ALTER SEQUENCE public.psus_id_seq OWNER TO postgres;

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
    capacity integer NOT NULL,
    speed integer NOT NULL,
    price numeric,
    ram_type text
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


ALTER SEQUENCE public.rams_id_seq OWNER TO postgres;

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
    brand text,
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


ALTER SEQUENCE public.storages_id_seq OWNER TO postgres;

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

COPY public.cpus (id, name, brand, cores, threads, base_clock, boost_clock, tdp, socket, price, ram_type) FROM stdin;
1	Ryzen 5 5600	AMD	6	12	3.5	4.4	65	AM4	120	\N
2	Core i5-12400F	Intel	6	12	2.5	4.4	65	LGA1700	150	\N
3	Ryzen 5 5600	AMD	6	12	3.5	4.4	65	AM4	120	\N
4	Ryzen 7 5800X	AMD	8	16	3.8	4.7	105	AM4	220	\N
5	Core i5-12400F	Intel	6	12	2.5	4.4	65	LGA1700	150	\N
6	Core i7-12700K	Intel	12	20	3.6	5.0	125	LGA1700	350	\N
14	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
15	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
16	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
17	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
18	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
19	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
20	Процессор AMD Ryzen 7 7700, AM5,  OEM [100-000000592]	AMD	8	16	3	\N	65	AM5	\N	DDR5
21	Процессор AMD Ryzen 5 5500, AM4,  OEM [100-000000457]	AMD	6	12	3	\N	65	AM4	\N	DDR4
22	Процессор AMD Ryzen 5 3600, AM4,  OEM [100-000000031]	AMD	6	12	3	\N	65	AM4	\N	DDR4
23	Процессор AMD Ryzen 5 5600G, AM4,  OEM [100-000000252]	AMD	6	12	3	\N	65	AM4	\N	DDR4
24	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
25	Процессор Intel Core i3 12100F, LGA 1700,  OEM [cm8071504651013 srl63]	INTEL	4	8	3	\N	58	LGA 1700	\N	DDR5/ DDR4
26	Процессор Intel Core i5 14600KF, LGA 1700,  OEM [cm8071504821014 srn42]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
27	Процессор AMD Ryzen 7 9700X, AM5,  OEM [100-000001404]	AMD	8	16	3	\N	65	AM5	\N	DDR5
28	Процессор Intel Core i5 12400, LGA 1700,  OEM [cm8071504650608 srl5y]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
29	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
30	Процессор Intel Core i3 12100, LGA 1700,  OEM [cm8071504651012 srl62]	INTEL	4	8	3	\N	60	LGA 1700	\N	DDR5/ DDR4
31	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504555318 srl4w]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
32	Процессор AMD Ryzen 9 5950X, AM4,  OEM [100-000000059]	AMD	16	32	3	\N	105	AM4	\N	DDR4
33	Процессор AMD Ryzen 7 5700G, AM4,  OEM [100-000000263]	AMD	8	16	3	\N	65	AM4	\N	DDR4
34	Процессор AMD Ryzen 5 3500X, AM4,  OEM [100-000000158]	AMD	6	6	3	\N	65	AM4	\N	DDR4
35	Процессор AMD Ryzen 5 8400F, AM5,  OEM [100-000001591]	AMD	6	12	4	\N	65	AM5	\N	DDR5
36	Процессор Intel Core i7 14700KF, LGA 1700,  OEM [cm8071504820722 srn3y]	INTEL	20	28	3	\N	125	LGA 1700	\N	DDR5/ DDR4
37	Процессор Intel Core i5 12600KF, LGA 1700,  OEM [cm8071504555228 srl4u]	INTEL	10	16	3	\N	125	LGA 1700	\N	DDR5/ DDR4
38	Процессор Intel Core i5 13600KF, LGA 1700,  OEM [cm8071504821006 srmbe]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
39	Процессор AMD Ryzen 9 9950X, AM5,  OEM [100-000001277]	AMD	16	32	4	\N	170	AM5	\N	DDR5
40	Процессор Intel Core i5 10400F, LGA 1200,  OEM [cm8070104290716 srh3d]	INTEL	6	12	2	\N	65	LGA 1200	\N	DDR4
41	Процессор AMD Ryzen 9 9950X3D, AM5,  OEM [100-000000719]	AMD	16	32	4	\N	170	AM5	\N	DDR5
42	Процессор AMD Ryzen 5 9600X, AM5,  OEM [100-000001405]	AMD	6	12	3	\N	65	AM5	\N	DDR5
43	Процессор Intel Core i5 14400F, LGA 1700,  OEM [cm8071505093011 srn3r]	INTEL	10	16	2	\N	65	LGA 1700	\N	DDR5/ DDR4
44	Процессор Intel Core i5 12600K, LGA 1700,  OEM [cm8071504555227 srl4t]	INTEL	10	16	3	\N	125	LGA 1700	\N	DDR5/ DDR4
60	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
61	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
62	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
63	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
64	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
65	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
66	Процессор AMD Ryzen 7 7700, AM5,  OEM [100-000000592]	AMD	8	16	3	\N	65	AM5	\N	DDR5
67	Процессор AMD Ryzen 5 5500, AM4,  OEM [100-000000457]	AMD	6	12	3	\N	65	AM4	\N	DDR4
68	Процессор AMD Ryzen 5 3600, AM4,  OEM [100-000000031]	AMD	6	12	3	\N	65	AM4	\N	DDR4
69	Процессор AMD Ryzen 5 5600G, AM4,  OEM [100-000000252]	AMD	6	12	3	\N	65	AM4	\N	DDR4
70	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
71	Процессор Intel Core i3 12100F, LGA 1700,  OEM [cm8071504651013 srl63]	INTEL	4	8	3	\N	58	LGA 1700	\N	DDR5/ DDR4
72	Процессор Intel Core i5 14600KF, LGA 1700,  OEM [cm8071504821014 srn42]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
73	Процессор AMD Ryzen 7 9700X, AM5,  OEM [100-000001404]	AMD	8	16	3	\N	65	AM5	\N	DDR5
74	Процессор Intel Core i5 12400, LGA 1700,  OEM [cm8071504650608 srl5y]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
75	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
76	Процессор Intel Core i3 12100, LGA 1700,  OEM [cm8071504651012 srl62]	INTEL	4	8	3	\N	60	LGA 1700	\N	DDR5/ DDR4
77	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504555318 srl4w]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
78	Процессор AMD Ryzen 9 5950X, AM4,  OEM [100-000000059]	AMD	16	32	3	\N	105	AM4	\N	DDR4
79	Процессор AMD Ryzen 7 5700G, AM4,  OEM [100-000000263]	AMD	8	16	3	\N	65	AM4	\N	DDR4
106	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
107	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
108	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
109	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
110	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
111	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
112	Процессор AMD Ryzen 7 7700, AM5,  OEM [100-000000592]	AMD	8	16	3	\N	65	AM5	\N	DDR5
113	Процессор AMD Ryzen 5 5500, AM4,  OEM [100-000000457]	AMD	6	12	3	\N	65	AM4	\N	DDR4
114	Процессор AMD Ryzen 5 3600, AM4,  OEM [100-000000031]	AMD	6	12	3	\N	65	AM4	\N	DDR4
115	Процессор AMD Ryzen 5 5600G, AM4,  OEM [100-000000252]	AMD	6	12	3	\N	65	AM4	\N	DDR4
116	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
117	Процессор Intel Core i3 12100F, LGA 1700,  OEM [cm8071504651013 srl63]	INTEL	4	8	3	\N	58	LGA 1700	\N	DDR5/ DDR4
118	Процессор Intel Core i5 14600KF, LGA 1700,  OEM [cm8071504821014 srn42]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
119	Процессор AMD Ryzen 7 9700X, AM5,  OEM [100-000001404]	AMD	8	16	3	\N	65	AM5	\N	DDR5
120	Процессор Intel Core i5 12400, LGA 1700,  OEM [cm8071504650608 srl5y]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
121	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
122	Процессор Intel Core i3 12100, LGA 1700,  OEM [cm8071504651012 srl62]	INTEL	4	8	3	\N	60	LGA 1700	\N	DDR5/ DDR4
123	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504555318 srl4w]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
152	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
153	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
154	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
155	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
156	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
157	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
158	Процессор AMD Ryzen 7 7700, AM5,  OEM [100-000000592]	AMD	8	16	3	\N	65	AM5	\N	DDR5
159	Процессор AMD Ryzen 5 5500, AM4,  OEM [100-000000457]	AMD	6	12	3	\N	65	AM4	\N	DDR4
160	Процессор AMD Ryzen 5 3600, AM4,  OEM [100-000000031]	AMD	6	12	3	\N	65	AM4	\N	DDR4
161	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
162	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
163	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
164	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
165	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
166	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
167	Процессор AMD Ryzen 7 7700, AM5,  OEM [100-000000592]	AMD	8	16	3	\N	65	AM5	\N	DDR5
168	Процессор AMD Ryzen 5 5500, AM4,  OEM [100-000000457]	AMD	6	12	3	\N	65	AM4	\N	DDR4
169	Процессор AMD Ryzen 5 3600, AM4,  OEM [100-000000031]	AMD	6	12	3	\N	65	AM4	\N	DDR4
170	Процессор AMD Ryzen 5 5600G, AM4,  OEM [100-000000252]	AMD	6	12	3	\N	65	AM4	\N	DDR4
171	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
172	Процессор Intel Core i3 12100F, LGA 1700,  OEM [cm8071504651013 srl63]	INTEL	4	8	3	\N	58	LGA 1700	\N	DDR5/ DDR4
173	Процессор Intel Core i5 14600KF, LGA 1700,  OEM [cm8071504821014 srn42]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
174	Процессор AMD Ryzen 7 9700X, AM5,  OEM [100-000001404]	AMD	8	16	3	\N	65	AM5	\N	DDR5
175	Процессор Intel Core i5 12400, LGA 1700,  OEM [cm8071504650608 srl5y]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
176	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
177	Процессор Intel Core i3 12100, LGA 1700,  OEM [cm8071504651012 srl62]	INTEL	4	8	3	\N	60	LGA 1700	\N	DDR5/ DDR4
178	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504555318 srl4w]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
179	Процессор AMD Ryzen 9 5950X, AM4,  OEM [100-000000059]	AMD	16	32	3	\N	105	AM4	\N	DDR4
180	Процессор AMD Ryzen 7 5700G, AM4,  OEM [100-000000263]	AMD	8	16	3	\N	65	AM4	\N	DDR4
181	Процессор AMD Ryzen 5 3500X, AM4,  OEM [100-000000158]	AMD	6	6	3	\N	65	AM4	\N	DDR4
182	Процессор AMD Ryzen 5 8400F, AM5,  OEM [100-000001591]	AMD	6	12	4	\N	65	AM5	\N	DDR5
183	Процессор Intel Core i7 14700KF, LGA 1700,  OEM [cm8071504820722 srn3y]	INTEL	20	28	3	\N	125	LGA 1700	\N	DDR5/ DDR4
184	Процессор Intel Core i5 12600KF, LGA 1700,  OEM [cm8071504555228 srl4u]	INTEL	10	16	3	\N	125	LGA 1700	\N	DDR5/ DDR4
185	Процессор Intel Core i5 13600KF, LGA 1700,  OEM [cm8071504821006 srmbe]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
186	Процессор AMD Ryzen 9 9950X, AM5,  OEM [100-000001277]	AMD	16	32	4	\N	170	AM5	\N	DDR5
187	Процессор Intel Core i5 10400F, LGA 1200,  OEM [cm8070104290716 srh3d]	INTEL	6	12	2	\N	65	LGA 1200	\N	DDR4
188	Процессор AMD Ryzen 9 9950X3D, AM5,  OEM [100-000000719]	AMD	16	32	4	\N	170	AM5	\N	DDR5
189	Процессор AMD Ryzen 5 9600X, AM5,  OEM [100-000001405]	AMD	6	12	3	\N	65	AM5	\N	DDR5
190	Процессор Intel Core i5 14400F, LGA 1700,  OEM [cm8071505093011 srn3r]	INTEL	10	16	2	\N	65	LGA 1700	\N	DDR5/ DDR4
191	Процессор Intel Core i5 12600K, LGA 1700,  OEM [cm8071504555227 srl4t]	INTEL	10	16	3	\N	125	LGA 1700	\N	DDR5/ DDR4
195	Процессор Intel Core i5 14600K, LGA 1700,  OEM [cm8071504821015 srn43]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
196	Процессор AMD Ryzen 3 3200G, AM4,  OEM [yd3200c5m4mfh]	AMD	4	4	3	\N	65	AM4	\N	DDR4
197	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
198	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
199	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
200	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
201	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
202	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
203	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
204	Процессор AMD Ryzen 5 5500X3d, AM4,  OEM [100-000001504]	AMD	6	12	3	\N	105	AM4	\N	DDR4
205	Процессор AMD Ryzen 9 9950X3D, AM5,  OEM [100-000000719]	AMD	16	32	4	\N	170	AM5	\N	DDR5
206	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
207	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
208	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
209	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
210	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
211	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
212	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
213	Процессор AMD Ryzen 7 7700, AM5,  OEM [100-000000592]	AMD	8	16	3	\N	65	AM5	\N	DDR5
214	Процессор AMD Ryzen 5 5500, AM4,  OEM [100-000000457]	AMD	6	12	3	\N	65	AM4	\N	DDR4
215	Процессор AMD Ryzen 5 3600, AM4,  OEM [100-000000031]	AMD	6	12	3	\N	65	AM4	\N	DDR4
216	Процессор AMD Ryzen 5 5600G, AM4,  OEM [100-000000252]	AMD	6	12	3	\N	65	AM4	\N	DDR4
217	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
218	Процессор Intel Core i3 12100F, LGA 1700,  OEM [cm8071504651013 srl63]	INTEL	4	8	3	\N	58	LGA 1700	\N	DDR5/ DDR4
219	Процессор Intel Core i5 14600KF, LGA 1700,  OEM [cm8071504821014 srn42]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
220	Процессор AMD Ryzen 7 9700X, AM5,  OEM [100-000001404]	AMD	8	16	3	\N	65	AM5	\N	DDR5
221	Процессор Intel Core i5 12400, LGA 1700,  OEM [cm8071504650608 srl5y]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
222	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
223	Процессор Intel Core i3 12100, LGA 1700,  OEM [cm8071504651012 srl62]	INTEL	4	8	3	\N	60	LGA 1700	\N	DDR5/ DDR4
224	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504555318 srl4w]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
225	Процессор AMD Ryzen 9 5950X, AM4,  OEM [100-000000059]	AMD	16	32	3	\N	105	AM4	\N	DDR4
226	Процессор AMD Ryzen 7 5700G, AM4,  OEM [100-000000263]	AMD	8	16	3	\N	65	AM4	\N	DDR4
227	Процессор AMD Ryzen 5 3500X, AM4,  OEM [100-000000158]	AMD	6	6	3	\N	65	AM4	\N	DDR4
228	Процессор AMD Ryzen 5 8400F, AM5,  OEM [100-000001591]	AMD	6	12	4	\N	65	AM5	\N	DDR5
229	Процессор Intel Core i7 14700KF, LGA 1700,  OEM [cm8071504820722 srn3y]	INTEL	20	28	3	\N	125	LGA 1700	\N	DDR5/ DDR4
230	Процессор Intel Core i5 12600KF, LGA 1700,  OEM [cm8071504555228 srl4u]	INTEL	10	16	3	\N	125	LGA 1700	\N	DDR5/ DDR4
231	Процессор Intel Core i5 13600KF, LGA 1700,  OEM [cm8071504821006 srmbe]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
232	Процессор AMD Ryzen 9 9950X, AM5,  OEM [100-000001277]	AMD	16	32	4	\N	170	AM5	\N	DDR5
233	Процессор Intel Core i5 10400F, LGA 1200,  OEM [cm8070104290716 srh3d]	INTEL	6	12	2	\N	65	LGA 1200	\N	DDR4
234	Процессор AMD Ryzen 9 9950X3D, AM5,  OEM [100-000000719]	AMD	16	32	4	\N	170	AM5	\N	DDR5
235	Процессор AMD Ryzen 5 9600X, AM5,  OEM [100-000001405]	AMD	6	12	3	\N	65	AM5	\N	DDR5
236	Процессор Intel Core i5 14400F, LGA 1700,  OEM [cm8071505093011 srn3r]	INTEL	10	16	2	\N	65	LGA 1700	\N	DDR5/ DDR4
237	Процессор Intel Core i5 12600K, LGA 1700,  OEM [cm8071504555227 srl4t]	INTEL	10	16	3	\N	125	LGA 1700	\N	DDR5/ DDR4
239	Процессор AMD Ryzen 5 5500X3d, AM4,  OEM [100-000001504]	AMD	6	12	3	\N	105	AM4	\N	DDR4
240	Процессор Intel Core i7 14700K, LGA 1700,  OEM [cm8071504820721 srn3x]	INTEL	20	28	3	\N	125	LGA 1700	\N	DDR5/ DDR4
241	Процессор Intel Core i5 14600K, LGA 1700,  OEM [cm8071504821015 srn43]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
242	Процессор AMD Ryzen 3 3200G, AM4,  OEM [yd3200c5m4mfh]	AMD	4	4	3	\N	65	AM4	\N	DDR4
243	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
244	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
245	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
246	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
247	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
248	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
249	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
250	Процессор AMD Ryzen 5 5500X3d, AM4,  OEM [100-000001504]	AMD	6	12	3	\N	105	AM4	\N	DDR4
251	Процессор AMD Ryzen 9 9950X3D, AM5,  OEM [100-000000719]	AMD	16	32	4	\N	170	AM5	\N	DDR5
252	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
253	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
254	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
255	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
256	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
257	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
258	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
259	Процессор AMD Ryzen 7 7700, AM5,  OEM [100-000000592]	AMD	8	16	3	\N	65	AM5	\N	DDR5
260	Процессор AMD Ryzen 5 5500, AM4,  OEM [100-000000457]	AMD	6	12	3	\N	65	AM4	\N	DDR4
261	Процессор AMD Ryzen 5 3600, AM4,  OEM [100-000000031]	AMD	6	12	3	\N	65	AM4	\N	DDR4
262	Процессор AMD Ryzen 5 5600G, AM4,  OEM [100-000000252]	AMD	6	12	3	\N	65	AM4	\N	DDR4
263	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
264	Процессор Intel Core i3 12100F, LGA 1700,  OEM [cm8071504651013 srl63]	INTEL	4	8	3	\N	58	LGA 1700	\N	DDR5/ DDR4
265	Процессор Intel Core i5 14600KF, LGA 1700,  OEM [cm8071504821014 srn42]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
266	Процессор AMD Ryzen 7 9700X, AM5,  OEM [100-000001404]	AMD	8	16	3	\N	65	AM5	\N	DDR5
267	Процессор Intel Core i5 12400, LGA 1700,  OEM [cm8071504650608 srl5y]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
268	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
269	Процессор Intel Core i3 12100, LGA 1700,  OEM [cm8071504651012 srl62]	INTEL	4	8	3	\N	60	LGA 1700	\N	DDR5/ DDR4
270	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504555318 srl4w]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
271	Процессор AMD Ryzen 9 5950X, AM4,  OEM [100-000000059]	AMD	16	32	3	\N	105	AM4	\N	DDR4
272	Процессор AMD Ryzen 7 5700G, AM4,  OEM [100-000000263]	AMD	8	16	3	\N	65	AM4	\N	DDR4
273	Процессор AMD Ryzen 5 3500X, AM4,  OEM [100-000000158]	AMD	6	6	3	\N	65	AM4	\N	DDR4
274	Процессор AMD Ryzen 5 8400F, AM5,  OEM [100-000001591]	AMD	6	12	4	\N	65	AM5	\N	DDR5
275	Процессор Intel Core i7 14700KF, LGA 1700,  OEM [cm8071504820722 srn3y]	INTEL	20	28	3	\N	125	LGA 1700	\N	DDR5/ DDR4
276	Процессор Intel Core i5 12600KF, LGA 1700,  OEM [cm8071504555228 srl4u]	INTEL	10	16	3	\N	125	LGA 1700	\N	DDR5/ DDR4
277	Процессор Intel Core i5 13600KF, LGA 1700,  OEM [cm8071504821006 srmbe]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
278	Процессор AMD Ryzen 9 9950X, AM5,  OEM [100-000001277]	AMD	16	32	4	\N	170	AM5	\N	DDR5
279	Процессор Intel Core i5 10400F, LGA 1200,  OEM [cm8070104290716 srh3d]	INTEL	6	12	2	\N	65	LGA 1200	\N	DDR4
280	Процессор AMD Ryzen 9 9950X3D, AM5,  OEM [100-000000719]	AMD	16	32	4	\N	170	AM5	\N	DDR5
281	Процессор AMD Ryzen 5 9600X, AM5,  OEM [100-000001405]	AMD	6	12	3	\N	65	AM5	\N	DDR5
282	Процессор Intel Core i5 14400F, LGA 1700,  OEM [cm8071505093011 srn3r]	INTEL	10	16	2	\N	65	LGA 1700	\N	DDR5/ DDR4
283	Процессор Intel Core i5 12600K, LGA 1700,  OEM [cm8071504555227 srl4t]	INTEL	10	16	3	\N	125	LGA 1700	\N	DDR5/ DDR4
287	Процессор Intel Core i5 14600K, LGA 1700,  OEM [cm8071504821015 srn43]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
288	Процессор AMD Ryzen 3 3200G, AM4,  OEM [yd3200c5m4mfh]	AMD	4	4	3	\N	65	AM4	\N	DDR4
289	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	\N	DDR4
290	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	\N	DDR5
291	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	\N	DDR4
292	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	\N	DDR5
293	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	\N	DDR5/ DDR4
294	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	\N	DDR4
295	Процессор AMD Ryzen 5 7500F, AM5,  OEM [100-000000597]	AMD	6	12	3	\N	65	AM5	\N	DDR5
296	Процессор AMD Ryzen 5 5500X3d, AM4,  OEM [100-000001504]	AMD	6	12	3	\N	105	AM4	\N	DDR4
297	Процессор AMD Ryzen 9 9950X3D, AM5,  OEM [100-000000719]	AMD	16	32	4	\N	170	AM5	\N	DDR5
298	Процессор AMD Ryzen 7 5800X, AM4,  OEM [100-000000063]	AMD	8	16	3	\N	105	AM4	\N	DDR4
299	Процессор AMD Ryzen 7 8700F, AM5,  OEM [100-000001590]	AMD	8	16	4	\N	65	AM5	\N	DDR5
300	Процессор AMD Ryzen 9 9900X, AM5,  OEM [100-000000662]	AMD	12	24	4	\N	120	AM5	\N	DDR5
301	Процессор Intel Core i7 14700F, LGA 1700,  OEM [cm8071504820816 srn3z]	INTEL	20	28	2	\N	65	LGA 1700	\N	DDR5/ DDR4
302	Процессор Intel Core i9 14900K, LGA 1700,  OEM [cm8071505094017 srn48]	INTEL	24	32	3	\N	125	LGA 1700	\N	DDR5/ DDR4
303	Процессор Intel Core i5 13400F, LGA 1700,  OEM [cm8071505093005 srmbn]	INTEL	10	16	2	\N	65	LGA 1700	\N	DDR5/ DDR4
304	Процессор Intel Core i5 13600K, LGA 1700,  OEM [cm8071504821005 srmbd]	INTEL	14	20	3	\N	125	LGA 1700	\N	DDR5/ DDR4
305	Процессор AMD Ryzen Threadripper Pro 9995WX, sTR5,  OEM [100-000001361]	AMD	96	192	2	\N	350	sTR5	\N	DDR5
306	Процессор AMD Ryzen 7 9850x3d, AM5,  OEM [100-000001973]	AMD	8	16	4	\N	120	AM5	\N	DDR5
307	Процессор Intel Core Ultra 9 285K, LGA 1851,  OEM [at8076806419]	INTEL	24	24	3	\N	125	LGA 1851	\N	DDR5
308	Процессор Intel Core i7 14700, LGA 1700,  OEM [cm8071504820817 srn40]	INTEL	20	28	2	\N	65	LGA 1700	\N	DDR5/ DDR4
309	Процессор Intel Core i9 14900KF, LGA 1700,  OEM [cm8071505094018 srn49]	INTEL	24	32	3	\N	125	LGA 1700	\N	DDR5/ DDR4
\.


--
-- Data for Name: gpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gpus (id, name, brand, vram, tdp, price, interface) FROM stdin;
1	RTX 3060	NVIDIA	12	170	300	\N
2	RTX 4070	NVIDIA	12	200	600	\N
3	RX 6600	AMD	8	132	220	\N
4	RX 7800 XT	AMD	16	263	500	\N
92	Видеокарта Gigabyte NVIDIA  GeForce RTX 5070 GV-N5070WF3OC-12GD 1.0 12ГБ Windforce, GDDR7, OC,  Ret	GIGABYTE	12	250	\N	\N
93	Видеокарта Palit NVIDIA  GeForce RTX 5060TI PA-RTX5060TI INFINITY 3 OC 16ГБ Infinity 3, GDDR7, OC,  Ret [ne7506ts19t1-gb2061s]	PALIT	16	180	\N	\N
94	Видеокарта Gigabyte NVIDIA  GeForce RTX 5070TI GV-N507TWF3OC-16GD 1.0 16ГБ Windforce, GDDR7, OC,  Ret	GIGABYTE	16	300	\N	\N
95	Видеокарта Palit NVIDIA  GeForce RTX 5060TI PA-RTX5060TI DUAL 8ГБ Dual, GDDR7, Ret [ne7506t019p1-gb2062d]	PALIT	8	180	\N	\N
96	Видеокарта Palit NVIDIA  GeForce RTX 5060 PA-RTX5060 DUAL OC 8ГБ Dual, GDDR7, OC,  Ret [ne75060s19p1-gb2063d]	PALIT	8	145	\N	\N
97	Видеокарта Palit NVIDIA  GeForce RTX 5060TI PA-RTX5060TI INFINITY 3 16ГБ Infinity 3, GDDR7, Ret [ne7506t019t1-gb2061s]	PALIT	16	180	\N	\N
98	Видеокарта Gigabyte NVIDIA  GeForce RTX 5070 GV-N5070GAMING OC-12GD 1.0 12ГБ Gaming, GDDR7, OC,  Ret	GIGABYTE	12	250	\N	\N
99	Видеокарта Gigabyte NVIDIA  GeForce RTX 5070 GV-N5070WF3OC-12GD 1.0 12ГБ Windforce, GDDR7, OC,  Ret	GIGABYTE	12	250	\N	\N
100	Видеокарта Palit NVIDIA  GeForce RTX 5060TI PA-RTX5060TI INFINITY 3 OC 16ГБ Infinity 3, GDDR7, OC,  Ret [ne7506ts19t1-gb2061s]	PALIT	16	180	\N	\N
101	Видеокарта MSI NVIDIA  GeForce RTX 3050 RTX 3050 VENTUS 2X XS 8G OC 8ГБ Ventus 2X, GDDR6, OC,  Ret	MSI	8	115	\N	\N
102	Видеокарта Gigabyte NVIDIA  GeForce RTX 3060 GV-N3060GAMING OC-8GD 2.0 8ГБ Gaming, GDDR6, OC,  Ret	GIGABYTE	8	170	\N	\N
103	Видеокарта Biostar AMD  Radeon RX 580 VA5815RQ82 8ГБ GDDR5, Ret	BIOSTAR	8	150	\N	\N
104	Видеокарта Palit NVIDIA  GeForce RTX 5070 PA-RTX5070 Infinity 3 12ГБ Infinity 3, GDDR7, Ret [ne75070019k9-gb2050s]	PALIT	12	250	\N	\N
105	Видеокарта AFOX NVIDIA  GeForce RTX 2060 AF2060-6144D6H4-V2 6ГБ GDDR6, Ret	AFOX	6	160	\N	\N
106	Видеокарта Gigabyte NVIDIA  GeForce RTX 5070TI GV-N507TWF3OC-16GD 1.0 16ГБ Windforce, GDDR7, OC,  Ret	GIGABYTE	16	300	\N	\N
107	Видеокарта MSI NVIDIA  GeForce RTX 5060TI RTX 5060 TI 16G GAMING OC 16ГБ Gaming, GDDR7, OC,  Ret	MSI	16	180	\N	\N
108	Видеокарта Palit NVIDIA  GeForce RTX 5060 PA-RTX5060 DUAL 8ГБ Dual, GDDR7, Ret [ne75060019p1-gb2063d]	PALIT	8	145	\N	\N
109	Видеокарта Gigabyte NVIDIA  GeForce RTX 5070TI GV-N507TGAMING OC-16GD 1.0 16ГБ Gaming, GDDR7, OC,  Ret	GIGABYTE	16	300	\N	\N
110	Видеокарта Gigabyte NVIDIA  GeForce RTX 5060TI GV-N506TWF2MAX OC-8GD 1.0 8ГБ Windforce Max, GDDR7, OC,  Ret	GIGABYTE	8	180	\N	\N
111	Видеокарта MSI NVIDIA  GeForce RTX 3050 RTX 3050 VENTUS 2X E 6G OC 6ГБ Ventus 2X, GDDR6, OC,  Ret	MSI	6	70	\N	\N
112	Видеокарта Palit NVIDIA  GeForce RTX 5060 PA-RTX5060 DUAL OC 8ГБ Dual, GDDR7, OC,  Ret [ne75060s19p1-gb2063d]	PALIT	8	145	\N	\N
113	Видеокарта ASRock INTEL  ARC B580 B580 CL 12GO 12ГБ Challenger, GDDR6, OC,  Ret	ASROCK	12	190	\N	\N
114	Видеокарта Gigabyte NVIDIA  GeForce RTX 5070 GV-N5070EAGLE OC-12GD 1.0 12ГБ Eagle, GDDR7, OC,  Ret	GIGABYTE	12	250	\N	\N
115	Видеокарта AFOX NVIDIA  GeForce GTX 1660SUPER AF1660S-6144D6H4-V2 6ГБ GDDR6, Ret	AFOX	6	\N	\N	\N
116	Видеокарта Gigabyte NVIDIA  GeForce RTX 5070 GV-N5070AERO OC-12GD 1.0 12ГБ Aero, GDDR7, OC,  Ret	GIGABYTE	12	250	\N	\N
\.


--
-- Data for Name: motherboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motherboards (id, name, brand, socket, chipset, form_factor, ram_type, ram_slots, max_ram, price) FROM stdin;
1	MSI B550 Tomahawk	MSI	AM4	B550	ATX	DDR4	4	128	160
2	ASUS ROG Strix B550-F	ASUS	AM4	B550	ATX	DDR4	4	128	180
3	Gigabyte Z690 UD	Gigabyte	LGA1700	Z690	ATX	DDR4	4	128	200
4	ASUS Prime Z690-P	ASUS	LGA1700	Z690	ATX	DDR5	4	128	250
97	Материнская плата Gigabyte B550 GAMING X V2, Socket AM4, AMD B550, ATX, Ret	GIGABYTE	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
98	Материнская плата MSI MPG B550 GAMING PLUS, Socket AM4, AMD B550, ATX, Ret	MSI	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
99	Материнская плата MSI A520M-A PRO, Socket AM4, AMD A520, mATX, Ret	MSI	Socket AM4	AMD A520	DIMM	DDR4	2	64	\N
100	Материнская плата Gigabyte A520M K V2, Socket AM4, AMD A520, mATX, Ret	GIGABYTE	Socket AM4	AMD A520	DIMM	DDR4	2	64	\N
101	Материнская плата Gigabyte B760M DS3H DDR4, Socket LGA 1700, Intel B760, mATX, Ret	GIGABYTE	Socket LGA 1700	Intel B760	DIMM	DDR4	4	128	\N
102	Материнская плата MSI PRO H610M-E DDR4, Socket LGA 1700, Intel H610, mATX, Ret	MSI	Socket LGA 1700	Intel H610	DIMM	DDR4	2	64	\N
103	Материнская плата MSI B550M PRO-VDH WIFI, Socket AM4, AMD B550, mATX, Ret	MSI	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
104	Материнская плата Gigabyte B550M K, Socket AM4, AMD B550, mATX, Ret	GIGABYTE	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
105	Материнская плата MSI PRO B760M-E DDR4, Socket LGA 1700, Intel B760, mATX, Ret	MSI	Socket LGA 1700	Intel B760	DIMM	DDR4	2	64	\N
106	Материнская плата MSI B550M PRO-VDH, Socket AM4, AMD B550, mATX, Ret	MSI	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
107	Материнская плата ASUS PRIME B550-PLUS, Socket AM4, AMD B550, ATX, Ret	ASUS	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
108	Материнская плата MSI B760 GAMING PLUS WIFI, Socket LGA 1700, Intel B760, ATX, Ret	MSI	Socket LGA 1700	Intel B760	DIMM	DDR5	4	192	\N
109	Материнская плата ASUS ROG STRIX B550-F GAMING, Socket AM4, AMD B550, ATX, Ret	ASUS	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
110	Материнская плата Gigabyte B850 GAMING X WIFI6E, Socket AM5, AMD B850, ATX, Ret	GIGABYTE	Socket AM5	AMD B850	DIMM	DDR5	4	256	\N
111	Материнская плата Gigabyte B760M D3HP DDR4, Socket LGA 1700, Intel B760, mATX, Ret	GIGABYTE	Socket LGA 1700	Intel B760	DIMM	DDR4	4	128	\N
112	Материнская плата MSI B760M GAMING PLUS WIFI, Socket LGA 1700, Intel B760, mATX, Ret	MSI	Socket LGA 1700	Intel B760	DIMM	DDR5	4	256	\N
113	Материнская плата ASUS PRIME B550M-K, Socket AM4, AMD B550, mATX, Ret	ASUS	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
114	Материнская плата MSI PRO B760-P WIFI DDR4, Socket LGA 1700, Intel B760, ATX, Ret	MSI	Socket LGA 1700	Intel B760	DIMM	DDR4	4	128	\N
115	Материнская плата ASUS TUF GAMING B850-PLUS WIFI, Socket AM5, AMD B850, ATX, Ret	ASUS	Socket AM5	AMD B850	DIMM	DDR5	4	256	\N
116	Материнская плата MSI PRO B650-S WIFI, Socket AM5, AMD B650, ATX, Ret	MSI	Socket AM5	AMD B650	DIMM	DDR5	4	256	\N
117	Материнская плата MSI MAG Z790 TOMAHAWK WIFI, Socket LGA 1700, Intel Z790, ATX, Ret	MSI	Socket LGA 1700	Intel Z790	DIMM	DDR5	4	192	\N
118	Материнская плата Gigabyte B550M DS3H R2, Socket AM4, AMD B550, mATX, Ret	GIGABYTE	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
119	Материнская плата MSI Z790 GAMING PLUS WIFI, Socket LGA 1700, Intel Z790, ATX, Ret	MSI	Socket LGA 1700	Intel Z790	DIMM	DDR5	4	128	\N
120	Материнская плата Gigabyte A520M DS3H V2, Socket AM4, AMD A520, mATX, Ret	GIGABYTE	Socket AM4	AMD A520	DIMM	DDR4	4	128	\N
121	Материнская плата ASUS PRIME B760M-K D4, Socket LGA 1700, Intel B760, mATX, Ret	ASUS	Socket LGA 1700	Intel B760	DIMM	DDR4	2	64	\N
122	Материнская плата Gigabyte H610M K DDR4, Socket LGA 1700, Intel H610, mATX, Ret	GIGABYTE	Socket LGA 1700	Intel H610	DIMM	DDR4	2	64	\N
123	Материнская плата ASUS TUF GAMING B550-PLUS, Socket AM4, AMD B550, ATX, Ret	ASUS	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
124	Материнская плата MSI PRO H610M-S DDR4, Socket LGA 1700, Intel H610, mATX, Ret	MSI	Socket LGA 1700	Intel H610	DIMM	DDR4	2	64	\N
125	Материнская плата ASUS PRIME B660-PLUS D4, Socket LGA 1700, Intel B660, ATX, Ret	ASUS	Socket LGA 1700	Intel B660	DIMM	DDR4	4	128	\N
126	Материнская плата ASUS TUF GAMING B850M-PLUS WIFI, Socket AM5, AMD B850, mATX, Ret	ASUS	Socket AM5	AMD B850	DIMM	DDR5	4	192	\N
127	Материнская плата ASUS PRIME B760M-K, Socket LGA 1700, Intel B760, mATX, Ret	ASUS	Socket LGA 1700	Intel B760	DIMM	DDR5	2	96	\N
128	Материнская плата MSI PRO B760M-P DDR4, Socket LGA 1700, Intel B760, mATX, Ret	MSI	Socket LGA 1700	Intel B760	DIMM	DDR4	4	128	\N
129	Материнская плата MSI A520M PRO, Socket AM4, AMD A520, mATX, Ret	MSI	Socket AM4	AMD A520	DIMM	DDR4	2	64	\N
130	Материнская плата Gigabyte B650 EAGLE AX, Socket AM5, AMD B650, ATX, Ret	GIGABYTE	Socket AM5	AMD B650	DIMM	DDR5	4	256	\N
131	Материнская плата ASUS TUF GAMING B450-PLUS II, Socket AM4, AMD B450, ATX, Ret	ASUS	Socket AM4	AMD B450	DIMM	DDR4	4	128	\N
132	Материнская плата MSI B550-A PRO, Socket AM4, AMD B550, ATX, Ret	MSI	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
133	Материнская плата Gigabyte B550 GAMING X V2, Socket AM4, AMD B550, ATX, Ret	GIGABYTE	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
134	Материнская плата Gigabyte A520M K V2, Socket AM4, AMD A520, mATX, Ret	GIGABYTE	Socket AM4	AMD A520	DIMM	DDR4	2	64	\N
135	Материнская плата MSI MPG B550 GAMING PLUS, Socket AM4, AMD B550, ATX, Ret	MSI	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
136	Материнская плата MSI A520M-A PRO, Socket AM4, AMD A520, mATX, Ret	MSI	Socket AM4	AMD A520	DIMM	DDR4	2	64	\N
137	Материнская плата Gigabyte B550M K, Socket AM4, AMD B550, mATX, Ret	GIGABYTE	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
138	Материнская плата Gigabyte B760M DS3H DDR4, Socket LGA 1700, Intel B760, mATX, Ret	GIGABYTE	Socket LGA 1700	Intel B760	DIMM	DDR4	4	128	\N
139	Материнская плата MSI B550M PRO-VDH WIFI, Socket AM4, AMD B550, mATX, Ret	MSI	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
140	Материнская плата Gigabyte B550M DS3H R2, Socket AM4, AMD B550, mATX, Ret	GIGABYTE	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
141	Материнская плата MSI PRO H610M-E DDR4, Socket LGA 1700, Intel H610, mATX, Ret	MSI	Socket LGA 1700	Intel H610	DIMM	DDR4	2	64	\N
142	Материнская плата MSI B550M PRO-VDH, Socket AM4, AMD B550, mATX, Ret	MSI	Socket AM4	AMD B550	DIMM	DDR4	4	128	\N
\.


--
-- Data for Name: psus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.psus (id, name, brand, wattage, certification, modular, price) FROM stdin;
1	Corsair RM650x	Corsair	650	80+ Gold	t	110
2	Be Quiet Pure Power 11	Be Quiet	600	80+ Gold	f	90
3	Seasonic Focus GX-750	Seasonic	750	80+ Gold	t	130
4	Блок питания BLOODY BD-PS750G,  750Вт,  80 PLUS GOLD,  120мм, черный, retail [bd-ps750g-m]	BLOODY	750	80 PLUS GOLD	t	\N
5	Блок питания Formula APMM-750BM,  750Вт,  80 PLUS BRONZE,  140мм, черный, retail(восстановленный)	FORMULA	750	80 PLUS BRONZE	t	\N
6	Блок питания KINGPRICE KPPSU750,  750Вт,  120мм, серый [kppsu750v3]	KINGPRICE	750	\N	\N	\N
7	Блок питания Formula APMM-1000GM Gen.5,  1000Вт,  80 PLUS GOLD,  120мм, черный, retail(Б/У)	FORMULA	1000	80 PLUS GOLD	t	\N
8	Блок питания BLOODY BD-PS1000G,  1000Вт,  80 PLUS GOLD,  140мм, черный, retail [bd-ps1000g-m]	BLOODY	1000	80 PLUS GOLD	t	\N
9	Блок питания Thermaltake Litepower,  650Вт,  120мм, черный, retail [ps-ltp-0650npcneu-2]	THERMALTAKE	650	\N	\N	\N
10	Блок питания Digma DPSU-550W-WH,  550Вт,  80 PLUS WHITE,  120мм, черный, retail	DIGMA	550	80 PLUS WHITE	\N	\N
11	Блок питания BLOODY BD-PS850G,  850Вт,  80 PLUS GOLD,  120мм, черный, retail [bd-ps850g-m]	BLOODY	850	80 PLUS GOLD	t	\N
12	Блок питания Digma DPSU-750W-WH,  750Вт,  80 PLUS WHITE,  120мм, черный, retail	DIGMA	750	80 PLUS WHITE	\N	\N
13	Блок питания MSI MAG A650BN,  650Вт,  80 PLUS BRONZE,  120мм, черный, retail [306-7zp2b11-ce0]	MSI	650	80 PLUS BRONZE	\N	\N
14	Блок питания Accord ACC-350W-12,  350Вт,  120мм, черный [acc-350-12]	ACCORD	350	\N	\N	\N
15	Блок питания BLOODY BD-PS750G,  750Вт,  80 PLUS GOLD,  120мм, белый, retail [bd-ps750g-mw]	BLOODY	750	80 PLUS GOLD	t	\N
16	Блок питания BLOODY BD-PS1250P,  1250Вт,  80 PLUS PLATINUM,  140мм, черный, retail [bd-ps1250p-m]	BLOODY	1250	80 PLUS PLATINUM	t	\N
17	Блок питания Thermaltake Smart RGB 700,  700Вт,  80 PLUS WHITE,  120мм, черный, retail [ps-spr-0700nhsawe-1]	THERMALTAKE	700	80 PLUS WHITE	\N	\N
18	Блок питания BLOODY BD-PS750G,  750Вт,  80 PLUS GOLD,  120мм, черный, retail [bd-ps750g-mr]	BLOODY	750	80 PLUS GOLD	t	\N
19	Блок питания KINGPRICE KPPSU500,  500Вт,  120мм, черный, retail [kppsu500v2]	KINGPRICE	500	\N	\N	\N
20	Блок питания DeepCool PF750,  750Вт,  80 PLUS WHITE,  120мм, черный, retail [r-pf750d-ha0b-wdeu]	DEEPCOOL	750	80 PLUS WHITE	\N	\N
21	Блок питания BLOODY BD-PS700W,  700Вт,  80 PLUS WHITE,  120мм, черный, retail	BLOODY	700	80 PLUS WHITE	\N	\N
22	Блок питания DeepCool GamerStorm PQ850G Gen.5,  850Вт,  80 PLUS GOLD,  120мм, черный, retail [r-pq850g-fd0b-wgeu-v1]	DEEPCOOL	850	80 PLUS GOLD	t	\N
23	Блок питания DeepCool GamerStorm PN850M V2 Gen.5,  850Вт,  80 PLUS GOLD,  120мм, черный, retail [r-pn850m-fc0b-wgeu]	DEEPCOOL	850	80 PLUS GOLD	\N	\N
24	Блок питания BLOODY BD-PS600W,  600Вт,  80 PLUS WHITE,  120мм, черный, retail	BLOODY	600	80 PLUS WHITE	\N	\N
25	Блок питания BLOODY BD-PS500W,  500Вт,  80 PLUS WHITE,  120мм, черный, retail	BLOODY	500	80 PLUS WHITE	\N	\N
26	Блок питания DeepCool GamerStorm PQ750G Gen.5,  750Вт,  80 PLUS GOLD,  120мм, черный, retail [r-pq750g-fd0b-wgeu-v1]	DEEPCOOL	750	80 PLUS GOLD	t	\N
27	Блок питания Accord ACC-400W-12,  400Вт,  120мм, черный [acc-400-12]	ACCORD	400	\N	\N	\N
28	Блок питания DeepCool PF700,  700Вт,  80 PLUS WHITE,  120мм, черный, retail [r-pf700d-ha0b-wdeu]	DEEPCOOL	700	80 PLUS WHITE	\N	\N
29	Блок питания Digma DPSU-450W,  450Вт,  120мм, черный, retail	DIGMA	450	\N	\N	\N
30	Блок питания DeepCool PF600,  600Вт,  80 PLUS WHITE,  120мм, черный, retail [r-pf600d-ha0b-wdeu]	DEEPCOOL	600	80 PLUS WHITE	\N	\N
31	Блок питания DeepCool PF650,  650Вт,  80 PLUS WHITE,  120мм, черный, retail [r-pf650d-ha0b-wdeu]	DEEPCOOL	650	80 PLUS WHITE	\N	\N
32	Блок питания Accord ACC-450W-12,  450Вт,  120мм, черный [acc-450-12]	ACCORD	450	\N	\N	\N
33	Блок питания DeepCool PF500,  500Вт,  80 PLUS WHITE,  120мм, черный, retail [r-pf500d-ha0b-wdeu]	DEEPCOOL	500	80 PLUS WHITE	\N	\N
34	Блок питания Digma DPSU-500W,  500Вт,  120мм, черный, retail	DIGMA	500	\N	\N	\N
35	Блок питания Thermaltake Toughpower GF A3 Gen.5,  750Вт,  80 PLUS GOLD,  120мм, черный, retail [ps-tpd-0750fnfage-h]	THERMALTAKE	750	80 PLUS GOLD	t	\N
36	Блок питания MSI MEG Ai1300P,  1300Вт,  80 PLUS PLATINUM,  120мм, черный, retail [306-7zp4a11-ce0]	MSI	1300	80 PLUS PLATINUM	t	\N
37	Блок питания Thermaltake Toughpower GF A3 Gen.5,  1050Вт,  80 PLUS GOLD,  120мм, черный, retail [ps-tpd-1050fnfage-h]	THERMALTAKE	1050	80 PLUS GOLD	t	\N
38	Блок питания Thermaltake Toughpower GF A3 Gen.5,  650Вт,  80 PLUS GOLD,  120мм, черный, retail [ps-tpd-0650fnfage-h]	THERMALTAKE	650	80 PLUS GOLD	t	\N
39	Блок питания BLOODY BD-PS700W,  700Вт,  80 PLUS WHITE,  120мм, черный, retail [bd-ps700w-r]	BLOODY	700	80 PLUS WHITE	\N	\N
40	Блок питания DeepCool GamerStorm PQ750G Gen.5,  750Вт,  80 PLUS GOLD,  120мм, черный, retail [r-pq750g-fd0b-wgeu-v1]	DEEPCOOL	750	80 PLUS GOLD	t	\N
41	Блок питания DeepCool PF750,  750Вт,  80 PLUS WHITE,  120мм, черный, retail [r-pf750d-ha0b-wdeu]	DEEPCOOL	750	80 PLUS WHITE	\N	\N
42	Блок питания DeepCool GamerStorm PN850M V2 Gen.5,  850Вт,  80 PLUS GOLD,  120мм, черный, retail [r-pn850m-fc0b-wgeu]	DEEPCOOL	850	80 PLUS GOLD	\N	\N
43	Блок питания BLOODY BD-PS750G,  750Вт,  80 PLUS GOLD,  120мм, черный, retail [bd-ps750g-m]	BLOODY	750	80 PLUS GOLD	t	\N
44	Блок питания Accord ACC-400W-12,  400Вт,  120мм, черный [acc-400-12]	ACCORD	400	\N	\N	\N
45	Блок питания DeepCool PF600,  600Вт,  80 PLUS WHITE,  120мм, черный, retail [r-pf600d-ha0b-wdeu]	DEEPCOOL	600	80 PLUS WHITE	\N	\N
46	Блок питания BLOODY BD-PS1000G,  1000Вт,  80 PLUS GOLD,  140мм, черный, retail [bd-ps1000g-m]	BLOODY	1000	80 PLUS GOLD	t	\N
47	Блок питания DeepCool GamerStorm PQ850G Gen.5,  850Вт,  80 PLUS GOLD,  120мм, черный, retail [r-pq850g-fd0b-wgeu-v1]	DEEPCOOL	850	80 PLUS GOLD	t	\N
48	Блок питания DeepCool PL750D,  750Вт,  80 PLUS BRONZE,  120мм, черный, retail [r-pl750d-fc0b-wdeu-v2]	DEEPCOOL	750	80 PLUS BRONZE	\N	\N
49	Блок питания DeepCool PF500,  500Вт,  80 PLUS WHITE,  120мм, черный, retail [r-pf500d-ha0b-wdeu]	DEEPCOOL	500	80 PLUS WHITE	\N	\N
\.


--
-- Data for Name: rams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rams (id, name, brand, capacity, speed, price, ram_type) FROM stdin;
1	Corsair Vengeance LPX	Corsair	16	3200	50	\N
2	G.Skill Ripjaws V	G.Skill	32	3600	90	\N
3	Kingston Fury Beast	Kingston	16	5200	80	\N
4	Corsair Dominator Platinum	Corsair	32	6000	160	\N
\.


--
-- Data for Name: storages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.storages (id, name, brand, capacity, interface, price) FROM stdin;
1	Samsung 970 EVO Plus	Samsung	500	NVMe	60
2	Samsung 980 PRO	Samsung	1000	NVMe	120
3	WD Blue HDD	Western Digital	2000	SATA	50
4	Crucial MX500	Crucial	1000	SATA	70
50	SSD накопитель Samsung 990 Pro MZ-V9P2T0BW 2ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	SAMSUNG	2	PCIe 4.0 x4	\N
51	SSD накопитель Kingston A400 SA400S37/240G 240ГБ, 2.5", SATA III,  SATA	KINGSTON	240	SATA III	\N
52	SSD накопитель Samsung 990 Pro MZ-V9P1T0BW 1ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	SAMSUNG	1024	PCIe 4.0 x4	\N
53	SSD накопитель Kingston NV3 SNV3S/2000G 2ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	KINGSTON	2	PCIe 4.0 x4	\N
54	SSD накопитель Kingston A400 SA400S37/960G 960ГБ, 2.5", SATA III,  SATA	KINGSTON	960	SATA III	\N
55	SSD накопитель Samsung 870 EVO MZ-77E500BW 500ГБ, 2.5", SATA III,  SATA	SAMSUNG	500	SATA III	\N
56	SSD накопитель KINGSPEC P3-256 256ГБ, 2.5", SATA III,  SATA	KINGSPEC	256	SATA III	\N
92	Жесткий диск Seagate Ironwolf ST8000VN004,  8ТБ,  HDD,  SATA III,  3.5"	\N	8	SATA III	\N
93	Жесткий диск WD Purple WD33PURZ,  3ТБ,  HDD,  SATA III,  3.5"	\N	3	SATA III	\N
94	Жесткий диск WD Black WD5000LPSX,  500ГБ,  HDD,  SATA III,  2.5"	\N	500	SATA III	\N
95	Жесткий диск WD Blue WD20SPZX,  2ТБ,  HDD,  SATA III,  2.5"	\N	2	SATA III	\N
96	Жесткий диск WD Purple WD23PURZ,  2ТБ,  HDD,  SATA III,  3.5"	\N	2	SATA III	\N
97	Жесткий диск WD Purple WD43PURZ,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	\N
98	Жесткий диск WD Purple WD10PURZ,  1ТБ,  HDD,  SATA III,  3.5"	\N	1024	SATA III	\N
99	Жесткий диск WD Purple WD85PURZ,  8ТБ,  HDD,  SATA III,  3.5"	\N	8	SATA III	\N
100	Жесткий диск WD Red Plus WD40EFPX,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	\N
101	Жесткий диск WD Blue WD40EZAX,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	\N
102	Жесткий диск WD Purple WD64PURZ,  6ТБ,  HDD,  SATA III,  3.5"	\N	6	SATA III	\N
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

SELECT pg_catalog.setval('public.cpus_id_seq', 309, true);


--
-- Name: gpus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gpus_id_seq', 188, true);


--
-- Name: motherboards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motherboards_id_seq', 142, true);


--
-- Name: psus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.psus_id_seq', 49, true);


--
-- Name: rams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rams_id_seq', 136, true);


--
-- Name: storages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.storages_id_seq', 102, true);


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

