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
    health integer NOT NULL,
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
-- Name: maintenance_record id; Type: DEFAULT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY maintenance_record ALTER COLUMN id SET DEFAULT nextval('maintenance_record_id_seq'::regclass);


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

COPY maintenance_record (id, machine_id, date, repair, health, mechanic) FROM stdin;
752	1	2018-06-29	27	0	Chuck
753	1	2018-07-14	20	0	Chuck
754	1	2018-07-20	43	0	Chuck
756	1	2018-09-01	31	0	Alice
757	1	2018-09-06	32	0	Alice
758	1	2018-09-27	48	0	Chuck
759	1	2018-10-27	44	0	Bob
760	1	2018-11-14	57	0	Bob
761	1	2018-11-30	27	0	Chuck
762	1	2018-12-16	31	0	Bob
763	1	2018-12-30	50	0	Alice
764	1	2019-01-28	30	0	Bob
765	1	2019-02-13	36	0	Bob
766	1	2019-02-24	46	0	Alice
767	1	2019-03-19	22	0	Alice
768	2	2017-08-05	40	0	Chuck
769	2	2017-09-03	29	0	Chuck
770	2	2017-09-11	47	0	Alice
771	2	2017-10-10	35	0	Alice
772	2	2017-10-20	37	0	Chuck
773	2	2017-11-13	31	0	Bob
774	2	2017-12-11	29	0	Bob
775	2	2017-12-19	29	0	Bob
776	2	2018-01-16	37	0	Alice
777	2	2018-01-25	38	0	Chuck
778	2	2018-01-28	27	0	Chuck
779	2	2018-02-21	39	0	Bob
780	2	2018-03-24	45	0	Alice
781	2	2018-04-19	31	0	Alice
782	2	2018-04-23	47	0	Bob
783	2	2018-04-26	47	0	Alice
784	2	2018-05-24	41	0	Chuck
785	2	2018-06-18	24	0	Chuck
786	2	2018-07-03	44	0	Alice
787	2	2018-07-24	28	0	Alice
788	2	2018-08-15	20	0	Alice
789	2	2018-09-09	47	0	Alice
790	2	2018-10-10	20	0	Alice
791	2	2018-11-03	25	0	Bob
792	2	2018-12-04	22	0	Bob
793	2	2018-12-13	33	0	Alice
794	2	2018-12-21	37	0	Alice
795	2	2019-01-15	47	0	Bob
796	2	2019-02-01	47	0	Alice
797	2	2019-02-16	29	0	Alice
798	2	2019-02-27	37	0	Chuck
799	2	2019-03-21	26	0	Chuck
800	3	2017-08-05	47	0	Bob
801	3	2017-08-23	52	0	Bob
802	3	2017-09-03	37	0	Chuck
803	3	2017-10-01	39	0	Bob
804	3	2017-10-23	52	0	Bob
805	3	2017-11-20	20	0	Chuck
806	3	2017-12-01	25	0	Alice
807	3	2017-12-22	38	0	Alice
808	3	2018-01-05	32	0	Alice
809	3	2018-01-31	43	0	Alice
810	3	2018-02-17	55	0	Alice
811	3	2018-02-20	33	0	Chuck
812	3	2018-03-12	27	0	Alice
813	3	2018-04-10	42	0	Bob
814	3	2018-04-24	40	0	Chuck
815	3	2018-05-19	56	0	Chuck
816	3	2018-06-01	54	0	Alice
817	3	2018-06-15	24	0	Alice
818	3	2018-07-07	49	0	Alice
819	3	2018-08-04	40	0	Bob
820	3	2018-08-21	30	0	Alice
821	3	2018-09-11	22	0	Chuck
822	3	2018-10-09	55	0	Alice
823	3	2018-10-23	31	0	Alice
824	3	2018-11-09	40	0	Chuck
825	3	2018-11-11	33	0	Bob
826	3	2018-11-17	38	0	Chuck
827	3	2018-12-12	54	0	Alice
828	3	2018-12-30	35	0	Chuck
829	3	2019-01-19	47	0	Chuck
830	3	2019-02-14	54	0	Bob
831	3	2019-02-23	57	0	Alice
832	3	2019-03-19	26	0	Chuck
833	4	2017-08-05	34	0	Chuck
834	4	2017-08-07	56	0	Bob
835	4	2017-08-22	27	0	Bob
836	4	2017-09-18	28	0	Bob
837	4	2017-10-12	23	0	Bob
838	4	2017-10-31	52	0	Alice
839	4	2017-11-06	26	0	Bob
840	4	2017-11-14	48	0	Alice
841	4	2017-11-28	23	0	Chuck
842	4	2017-12-16	58	0	Alice
843	4	2018-01-16	57	0	Bob
844	4	2018-02-02	55	0	Alice
845	4	2018-02-25	55	0	Chuck
846	4	2018-03-20	33	0	Chuck
847	4	2018-04-13	30	0	Bob
848	4	2018-04-28	33	0	Alice
849	4	2018-05-04	30	0	Alice
850	4	2018-05-14	36	0	Alice
851	4	2018-06-12	52	0	Bob
852	4	2018-06-23	29	0	Chuck
853	4	2018-06-27	28	0	Chuck
854	4	2018-07-22	55	0	Chuck
855	4	2018-08-19	50	0	Chuck
856	4	2018-09-06	39	0	Bob
857	4	2018-09-26	40	0	Chuck
858	4	2018-10-16	58	0	Bob
859	4	2018-11-09	27	0	Bob
860	4	2018-12-09	21	0	Chuck
861	4	2018-12-29	51	0	Alice
862	4	2019-01-25	57	0	Alice
863	4	2019-02-23	33	0	Chuck
864	4	2019-03-15	37	0	Bob
865	4	2019-03-27	46	0	Bob
866	5	2017-08-05	22	0	Alice
867	5	2017-08-16	47	0	Alice
868	5	2017-09-15	20	0	Bob
869	5	2017-09-28	20	0	Bob
870	5	2017-10-01	54	0	Bob
871	5	2017-10-30	53	0	Bob
872	5	2017-11-30	27	0	Bob
873	5	2017-12-22	29	0	Alice
874	5	2018-01-22	57	0	Alice
875	5	2018-01-27	46	0	Alice
876	5	2018-02-05	57	0	Chuck
877	5	2018-02-15	50	0	Alice
878	5	2018-02-28	22	0	Bob
879	5	2018-03-15	40	0	Bob
880	5	2018-03-23	39	0	Alice
881	5	2018-03-30	56	0	Bob
882	5	2018-04-07	29	0	Alice
883	5	2018-04-16	57	0	Alice
884	5	2018-04-28	25	0	Bob
885	5	2018-05-08	20	0	Alice
886	5	2018-05-28	24	0	Chuck
887	5	2018-06-01	52	0	Alice
888	5	2018-06-25	45	0	Bob
889	5	2018-07-04	33	0	Bob
890	5	2018-08-03	39	0	Alice
891	5	2018-08-20	31	0	Bob
892	5	2018-09-16	27	0	Chuck
893	5	2018-09-26	24	0	Chuck
894	5	2018-10-12	55	0	Bob
895	5	2018-11-02	35	0	Alice
896	5	2018-11-19	23	0	Chuck
897	5	2018-12-02	38	0	Bob
898	5	2018-12-18	41	0	Chuck
899	5	2019-01-09	32	0	Alice
900	5	2019-01-31	57	0	Bob
901	5	2019-02-12	40	0	Bob
902	5	2019-02-25	48	0	Alice
903	5	2019-03-07	38	0	Chuck
904	5	2019-03-19	30	0	Bob
905	6	2017-08-05	49	0	Chuck
906	6	2017-08-28	39	0	Bob
907	6	2017-09-19	48	0	Chuck
908	6	2017-10-05	50	0	Alice
909	6	2017-10-27	45	0	Alice
910	6	2017-11-22	29	0	Alice
911	6	2017-12-19	41	0	Alice
912	6	2017-12-24	50	0	Alice
913	6	2018-01-04	30	0	Chuck
914	6	2018-01-21	46	0	Alice
915	6	2018-01-29	21	0	Alice
916	6	2018-02-02	57	0	Chuck
917	6	2018-02-15	44	0	Chuck
918	6	2018-02-28	21	0	Bob
919	6	2018-03-12	36	0	Chuck
920	6	2018-04-04	30	0	Alice
921	6	2018-04-22	51	0	Alice
922	6	2018-05-13	20	0	Bob
923	6	2018-05-25	48	0	Alice
924	6	2018-06-21	33	0	Alice
925	6	2018-07-19	45	0	Bob
926	6	2018-08-05	43	0	Chuck
927	6	2018-08-11	47	0	Bob
928	6	2018-08-24	28	0	Bob
929	6	2018-09-19	48	0	Bob
930	6	2018-10-15	42	0	Chuck
931	6	2018-11-08	44	0	Bob
932	6	2018-11-11	43	0	Alice
933	6	2018-12-10	47	0	Chuck
934	6	2018-12-31	29	0	Chuck
935	6	2019-01-22	57	0	Bob
936	6	2019-01-26	35	0	Chuck
937	6	2019-02-20	47	0	Chuck
938	6	2019-03-17	59	0	Chuck
939	7	2017-08-05	59	0	Alice
940	7	2017-09-02	43	0	Alice
941	7	2017-09-18	38	0	Bob
942	7	2017-10-01	41	0	Alice
943	7	2017-10-30	32	0	Alice
944	7	2017-11-06	47	0	Alice
945	7	2017-12-05	54	0	Chuck
946	7	2017-12-12	36	0	Bob
947	7	2017-12-31	24	0	Chuck
948	7	2018-01-19	56	0	Alice
949	7	2018-02-09	40	0	Bob
950	7	2018-03-03	28	0	Chuck
951	7	2018-03-15	44	0	Alice
952	7	2018-03-30	30	0	Alice
953	7	2018-04-29	46	0	Alice
954	7	2018-05-03	21	0	Bob
955	7	2018-05-13	22	0	Bob
956	7	2018-05-20	32	0	Chuck
957	7	2018-05-25	25	0	Alice
958	7	2018-06-11	52	0	Bob
959	7	2018-06-28	52	0	Bob
960	7	2018-07-20	47	0	Alice
961	7	2018-07-27	54	0	Chuck
962	7	2018-07-31	31	0	Bob
963	7	2018-08-21	25	0	Alice
964	7	2018-09-16	56	0	Bob
965	7	2018-09-28	48	0	Alice
966	7	2018-10-09	39	0	Bob
967	7	2018-11-09	20	0	Bob
968	7	2018-11-24	31	0	Alice
969	7	2018-12-12	23	0	Alice
970	7	2018-12-23	38	0	Bob
971	7	2019-01-06	47	0	Alice
972	7	2019-01-08	52	0	Alice
973	7	2019-02-08	41	0	Chuck
974	7	2019-03-08	36	0	Chuck
975	7	2019-03-22	29	0	Chuck
976	8	2017-08-05	28	0	Chuck
977	8	2017-08-18	57	0	Bob
978	8	2017-09-13	43	0	Chuck
979	8	2017-10-06	51	0	Alice
980	8	2017-11-03	27	0	Alice
981	8	2017-11-28	46	0	Alice
982	8	2017-12-21	48	0	Alice
983	8	2018-01-19	50	0	Chuck
984	8	2018-02-16	34	0	Bob
985	8	2018-03-04	26	0	Alice
986	8	2018-03-27	38	0	Bob
987	8	2018-04-16	57	0	Bob
988	8	2018-04-25	44	0	Bob
989	8	2018-05-20	42	0	Chuck
990	8	2018-06-15	39	0	Bob
991	8	2018-06-19	31	0	Alice
992	8	2018-07-15	57	0	Alice
993	8	2018-08-11	37	0	Chuck
994	8	2018-09-02	46	0	Alice
995	8	2018-09-22	55	0	Bob
996	8	2018-10-05	53	0	Chuck
1052	10	2017-09-30	59	0	Chuck
1053	10	2017-10-20	36	0	Alice
1054	10	2017-11-17	23	0	Chuck
1055	10	2017-11-24	52	0	Alice
1056	10	2017-12-09	51	0	Alice
1057	10	2017-12-15	44	0	Chuck
1058	10	2017-12-26	40	0	Bob
1059	10	2018-01-25	30	0	Chuck
1060	10	2018-02-25	25	0	Bob
1061	10	2018-03-16	28	0	Chuck
1062	10	2018-03-26	53	0	Bob
1063	10	2018-03-28	59	0	Alice
1064	10	2018-04-07	23	0	Bob
1065	10	2018-04-29	56	0	Alice
1066	10	2018-05-08	53	0	Chuck
1067	10	2018-05-21	48	0	Bob
1068	10	2018-06-11	56	0	Chuck
1069	10	2018-07-02	59	0	Chuck
1070	10	2018-08-01	49	0	Bob
1071	10	2018-08-14	26	0	Bob
1072	10	2018-08-22	31	0	Chuck
1073	10	2018-08-30	33	0	Alice
1074	10	2018-09-25	40	0	Alice
1075	10	2018-10-20	21	0	Bob
1076	10	2018-10-25	23	0	Chuck
1077	10	2018-11-05	29	0	Alice
1078	10	2018-11-15	55	0	Alice
1079	10	2018-12-16	23	0	Chuck
1080	10	2019-01-07	58	0	Chuck
1081	10	2019-01-19	51	0	Chuck
1082	10	2019-02-19	36	0	Alice
1083	10	2019-03-04	23	0	Alice
1084	10	2019-03-20	35	0	Alice
733	1	2017-08-05	59	0	Chuck
734	1	2017-09-03	28	0	Alice
735	1	2017-09-30	26	0	Chuck
736	1	2017-10-09	25	0	Bob
737	1	2017-10-20	43	0	Alice
738	1	2017-11-06	26	0	Bob
739	1	2017-12-04	36	0	Chuck
740	1	2017-12-10	43	0	Bob
741	1	2018-01-02	44	0	Alice
742	1	2018-01-13	56	0	Bob
743	1	2018-02-04	21	0	Bob
744	1	2018-02-07	29	0	Chuck
745	1	2018-02-16	27	0	Chuck
746	1	2018-03-18	44	0	Bob
747	1	2018-04-03	46	0	Chuck
748	1	2018-04-25	20	0	Alice
749	1	2018-05-14	42	0	Bob
750	1	2018-05-19	50	0	Alice
751	1	2018-05-30	36	0	Alice
755	1	2018-08-06	52	0	Bob
997	8	2018-10-09	47	0	Bob
998	8	2018-10-13	36	0	Alice
999	8	2018-11-02	22	0	Bob
1000	8	2018-11-20	26	0	Chuck
1001	8	2018-12-10	56	0	Bob
1002	8	2018-12-12	48	0	Alice
1003	8	2018-12-29	52	0	Bob
1004	8	2019-01-02	34	0	Bob
1005	8	2019-01-29	22	0	Chuck
1006	8	2019-02-12	25	0	Bob
1007	8	2019-03-15	51	0	Bob
1008	9	2017-08-05	41	0	Alice
1009	9	2017-08-22	39	0	Alice
1010	9	2017-09-06	45	0	Chuck
1011	9	2017-09-17	26	0	Chuck
1012	9	2017-09-22	53	0	Bob
1013	9	2017-10-11	23	0	Alice
1014	9	2017-10-29	43	0	Alice
1015	9	2017-11-25	45	0	Bob
1016	9	2017-12-16	52	0	Alice
1017	9	2017-12-20	44	0	Bob
1018	9	2017-12-27	39	0	Chuck
1019	9	2018-01-27	49	0	Alice
1020	9	2018-02-05	44	0	Alice
1021	9	2018-02-10	28	0	Bob
1022	9	2018-02-26	54	0	Bob
1023	9	2018-03-24	52	0	Bob
1024	9	2018-04-11	58	0	Alice
1025	9	2018-04-28	39	0	Bob
1026	9	2018-05-13	34	0	Chuck
1027	9	2018-06-11	53	0	Chuck
1028	9	2018-06-14	43	0	Chuck
1029	9	2018-07-07	52	0	Alice
1030	9	2018-07-14	49	0	Bob
1031	9	2018-08-02	26	0	Bob
1032	9	2018-08-04	41	0	Chuck
1033	9	2018-09-01	20	0	Chuck
1034	9	2018-09-05	33	0	Chuck
1035	9	2018-10-01	52	0	Chuck
1036	9	2018-10-13	23	0	Bob
1037	9	2018-10-26	47	0	Alice
1038	9	2018-11-06	31	0	Alice
1039	9	2018-11-15	58	0	Bob
1040	9	2018-12-13	33	0	Chuck
1041	9	2018-12-30	26	0	Bob
1042	9	2019-01-04	22	0	Chuck
1043	9	2019-01-25	27	0	Bob
1044	9	2019-02-01	39	0	Alice
1045	9	2019-02-03	54	0	Bob
1046	9	2019-02-19	50	0	Chuck
1047	9	2019-03-02	32	0	Alice
1048	9	2019-03-13	37	0	Alice
1049	9	2019-03-15	24	0	Alice
1050	10	2017-08-05	27	0	Chuck
1051	10	2017-08-31	57	0	Bob
\.


--
-- Name: maintenance_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: stuart
--

SELECT pg_catalog.setval('maintenance_record_id_seq', 1084, true);


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
-- Name: maintenance_record maintenance_record_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: stuart
--

ALTER TABLE ONLY maintenance_record
    ADD CONSTRAINT maintenance_record_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES machine_record(id);


--
-- PostgreSQL database dump complete
--

