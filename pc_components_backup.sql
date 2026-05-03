--
-- PostgreSQL database dump
--

\restrict BFHqQaH6sowzEB5IN8zDTsRqHWEgxsZMRZ7b4HCbhq6547vEhIAZlSie0YRHUtH

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

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
-- Name: build_components; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.build_components (
    build_id integer NOT NULL,
    component_id integer NOT NULL,
    quantity integer DEFAULT 1
);


ALTER TABLE public.build_components OWNER TO postgres;

--
-- Name: builds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.builds (
    id integer NOT NULL,
    name character varying(200),
    description text,
    total_price numeric(12,2),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.builds OWNER TO postgres;

--
-- Name: builds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.builds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.builds_id_seq OWNER TO postgres;

--
-- Name: builds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.builds_id_seq OWNED BY public.builds.id;


--
-- Name: compatibility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compatibility (
    component1_id integer NOT NULL,
    component2_id integer NOT NULL,
    compatible boolean DEFAULT true,
    notes text
);


ALTER TABLE public.compatibility OWNER TO postgres;

--
-- Name: components; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.components (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    type character varying(50) NOT NULL,
    brand character varying(100),
    model character varying(200),
    price numeric(12,2),
    specifications jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.components OWNER TO postgres;

--
-- Name: components_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.components_id_seq OWNER TO postgres;

--
-- Name: components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.components_id_seq OWNED BY public.components.id;


--
-- Name: builds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.builds ALTER COLUMN id SET DEFAULT nextval('public.builds_id_seq'::regclass);


--
-- Name: components id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components ALTER COLUMN id SET DEFAULT nextval('public.components_id_seq'::regclass);


--
-- Data for Name: build_components; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.build_components (build_id, component_id, quantity) FROM stdin;
1	1	1
1	6	1
1	11	1
1	15	1
1	19	1
1	23	1
\.


--
-- Data for Name: builds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.builds (id, name, description, total_price, created_at) FROM stdin;
1	Gaming PC Ultimate	Топовая игровая сборка для 4K гейминга	317994.00	2026-05-03 15:40:52.483245
\.


--
-- Data for Name: compatibility; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compatibility (component1_id, component2_id, compatible, notes) FROM stdin;
\.


--
-- Data for Name: components; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.components (id, name, type, brand, model, price, specifications, created_at) FROM stdin;
1	Intel Core i9-13900K	CPU	Intel	13900K	58999.00	{"tdp": "125W", "cores": 24, "socket": "LGA1700", "threads": 32, "frequency": "3.0-5.8GHz"}	2026-05-03 15:40:26.890149
2	Intel Core i7-13700K	CPU	Intel	13700K	38999.00	{"tdp": "125W", "cores": 16, "socket": "LGA1700", "threads": 24, "frequency": "3.4-5.4GHz"}	2026-05-03 15:40:26.890149
3	AMD Ryzen 9 7950X	CPU	AMD	7950X	54999.00	{"tdp": "170W", "cores": 16, "socket": "AM5", "threads": 32, "frequency": "4.5-5.7GHz"}	2026-05-03 15:40:26.890149
4	AMD Ryzen 7 7800X3D	CPU	AMD	7800X3D	39999.00	{"tdp": "120W", "cores": 8, "socket": "AM5", "threads": 16, "frequency": "4.2-5.0GHz"}	2026-05-03 15:40:26.890149
5	Intel Core i5-13600K	CPU	Intel	13600K	25999.00	{"tdp": "125W", "cores": 14, "socket": "LGA1700", "threads": 20, "frequency": "3.5-5.1GHz"}	2026-05-03 15:40:26.890149
6	NVIDIA GeForce RTX 4090	GPU	NVIDIA	RTX 4090	169999.00	{"vram": "24GB", "power": "450W", "interface": "PCIe 4.0", "vram_type": "GDDR6X"}	2026-05-03 15:40:31.916423
7	NVIDIA GeForce RTX 4080	GPU	NVIDIA	RTX 4080	114999.00	{"vram": "16GB", "power": "320W", "interface": "PCIe 4.0", "vram_type": "GDDR6X"}	2026-05-03 15:40:31.916423
8	AMD Radeon RX 7900 XTX	GPU	AMD	7900 XTX	94999.00	{"vram": "24GB", "power": "355W", "interface": "PCIe 4.0", "vram_type": "GDDR6"}	2026-05-03 15:40:31.916423
9	NVIDIA GeForce RTX 4070	GPU	NVIDIA	RTX 4070	59999.00	{"vram": "12GB", "power": "200W", "interface": "PCIe 4.0", "vram_type": "GDDR6X"}	2026-05-03 15:40:31.916423
10	AMD Radeon RX 7800 XT	GPU	AMD	7800 XT	54999.00	{"vram": "16GB", "power": "263W", "interface": "PCIe 4.0", "vram_type": "GDDR6"}	2026-05-03 15:40:31.916423
11	Corsair Vengeance 32GB DDR5	RAM	Corsair	CMK32GX5M2B6000C30	11999.00	{"kit": "2x16GB", "type": "DDR5", "speed": "6000MHz", "timing": "CL30", "capacity": "32GB"}	2026-05-03 15:40:35.243399
12	Kingston Fury 32GB DDR5	RAM	Kingston	KF560C36BBEK2-32	11499.00	{"kit": "2x16GB", "type": "DDR5", "speed": "6000MHz", "timing": "CL36", "capacity": "32GB"}	2026-05-03 15:40:35.243399
13	G.Skill Trident Z5 64GB DDR5	RAM	G.Skill	F5-6000J3040G32GX2-TZ5N	21999.00	{"kit": "2x32GB", "type": "DDR5", "speed": "6000MHz", "timing": "CL30", "capacity": "64GB"}	2026-05-03 15:40:35.243399
14	Samsung 16GB DDR4	RAM	Samsung	M378A2K43DB3-CWE	20000.00	{"kit": "1x16GB", "type": "DDR4", "speed": "3200MHz", "timing": "CL22", "capacity": "16GB"}	2026-05-03 15:40:35.243399
15	ASUS ROG Maximus Z790 Hero	Motherboard	ASUS	Maximus Z790 Hero	44999.00	{"socket": "LGA1700", "chipset": "Z790", "ram_type": "DDR5", "ram_slots": 4, "form_factor": "ATX", "pcie_16x_slots": 3}	2026-05-03 15:40:39.34527
16	MSI MPG B650 Carbon WiFi	Motherboard	MSI	MPG B650 Carbon WiFi	27999.00	{"socket": "AM5", "chipset": "B650", "ram_type": "DDR5", "ram_slots": 4, "form_factor": "ATX", "pcie_16x_slots": 2}	2026-05-03 15:40:39.34527
17	Gigabyte Z790 Aorus Elite	Motherboard	Gigabyte	Z790 Aorus Elite	23999.00	{"socket": "LGA1700", "chipset": "Z790", "ram_type": "DDR5", "ram_slots": 4, "form_factor": "ATX", "pcie_16x_slots": 3}	2026-05-03 15:40:39.34527
18	ASRock B760 Pro RS	Motherboard	ASRock	B760 Pro RS	15999.00	{"socket": "LGA1700", "chipset": "B760", "ram_type": "DDR5", "ram_slots": 4, "form_factor": "ATX", "pcie_16x_slots": 2}	2026-05-03 15:40:39.34527
19	Samsung 990 Pro 1TB	SSD	Samsung	MZ-V9P1T0BW	11999.00	{"format": "M.2", "capacity": "1TB", "interface": "NVMe PCIe 4.0", "read_speed": "7450MB/s", "write_speed": "6900MB/s"}	2026-05-03 15:40:42.898699
20	WD Black SN850X 2TB	SSD	Western Digital	SN850X	17999.00	{"format": "M.2", "capacity": "2TB", "interface": "NVMe PCIe 4.0", "read_speed": "7300MB/s", "write_speed": "6600MB/s"}	2026-05-03 15:40:42.898699
21	Kingston KC3000 1TB	SSD	Kingston	SKC3000S/1024G	8999.00	{"format": "M.2", "capacity": "1TB", "interface": "NVMe PCIe 4.0", "read_speed": "7000MB/s", "write_speed": "6000MB/s"}	2026-05-03 15:40:42.898699
22	Crucial P3 Plus 500GB	SSD	Crucial	CT500P3PSSD8	3999.00	{"format": "M.2", "capacity": "500GB", "interface": "NVMe PCIe 4.0", "read_speed": "4700MB/s", "write_speed": "1900MB/s"}	2026-05-03 15:40:42.898699
23	Corsair RM1000x	PSU	Corsair	RM1000x	19999.00	{"power": "1000W", "modular": "Full", "efficiency": "80+ Gold", "form_factor": "ATX"}	2026-05-03 15:40:45.75869
24	Seasonic Focus GX-850	PSU	Seasonic	Focus GX-850	15999.00	{"power": "850W", "modular": "Full", "efficiency": "80+ Gold", "form_factor": "ATX"}	2026-05-03 15:40:45.75869
25	be quiet! Straight Power 12 750W	PSU	be quiet!	Straight Power 12	13999.00	{"power": "750W", "modular": "Full", "efficiency": "80+ Platinum", "form_factor": "ATX"}	2026-05-03 15:40:45.75869
\.


--
-- Name: builds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.builds_id_seq', 1, true);


--
-- Name: components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.components_id_seq', 25, true);


--
-- Name: build_components build_components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_pkey PRIMARY KEY (build_id, component_id);


--
-- Name: builds builds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.builds
    ADD CONSTRAINT builds_pkey PRIMARY KEY (id);


--
-- Name: compatibility compatibility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibility
    ADD CONSTRAINT compatibility_pkey PRIMARY KEY (component1_id, component2_id);


--
-- Name: components components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);


--
-- Name: build_components build_components_build_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_build_id_fkey FOREIGN KEY (build_id) REFERENCES public.builds(id);


--
-- Name: build_components build_components_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id);


--
-- Name: compatibility compatibility_component1_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibility
    ADD CONSTRAINT compatibility_component1_id_fkey FOREIGN KEY (component1_id) REFERENCES public.components(id);


--
-- Name: compatibility compatibility_component2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibility
    ADD CONSTRAINT compatibility_component2_id_fkey FOREIGN KEY (component2_id) REFERENCES public.components(id);


--
-- PostgreSQL database dump complete
--

\unrestrict BFHqQaH6sowzEB5IN8zDTsRqHWEgxsZMRZ7b4HCbhq6547vEhIAZlSie0YRHUtH

