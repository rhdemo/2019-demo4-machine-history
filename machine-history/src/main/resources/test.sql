--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: damage_record; Type: TABLE; Schema: public; Owner: stuart
--

CREATE TABLE damage_record (
    id integer NOT NULL,
    machine_id integer NOT NULL,
    date date NOT NULL,
    damage integer NOT NULL
);


ALTER TABLE damage_record OWNER TO stuart;

--
-- Name: damage_record_id_seq; Type: SEQUENCE; Schema: public; Owner: stuart
--

CREATE SEQUENCE damage_record_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE damage_record_id_seq OWNER TO stuart;

--
-- Name: damage_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stuart
--

ALTER SEQUENCE damage_record_id_seq OWNED BY damage_record.id;


--
-- Name: machine_record; Type: TABLE; Schema: public; Owner: stuart
--

CREATE TABLE machine_record (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE machine_record OWNER TO stuart;

--
-- Name: maintenance_record; Type: TABLE; Schema: public; Owner: stuart
--

CREATE TABLE maintenance_record (
    id integer NOT NULL,
    machine_id integer NOT NULL,
    date date NOT NULL,
    repair integer NOT NULL,
    mechanic character varying NOT NULL
);


ALTER TABLE maintenance_record OWNER TO stuart;

--
-- Name: maintenance_record_id_seq; Type: SEQUENCE; Schema: public; Owner: stuart
--

CREATE SEQUENCE maintenance_record_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE maintenance_record_id_seq OWNER TO stuart;

--
-- Name: maintenance_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stuart
--

ALTER SEQUENCE maintenance_record_id_seq OWNED BY maintenance_record.id;


--
-- Name: damage_record id; Type: DEFAULT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY damage_record ALTER COLUMN id SET DEFAULT nextval('damage_record_id_seq'::regclass);


--
-- Name: maintenance_record id; Type: DEFAULT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY maintenance_record ALTER COLUMN id SET DEFAULT nextval('maintenance_record_id_seq'::regclass);


--
-- Data for Name: damage_record; Type: TABLE DATA; Schema: public; Owner: stuart
--

COPY damage_record (id, machine_id, date, damage) FROM stdin;
\.


--
-- Name: damage_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stuart
--

SELECT pg_catalog.setval('damage_record_id_seq', 489, true);


--
-- Data for Name: machine_record; Type: TABLE DATA; Schema: public; Owner: stuart
--

COPY machine_record (id, name) FROM stdin;
1	Heavy Duty Sheet Metal Press
2	Light Sheet Metal Press
3	Bending Unit
4	Paint Station
5	Drill Press
6	CNC Lathe
7	Boring Machine
8	Milling Machine
9	Injection Moulding Station
10	Hydraulic Press
\.


--
-- Data for Name: maintenance_record; Type: TABLE DATA; Schema: public; Owner: stuart
--

COPY maintenance_record (id, machine_id, date, repair, mechanic) FROM stdin;
1	1	2017-11-06	48	Bob
2	1	2018-04-21	56	Bob
3	1	2018-10-31	48	Bob
4	1	2019-02-22	50	Alice
5	2	2018-02-19	79	Chuck
6	2	2018-09-04	82	Chuck
7	3	2017-10-11	42	Alice
8	3	2018-01-03	35	Chuck
9	3	2018-03-26	58	Bob
10	3	2018-08-27	41	Alice
11	3	2018-11-09	35	Chuck
12	3	2019-03-05	30	Bob
13	4	2017-11-19	32	Bob
14	4	2018-02-13	31	Alice
15	4	2018-05-16	43	Alice
16	4	2018-08-28	28	Bob
17	4	2018-12-26	40	Bob
18	5	2017-12-18	51	Chuck
19	5	2018-04-24	48	Chuck
20	5	2018-08-21	47	Chuck
21	5	2018-11-23	48	Chuck
22	5	2019-03-02	50	Chuck
23	6	2017-10-21	48	Chuck
24	6	2018-04-29	40	Chuck
25	6	2018-08-14	42	Chuck
26	6	2018-11-04	33	Bob
27	6	2019-02-19	33	Alice
28	7	2017-12-14	58	Bob
29	7	2018-07-24	61	Bob
30	7	2019-01-29	58	Alice
31	8	2018-01-25	59	Alice
32	8	2018-05-29	57	Chuck
33	8	2019-01-09	61	Alice
34	9	2018-02-02	62	Chuck
35	9	2018-07-15	62	Bob
36	9	2019-01-14	60	Chuck
37	10	2018-01-07	58	Alice
38	10	2018-05-07	56	Bob
39	10	2018-12-28	58	Chuck
\.


--
-- Name: maintenance_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stuart
--

SELECT pg_catalog.setval('maintenance_record_id_seq', 39, true);


--
-- Name: damage_record damage_record_pkey; Type: CONSTRAINT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY damage_record
    ADD CONSTRAINT damage_record_pkey PRIMARY KEY (id);


--
-- Name: machine_record machine_record_pkey; Type: CONSTRAINT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY machine_record
    ADD CONSTRAINT machine_record_pkey PRIMARY KEY (id);


--
-- Name: maintenance_record maintenance_record_pkey; Type: CONSTRAINT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY maintenance_record
    ADD CONSTRAINT maintenance_record_pkey PRIMARY KEY (id);


--
-- Name: damage_record damage_record_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY damage_record
    ADD CONSTRAINT damage_record_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES machine_record(id);


--
-- Name: maintenance_record maintenance_record_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY maintenance_record
    ADD CONSTRAINT maintenance_record_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES machine_record(id);


--
-- PostgreSQL database dump complete
--

