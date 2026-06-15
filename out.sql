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
    price numeric,
    img_url text
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
    brand text,
    tdp_support integer,
    socket_support text[],
    price numeric,
    img_url text
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
    ram_type text,
    img_url text
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
    interface text,
    img_url text
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
    price numeric,
    img_url text
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
    price numeric,
    img_url text
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
    ram_type text,
    img_url text
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
    price numeric,
    img_url text
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

COPY public.cases (id, name, brand, form_factor, gpu_length_limit, cooler_height_limit, price, img_url) FROM stdin;
4	Корпус ATX Formula Crystal Z1, Midi-Tower, без БП,  черный [crystal z1 black]	FORMULA	Midi-Tower	300	165	2550	\N
5	Корпус ATX Zalman S2, Midi-Tower, без БП,  черный [s2 black]	ZALMAN	Midi-Tower	330	156	3550	\N
6	Корпус mATX BLOODY BD-CC103, Mini-Tower, без БП,  белый [bd-cc103-wh]	BLOODY	Mini-Tower	330	165	2990	\N
7	Корпус mATX Thermaltake Versa H18 Window, Micro-Tower, без БП,  черный [ca-1j4-00s1wn-00]	THERMALTAKE	Micro-Tower	350	155	4190	\N
8	Корпус miniITX Thermaltake Core V1, SFF, без БП,  черный [ca-1b8-00s]	THERMALTAKE	SFF	255	140	6190	\N
9	Корпус mATX BLOODY BD-CC103, Mini-Tower, без БП,  черный [bd-cc103-bk]	BLOODY	Mini-Tower	330	165	2990	\N
10	Корпус mATX BLOODY CC-125, Mini-Tower, без БП,  черный [cc-125-bk]	BLOODY	Mini-Tower	280	165	2490	\N
11	Корпус mATX DeepCool MATREXX 30, Mini-Tower, без БП,  черный [dp-matx-matrexx30]	DEEPCOOL	Mini-Tower	250	151	1968	\N
12	Корпус mATX KINGPRICE KPCC-MN210, Mini-Tower, без БП,  черный	KINGPRICE	Mini-Tower	260	135	1190	\N
13	Корпус ATX Zalman N5 MF, Midi-Tower, без БП,  черный [n5 mf black]	ZALMAN	Midi-Tower	365	158	4280	\N
14	Корпус ATX Aerocool Aero One Eclipse-G-BK-v1, Midi-Tower, без БП,  черный [accm-pb17143.11]	AEROCOOL	Midi-Tower	327	161	9400	\N
\.


--
-- Data for Name: coolers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coolers (id, name, brand, tdp_support, socket_support, price, img_url) FROM stdin;
13	Устройство охлаждения (кулер) ID-COOLING SE-214-XT Basic,  4-pin,  120мм,  черный,  retail	ID-COOLING	\N	{AM4,AM5,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	1050	\N
14	Устройство охлаждения (кулер) ID-COOLING SE-224-XTS,  4-pin,  120мм,  черный,  retail	ID-COOLING	\N	{AM4,AM5,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	1570	\N
15	Устройство охлаждения (кулер) ID-COOLING SE-214-XT,  4-pin,  RGB,  120мм,  черный,  retail	ID-COOLING	\N	{AM4,AM5,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	1190	\N
16	Система водяного охлаждения DeepCool LE360 V2,  4-pin,  ARGB,  120мм,  черный,  retail [r-le360-bkammc-g-2]	DEEPCOOL	\N	{AM4,AM5,FM1,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	5040	\N
17	Устройство охлаждения (кулер) DeepCool Gammaxx 400 Blue Basic,  4-pin,  одноцветная,  120мм,  черный,  retail [dp-mch4-gmx400p-bl]	DEEPCOOL	\N	{AM4,AM5,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	1350	\N
18	Устройство охлаждения (кулер) DeepCool AG400,  4-pin,  120мм,  черный,  retail [r-ag400-bknnmn-g-1]	DEEPCOOL	\N	{AM4,AM5,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	1160	\N
19	Устройство охлаждения (кулер) DeepCool AG300,  4-pin,  92мм,  черный,  retail [r-ag300-bknnmn-g]	DEEPCOOL	\N	{AM4,AM5,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	780	\N
20	Устройство охлаждения (кулер) ID-COOLING SE-224-XTS,  4-pin,  ARGB,  120мм,  черный,  retail [se-224-xts argb]	ID-COOLING	\N	{AM4,AM5,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	1720	\N
21	Устройство охлаждения (кулер) DeepCool Gamma Archer Pro V2,  4-pin,  120мм,  черный,  retail [g-u-archer-arnnnn-g-2]	DEEPCOOL	\N	{AM4,AM5,"LGA 1150","LGA 1151","LGA 1155","LGA 1156","LGA 1200","LGA 1700","LGA 1851"}	730	\N
56	Вентилятор ID-COOLING AS-140-K 140мм, 4-pin, 1800об/мин, 14 - 30 дБ, черный, Ret	\N	\N	\N	550	\N
57	Вентилятор Zalman ZM-F3 (SF) 120мм, 3-pin, 1200об/мин, 20 - 23 дБ, черный, Ret	\N	\N	\N	400	\N
58	Вентилятор ID-COOLING FL-12025K 120мм, 3-pin, 1250об/мин, 21 дБ, черный, Ret	\N	\N	\N	250	\N
59	Вентилятор DeepCool FL12R SE Reverse, 120мм, 4-pin, 1500об/мин, 25.79 дБ, ARGB, черный, Ret [r-fl12rse-bkapn1-g]	\N	\N	\N	790	\N
35	Термопаста ARCTIC COOLING MX-4 шприц,  4грамм [actcp00002b]	ARCTIC COOLING	\N	\N	800	\N
36	Термопаста ARCTIC COOLING MX-4 шприц,  8грамм [actcp00008b]	ARCTIC COOLING	\N	\N	960	\N
37	Термопаста Zalman ZM-STC8 шприц,  1.5грамм	ZALMAN	\N	\N	500	\N
38	Термопаста ARCTIC COOLING MX-6 шприц,  8грамм [actcp00081a]	ARCTIC COOLING	\N	\N	1050	\N
39	Термопаста ARCTIC COOLING MX-4 шприц,  20грамм [actcp00001b]	ARCTIC COOLING	\N	\N	1990	\N
40	Термопаста Thermalright TF7-2G шприц,  2грамм	THERMALRIGHT	\N	\N	550	\N
41	Термопаста ARCTIC COOLING MX-4 шприц,  4грамм [actcp00031b]	ARCTIC COOLING	\N	\N	500	\N
42	Термопаста ID-COOLING FROST X05 3g шприц,  3грамм	ID-COOLING	\N	\N	400	\N
43	Термопаста EXEGATE ETG-9WMK Gold шприц,  20грамм [ex282345rus]	EXEGATE	\N	\N	1280	\N
44	Термопаста ID-COOLING FROST X25 2g шприц,  2грамм	ID-COOLING	\N	\N	500	\N
45	Крепления Aerocool ACTC-XX1XX30.00	AEROCOOL	\N	\N	170	\N
46	Решетка ARCTIC COOLING ACFAN00085A	ARCTIC COOLING	\N	\N	450	\N
60	Вентилятор Formula Air Fusion 1 120мм, 4-pin, 1800об/мин, 29.93 дБ, ARGB, черный, Ret [air fusion 1 bk]	\N	\N	\N	590	\N
61	Вентилятор Formula Air Fusion 3 Reverse, 3шт, 120мм, 4-pin, 1800об/мин, 36.97 дБ, ARGB, черный, Ret [air fusion 3 bk reverse]	\N	\N	\N	1710	\N
62	Вентилятор DeepCool XFan 80 80мм, от БП:4-pin (Molex), 1800об/мин, 20 дБ, черный, Ret [dp-fdc-xf80]	\N	\N	\N	120	\N
63	Вентилятор Formula Cosmic 12BK 120мм, 3-pin, от БП:4-pin (Molex), 1100об/мин, 22.3 дБ, RGB, черный, Ret [cosmic 12bk fr]	\N	\N	\N	200	\N
64	Вентилятор BLOODY CF-12 LCD 120мм, 4-pin, 1800об/мин, 11 - 32 дБ, ARGB, черный, Ret [cf-12-argb120-bk]	\N	\N	\N	490	\N
65	Вентилятор Formula Nulight 12WH 120мм, 4-pin, 1500об/мин, 25.34 дБ, ARGB, белый, Ret [nulight 12wh arpw]	\N	\N	\N	350	\N
66	Радиатор Digma DGRDRM2A для 2280, металлический, Ret	\N	\N	\N	290	\N
67	Радиатор Digma DGRDRM2B для 2280, металлический, Ret	\N	\N	\N	490	\N
68	Радиатор ID-COOLING Zero M25 для 2280, с вентилятором 20мм, алюминиевый, Ret	\N	\N	\N	950	\N
\.


--
-- Data for Name: cpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cpus (id, name, brand, cores, threads, base_clock, boost_clock, tdp, socket, price, ram_type, img_url) FROM stdin;
381	Процессор AMD Ryzen 7 5700X, AM4,  OEM [100-000000926]	AMD	8	16	3	\N	65	AM4	13990	DDR4	\N
382	Процессор Intel Core i5 12400F, LGA 1700,  OEM [cm8071504650609 srl5z]	INTEL	6	12	2	\N	65	LGA 1700	11990	DDR5/ DDR4	\N
383	Процессор AMD Ryzen 5 5600, AM4,  OEM [100-000000927]	AMD	6	12	3	\N	65	AM4	10990	DDR4	\N
384	Процессор AMD Ryzen 5 5600X, AM4,  OEM [100-000000065]	AMD	6	12	3	\N	65	AM4	11790	DDR4	\N
385	Процессор AMD Ryzen 7 9800x3d, AM5,  OEM [100-000001084]	AMD	8	16	4	\N	120	AM5	39990	DDR5	\N
386	Процессор AMD Ryzen 7 7800X3D, AM5,  OEM [100-000000910]	AMD	8	16	4	\N	120	AM5	27990	DDR5	\N
\.


--
-- Data for Name: gpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gpus (id, name, brand, vram, tdp, price, interface, img_url) FROM stdin;
\.


--
-- Data for Name: motherboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motherboards (id, name, brand, socket, chipset, form_factor, ram_type, ram_slots, max_ram, price, img_url) FROM stdin;
\.


--
-- Data for Name: psus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.psus (id, name, brand, wattage, certification, modular, price, img_url) FROM stdin;
\.


--
-- Data for Name: rams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rams (id, name, brand, capacity, speed, price, ram_type, img_url) FROM stdin;
\.


--
-- Data for Name: storages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.storages (id, name, brand, capacity, interface, price, img_url) FROM stdin;
106	SSD накопитель KINGSPEC P3-256 256ГБ, 2.5", SATA III,  SATA	KINGSPEC	256	SATA III	3890	\N
108	SSD накопитель Digma Run S9 DGSR2512GS93T 512ГБ, 2.5", SATA III,  SATA,  rtl	DIGMA	512	SATA III	7990	\N
111	SSD накопитель Digma Run S9 DGSR2256GS93T 256ГБ, 2.5", SATA III,  SATA,  rtl	DIGMA	256	SATA III	5990	\N
112	SSD накопитель Digma Run S9 DGSR2001TS93T 1ТБ, 2.5", SATA III,  SATA,  rtl	DIGMA	1024	SATA III	13990	\N
113	SSD накопитель Digma Run Y2 DGSR2128GY23T 128ГБ, 2.5", SATA III,  SATA,  rtl	DIGMA	128	SATA III	2490	\N
114	SSD накопитель KINGSPEC P3-512 512ГБ, 2.5", SATA III,  SATA	KINGSPEC	512	SATA III	6990	\N
116	SSD накопитель Samsung 980 MZ-V8V500BW 500ГБ, M.2 2280, PCIe 3.0 x4,  NVMe,  M.2	SAMSUNG	500	PCIe 3.0 x4	21990	\N
117	SSD накопитель NETAC N600S NT01N600S-256G-S3X 256ГБ, 2.5", SATA III,  SATA	NETAC	256	SATA III	4990	\N
119	SSD накопитель Samsung 980 MZ-V8V1T0BW 1ТБ, M.2 2280, PCIe 3.0 x4,  NVMe,  M.2	SAMSUNG	1024	PCIe 3.0 x4	24990	\N
120	SSD накопитель A-Data Legend 960 Max ALEG-960M-1TCS 1ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	A-DATA	1024	PCIe 4.0 x4	17260	\N
121	SSD накопитель KINGSPEC P3-1TB 1ТБ, 2.5", SATA III,  SATA	KINGSPEC	1024	SATA III	11990	\N
122	SSD накопитель A-Data XPG SX8200 Pro ASX8200PNP-512GT-C 512ГБ, M.2 2280, PCIe 3.0 x4,  NVMe,  M.2	A-DATA	512	PCIe 3.0 x4	9290	\N
123	SSD накопитель Crucial BX500 CT240BX500SSD1 240ГБ, 2.5", SATA III,  SATA	CRUCIAL	240	SATA III	5990	\N
124	SSD накопитель NETAC N600S NT01N600S-512G-S3X 512ГБ, 2.5", SATA III,  SATA	NETAC	512	SATA III	7590	\N
126	SSD накопитель Samsung 870 EVO MZ-77E250BW 250ГБ, 2.5", SATA III,  SATA	SAMSUNG	250	SATA III	15990	\N
127	SSD накопитель Patriot P220 P220S512G25 512ГБ, 2.5", SATA III,  SATA	PATRIOT	512	SATA III	7990	\N
128	SSD накопитель A-Data Ultimate SU650 ASU650SS-512GT-R 512ГБ, 2.5", SATA III,  SATA	A-DATA	512	SATA III	6990	\N
129	SSD накопитель Patriot Burst Elite PBE240GS25SSDR 240ГБ, 2.5", SATA III,  SATA	PATRIOT	240	SATA III	4590	\N
130	SSD накопитель A-Data Ultimate SU650 ASU650SS-256GT-R 256ГБ, 2.5", SATA III,  SATA	A-DATA	256	SATA III	4790	\N
131	SSD накопитель Kingston KC3000 SKC3000S/512G 512ГБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	KINGSTON	512	PCIe 4.0 x4	17990	\N
132	SSD накопитель A-Data Ultimate SU650 ASU650SS-240GT-R 240ГБ, 2.5", SATA III,  SATA	A-DATA	240	SATA III	5040	\N
133	SSD накопитель A-Data Legend 960 Max ALEG-960M-2TCS 2ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	A-DATA	2	PCIe 4.0 x4	26990	\N
134	SSD накопитель Patriot P210 P210S512G25 512ГБ, 2.5", SATA III,  SATA	PATRIOT	512	SATA III	7990	\N
135	SSD накопитель Digma Mega M2 DGSM3512GM23T 512ГБ, M.2 2280, PCIe 3.0 x4,  NVMe,  M.2,  rtl	DIGMA	512	PCIe 3.0 x4	8990	\N
136	SSD накопитель NETAC N535S NT01N535S-240G-S3X 240ГБ, 2.5", SATA III,  SATA	NETAC	240	SATA III	3990	\N
137	SSD накопитель Kingston KC600 SKC600/256G 256ГБ, 2.5", SATA III,  SATA	KINGSTON	256	SATA III	9990	\N
104	SSD накопитель Kingston NV3 SNV3S/1000G 1ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	KINGSTON	1024	PCIe 4.0 x4	12990	\N
125	SSD накопитель Kingston NV3 SNV3S/500G 500ГБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	KINGSTON	500	PCIe 4.0 x4	8990	\N
103	SSD накопитель Kingston A400 SA400S37/480G 480ГБ, 2.5", SATA III,  SATA	KINGSTON	480	SATA III	9990	\N
105	SSD накопитель Kingston A400 SA400S37/240G 240ГБ, 2.5", SATA III,  SATA	KINGSTON	240	SATA III	6990	\N
115	SSD накопитель Samsung 990 Pro MZ-V9P1T0BW 1ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	SAMSUNG	1024	PCIe 4.0 x4	23990	\N
109	SSD накопитель Samsung 990 Pro MZ-V9P2T0BW 2ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	SAMSUNG	2	PCIe 4.0 x4	31990	\N
107	SSD накопитель Samsung 870 EVO MZ-77E500BW 500ГБ, 2.5", SATA III,  SATA	SAMSUNG	500	SATA III	23990	\N
110	SSD накопитель Kingston A400 SA400S37/960G 960ГБ, 2.5", SATA III,  SATA	KINGSTON	960	SATA III	11990	\N
118	SSD накопитель Kingston KC3000 SKC3000S/1024G 1ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	KINGSTON	1024	PCIe 4.0 x4	19990	\N
138	SSD накопитель A-Data Legend 900 SLEG-900-1TCS 1ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	A-DATA	1024	PCIe 4.0 x4	15990	\N
145	SSD накопитель Kingston NV3 SNV3S/2000G 2ТБ, M.2 2280, PCIe 4.0 x4,  NVMe,  M.2	KINGSTON	2	PCIe 4.0 x4	20990	\N
153	Жесткий диск Seagate Barracuda ST2000DM008,  2ТБ,  HDD,  SATA III,  3.5"	\N	2	SATA III	15990	\N
154	Жесткий диск Seagate Skyhawk ST4000VX016,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	18990	\N
157	Жесткий диск WD Purple WD11PURZ,  1ТБ,  HDD,  SATA III,  3.5"	\N	1024	SATA III	11990	\N
158	Жесткий диск WD Blue WD20EZBX,  2ТБ,  HDD,  SATA III,  3.5"	\N	2	SATA III	15990	\N
160	Жесткий диск WD Blue WD20EARZ,  2ТБ,  HDD,  SATA III,  3.5"	\N	2	SATA III	13990	\N
161	Жесткий диск WD Purple WD64PURZ,  6ТБ,  HDD,  SATA III,  3.5"	\N	6	SATA III	25990	\N
162	Жесткий диск WD Blue WD60EZAX,  6ТБ,  HDD,  SATA III,  3.5"	\N	6	SATA III	25990	\N
164	Жесткий диск Seagate Skyhawk ST4000VX015,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	18990	\N
165	Жесткий диск Seagate Ironwolf ST4000VN006,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	21990	\N
166	Жесткий диск Seagate Skyhawk ST2000VX017,  2ТБ,  HDD,  SATA III,  3.5"	\N	2	SATA III	13990	\N
167	Жесткий диск WD Red Plus WD60EFPX,  6ТБ,  HDD,  SATA III,  3.5"	\N	6	SATA III	31990	\N
168	Жесткий диск WD Blue WD80EAAZ,  8ТБ,  HDD,  SATA III,  3.5"	\N	8	SATA III	26990	\N
170	Жесткий диск Seagate Barracuda ST4000DM004,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	16990	\N
171	Жесткий диск Seagate Skyhawk ST1000VX013,  1ТБ,  HDD,  SATA III,  3.5"	\N	1024	SATA III	10990	\N
172	Жесткий диск Seagate Barracuda ST1000DM014,  1ТБ,  HDD,  SATA III,  3.5"	\N	1024	SATA III	13990	\N
174	Жесткий диск Toshiba MQ04 MQ04ABF100,  1ТБ,  HDD,  SATA III,  2.5"	\N	1024	SATA III	15990	\N
175	Жесткий диск Seagate Barracuda ST2000DM005,  2ТБ,  HDD,  SATA III,  3.5"	\N	2	SATA III	12990	\N
176	Жесткий диск Seagate Barracuda ST8000DM004,  8ТБ,  HDD,  SATA III,  3.5"	\N	8	SATA III	30990	\N
177	Жесткий диск WD Blue WD10SPZX,  1ТБ,  HDD,  SATA III,  2.5"	\N	1024	SATA III	15990	\N
178	Жесткий диск Toshiba P300 HDWD320UZSVA,  2ТБ,  HDD,  SATA III,  3.5"	\N	2	SATA III	14990	\N
179	Жесткий диск Seagate Ironwolf ST8000VN004,  8ТБ,  HDD,  SATA III,  3.5"	\N	8	SATA III	39990	\N
180	Жесткий диск Seagate Exos X18 ST18000NM000J,  18ТБ,  HDD,  SATA III,  3.5"	\N	18	SATA III	89990	\N
181	Жесткий диск Seagate Skyhawk ST8000VX010,  8ТБ,  HDD,  SATA III,  3.5"	\N	8	SATA III	35990	\N
182	Жесткий диск WD Ultrastar DC HC550 WUH721818ALE6L4,  18ТБ,  HDD,  SATA III,  3.5" [0f38459]	\N	18	SATA III	78990	\N
183	Жесткий диск Seagate Barracuda ST6000DM003,  6ТБ,  HDD,  SATA III,  3.5"	\N	6	SATA III	24990	\N
184	Жесткий диск Seagate Barracuda ST2000LM015,  2ТБ,  HDD,  SATA III,  2.5"	\N	2	SATA III	17990	\N
156	Жесткий диск WD Purple WD33PURZ,  3ТБ,  HDD,  SATA III,  3.5"	\N	3	SATA III	15990	\N
155	Жесткий диск WD Blue WD20SPZX,  2ТБ,  HDD,  SATA III,  2.5"	\N	2	SATA III	17990	\N
173	Жесткий диск WD Black WD5000LPSX,  500ГБ,  HDD,  SATA III,  2.5"	\N	500	SATA III	12990	\N
149	Жесткий диск WD Purple WD43PURZ,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	19990	\N
151	Жесткий диск WD Purple WD23PURZ,  2ТБ,  HDD,  SATA III,  3.5"	\N	2	SATA III	13990	\N
150	Жесткий диск WD Blue WD40EZAX,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	15990	\N
159	Жесткий диск WD Purple WD10PURZ,  1ТБ,  HDD,  SATA III,  3.5"	\N	1024	SATA III	10990	\N
152	Жесткий диск WD Red Plus WD40EFPX,  4ТБ,  HDD,  SATA III,  3.5"	\N	4	SATA III	21990	\N
163	Жесткий диск WD Purple WD85PURZ,  8ТБ,  HDD,  SATA III,  3.5"	\N	8	SATA III	34990	\N
169	Жесткий диск WD Red Plus WD80EFPX,  8ТБ,  HDD,  SATA III,  3.5"	\N	8	SATA III	34990	\N
\.


--
-- Name: cases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cases_id_seq', 14, true);


--
-- Name: coolers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coolers_id_seq', 80, true);


--
-- Name: cpus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cpus_id_seq', 386, true);


--
-- Name: gpus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gpus_id_seq', 234, true);


--
-- Name: motherboards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.motherboards_id_seq', 188, true);


--
-- Name: psus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.psus_id_seq', 95, true);


--
-- Name: rams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rams_id_seq', 182, true);


--
-- Name: storages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.storages_id_seq', 194, true);


--
-- Name: cases cases_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_name_key UNIQUE (name);


--
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: coolers coolers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coolers
    ADD CONSTRAINT coolers_name_key UNIQUE (name);


--
-- Name: coolers coolers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coolers
    ADD CONSTRAINT coolers_pkey PRIMARY KEY (id);


--
-- Name: cpus cpus_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_name_key UNIQUE (name);


--
-- Name: cpus cpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_pkey PRIMARY KEY (id);


--
-- Name: gpus gpus_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gpus
    ADD CONSTRAINT gpus_name_key UNIQUE (name);


--
-- Name: gpus gpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gpus
    ADD CONSTRAINT gpus_pkey PRIMARY KEY (id);


--
-- Name: motherboards motherboards_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_name_key UNIQUE (name);


--
-- Name: motherboards motherboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_pkey PRIMARY KEY (id);


--
-- Name: psus psus_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.psus
    ADD CONSTRAINT psus_name_key UNIQUE (name);


--
-- Name: psus psus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.psus
    ADD CONSTRAINT psus_pkey PRIMARY KEY (id);


--
-- Name: rams rams_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rams
    ADD CONSTRAINT rams_name_key UNIQUE (name);


--
-- Name: rams rams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rams
    ADD CONSTRAINT rams_pkey PRIMARY KEY (id);


--
-- Name: storages storages_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storages
    ADD CONSTRAINT storages_name_key UNIQUE (name);


--
-- Name: storages storages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storages
    ADD CONSTRAINT storages_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

