--
-- PostgreSQL database dump
--

\restrict Q5Ng0lkhXsvbWidoycaNXGdzXRgSDxCApKNhhawmeZzyZDy5yCqzFV5QdrngYYq

-- Dumped from database version 17.10
-- Dumped by pg_dump version 17.10

-- Started on 2026-07-25 17:03:05

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
-- TOC entry 224 (class 1259 OID 16495)
-- Name: caseadvocate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caseadvocate (
    advocate_id character varying(10),
    case_id character varying(10),
    advocate_name character varying(100),
    role character varying(50),
    experience_years integer
);


ALTER TABLE public.caseadvocate OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16464)
-- Name: casefile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.casefile (
    case_id character varying(10),
    title character varying(100),
    description text,
    start_date date,
    status character varying(30),
    crime_type character varying(50)
);


ALTER TABLE public.casefile OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16498)
-- Name: casejudge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.casejudge (
    judge_id character varying(10),
    case_id character varying(10),
    judge_name character varying(100),
    court_name character varying(100)
);


ALTER TABLE public.casejudge OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16477)
-- Name: caseofficer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caseofficer (
    case_id character varying(10),
    officer_id character varying(10),
    role_in_case character varying(100)
);


ALTER TABLE public.caseofficer OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16480)
-- Name: casesuspect; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.casesuspect (
    suspect_id character varying(10),
    case_id character varying(10),
    name character varying(100),
    dob date,
    gender character varying(10),
    criminal_history text,
    suspicion_level character varying(20),
    role_in_case character varying(100)
);


ALTER TABLE public.casesuspect OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16485)
-- Name: clue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clue (
    clue_id character varying(10),
    case_id character varying(10),
    description text,
    discovered_date date,
    location character varying(100)
);


ALTER TABLE public.clue OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16472)
-- Name: crimescene; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crimescene (
    scene_id character varying(10),
    case_id character varying(10),
    address text,
    city character varying(50),
    date_reported date,
    description text
);


ALTER TABLE public.crimescene OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16490)
-- Name: evidence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evidence (
    evidence_id character varying(10),
    case_id character varying(10),
    type character varying(50),
    description text,
    storage_location character varying(100)
);


ALTER TABLE public.evidence OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16469)
-- Name: officer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.officer (
    officer_id character varying(10),
    name character varying(100),
    officer_rank character varying(50),
    department character varying(100)
);


ALTER TABLE public.officer OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16501)
-- Name: verdict; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verdict (
    verdict_id character varying(10),
    case_id character varying(10),
    decision character varying(100),
    date date,
    remarks text
);


ALTER TABLE public.verdict OWNER TO postgres;

--
-- TOC entry 4929 (class 0 OID 16495)
-- Dependencies: 224
-- Data for Name: caseadvocate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.caseadvocate (advocate_id, case_id, advocate_name, role, experience_years) FROM stdin;
A007	C001	Sneha Joshi	Defense	5
A011	C002	Arjun Nair	Prosecution	12
A004	C002	Arjun Das	Prosecution	5
A018	C003	Rahul Sharma	Prosecution	15
A020	C003	Amit Singh	Prosecution	17
A013	C004	Rahul Mehta	Prosecution	6
A012	C005	Rahul Joshi	Prosecution	3
A015	C006	Priya Singh	Prosecution	18
A014	C006	Anjali Khan	Defense	11
A015	C007	Priya Singh	Defense	8
A023	C008	Vikram Patel	Defense	14
A022	C009	Sneha Gupta	Defense	3
A002	C010	Sneha Reddy	Prosecution	19
A022	C011	Sneha Gupta	Prosecution	10
A024	C011	Kavita Singh	Defense	12
A009	C012	Rahul Reddy	Prosecution	18
A024	C012	Kavita Singh	Prosecution	5
A024	C013	Kavita Singh	Defense	4
A003	C013	Neha Joshi	Prosecution	14
A007	C014	Sneha Joshi	Prosecution	19
A001	C014	Anjali Nair	Defense	15
A004	C015	Arjun Das	Defense	14
A018	C015	Rahul Sharma	Defense	17
A002	C016	Sneha Reddy	Defense	12
A006	C017	Neha Reddy	Prosecution	20
A011	C018	Arjun Nair	Prosecution	4
A006	C019	Neha Reddy	Prosecution	11
A009	C020	Rahul Reddy	Prosecution	11
A005	C020	Rahul Das	Prosecution	7
A001	C021	Anjali Nair	Defense	10
A006	C021	Neha Reddy	Prosecution	13
A010	C022	Neha Gupta	Prosecution	15
A011	C022	Arjun Nair	Defense	7
A024	C023	Kavita Singh	Defense	7
A024	C024	Kavita Singh	Defense	18
A011	C024	Arjun Nair	Defense	16
A022	C025	Sneha Gupta	Defense	16
A003	C025	Neha Joshi	Prosecution	8
A007	C026	Sneha Joshi	Defense	16
A023	C026	Vikram Patel	Defense	16
A023	C027	Vikram Patel	Defense	15
A001	C028	Anjali Nair	Defense	17
A022	C028	Sneha Gupta	Defense	12
A002	C029	Sneha Reddy	Prosecution	15
A018	C029	Rahul Sharma	Prosecution	8
A007	C030	Sneha Joshi	Defense	15
A019	C031	Vikram Das	Defense	7
A020	C032	Amit Singh	Prosecution	9
A004	C032	Arjun Das	Defense	12
A017	C033	Amit Khan	Defense	3
A001	C033	Anjali Nair	Defense	6
A019	C034	Vikram Das	Defense	10
A013	C034	Rahul Mehta	Defense	8
A002	C035	Sneha Reddy	Prosecution	10
A024	C036	Kavita Singh	Prosecution	12
A014	C037	Anjali Khan	Prosecution	3
A025	C037	Vikram Sharma	Defense	11
A009	C038	Rahul Reddy	Prosecution	18
A023	C038	Vikram Patel	Defense	17
A017	C039	Amit Khan	Defense	20
A007	C040	Sneha Joshi	Defense	3
A013	C040	Rahul Mehta	Prosecution	17
A024	C041	Kavita Singh	Prosecution	17
A018	C042	Rahul Sharma	Defense	13
A008	C043	Sneha Khan	Prosecution	14
A001	C043	Anjali Nair	Prosecution	16
A007	C044	Sneha Joshi	Defense	10
A003	C044	Neha Joshi	Defense	11
A019	C045	Vikram Das	Prosecution	14
A013	C045	Rahul Mehta	Defense	8
A015	C046	Priya Singh	Defense	8
A003	C047	Neha Joshi	Prosecution	20
A008	C048	Sneha Khan	Defense	14
A014	C049	Anjali Khan	Prosecution	14
A024	C049	Kavita Singh	Defense	11
A006	C050	Neha Reddy	Defense	10
A025	C050	Vikram Sharma	Prosecution	19
A016	C051	Amit Nair	Defense	5
A003	C052	Neha Joshi	Defense	11
A008	C053	Sneha Khan	Prosecution	3
A003	C053	Neha Joshi	Prosecution	17
A002	C054	Sneha Reddy	Prosecution	4
A005	C055	Rahul Das	Defense	15
A002	C055	Sneha Reddy	Defense	10
A014	C056	Anjali Khan	Defense	17
A013	C057	Rahul Mehta	Defense	3
A012	C057	Rahul Joshi	Defense	5
A018	C058	Rahul Sharma	Prosecution	16
A017	C058	Amit Khan	Prosecution	18
A024	C059	Kavita Singh	Defense	11
A007	C060	Sneha Joshi	Defense	4
A002	C060	Sneha Reddy	Defense	16
A005	C061	Rahul Das	Defense	15
A010	C062	Neha Gupta	Defense	7
A001	C063	Anjali Nair	Prosecution	16
A017	C064	Amit Khan	Prosecution	20
A008	C065	Sneha Khan	Defense	3
A007	C066	Sneha Joshi	Prosecution	10
A014	C066	Anjali Khan	Defense	19
A022	C067	Sneha Gupta	Prosecution	15
A005	C067	Rahul Das	Defense	20
A019	C068	Vikram Das	Defense	20
A022	C069	Sneha Gupta	Prosecution	13
A015	C069	Priya Singh	Prosecution	19
A017	C070	Amit Khan	Defense	12
A006	C071	Neha Reddy	Prosecution	8
A023	C071	Vikram Patel	Prosecution	20
A016	C072	Amit Nair	Defense	3
A006	C073	Neha Reddy	Defense	17
A009	C073	Rahul Reddy	Defense	13
A014	C074	Anjali Khan	Defense	18
A021	C074	Anjali Reddy	Defense	10
A021	C075	Anjali Reddy	Prosecution	18
A014	C076	Anjali Khan	Defense	5
A007	C076	Sneha Joshi	Prosecution	19
A013	C077	Rahul Mehta	Defense	6
A002	C077	Sneha Reddy	Defense	12
A017	C078	Amit Khan	Defense	6
A020	C078	Amit Singh	Defense	16
A024	C079	Kavita Singh	Defense	16
A012	C079	Rahul Joshi	Prosecution	18
A012	C080	Rahul Joshi	Prosecution	10
A008	C080	Sneha Khan	Defense	19
A012	C081	Rahul Joshi	Defense	16
A003	C081	Neha Joshi	Prosecution	17
A003	C082	Neha Joshi	Defense	8
A023	C083	Vikram Patel	Prosecution	9
A005	C083	Rahul Das	Defense	9
A011	C084	Arjun Nair	Prosecution	20
A010	C084	Neha Gupta	Defense	14
A001	C085	Anjali Nair	Prosecution	19
A009	C086	Rahul Reddy	Defense	17
A003	C086	Neha Joshi	Defense	11
A024	C087	Kavita Singh	Prosecution	9
A017	C088	Amit Khan	Prosecution	9
A003	C089	Neha Joshi	Prosecution	10
A014	C090	Anjali Khan	Prosecution	19
A001	C090	Anjali Nair	Defense	10
A021	C091	Anjali Reddy	Defense	6
A001	C092	Anjali Nair	Defense	5
A012	C093	Rahul Joshi	Defense	4
A003	C093	Neha Joshi	Defense	6
A016	C094	Amit Nair	Defense	5
A021	C094	Anjali Reddy	Defense	13
A011	C095	Arjun Nair	Prosecution	19
A010	C096	Neha Gupta	Defense	3
A016	C096	Amit Nair	Defense	9
A022	C097	Sneha Gupta	Prosecution	18
A020	C097	Amit Singh	Prosecution	8
A018	C098	Rahul Sharma	Prosecution	19
A013	C098	Rahul Mehta	Prosecution	4
A003	C099	Neha Joshi	Defense	11
A017	C099	Amit Khan	Prosecution	13
A022	C100	Sneha Gupta	Prosecution	15
\.


--
-- TOC entry 4922 (class 0 OID 16464)
-- Dependencies: 217
-- Data for Name: casefile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.casefile (case_id, title, description, start_date, status, crime_type) FROM stdin;
C001	Jewelry Theft	Gold jewelry stolen from residence	2025-01-26	Under Investigation	Theft
C002	Bank Fraud	Unauthorized bank transactions detected	2025-11-29	Under Investigation	Fraud
C003	Jewelry Theft	Gold jewelry stolen from residence	2025-07-26	Under Investigation	Theft
C004	Email Phishing Scam	Multiple victims of phishing attack	2023-12-23	Closed	Cybercrime
C005	Email Phishing Scam	Multiple victims of phishing attack	2023-11-10	Closed	Cybercrime
C006	Domestic Violence Case	Reported abuse in household	2025-10-28	Under Investigation	Assault
C007	Homicide Investigation	Suspicious death under investigation	2024-02-24	Under Investigation	Murder
C008	ATM Robbery	Cash stolen from ATM machine	2024-03-17	Closed	Robbery
C009	Bank Fraud	Unauthorized bank transactions detected	2025-11-08	Closed	Fraud
C010	Homicide Investigation	Suspicious death under investigation	2024-11-13	Closed	Murder
C011	Convenience Store Robbery	Armed robbery at local store	2024-01-01	Open	Robbery
C012	Domestic Violence Case	Reported abuse in household	2023-02-24	Open	Assault
C013	Insurance Fraud	Fake insurance claims submitted	2024-04-11	Under Investigation	Fraud
C014	Vehicle Theft	Car stolen from parking lot	2024-10-11	Open	Theft
C015	Convenience Store Robbery	Armed robbery at local store	2025-06-14	Under Investigation	Robbery
C016	Jewelry Theft	Gold jewelry stolen from residence	2023-08-31	Under Investigation	Theft
C017	Convenience Store Robbery	Armed robbery at local store	2024-10-18	Under Investigation	Robbery
C018	Convenience Store Robbery	Armed robbery at local store	2023-11-12	Under Investigation	Robbery
C019	Domestic Violence Case	Reported abuse in household	2023-08-14	Open	Assault
C020	ATM Robbery	Cash stolen from ATM machine	2024-01-16	Open	Robbery
C021	Data Breach	Company data leak detected	2023-05-03	Closed	Cybercrime
C022	Data Breach	Company data leak detected	2025-09-09	Under Investigation	Cybercrime
C023	Convenience Store Robbery	Armed robbery at local store	2023-02-15	Under Investigation	Robbery
C024	Convenience Store Robbery	Armed robbery at local store	2023-10-31	Under Investigation	Robbery
C025	Data Breach	Company data leak detected	2024-08-19	Under Investigation	Cybercrime
C026	Vehicle Theft	Car stolen from parking lot	2024-01-29	Closed	Theft
C027	Data Breach	Company data leak detected	2023-02-17	Closed	Cybercrime
C028	ATM Robbery	Cash stolen from ATM machine	2025-04-04	Under Investigation	Robbery
C029	Convenience Store Robbery	Armed robbery at local store	2023-04-11	Under Investigation	Robbery
C030	Email Phishing Scam	Multiple victims of phishing attack	2023-11-16	Under Investigation	Cybercrime
C031	Bank Fraud	Unauthorized bank transactions detected	2024-10-15	Open	Fraud
C032	Email Phishing Scam	Multiple victims of phishing attack	2025-05-17	Closed	Cybercrime
C033	ATM Robbery	Cash stolen from ATM machine	2024-02-02	Closed	Robbery
C034	Jewelry Theft	Gold jewelry stolen from residence	2025-01-12	Closed	Theft
C035	Data Breach	Company data leak detected	2024-04-07	Open	Cybercrime
C036	Bank Fraud	Unauthorized bank transactions detected	2024-03-12	Open	Fraud
C037	Data Breach	Company data leak detected	2024-05-31	Closed	Cybercrime
C038	Vehicle Theft	Car stolen from parking lot	2025-08-01	Closed	Theft
C039	Domestic Violence Case	Reported abuse in household	2025-09-18	Closed	Assault
C040	Insurance Fraud	Fake insurance claims submitted	2025-07-25	Open	Fraud
C041	Jewelry Theft	Gold jewelry stolen from residence	2023-08-29	Under Investigation	Theft
C042	ATM Robbery	Cash stolen from ATM machine	2024-04-05	Closed	Robbery
C043	Bank Fraud	Unauthorized bank transactions detected	2024-01-01	Open	Fraud
C044	Convenience Store Robbery	Armed robbery at local store	2023-10-29	Under Investigation	Robbery
C045	Bank Fraud	Unauthorized bank transactions detected	2023-11-16	Under Investigation	Fraud
C046	Email Phishing Scam	Multiple victims of phishing attack	2024-08-25	Open	Cybercrime
C047	Vehicle Theft	Car stolen from parking lot	2025-06-17	Closed	Theft
C048	Data Breach	Company data leak detected	2024-11-17	Closed	Cybercrime
C049	Homicide Investigation	Suspicious death under investigation	2025-08-18	Under Investigation	Murder
C050	Jewelry Theft	Gold jewelry stolen from residence	2024-09-11	Under Investigation	Theft
C051	Email Phishing Scam	Multiple victims of phishing attack	2025-07-12	Under Investigation	Cybercrime
C052	Vehicle Theft	Car stolen from parking lot	2023-08-18	Under Investigation	Theft
C053	Homicide Investigation	Suspicious death under investigation	2023-02-20	Open	Murder
C054	Homicide Investigation	Suspicious death under investigation	2024-06-02	Under Investigation	Murder
C055	Convenience Store Robbery	Armed robbery at local store	2023-10-07	Open	Robbery
C056	Email Phishing Scam	Multiple victims of phishing attack	2025-04-26	Open	Cybercrime
C057	ATM Robbery	Cash stolen from ATM machine	2023-07-19	Closed	Robbery
C058	Insurance Fraud	Fake insurance claims submitted	2023-07-19	Under Investigation	Fraud
C059	Convenience Store Robbery	Armed robbery at local store	2024-11-25	Closed	Robbery
C060	Convenience Store Robbery	Armed robbery at local store	2023-11-15	Open	Robbery
C061	Bank Fraud	Unauthorized bank transactions detected	2025-09-04	Under Investigation	Fraud
C062	ATM Robbery	Cash stolen from ATM machine	2025-11-04	Closed	Robbery
C063	Insurance Fraud	Fake insurance claims submitted	2025-01-30	Under Investigation	Fraud
C064	Bank Fraud	Unauthorized bank transactions detected	2023-12-20	Open	Fraud
C065	Email Phishing Scam	Multiple victims of phishing attack	2025-02-22	Closed	Cybercrime
C066	Bank Fraud	Unauthorized bank transactions detected	2023-03-27	Under Investigation	Fraud
C067	Jewelry Theft	Gold jewelry stolen from residence	2024-05-25	Open	Theft
C068	Domestic Violence Case	Reported abuse in household	2025-01-02	Open	Assault
C069	Bank Fraud	Unauthorized bank transactions detected	2025-07-24	Under Investigation	Fraud
C070	Insurance Fraud	Fake insurance claims submitted	2024-06-19	Closed	Fraud
C071	Email Phishing Scam	Multiple victims of phishing attack	2024-10-21	Closed	Cybercrime
C072	Convenience Store Robbery	Armed robbery at local store	2024-10-23	Closed	Robbery
C073	Bank Fraud	Unauthorized bank transactions detected	2025-01-17	Open	Fraud
C074	Bank Fraud	Unauthorized bank transactions detected	2024-02-08	Under Investigation	Fraud
C075	Email Phishing Scam	Multiple victims of phishing attack	2025-09-25	Closed	Cybercrime
C076	Bank Fraud	Unauthorized bank transactions detected	2024-01-16	Under Investigation	Fraud
C077	Convenience Store Robbery	Armed robbery at local store	2023-01-08	Under Investigation	Robbery
C078	Domestic Violence Case	Reported abuse in household	2023-12-13	Open	Assault
C079	Insurance Fraud	Fake insurance claims submitted	2023-03-16	Closed	Fraud
C080	Convenience Store Robbery	Armed robbery at local store	2024-10-07	Open	Robbery
C081	Insurance Fraud	Fake insurance claims submitted	2023-04-14	Closed	Fraud
C082	Insurance Fraud	Fake insurance claims submitted	2024-08-30	Closed	Fraud
C083	Convenience Store Robbery	Armed robbery at local store	2024-06-28	Under Investigation	Robbery
C084	Convenience Store Robbery	Armed robbery at local store	2023-06-30	Under Investigation	Robbery
C085	Insurance Fraud	Fake insurance claims submitted	2025-01-30	Under Investigation	Fraud
C086	Convenience Store Robbery	Armed robbery at local store	2024-04-22	Under Investigation	Robbery
C087	ATM Robbery	Cash stolen from ATM machine	2023-03-14	Closed	Robbery
C088	Homicide Investigation	Suspicious death under investigation	2025-05-11	Closed	Murder
C089	Bank Fraud	Unauthorized bank transactions detected	2025-08-25	Open	Fraud
C090	Vehicle Theft	Car stolen from parking lot	2023-07-04	Under Investigation	Theft
C091	Bank Fraud	Unauthorized bank transactions detected	2023-04-07	Open	Fraud
C092	Vehicle Theft	Car stolen from parking lot	2023-12-16	Under Investigation	Theft
C093	Data Breach	Company data leak detected	2025-05-29	Closed	Cybercrime
C094	Jewelry Theft	Gold jewelry stolen from residence	2023-07-20	Closed	Theft
C095	Data Breach	Company data leak detected	2025-08-01	Under Investigation	Cybercrime
C096	Insurance Fraud	Fake insurance claims submitted	2023-05-15	Closed	Fraud
C097	Jewelry Theft	Gold jewelry stolen from residence	2024-02-26	Under Investigation	Theft
C098	Domestic Violence Case	Reported abuse in household	2024-01-11	Open	Assault
C099	Jewelry Theft	Gold jewelry stolen from residence	2025-06-01	Under Investigation	Theft
C100	Email Phishing Scam	Multiple victims of phishing attack	2025-11-20	Closed	Cybercrime
C101	Test Cybercrime	Test case for verification	2026-04-12	Open	Cybercrime
C102	Murder101	married woman of 35yrs murdered in sleep	2026-04-12	Open	Murder
C103	Theft	Theft in Alpha Mall	2026-04-12	Open	Theft
\.


--
-- TOC entry 4930 (class 0 OID 16498)
-- Dependencies: 225
-- Data for Name: casejudge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.casejudge (judge_id, case_id, judge_name, court_name) FROM stdin;
J007	C001	Rahul Singh	High Court
J014	C002	Rohit Sharma	High Court
J012	C003	Kavita Singh	Sessions Court
J009	C004	Rohit Reddy	District Court
J005	C005	Sneha Joshi	Sessions Court
J001	C006	Neha Khan	District Court
J007	C007	Rahul Singh	High Court
J015	C008	Arjun Patel	District Court
J008	C009	Rahul Mehta	District Court
J007	C010	Rahul Singh	District Court
J007	C011	Rahul Singh	Sessions Court
J004	C012	Rahul Das	High Court
J015	C013	Arjun Patel	District Court
J001	C014	Neha Khan	District Court
J008	C015	Rahul Mehta	Sessions Court
J001	C016	Neha Khan	High Court
J010	C017	Anjali Sharma	Sessions Court
J015	C018	Arjun Patel	District Court
J007	C019	Rahul Singh	High Court
J015	C020	Arjun Patel	Sessions Court
J016	C021	Arjun Joshi	Sessions Court
J013	C022	Arjun Das	High Court
J013	C023	Arjun Das	High Court
J006	C024	Anjali Nair	District Court
J004	C025	Rahul Das	District Court
J007	C026	Rahul Singh	High Court
J008	C027	Rahul Mehta	High Court
J004	C028	Rahul Das	High Court
J002	C029	Vikram Das	High Court
J014	C030	Rohit Sharma	Sessions Court
J003	C031	Amit Patel	Sessions Court
J007	C032	Rahul Singh	Sessions Court
J016	C033	Arjun Joshi	Sessions Court
J014	C034	Rohit Sharma	District Court
J013	C035	Arjun Das	High Court
J004	C036	Rahul Das	High Court
J016	C037	Arjun Joshi	Sessions Court
J014	C038	Rohit Sharma	Sessions Court
J007	C039	Rahul Singh	Sessions Court
J004	C040	Rahul Das	District Court
J010	C041	Anjali Sharma	High Court
J009	C042	Rohit Reddy	Sessions Court
J017	C043	Arjun Nair	District Court
J008	C044	Rahul Mehta	High Court
J018	C045	Vikram Mehta	High Court
J003	C046	Amit Patel	High Court
J010	C047	Anjali Sharma	Sessions Court
J009	C048	Rohit Reddy	High Court
J016	C049	Arjun Joshi	Sessions Court
J015	C050	Arjun Patel	High Court
J007	C051	Rahul Singh	High Court
J007	C052	Rahul Singh	Sessions Court
J001	C053	Neha Khan	District Court
J002	C054	Vikram Das	District Court
J002	C055	Vikram Das	District Court
J012	C056	Kavita Singh	Sessions Court
J005	C057	Sneha Joshi	District Court
J007	C058	Rahul Singh	District Court
J007	C059	Rahul Singh	Sessions Court
J010	C060	Anjali Sharma	Sessions Court
J009	C061	Rohit Reddy	District Court
J009	C062	Rohit Reddy	High Court
J011	C063	Arjun Khan	District Court
J008	C064	Rahul Mehta	High Court
J001	C065	Neha Khan	High Court
J009	C066	Rohit Reddy	High Court
J012	C067	Kavita Singh	High Court
J002	C068	Vikram Das	Sessions Court
J005	C069	Sneha Joshi	District Court
J003	C070	Amit Patel	Sessions Court
J016	C071	Arjun Joshi	District Court
J008	C072	Rahul Mehta	Sessions Court
J018	C073	Vikram Mehta	High Court
J008	C074	Rahul Mehta	District Court
J011	C075	Arjun Khan	High Court
J001	C076	Neha Khan	High Court
J002	C077	Vikram Das	High Court
J001	C078	Neha Khan	District Court
J001	C079	Neha Khan	District Court
J013	C080	Arjun Das	High Court
J008	C081	Rahul Mehta	District Court
J009	C082	Rohit Reddy	Sessions Court
J002	C083	Vikram Das	High Court
J005	C084	Sneha Joshi	High Court
J002	C085	Vikram Das	High Court
J007	C086	Rahul Singh	Sessions Court
J007	C087	Rahul Singh	High Court
J012	C088	Kavita Singh	High Court
J013	C089	Arjun Das	Sessions Court
J012	C090	Kavita Singh	High Court
J009	C091	Rohit Reddy	Sessions Court
J003	C092	Amit Patel	District Court
J017	C093	Arjun Nair	High Court
J006	C094	Anjali Nair	District Court
J005	C095	Sneha Joshi	Sessions Court
J002	C096	Vikram Das	District Court
J018	C097	Vikram Mehta	High Court
J011	C098	Arjun Khan	Sessions Court
J003	C099	Amit Patel	District Court
J002	C100	Vikram Das	Sessions Court
\.


--
-- TOC entry 4925 (class 0 OID 16477)
-- Dependencies: 220
-- Data for Name: caseofficer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.caseofficer (case_id, officer_id, role_in_case) FROM stdin;
C001	O091	Lead Investigator
C001	O020	Forensic Officer
C002	O024	Assistant Officer
C002	O031	Assistant Officer
C003	O014	Lead Investigator
C004	O052	Lead Investigator
C004	O066	Cyber Analyst
C005	O056	Lead Investigator
C006	O018	Field Officer
C006	O012	Forensic Officer
C007	O019	Forensic Officer
C007	O087	Field Officer
C007	O058	Field Officer
C008	O031	Assistant Officer
C008	O006	Forensic Officer
C009	O045	Forensic Officer
C009	O052	Cyber Analyst
C010	O017	Lead Investigator
C010	O067	Assistant Officer
C010	O006	Cyber Analyst
C011	O100	Assistant Officer
C011	O021	Assistant Officer
C012	O078	Field Officer
C012	O064	Forensic Officer
C012	O060	Field Officer
C013	O095	Lead Investigator
C013	O017	Cyber Analyst
C013	O052	Field Officer
C014	O006	Assistant Officer
C014	O056	Assistant Officer
C015	O037	Lead Investigator
C016	O087	Forensic Officer
C017	O052	Forensic Officer
C017	O003	Cyber Analyst
C017	O039	Assistant Officer
C018	O079	Assistant Officer
C018	O039	Lead Investigator
C018	O053	Forensic Officer
C019	O075	Lead Investigator
C019	O044	Field Officer
C020	O100	Forensic Officer
C020	O075	Forensic Officer
C021	O085	Cyber Analyst
C021	O007	Assistant Officer
C022	O094	Lead Investigator
C023	O012	Field Officer
C023	O080	Lead Investigator
C023	O038	Field Officer
C024	O061	Field Officer
C024	O088	Lead Investigator
C025	O063	Lead Investigator
C026	O092	Field Officer
C027	O092	Cyber Analyst
C027	O014	Assistant Officer
C028	O063	Assistant Officer
C028	O094	Lead Investigator
C029	O085	Field Officer
C030	O082	Field Officer
C030	O064	Cyber Analyst
C030	O049	Assistant Officer
C031	O081	Field Officer
C032	O073	Field Officer
C032	O042	Lead Investigator
C033	O028	Lead Investigator
C033	O087	Lead Investigator
C033	O082	Forensic Officer
C034	O012	Forensic Officer
C034	O090	Cyber Analyst
C035	O093	Cyber Analyst
C035	O080	Field Officer
C036	O098	Lead Investigator
C037	O063	Lead Investigator
C037	O057	Cyber Analyst
C037	O005	Lead Investigator
C038	O070	Field Officer
C038	O005	Field Officer
C038	O067	Lead Investigator
C039	O036	Forensic Officer
C039	O098	Lead Investigator
C040	O099	Lead Investigator
C040	O016	Field Officer
C040	O056	Assistant Officer
C041	O034	Field Officer
C041	O054	Forensic Officer
C042	O064	Field Officer
C043	O017	Lead Investigator
C043	O086	Forensic Officer
C043	O024	Cyber Analyst
C044	O004	Lead Investigator
C044	O098	Assistant Officer
C044	O039	Field Officer
C045	O041	Lead Investigator
C046	O032	Assistant Officer
C046	O037	Assistant Officer
C047	O096	Assistant Officer
C047	O051	Assistant Officer
C047	O078	Forensic Officer
C048	O013	Forensic Officer
C048	O057	Lead Investigator
C049	O025	Field Officer
C049	O066	Lead Investigator
C050	O067	Field Officer
C051	O035	Assistant Officer
C052	O073	Forensic Officer
C053	O069	Field Officer
C053	O097	Assistant Officer
C054	O079	Field Officer
C055	O009	Assistant Officer
C056	O032	Assistant Officer
C056	O077	Assistant Officer
C056	O018	Lead Investigator
C057	O010	Forensic Officer
C058	O055	Lead Investigator
C059	O028	Lead Investigator
C059	O077	Field Officer
C060	O054	Field Officer
C060	O023	Cyber Analyst
C061	O041	Assistant Officer
C061	O070	Forensic Officer
C062	O085	Field Officer
C063	O034	Assistant Officer
C063	O027	Cyber Analyst
C064	O082	Cyber Analyst
C065	O061	Lead Investigator
C065	O030	Forensic Officer
C066	O007	Assistant Officer
C066	O092	Field Officer
C066	O064	Field Officer
C067	O002	Assistant Officer
C067	O091	Assistant Officer
C068	O050	Field Officer
C068	O048	Lead Investigator
C069	O001	Cyber Analyst
C069	O042	Forensic Officer
C069	O084	Cyber Analyst
C070	O076	Cyber Analyst
C070	O012	Assistant Officer
C070	O021	Assistant Officer
C071	O073	Forensic Officer
C072	O070	Lead Investigator
C072	O045	Field Officer
C073	O052	Assistant Officer
C073	O014	Lead Investigator
C074	O029	Field Officer
C075	O040	Field Officer
C076	O038	Lead Investigator
C076	O072	Lead Investigator
C076	O010	Assistant Officer
C077	O017	Forensic Officer
C077	O039	Cyber Analyst
C078	O005	Forensic Officer
C078	O093	Field Officer
C079	O065	Forensic Officer
C079	O056	Cyber Analyst
C079	O040	Lead Investigator
C080	O060	Forensic Officer
C081	O017	Field Officer
C081	O094	Field Officer
C082	O095	Assistant Officer
C082	O034	Assistant Officer
C082	O011	Field Officer
C083	O039	Forensic Officer
C084	O009	Field Officer
C084	O089	Forensic Officer
C084	O037	Assistant Officer
C085	O086	Field Officer
C086	O049	Cyber Analyst
C087	O001	Field Officer
C088	O087	Field Officer
C088	O066	Lead Investigator
C088	O036	Forensic Officer
C089	O100	Lead Investigator
C090	O041	Cyber Analyst
C091	O086	Cyber Analyst
C091	O041	Assistant Officer
C091	O097	Field Officer
C092	O070	Assistant Officer
C093	O085	Assistant Officer
C093	O021	Lead Investigator
C093	O037	Cyber Analyst
C094	O053	Cyber Analyst
C095	O043	Forensic Officer
C095	O005	Forensic Officer
C096	O073	Field Officer
C096	O023	Cyber Analyst
C096	O019	Cyber Analyst
C097	O072	Forensic Officer
C097	O026	Cyber Analyst
C097	O003	Lead Investigator
C098	O027	Lead Investigator
C098	O098	Forensic Officer
C098	O088	Assistant Officer
C099	O085	Field Officer
C099	O082	Field Officer
C099	O069	Forensic Officer
C100	O095	Lead Investigator
C100	O009	Forensic Officer
\.


--
-- TOC entry 4926 (class 0 OID 16480)
-- Dependencies: 221
-- Data for Name: casesuspect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.casesuspect (suspect_id, case_id, name, dob, gender, criminal_history, suspicion_level, role_in_case) FROM stdin;
SUS001	C001	Anjali Das	1977-10-03	Male	Repeat offender	Low	Main Suspect
SUS002	C002	Rekha Gupta	1973-07-15	Female	First-time suspect	Low	Main Suspect
SUS003	C003	Pooja Nair	1970-08-25	Female	No prior record	High	Witness Turned Suspect
SUS004	C003	Suresh Gupta	1973-09-13	Female	Fraud investigation history	Low	Main Suspect
SUS005	C003	Sameer Singh	1985-04-04	Female	No prior record	Low	Witness Turned Suspect
SUS006	C004	Kavita Mehta	1985-08-29	Male	Repeat offender	Low	Accomplice
SUS007	C005	Simran Sharma	2003-06-23	Male	Repeat offender	High	Accomplice
SUS008	C005	Vikram Das	1970-12-26	Male	No prior record	Low	Accomplice
SUS009	C005	Pooja Patel	1984-05-20	Male	No prior record	High	Witness Turned Suspect
SUS010	C006	Nikhil Khan	1981-04-12	Male	Previous theft charges	Medium	Witness Turned Suspect
SUS011	C006	Imran Reddy	1978-09-15	Male	No prior record	Low	Main Suspect
SUS012	C006	Simran Das	1976-01-29	Male	Previous theft charges	Medium	Main Suspect
SUS013	C007	Anjali Sharma	1979-10-29	Female	Previous theft charges	Medium	Accomplice
SUS014	C007	Priya Joshi	1991-07-23	Female	Repeat offender	Medium	Accomplice
SUS015	C007	Nikhil Reddy	1989-10-03	Male	Repeat offender	Low	Accomplice
SUS016	C008	Anjali Joshi	1977-03-29	Male	Previous theft charges	Medium	Witness Turned Suspect
SUS017	C009	Sameer Singh	1992-08-17	Female	No prior record	Medium	Main Suspect
SUS018	C010	Rahul Joshi	1981-09-11	Male	Previous theft charges	High	Witness Turned Suspect
SUS019	C011	Arjun Nair	1970-03-17	Female	Repeat offender	High	Witness Turned Suspect
SUS020	C011	Kavita Das	2000-01-18	Male	No prior record	High	Witness Turned Suspect
SUS021	C011	Priya Joshi	1976-11-25	Male	Previous theft charges	Low	Main Suspect
SUS022	C012	Anjali Patel	1977-02-07	Male	Fraud investigation history	Medium	Main Suspect
SUS023	C012	Karan Nair	1971-07-25	Male	Repeat offender	Medium	Main Suspect
SUS024	C012	Nikhil Mehta	2003-09-28	Female	Fraud investigation history	Medium	Witness Turned Suspect
SUS025	C013	Imran Reddy	1974-02-24	Male	No prior record	Medium	Main Suspect
SUS026	C013	Nikhil Khan	1977-11-29	Female	First-time suspect	High	Accomplice
SUS027	C013	Riya Mehta	1973-02-04	Male	Previous theft charges	Medium	Accomplice
SUS028	C014	Rekha Gupta	1982-12-17	Female	Fraud investigation history	Low	Main Suspect
SUS029	C014	Sneha Sharma	1990-10-05	Male	Previous theft charges	High	Witness Turned Suspect
SUS030	C015	Suresh Sharma	1971-11-17	Male	Repeat offender	Low	Accomplice
SUS031	C015	Karan Patel	1989-03-14	Male	Previous theft charges	Low	Witness Turned Suspect
SUS032	C015	Anjali Joshi	1973-09-18	Female	Repeat offender	Medium	Main Suspect
SUS033	C016	Kavita Singh	1992-05-25	Female	Fraud investigation history	Medium	Witness Turned Suspect
SUS034	C017	Ayesha Nair	1986-04-05	Female	First-time suspect	Low	Main Suspect
SUS035	C017	Amit Gupta	1991-01-05	Female	No prior record	High	Main Suspect
SUS036	C018	Ayesha Joshi	2002-04-04	Female	No prior record	High	Accomplice
SUS037	C019	Rahul Nair	1979-09-02	Male	Repeat offender	Medium	Accomplice
SUS038	C019	Nikhil Das	1976-09-18	Female	Repeat offender	High	Accomplice
SUS039	C020	Rahul Singh	1991-12-06	Male	Fraud investigation history	High	Witness Turned Suspect
SUS040	C021	Priya Singh	1999-05-03	Female	No prior record	Medium	Accomplice
SUS041	C021	Pooja Sharma	2000-02-17	Male	Previous theft charges	Medium	Witness Turned Suspect
SUS042	C022	Nikhil Das	1983-11-14	Male	No prior record	Low	Main Suspect
SUS043	C022	Neha Gupta	1988-12-19	Female	Repeat offender	High	Accomplice
SUS044	C022	Priya Khan	1997-01-07	Female	Previous theft charges	Medium	Witness Turned Suspect
SUS045	C023	Imran Das	1973-05-16	Female	Fraud investigation history	Medium	Main Suspect
SUS046	C023	Nikhil Das	1997-04-11	Female	No prior record	Medium	Witness Turned Suspect
SUS047	C024	Anjali Das	1971-05-02	Female	First-time suspect	Low	Main Suspect
SUS048	C024	Simran Joshi	1994-01-07	Female	Previous theft charges	Medium	Accomplice
SUS049	C024	Pooja Sharma	1978-04-24	Female	Repeat offender	Low	Main Suspect
SUS050	C025	Sameer Mehta	2003-11-18	Male	Repeat offender	Low	Main Suspect
SUS051	C025	Karan Joshi	2003-10-20	Female	No prior record	Medium	Main Suspect
SUS052	C026	Riya Mehta	1978-12-16	Male	Previous theft charges	Medium	Main Suspect
SUS053	C027	Imran Singh	1996-11-28	Male	Repeat offender	Low	Main Suspect
SUS054	C027	Rekha Patel	1978-09-30	Male	Previous theft charges	High	Accomplice
SUS055	C028	Simran Sharma	1984-08-01	Female	Previous theft charges	Medium	Main Suspect
SUS056	C029	Riya Nair	1970-06-26	Male	Repeat offender	High	Witness Turned Suspect
SUS057	C029	Sameer Reddy	1995-07-21	Female	Repeat offender	High	Accomplice
SUS058	C029	Amit Das	1994-07-09	Female	Fraud investigation history	High	Witness Turned Suspect
SUS059	C030	Pooja Joshi	1972-01-17	Female	Fraud investigation history	High	Witness Turned Suspect
SUS060	C031	Kavita Khan	1981-09-24	Male	Previous theft charges	Medium	Witness Turned Suspect
SUS061	C031	Amit Mehta	1989-12-30	Female	No prior record	High	Witness Turned Suspect
SUS062	C032	Karan Reddy	1979-07-25	Female	First-time suspect	High	Witness Turned Suspect
SUS063	C032	Imran Khan	1986-07-10	Female	No prior record	High	Accomplice
SUS064	C032	Vikram Sharma	1985-04-08	Female	Previous theft charges	High	Main Suspect
SUS065	C033	Sameer Khan	2002-06-03	Female	Fraud investigation history	Low	Main Suspect
SUS066	C033	Pooja Khan	1979-05-20	Female	Repeat offender	Low	Witness Turned Suspect
SUS067	C034	Pooja Das	1989-11-05	Male	No prior record	Medium	Main Suspect
SUS068	C034	Sneha Reddy	1988-05-30	Male	Repeat offender	High	Main Suspect
SUS069	C034	Sameer Khan	1973-06-13	Female	First-time suspect	High	Witness Turned Suspect
SUS070	C035	Neha Das	1973-04-09	Male	Repeat offender	High	Witness Turned Suspect
SUS071	C036	Arjun Gupta	1994-12-21	Female	No prior record	Medium	Witness Turned Suspect
SUS072	C037	Riya Nair	1999-05-01	Male	Repeat offender	Low	Witness Turned Suspect
SUS073	C038	Imran Das	1973-04-22	Female	Fraud investigation history	Low	Main Suspect
SUS074	C038	Imran Joshi	2000-05-13	Male	No prior record	Low	Witness Turned Suspect
SUS075	C039	Nikhil Khan	1980-08-06	Male	First-time suspect	High	Main Suspect
SUS076	C040	Karan Gupta	2002-04-27	Male	First-time suspect	Low	Accomplice
SUS077	C040	Ayesha Joshi	1972-08-08	Male	Repeat offender	Low	Witness Turned Suspect
SUS078	C041	Priya Singh	1989-02-18	Female	Repeat offender	Low	Main Suspect
SUS079	C041	Anjali Nair	1983-10-13	Female	First-time suspect	Medium	Main Suspect
SUS080	C042	Neha Das	1974-06-20	Female	Previous theft charges	Low	Accomplice
SUS081	C043	Anjali Nair	1999-03-08	Male	Repeat offender	Medium	Witness Turned Suspect
SUS082	C043	Priya Khan	1982-12-20	Male	Repeat offender	High	Witness Turned Suspect
SUS083	C044	Riya Joshi	2001-04-16	Male	First-time suspect	Medium	Main Suspect
SUS084	C044	Simran Nair	1977-03-07	Male	Repeat offender	Low	Accomplice
SUS085	C044	Priya Khan	1976-06-26	Female	No prior record	High	Accomplice
SUS086	C045	Nikhil Khan	2002-04-08	Male	Fraud investigation history	High	Witness Turned Suspect
SUS087	C045	Kavita Patel	1984-04-11	Female	Previous theft charges	Low	Accomplice
SUS088	C045	Priya Khan	1993-09-20	Male	Fraud investigation history	High	Main Suspect
SUS089	C046	Suresh Patel	1976-12-20	Male	No prior record	Low	Witness Turned Suspect
SUS090	C046	Priya Mehta	1977-10-12	Male	First-time suspect	High	Witness Turned Suspect
SUS091	C046	Pooja Nair	1980-10-04	Female	No prior record	Low	Main Suspect
SUS092	C047	Neha Mehta	2003-02-10	Female	First-time suspect	Medium	Witness Turned Suspect
SUS093	C047	Vikram Gupta	1971-07-17	Male	Previous theft charges	Medium	Main Suspect
SUS094	C048	Pooja Patel	2003-01-18	Male	Fraud investigation history	Low	Main Suspect
SUS095	C048	Imran Patel	1983-02-05	Male	No prior record	Medium	Main Suspect
SUS096	C048	Karan Patel	1974-12-30	Male	No prior record	Medium	Witness Turned Suspect
SUS097	C049	Suresh Khan	1970-03-21	Male	Previous theft charges	Low	Main Suspect
SUS098	C049	Sameer Patel	1983-10-10	Male	First-time suspect	Low	Accomplice
SUS099	C049	Rohit Khan	2003-06-12	Male	Repeat offender	High	Witness Turned Suspect
SUS100	C050	Rekha Nair	1971-12-10	Female	Fraud investigation history	High	Main Suspect
SUS101	C050	Priya Das	1998-11-03	Male	Fraud investigation history	High	Main Suspect
SUS102	C051	Pooja Joshi	1983-08-09	Male	Fraud investigation history	Low	Witness Turned Suspect
SUS103	C051	Amit Mehta	1976-02-17	Female	Fraud investigation history	Medium	Main Suspect
SUS104	C051	Kavita Das	1974-12-29	Male	No prior record	Medium	Main Suspect
SUS105	C052	Rekha Patel	1982-07-09	Male	No prior record	Medium	Accomplice
SUS106	C052	Arjun Khan	1994-02-19	Female	Fraud investigation history	High	Accomplice
SUS107	C052	Simran Khan	1997-07-05	Female	First-time suspect	High	Accomplice
SUS108	C053	Vikram Patel	1992-09-14	Female	Previous theft charges	High	Accomplice
SUS109	C053	Imran Singh	1981-04-10	Female	First-time suspect	High	Main Suspect
SUS110	C053	Anjali Mehta	1976-09-10	Male	No prior record	High	Main Suspect
SUS111	C054	Sneha Khan	1974-12-24	Male	Fraud investigation history	High	Witness Turned Suspect
SUS112	C055	Rahul Das	2000-09-25	Male	Previous theft charges	Low	Accomplice
SUS113	C055	Suresh Khan	2003-02-19	Male	Fraud investigation history	Medium	Accomplice
SUS114	C056	Suresh Das	1998-06-29	Male	Fraud investigation history	Low	Witness Turned Suspect
SUS115	C057	Sameer Patel	1973-02-17	Female	Repeat offender	Medium	Main Suspect
SUS116	C057	Sameer Sharma	1981-01-27	Male	Previous theft charges	Low	Witness Turned Suspect
SUS117	C057	Priya Reddy	2003-06-14	Male	Previous theft charges	High	Accomplice
SUS118	C058	Arjun Mehta	1970-02-28	Male	Repeat offender	Low	Witness Turned Suspect
SUS119	C058	Riya Gupta	1972-12-22	Male	First-time suspect	High	Main Suspect
SUS120	C058	Kavita Sharma	1976-03-12	Male	No prior record	High	Main Suspect
SUS121	C059	Imran Nair	1988-03-25	Female	Fraud investigation history	Low	Witness Turned Suspect
SUS122	C059	Vikram Khan	1990-02-14	Female	Previous theft charges	Medium	Main Suspect
SUS123	C059	Rahul Khan	2003-04-17	Female	Repeat offender	Low	Witness Turned Suspect
SUS124	C060	Anjali Khan	1978-08-09	Male	First-time suspect	Medium	Accomplice
SUS125	C060	Rohit Das	1999-07-31	Male	No prior record	Low	Accomplice
SUS126	C060	Arjun Das	2002-07-18	Female	First-time suspect	Medium	Accomplice
SUS127	C061	Simran Reddy	1995-07-05	Female	First-time suspect	Low	Accomplice
SUS128	C061	Rekha Nair	1971-03-19	Male	First-time suspect	High	Main Suspect
SUS129	C062	Rohit Reddy	1986-05-16	Male	Previous theft charges	Medium	Accomplice
SUS130	C062	Imran Mehta	1975-07-04	Male	Repeat offender	Low	Main Suspect
SUS131	C063	Rahul Reddy	2002-07-29	Female	No prior record	High	Witness Turned Suspect
SUS132	C063	Rahul Sharma	1987-01-16	Male	No prior record	Medium	Witness Turned Suspect
SUS133	C064	Anjali Sharma	1974-11-21	Male	Repeat offender	High	Main Suspect
SUS134	C064	Rekha Reddy	1974-07-05	Female	First-time suspect	Low	Main Suspect
SUS135	C065	Karan Reddy	1997-07-03	Male	No prior record	High	Accomplice
SUS136	C065	Vikram Gupta	1978-04-20	Female	Repeat offender	Low	Accomplice
SUS137	C065	Pooja Joshi	2003-04-14	Male	No prior record	High	Witness Turned Suspect
SUS138	C066	Pooja Reddy	1989-01-31	Male	Previous theft charges	Medium	Witness Turned Suspect
SUS139	C067	Rekha Das	2003-09-01	Female	First-time suspect	Low	Witness Turned Suspect
SUS140	C067	Karan Mehta	1973-10-01	Male	No prior record	Low	Witness Turned Suspect
SUS141	C068	Imran Gupta	1973-04-07	Female	Fraud investigation history	Medium	Accomplice
SUS142	C068	Suresh Joshi	1970-09-22	Female	Repeat offender	Medium	Main Suspect
SUS143	C069	Anjali Das	1973-12-08	Female	No prior record	Medium	Main Suspect
SUS144	C069	Priya Reddy	1971-08-08	Female	First-time suspect	Low	Accomplice
SUS145	C070	Ayesha Das	1973-06-10	Female	Repeat offender	Low	Witness Turned Suspect
SUS146	C071	Sameer Khan	1975-03-23	Female	Repeat offender	High	Main Suspect
SUS147	C071	Rekha Reddy	1996-04-23	Female	Repeat offender	Medium	Accomplice
SUS148	C072	Rekha Das	1983-10-11	Male	Repeat offender	High	Witness Turned Suspect
SUS149	C073	Pooja Reddy	1984-02-18	Male	No prior record	Medium	Witness Turned Suspect
SUS150	C073	Suresh Singh	2003-09-30	Female	Previous theft charges	High	Main Suspect
SUS151	C074	Nikhil Nair	1977-05-13	Male	First-time suspect	High	Witness Turned Suspect
SUS152	C074	Priya Mehta	1970-07-15	Female	Fraud investigation history	Medium	Main Suspect
SUS153	C075	Vikram Mehta	1985-07-10	Female	Fraud investigation history	Medium	Accomplice
SUS154	C075	Neha Khan	1997-10-22	Female	Previous theft charges	High	Accomplice
SUS155	C076	Pooja Gupta	1995-01-24	Female	Fraud investigation history	High	Accomplice
SUS156	C076	Simran Patel	1978-08-02	Female	Repeat offender	High	Accomplice
SUS157	C076	Nikhil Reddy	2001-02-26	Male	Repeat offender	Medium	Main Suspect
SUS158	C077	Suresh Sharma	2002-08-05	Female	First-time suspect	High	Accomplice
SUS159	C078	Neha Joshi	1988-01-29	Female	Fraud investigation history	Low	Witness Turned Suspect
SUS160	C078	Amit Reddy	1973-08-31	Male	No prior record	High	Main Suspect
SUS161	C078	Rekha Mehta	1997-07-13	Male	Repeat offender	Low	Accomplice
SUS162	C079	Vikram Sharma	1984-05-24	Female	No prior record	High	Witness Turned Suspect
SUS163	C080	Arjun Reddy	1996-04-28	Male	No prior record	Low	Witness Turned Suspect
SUS164	C081	Rahul Singh	1988-09-26	Female	Previous theft charges	Medium	Accomplice
SUS165	C081	Imran Das	1978-05-05	Female	No prior record	Low	Witness Turned Suspect
SUS166	C081	Suresh Nair	1975-05-20	Female	First-time suspect	High	Accomplice
SUS167	C082	Priya Singh	1970-05-12	Female	Fraud investigation history	High	Witness Turned Suspect
SUS168	C082	Sameer Das	1992-12-26	Female	Fraud investigation history	High	Main Suspect
SUS169	C082	Pooja Patel	1991-04-13	Female	No prior record	Low	Accomplice
SUS170	C083	Nikhil Nair	1994-12-20	Male	Repeat offender	Low	Accomplice
SUS171	C083	Kavita Mehta	1990-07-24	Female	Previous theft charges	Low	Accomplice
SUS172	C083	Pooja Singh	1988-03-15	Female	Fraud investigation history	Low	Main Suspect
SUS173	C084	Anjali Gupta	1989-04-15	Female	Repeat offender	Low	Main Suspect
SUS174	C084	Arjun Reddy	1998-06-28	Female	Previous theft charges	High	Main Suspect
SUS175	C085	Karan Sharma	1996-11-10	Female	Repeat offender	Medium	Accomplice
SUS176	C085	Neha Singh	1992-08-04	Male	No prior record	High	Accomplice
SUS177	C085	Amit Reddy	1977-11-12	Male	Fraud investigation history	High	Main Suspect
SUS178	C086	Nikhil Patel	2002-10-04	Female	No prior record	Medium	Main Suspect
SUS179	C086	Karan Gupta	1980-09-03	Male	No prior record	Low	Accomplice
SUS180	C087	Rekha Sharma	1983-03-13	Male	Previous theft charges	Medium	Accomplice
SUS181	C087	Rekha Joshi	1992-01-31	Male	Repeat offender	Medium	Witness Turned Suspect
SUS182	C088	Suresh Nair	1972-05-13	Male	Fraud investigation history	Low	Main Suspect
SUS183	C089	Riya Mehta	1994-11-25	Female	First-time suspect	High	Main Suspect
SUS184	C090	Amit Khan	1982-11-26	Male	Previous theft charges	High	Witness Turned Suspect
SUS185	C091	Pooja Patel	1995-01-09	Female	First-time suspect	Medium	Witness Turned Suspect
SUS186	C092	Vikram Nair	1980-01-25	Male	Fraud investigation history	High	Accomplice
SUS187	C093	Simran Reddy	1973-03-26	Male	No prior record	Medium	Witness Turned Suspect
SUS188	C094	Pooja Singh	1982-03-30	Male	Previous theft charges	High	Witness Turned Suspect
SUS189	C094	Simran Patel	2002-07-13	Male	Fraud investigation history	High	Accomplice
SUS190	C095	Neha Nair	1979-08-21	Female	Previous theft charges	High	Accomplice
SUS191	C096	Rahul Mehta	1984-07-29	Female	Previous theft charges	High	Witness Turned Suspect
SUS192	C096	Rohit Joshi	1992-04-22	Female	Previous theft charges	High	Witness Turned Suspect
SUS193	C096	Pooja Das	1981-10-11	Female	Fraud investigation history	Low	Witness Turned Suspect
SUS194	C097	Rekha Mehta	1975-02-18	Male	Fraud investigation history	Medium	Main Suspect
SUS195	C098	Riya Patel	1971-02-22	Female	Previous theft charges	Low	Main Suspect
SUS196	C098	Simran Joshi	1991-01-12	Male	First-time suspect	Medium	Main Suspect
SUS197	C098	Rohit Das	1989-08-17	Male	First-time suspect	Medium	Accomplice
SUS198	C099	Neha Khan	1997-12-10	Male	Repeat offender	Low	Main Suspect
SUS199	C100	Anjali Das	1997-06-23	Male	Repeat offender	Medium	Accomplice
\.


--
-- TOC entry 4927 (class 0 OID 16485)
-- Dependencies: 222
-- Data for Name: clue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clue (clue_id, case_id, description, discovered_date, location) FROM stdin;
CL001	C001	Weapon recovered near location	2023-01-30	Main entrance
CL002	C001	Transaction records obtained	2025-07-16	Back alley
CL003	C002	Weapon recovered near location	2024-11-18	Street corner
CL004	C002	Broken glass fragments analyzed	2024-11-12	ATM booth
CL005	C003	CCTV footage capturing suspect movement	2026-03-07	Parking area
CL006	C003	Transaction records obtained	2024-06-12	Living room
CL007	C004	Suspicious email trail identified	2023-05-03	Back alley
CL008	C004	Weapon recovered near location	2025-07-11	Parking area
CL009	C004	Witness sketch prepared	2024-01-27	ATM booth
CL010	C005	Blood sample collected at scene	2025-01-17	ATM booth
CL011	C005	Suspicious email trail identified	2024-08-02	Server room
CL012	C005	Vehicle tire marks documented	2025-09-04	Office cabin
CL013	C006	Weapon recovered near location	2025-04-01	Warehouse
CL014	C006	Vehicle tire marks documented	2024-08-24	Warehouse
CL015	C006	Vehicle tire marks documented	2026-02-09	Parking area
CL016	C007	Suspicious email trail identified	2024-07-29	Parking area
CL017	C007	CCTV footage capturing suspect movement	2023-04-07	Warehouse
CL018	C008	Transaction records obtained	2024-06-26	Main entrance
CL019	C008	Transaction records obtained	2024-02-25	ATM booth
CL020	C008	Witness sketch prepared	2023-06-06	Server room
CL021	C009	Witness sketch prepared	2025-04-02	Server room
CL022	C009	Vehicle tire marks documented	2023-05-01	Living room
CL023	C010	CCTV footage capturing suspect movement	2025-04-30	Street corner
CL024	C010	Fingerprint lifted from door handle	2025-09-28	Warehouse
CL025	C010	Vehicle tire marks documented	2023-07-22	ATM booth
CL026	C011	Weapon recovered near location	2023-03-28	Office cabin
CL027	C011	Broken glass fragments analyzed	2025-04-08	Street corner
CL028	C011	Fingerprint lifted from door handle	2025-03-17	Living room
CL029	C012	Suspicious email trail identified	2025-12-21	ATM booth
CL030	C012	Mobile phone data extracted	2023-01-13	Living room
CL031	C013	Weapon recovered near location	2024-12-01	Office cabin
CL032	C013	Vehicle tire marks documented	2024-05-26	Shopping mall
CL033	C014	Witness sketch prepared	2023-09-20	Main entrance
CL034	C014	Blood sample collected at scene	2025-08-09	Office cabin
CL035	C014	Transaction records obtained	2024-08-09	Street corner
CL036	C015	Fingerprint lifted from door handle	2025-08-01	Parking area
CL037	C015	Witness sketch prepared	2024-11-12	Shopping mall
CL038	C015	Transaction records obtained	2023-08-27	Shopping mall
CL039	C016	Suspicious email trail identified	2025-11-20	Shopping mall
CL040	C016	Broken glass fragments analyzed	2023-01-07	ATM booth
CL041	C016	Weapon recovered near location	2026-02-24	Warehouse
CL042	C017	Witness sketch prepared	2024-11-30	Street corner
CL043	C017	CCTV footage capturing suspect movement	2026-02-06	Street corner
CL044	C017	Weapon recovered near location	2024-07-30	Server room
CL045	C018	Suspicious email trail identified	2024-05-05	Living room
CL046	C018	Mobile phone data extracted	2023-04-03	ATM booth
CL047	C018	Fingerprint lifted from door handle	2023-02-19	Street corner
CL048	C019	Broken glass fragments analyzed	2024-05-11	Main entrance
CL049	C019	Weapon recovered near location	2023-09-01	Warehouse
CL050	C020	Transaction records obtained	2024-05-05	Street corner
CL051	C020	Transaction records obtained	2024-04-19	ATM booth
CL052	C021	CCTV footage capturing suspect movement	2024-04-21	Back alley
CL053	C021	Fingerprint lifted from door handle	2024-09-02	Parking area
CL054	C021	Fingerprint lifted from door handle	2023-01-02	Main entrance
CL055	C022	Weapon recovered near location	2025-05-17	Warehouse
CL056	C022	Suspicious email trail identified	2023-06-13	Office cabin
CL057	C022	Witness sketch prepared	2023-12-28	Office cabin
CL058	C023	Witness sketch prepared	2025-06-30	Parking area
CL059	C023	CCTV footage capturing suspect movement	2024-11-25	Parking area
CL060	C024	Fingerprint lifted from door handle	2024-10-04	Server room
CL061	C024	Vehicle tire marks documented	2026-03-28	ATM booth
CL062	C025	Transaction records obtained	2025-11-20	Back alley
CL063	C025	Weapon recovered near location	2025-04-06	Parking area
CL064	C025	Vehicle tire marks documented	2025-11-14	Street corner
CL065	C026	Suspicious email trail identified	2024-11-28	Parking area
CL066	C026	Broken glass fragments analyzed	2025-03-07	Office cabin
CL067	C027	Witness sketch prepared	2026-01-18	Shopping mall
CL068	C027	Broken glass fragments analyzed	2025-05-25	Street corner
CL069	C027	Transaction records obtained	2024-12-31	Parking area
CL070	C028	Witness sketch prepared	2023-05-21	ATM booth
CL071	C028	Mobile phone data extracted	2024-05-30	Server room
CL072	C029	Vehicle tire marks documented	2024-09-04	Back alley
CL073	C029	Blood sample collected at scene	2025-10-19	Server room
CL074	C030	Fingerprint lifted from door handle	2023-06-12	Server room
CL075	C030	Suspicious email trail identified	2023-02-18	Office cabin
CL076	C030	Suspicious email trail identified	2023-02-21	Back alley
CL077	C031	Suspicious email trail identified	2025-12-22	ATM booth
CL078	C031	Blood sample collected at scene	2024-02-06	Warehouse
CL079	C032	Mobile phone data extracted	2023-08-18	Parking area
CL080	C032	Vehicle tire marks documented	2025-12-19	Main entrance
CL081	C032	Blood sample collected at scene	2024-10-27	Office cabin
CL082	C033	Suspicious email trail identified	2023-05-11	Back alley
CL083	C033	Vehicle tire marks documented	2025-10-24	Office cabin
CL084	C034	Transaction records obtained	2026-01-01	Main entrance
CL085	C034	Mobile phone data extracted	2023-03-09	Warehouse
CL086	C035	Vehicle tire marks documented	2025-05-15	Living room
CL087	C035	Broken glass fragments analyzed	2023-03-06	Back alley
CL088	C035	Transaction records obtained	2025-05-13	Server room
CL089	C036	Witness sketch prepared	2023-06-25	Warehouse
CL090	C036	Transaction records obtained	2025-11-12	Living room
CL091	C037	Weapon recovered near location	2023-01-31	Office cabin
CL092	C037	Fingerprint lifted from door handle	2024-01-21	Shopping mall
CL093	C038	Fingerprint lifted from door handle	2024-10-29	Server room
CL094	C038	Broken glass fragments analyzed	2023-09-15	Main entrance
CL095	C039	Witness sketch prepared	2023-03-29	Office cabin
CL096	C039	Mobile phone data extracted	2024-12-02	Server room
CL097	C040	Mobile phone data extracted	2025-10-23	Back alley
CL098	C040	Vehicle tire marks documented	2026-03-21	ATM booth
CL099	C041	Blood sample collected at scene	2023-02-28	Parking area
CL100	C041	Broken glass fragments analyzed	2024-07-11	Parking area
CL101	C041	Suspicious email trail identified	2025-11-30	ATM booth
CL102	C042	CCTV footage capturing suspect movement	2025-11-26	ATM booth
CL103	C042	Blood sample collected at scene	2024-05-14	ATM booth
CL104	C043	Witness sketch prepared	2023-07-21	ATM booth
CL105	C043	Transaction records obtained	2026-02-07	Street corner
CL106	C044	Witness sketch prepared	2023-08-08	Back alley
CL107	C044	CCTV footage capturing suspect movement	2026-03-21	Back alley
CL108	C044	Mobile phone data extracted	2023-04-04	Office cabin
CL109	C045	Witness sketch prepared	2026-01-17	ATM booth
CL110	C045	Fingerprint lifted from door handle	2024-11-24	Server room
CL111	C046	Mobile phone data extracted	2025-09-09	Parking area
CL112	C046	Vehicle tire marks documented	2023-02-28	ATM booth
CL113	C047	CCTV footage capturing suspect movement	2023-11-25	Office cabin
CL114	C047	Witness sketch prepared	2024-03-08	Server room
CL115	C048	Mobile phone data extracted	2024-07-12	Office cabin
CL116	C048	Blood sample collected at scene	2025-04-26	Parking area
CL117	C049	Transaction records obtained	2023-02-08	Shopping mall
CL118	C049	Blood sample collected at scene	2026-03-05	Server room
CL119	C050	Vehicle tire marks documented	2025-01-26	Server room
CL120	C050	Blood sample collected at scene	2025-04-01	Shopping mall
CL121	C050	Fingerprint lifted from door handle	2024-01-20	ATM booth
CL122	C051	Broken glass fragments analyzed	2026-02-23	Parking area
CL123	C051	Broken glass fragments analyzed	2024-11-29	Back alley
CL124	C052	Mobile phone data extracted	2025-01-13	Back alley
CL125	C052	Suspicious email trail identified	2023-07-08	Living room
CL126	C053	CCTV footage capturing suspect movement	2023-02-04	Shopping mall
CL127	C053	Broken glass fragments analyzed	2025-01-22	Warehouse
CL128	C054	Blood sample collected at scene	2023-09-16	Shopping mall
CL129	C054	Weapon recovered near location	2024-05-17	Server room
CL130	C054	Fingerprint lifted from door handle	2024-06-08	Warehouse
CL131	C055	Broken glass fragments analyzed	2024-07-28	Office cabin
CL132	C055	CCTV footage capturing suspect movement	2023-11-02	Living room
CL133	C055	Mobile phone data extracted	2024-09-25	Main entrance
CL134	C056	Broken glass fragments analyzed	2023-06-27	ATM booth
CL135	C056	Transaction records obtained	2024-05-29	ATM booth
CL136	C056	CCTV footage capturing suspect movement	2025-07-23	Shopping mall
CL137	C057	Broken glass fragments analyzed	2024-02-28	Shopping mall
CL138	C057	Weapon recovered near location	2025-09-06	Living room
CL139	C057	Witness sketch prepared	2024-12-26	Shopping mall
CL140	C058	Vehicle tire marks documented	2024-03-03	Parking area
CL141	C058	Blood sample collected at scene	2023-12-02	Server room
CL142	C058	CCTV footage capturing suspect movement	2026-03-26	ATM booth
CL143	C059	Vehicle tire marks documented	2025-01-18	Parking area
CL144	C059	Fingerprint lifted from door handle	2023-07-14	Main entrance
CL145	C060	Broken glass fragments analyzed	2024-01-17	Main entrance
CL146	C060	Mobile phone data extracted	2024-01-29	Living room
CL147	C060	Blood sample collected at scene	2024-08-27	Street corner
CL148	C061	Weapon recovered near location	2025-12-07	Server room
CL149	C061	CCTV footage capturing suspect movement	2023-01-19	Shopping mall
CL150	C062	Vehicle tire marks documented	2025-11-29	Living room
CL151	C062	Fingerprint lifted from door handle	2023-04-26	Warehouse
CL152	C063	Broken glass fragments analyzed	2025-12-16	Street corner
CL153	C063	Weapon recovered near location	2023-02-11	ATM booth
CL154	C064	Fingerprint lifted from door handle	2025-05-14	ATM booth
CL155	C064	Mobile phone data extracted	2023-04-16	Warehouse
CL156	C065	Witness sketch prepared	2025-03-21	Main entrance
CL157	C065	CCTV footage capturing suspect movement	2024-11-10	Street corner
CL158	C066	CCTV footage capturing suspect movement	2025-11-03	Warehouse
CL159	C066	Suspicious email trail identified	2025-07-03	Living room
CL160	C066	Broken glass fragments analyzed	2025-04-03	Server room
CL161	C067	Witness sketch prepared	2023-01-19	Office cabin
CL162	C067	Blood sample collected at scene	2024-04-23	Parking area
CL163	C067	Mobile phone data extracted	2024-03-21	Main entrance
CL164	C068	Witness sketch prepared	2025-10-27	Street corner
CL165	C068	Transaction records obtained	2024-10-09	Warehouse
CL166	C069	CCTV footage capturing suspect movement	2026-03-22	Back alley
CL167	C069	Broken glass fragments analyzed	2026-02-16	Living room
CL168	C069	Suspicious email trail identified	2024-01-25	Living room
CL169	C070	Weapon recovered near location	2023-12-10	Office cabin
CL170	C070	Mobile phone data extracted	2025-03-20	Parking area
CL171	C071	Transaction records obtained	2024-04-23	Main entrance
CL172	C071	CCTV footage capturing suspect movement	2025-11-04	Main entrance
CL173	C072	Mobile phone data extracted	2024-10-11	Back alley
CL174	C072	Mobile phone data extracted	2023-02-02	Street corner
CL175	C073	Suspicious email trail identified	2023-05-08	Shopping mall
CL176	C073	Mobile phone data extracted	2025-01-18	Parking area
CL177	C073	Blood sample collected at scene	2025-05-26	Living room
CL178	C074	Vehicle tire marks documented	2024-07-26	Shopping mall
CL179	C074	Vehicle tire marks documented	2023-07-09	ATM booth
CL180	C074	Broken glass fragments analyzed	2025-05-19	Back alley
CL181	C075	Vehicle tire marks documented	2023-01-07	ATM booth
CL182	C075	Suspicious email trail identified	2024-10-18	Parking area
CL183	C076	CCTV footage capturing suspect movement	2026-02-17	Parking area
CL184	C076	Blood sample collected at scene	2024-06-15	Main entrance
CL185	C076	Weapon recovered near location	2023-10-18	Shopping mall
CL186	C077	Broken glass fragments analyzed	2023-03-10	Office cabin
CL187	C077	Witness sketch prepared	2023-09-16	Server room
CL188	C077	Fingerprint lifted from door handle	2025-03-26	Street corner
CL189	C078	Mobile phone data extracted	2023-02-05	Warehouse
CL190	C078	Mobile phone data extracted	2023-05-12	Warehouse
CL191	C079	Witness sketch prepared	2023-10-26	Back alley
CL192	C079	Weapon recovered near location	2024-09-14	Shopping mall
CL193	C080	Transaction records obtained	2023-02-12	Living room
CL194	C080	Blood sample collected at scene	2024-07-14	Parking area
CL195	C080	Witness sketch prepared	2024-11-12	Street corner
CL196	C081	Witness sketch prepared	2025-04-25	Main entrance
CL197	C081	Witness sketch prepared	2023-03-22	Shopping mall
CL198	C081	Witness sketch prepared	2024-06-17	Main entrance
CL199	C082	Broken glass fragments analyzed	2024-09-08	Server room
CL200	C082	Fingerprint lifted from door handle	2023-03-23	Back alley
CL201	C083	Vehicle tire marks documented	2023-05-13	Warehouse
CL202	C083	Mobile phone data extracted	2024-08-18	Server room
CL203	C083	Blood sample collected at scene	2025-01-22	Server room
CL204	C084	Fingerprint lifted from door handle	2023-03-21	Main entrance
CL205	C084	Suspicious email trail identified	2024-08-14	Parking area
CL206	C084	Suspicious email trail identified	2024-06-06	Office cabin
CL207	C085	Transaction records obtained	2024-05-18	Server room
CL208	C085	Suspicious email trail identified	2023-09-23	Shopping mall
CL209	C085	Fingerprint lifted from door handle	2023-06-28	Office cabin
CL210	C086	Broken glass fragments analyzed	2024-05-06	Street corner
CL211	C086	Fingerprint lifted from door handle	2023-11-24	Server room
CL212	C086	CCTV footage capturing suspect movement	2025-06-26	Street corner
CL213	C087	CCTV footage capturing suspect movement	2025-06-06	Shopping mall
CL214	C087	Transaction records obtained	2023-06-22	Back alley
CL215	C087	Mobile phone data extracted	2023-10-16	Office cabin
CL216	C088	Broken glass fragments analyzed	2024-07-25	Street corner
CL217	C088	CCTV footage capturing suspect movement	2026-03-18	Street corner
CL218	C089	Mobile phone data extracted	2023-09-29	Street corner
CL219	C089	Transaction records obtained	2023-04-13	ATM booth
CL220	C090	Mobile phone data extracted	2023-08-02	Main entrance
CL221	C090	CCTV footage capturing suspect movement	2025-07-26	Parking area
CL222	C090	Fingerprint lifted from door handle	2024-07-26	Shopping mall
CL223	C091	Broken glass fragments analyzed	2023-03-02	Warehouse
CL224	C091	Weapon recovered near location	2024-07-16	Parking area
CL225	C091	Suspicious email trail identified	2025-09-12	Street corner
CL226	C092	Blood sample collected at scene	2023-11-04	Warehouse
CL227	C092	Weapon recovered near location	2024-07-01	ATM booth
CL228	C092	Mobile phone data extracted	2023-03-29	Office cabin
CL229	C093	Blood sample collected at scene	2025-11-22	Street corner
CL230	C093	Fingerprint lifted from door handle	2025-03-06	Living room
CL231	C094	Suspicious email trail identified	2024-10-19	Street corner
CL232	C094	CCTV footage capturing suspect movement	2024-11-04	Office cabin
CL233	C095	Weapon recovered near location	2024-04-17	Shopping mall
CL234	C095	Weapon recovered near location	2025-02-05	ATM booth
CL235	C095	Mobile phone data extracted	2026-03-16	Street corner
CL236	C096	Broken glass fragments analyzed	2025-07-26	Back alley
CL237	C096	Blood sample collected at scene	2025-09-08	Warehouse
CL238	C097	Transaction records obtained	2025-01-08	Back alley
CL239	C097	Blood sample collected at scene	2025-08-07	Street corner
CL240	C097	CCTV footage capturing suspect movement	2024-04-20	Main entrance
CL241	C098	Transaction records obtained	2023-09-22	Main entrance
CL242	C098	Transaction records obtained	2025-04-30	Parking area
CL243	C098	Broken glass fragments analyzed	2023-10-29	Living room
CL244	C099	Mobile phone data extracted	2026-01-16	Street corner
CL245	C099	Witness sketch prepared	2025-07-20	Warehouse
CL246	C100	Transaction records obtained	2023-04-28	Main entrance
CL247	C100	Mobile phone data extracted	2023-10-12	Living room
\.


--
-- TOC entry 4924 (class 0 OID 16472)
-- Dependencies: 219
-- Data for Name: crimescene; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crimescene (scene_id, case_id, address, city, date_reported, description) FROM stdin;
S001	C001	118, College Road	Visakhapatnam	2023-01-30	Crime scene secured with perimeter established and evidence markers placed.
S002	C002	83, Market Road	Kolkata	2026-02-14	Crime scene secured with perimeter established and evidence markers placed.
S003	C003	5, Market Road	Hyderabad	2025-06-26	Evidence collected including physical traces and digital records.
S004	C004	53, Station Road	Surat	2025-01-18	Crime scene secured with perimeter established and evidence markers placed.
S005	C005	258, Market Road	Coimbatore	2024-10-17	Area sealed off and preliminary analysis completed by officers.
S006	C006	18, Link Road	Chennai	2026-01-08	Scene examined for CCTV footage and witness statements recorded.
S007	C007	204, Airport Road	Ahmedabad	2023-03-04	Scene examined for CCTV footage and witness statements recorded.
S008	C008	275, Ring Road	Pune	2026-02-10	Area sealed off and preliminary analysis completed by officers.
S009	C009	153, Market Road	Lucknow	2024-06-23	Witnesses interviewed and scene documented thoroughly.
S010	C010	132, Ring Road	Visakhapatnam	2023-05-06	Area sealed off and preliminary analysis completed by officers.
S011	C011	70, College Road	Bengaluru	2026-02-20	Forensic experts gathered biological and material samples.
S012	C012	175, Ring Road	Vadodara	2023-08-08	Forensic experts gathered biological and material samples.
S013	C013	36, College Road	Pune	2023-03-21	Area sealed off and preliminary analysis completed by officers.
S014	C014	124, College Road	Kolkata	2026-03-18	Investigation team analyzed entry and exit points at location.
S015	C015	212, Ring Road	Nagpur	2025-03-07	Witnesses interviewed and scene documented thoroughly.
S016	C016	40, Ring Road	Ahmedabad	2025-09-04	Crime location documented with photographs and sketches.
S017	C017	265, Ring Road	Delhi	2023-04-17	Crime location documented with photographs and sketches.
S018	C018	61, MG Road	Lucknow	2024-05-21	Area sealed off and preliminary analysis completed by officers.
S019	C019	196, MG Road	Kolkata	2024-09-03	Witnesses interviewed and scene documented thoroughly.
S020	C020	80, Market Road	Kolkata	2023-03-04	Area sealed off and preliminary analysis completed by officers.
S021	C021	88, Park Street	Hyderabad	2023-11-20	Crime location documented with photographs and sketches.
S022	C022	291, College Road	Nagpur	2025-08-09	Forensic experts gathered biological and material samples.
S023	C023	247, Link Road	Patna	2024-01-28	Initial forensic survey conducted, fingerprints and samples collected.
S024	C024	285, College Road	Hyderabad	2025-10-18	Investigation team analyzed entry and exit points at location.
S025	C025	105, MG Road	Chandigarh	2025-12-10	Forensic experts gathered biological and material samples.
S026	C026	218, Market Road	Bengaluru	2025-03-05	Crime scene secured with perimeter established and evidence markers placed.
S027	C027	69, College Road	Hyderabad	2023-07-28	Evidence collected including physical traces and digital records.
S028	C028	104, Link Road	Indore	2023-07-30	Witnesses interviewed and scene documented thoroughly.
S029	C029	142, Park Street	Bengaluru	2025-10-25	Witnesses interviewed and scene documented thoroughly.
S030	C030	51, Market Road	Bengaluru	2025-01-16	Crime scene secured with perimeter established and evidence markers placed.
S031	C031	202, College Road	Bhopal	2024-01-25	Detailed investigation carried out with forensic team assistance.
S032	C032	183, College Road	Lucknow	2025-11-15	Crime location documented with photographs and sketches.
S033	C033	135, Park Street	Pune	2023-04-24	Initial forensic survey conducted, fingerprints and samples collected.
S034	C034	283, Station Road	Mumbai	2025-01-18	Scene examined for CCTV footage and witness statements recorded.
S035	C035	110, College Road	Patna	2025-01-18	Area sealed off and preliminary analysis completed by officers.
S036	C036	109, College Road	Delhi	2024-07-12	Witnesses interviewed and scene documented thoroughly.
S037	C037	167, Airport Road	Kolkata	2023-09-03	Evidence collected including physical traces and digital records.
S038	C038	199, Ring Road	Hyderabad	2024-12-19	Detailed investigation carried out with forensic team assistance.
S039	C039	242, Link Road	Indore	2023-05-05	Area sealed off and preliminary analysis completed by officers.
S040	C040	35, College Road	Chennai	2024-03-14	Investigation team analyzed entry and exit points at location.
S041	C041	249, Market Road	Delhi	2024-07-11	Crime location documented with photographs and sketches.
S042	C042	156, Link Road	Jaipur	2024-11-24	Crime location documented with photographs and sketches.
S043	C043	27, Station Road	Vadodara	2023-07-03	Forensic experts gathered biological and material samples.
S044	C044	178, Airport Road	Pune	2024-02-23	Witnesses interviewed and scene documented thoroughly.
S045	C045	45, Station Road	Kolkata	2025-10-05	Crime scene secured with perimeter established and evidence markers placed.
S046	C046	188, Link Road	Bhopal	2024-01-04	Witnesses interviewed and scene documented thoroughly.
S047	C047	21, Ring Road	Bengaluru	2026-01-02	Detailed investigation carried out with forensic team assistance.
S048	C048	148, Link Road	Patna	2023-11-13	Scene examined for CCTV footage and witness statements recorded.
S049	C049	264, Ring Road	Chandigarh	2024-03-21	Crime scene secured with perimeter established and evidence markers placed.
S050	C050	128, Ring Road	Coimbatore	2023-08-04	Evidence collected including physical traces and digital records.
S051	C051	219, MG Road	Bhopal	2023-05-30	Forensic experts gathered biological and material samples.
S052	C052	178, Station Road	Indore	2023-07-18	Area sealed off and preliminary analysis completed by officers.
S053	C053	148, Ring Road	Ahmedabad	2024-11-26	Initial forensic survey conducted, fingerprints and samples collected.
S054	C054	210, College Road	Pune	2024-04-25	Detailed investigation carried out with forensic team assistance.
S055	C055	300, College Road	Bengaluru	2025-01-25	Evidence collected including physical traces and digital records.
S056	C056	219, Market Road	Kolkata	2023-05-27	Area sealed off and preliminary analysis completed by officers.
S057	C057	145, Link Road	Jaipur	2023-10-28	Crime location documented with photographs and sketches.
S058	C058	1, Airport Road	Delhi	2025-02-14	Witnesses interviewed and scene documented thoroughly.
S059	C059	65, Park Street	Nagpur	2024-06-06	Crime location documented with photographs and sketches.
S060	C060	194, College Road	Kolkata	2026-03-30	Detailed investigation carried out with forensic team assistance.
S061	C061	233, College Road	Coimbatore	2025-12-08	Investigation team analyzed entry and exit points at location.
S062	C062	285, Market Road	Chennai	2025-09-15	Detailed investigation carried out with forensic team assistance.
S063	C063	219, Station Road	Vadodara	2024-05-16	Evidence collected including physical traces and digital records.
S064	C064	5, College Road	Hyderabad	2025-02-18	Witnesses interviewed and scene documented thoroughly.
S065	C065	85, MG Road	Mumbai	2025-02-12	Witnesses interviewed and scene documented thoroughly.
S066	C066	251, Park Street	Lucknow	2023-07-03	Crime scene secured with perimeter established and evidence markers placed.
S067	C067	40, Market Road	Bengaluru	2024-12-25	Forensic experts gathered biological and material samples.
S068	C068	274, Market Road	Vadodara	2025-10-28	Evidence collected including physical traces and digital records.
S069	C069	226, Link Road	Kochi	2024-12-18	Crime location documented with photographs and sketches.
S070	C070	190, Airport Road	Chennai	2023-04-07	Witnesses interviewed and scene documented thoroughly.
S071	C071	293, Link Road	Surat	2025-01-15	Scene examined for CCTV footage and witness statements recorded.
S072	C072	3, College Road	Jaipur	2025-01-15	Scene examined for CCTV footage and witness statements recorded.
S073	C073	159, College Road	Kolkata	2024-02-21	Crime location documented with photographs and sketches.
S074	C074	3, Airport Road	Surat	2023-12-12	Initial forensic survey conducted, fingerprints and samples collected.
S075	C075	221, Station Road	Ahmedabad	2024-05-08	Evidence collected including physical traces and digital records.
S076	C076	36, Station Road	Pune	2025-08-09	Initial forensic survey conducted, fingerprints and samples collected.
S077	C077	97, MG Road	Ahmedabad	2025-12-10	Scene examined for CCTV footage and witness statements recorded.
S078	C078	236, Park Street	Coimbatore	2023-10-17	Scene examined for CCTV footage and witness statements recorded.
S079	C079	284, Station Road	Bhopal	2025-11-03	Witnesses interviewed and scene documented thoroughly.
S080	C080	131, Airport Road	Indore	2023-06-03	Scene examined for CCTV footage and witness statements recorded.
S081	C081	216, Ring Road	Mumbai	2025-01-21	Investigation team analyzed entry and exit points at location.
S082	C082	292, Airport Road	Chandigarh	2023-11-26	Forensic experts gathered biological and material samples.
S083	C083	28, MG Road	Vadodara	2025-06-21	Area sealed off and preliminary analysis completed by officers.
S084	C084	278, Link Road	Coimbatore	2025-08-16	Forensic experts gathered biological and material samples.
S085	C085	257, Station Road	Bengaluru	2025-06-30	Witnesses interviewed and scene documented thoroughly.
S086	C086	226, College Road	Kolkata	2026-01-31	Detailed investigation carried out with forensic team assistance.
S087	C087	65, Park Street	Lucknow	2025-01-10	Evidence collected including physical traces and digital records.
S088	C088	267, Link Road	Delhi	2026-02-19	Investigation team analyzed entry and exit points at location.
S089	C089	179, Airport Road	Indore	2024-12-18	Forensic experts gathered biological and material samples.
S090	C090	46, Park Street	Vadodara	2025-07-03	Area sealed off and preliminary analysis completed by officers.
S091	C091	153, Station Road	Chandigarh	2024-10-16	Forensic experts gathered biological and material samples.
S092	C092	85, Park Street	Lucknow	2025-09-10	Evidence collected including physical traces and digital records.
S093	C093	18, Airport Road	Nagpur	2026-02-01	Investigation team analyzed entry and exit points at location.
S094	C094	2, Airport Road	Indore	2025-04-27	Witnesses interviewed and scene documented thoroughly.
S095	C095	260, Market Road	Vadodara	2025-09-09	Investigation team analyzed entry and exit points at location.
S096	C096	94, Link Road	Surat	2025-01-25	Crime location documented with photographs and sketches.
S097	C097	78, Airport Road	Jaipur	2023-07-01	Scene examined for CCTV footage and witness statements recorded.
S098	C098	13, College Road	Chennai	2025-03-11	Investigation team analyzed entry and exit points at location.
S099	C099	198, Ring Road	Kolkata	2023-07-20	Forensic experts gathered biological and material samples.
S100	C100	13, College Road	Jaipur	2024-06-25	Crime location documented with photographs and sketches.
\.


--
-- TOC entry 4928 (class 0 OID 16490)
-- Dependencies: 223
-- Data for Name: evidence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evidence (evidence_id, case_id, type, description, storage_location) FROM stdin;
E001	C001	Documentary	Photographic evidence recorded	Evidence Room 2
E002	C001	Biological	DNA sample preserved	Evidence Room 2
E003	C002	Physical	Weapon sealed as evidence	Forensic Lab
E004	C002	Documentary	DNA sample preserved	Locker B
E005	C003	Documentary	Weapon sealed as evidence	Locker C
E006	C003	Physical	Glass fragments collected	Locker D
E007	C004	Biological	Weapon sealed as evidence	Locker D
E008	C004	Documentary	Weapon sealed as evidence	Evidence Room 1
E009	C005	Physical	Weapon sealed as evidence	Locker D
E010	C005	Biological	Financial transaction logs archived	Locker C
E011	C006	Physical	Blood sample secured	Locker B
E012	C006	Physical	DNA sample preserved	Evidence Room 2
E013	C007	Physical	Weapon sealed as evidence	Forensic Lab
E014	C007	Physical	DNA sample preserved	Locker D
E015	C008	Digital	DNA sample preserved	Evidence Room 2
E016	C008	Biological	DNA sample preserved	Locker D
E017	C009	Biological	Weapon sealed as evidence	Locker B
E018	C009	Biological	Mobile data extracted and stored	Evidence Room 2
E019	C010	Digital	Fingerprint sample preserved	Locker C
E020	C010	Biological	CCTV recording stored	Locker C
E021	C011	Documentary	Fingerprint sample preserved	Forensic Lab
E022	C011	Documentary	Glass fragments collected	Locker B
E023	C012	Documentary	Email records documented	Locker B
E024	C012	Digital	DNA sample preserved	Locker B
E025	C013	Physical	Weapon sealed as evidence	Locker B
E026	C013	Physical	Financial transaction logs archived	Evidence Room 2
E027	C014	Physical	Fingerprint sample preserved	Locker A
E028	C014	Digital	Financial transaction logs archived	Evidence Room 1
E029	C015	Physical	Photographic evidence recorded	Locker C
E030	C015	Documentary	CCTV recording stored	Forensic Lab
E031	C016	Documentary	Glass fragments collected	Locker C
E032	C016	Physical	Blood sample secured	Forensic Lab
E033	C017	Digital	Blood sample secured	Locker A
E034	C017	Physical	Weapon sealed as evidence	Forensic Lab
E035	C018	Digital	Photographic evidence recorded	Evidence Room 1
E036	C018	Biological	Fingerprint sample preserved	Evidence Room 2
E037	C019	Digital	Glass fragments collected	Evidence Room 1
E038	C019	Biological	Weapon sealed as evidence	Locker B
E039	C020	Digital	CCTV recording stored	Locker B
E040	C020	Documentary	Fingerprint sample preserved	Forensic Lab
E041	C021	Documentary	Photographic evidence recorded	Forensic Lab
E042	C021	Biological	Photographic evidence recorded	Forensic Lab
E043	C022	Digital	Weapon sealed as evidence	Evidence Room 1
E044	C022	Digital	Photographic evidence recorded	Locker D
E045	C023	Physical	Email records documented	Locker A
E046	C023	Biological	DNA sample preserved	Locker C
E047	C024	Digital	CCTV recording stored	Locker B
E048	C024	Physical	Glass fragments collected	Forensic Lab
E049	C025	Biological	Glass fragments collected	Evidence Room 1
E050	C025	Biological	Photographic evidence recorded	Locker C
E051	C026	Digital	Financial transaction logs archived	Locker A
E052	C026	Documentary	Photographic evidence recorded	Locker B
E053	C027	Physical	Blood sample secured	Locker D
E054	C027	Biological	Photographic evidence recorded	Evidence Room 2
E055	C028	Digital	Photographic evidence recorded	Forensic Lab
E056	C028	Biological	Financial transaction logs archived	Forensic Lab
E057	C029	Documentary	Weapon sealed as evidence	Forensic Lab
E058	C029	Documentary	Weapon sealed as evidence	Evidence Room 2
E059	C030	Digital	Financial transaction logs archived	Forensic Lab
E060	C030	Physical	Email records documented	Evidence Room 2
E061	C031	Documentary	Blood sample secured	Locker D
E062	C031	Biological	Glass fragments collected	Locker B
E063	C032	Documentary	Email records documented	Locker A
E064	C032	Biological	Mobile data extracted and stored	Locker A
E065	C033	Biological	Mobile data extracted and stored	Locker D
E066	C033	Digital	Mobile data extracted and stored	Locker A
E067	C034	Physical	Email records documented	Forensic Lab
E068	C034	Documentary	Photographic evidence recorded	Forensic Lab
E069	C035	Physical	Fingerprint sample preserved	Locker D
E070	C035	Biological	Weapon sealed as evidence	Evidence Room 1
E071	C036	Digital	Financial transaction logs archived	Locker B
E072	C036	Documentary	Fingerprint sample preserved	Evidence Room 2
E073	C037	Digital	Mobile data extracted and stored	Locker D
E074	C037	Digital	CCTV recording stored	Locker C
E075	C038	Physical	Mobile data extracted and stored	Locker C
E076	C038	Biological	Glass fragments collected	Locker A
E077	C039	Documentary	Mobile data extracted and stored	Evidence Room 1
E078	C039	Biological	Fingerprint sample preserved	Locker B
E079	C040	Biological	Fingerprint sample preserved	Evidence Room 2
E080	C040	Biological	Photographic evidence recorded	Locker D
E081	C041	Digital	Glass fragments collected	Evidence Room 1
E082	C041	Documentary	Mobile data extracted and stored	Locker C
E083	C042	Digital	DNA sample preserved	Evidence Room 1
E084	C042	Physical	Fingerprint sample preserved	Locker A
E085	C043	Digital	Blood sample secured	Locker A
E086	C043	Digital	DNA sample preserved	Evidence Room 1
E087	C044	Physical	Email records documented	Locker B
E088	C044	Documentary	Blood sample secured	Evidence Room 1
E089	C045	Biological	Photographic evidence recorded	Locker C
E090	C045	Documentary	Weapon sealed as evidence	Locker B
E091	C046	Biological	Photographic evidence recorded	Forensic Lab
E092	C046	Documentary	CCTV recording stored	Evidence Room 2
E093	C047	Documentary	Blood sample secured	Locker A
E094	C047	Digital	DNA sample preserved	Locker C
E095	C048	Digital	Mobile data extracted and stored	Evidence Room 2
E096	C048	Physical	Blood sample secured	Locker A
E097	C049	Biological	Financial transaction logs archived	Locker A
E098	C049	Biological	Mobile data extracted and stored	Locker C
E099	C050	Documentary	Weapon sealed as evidence	Evidence Room 1
E100	C050	Digital	Email records documented	Locker A
E101	C051	Digital	Glass fragments collected	Locker D
E102	C051	Documentary	Financial transaction logs archived	Locker C
E103	C052	Biological	Financial transaction logs archived	Evidence Room 2
E104	C052	Physical	Mobile data extracted and stored	Evidence Room 2
E105	C053	Digital	Mobile data extracted and stored	Evidence Room 1
E106	C053	Biological	Glass fragments collected	Evidence Room 1
E107	C054	Physical	DNA sample preserved	Forensic Lab
E108	C054	Physical	Blood sample secured	Evidence Room 1
E109	C055	Digital	Mobile data extracted and stored	Evidence Room 1
E110	C055	Documentary	Mobile data extracted and stored	Evidence Room 2
E111	C056	Documentary	Financial transaction logs archived	Locker A
E112	C056	Documentary	Mobile data extracted and stored	Locker D
E113	C057	Documentary	Glass fragments collected	Forensic Lab
E114	C057	Physical	Blood sample secured	Locker D
E115	C058	Digital	Blood sample secured	Forensic Lab
E116	C058	Digital	Email records documented	Forensic Lab
E117	C059	Digital	Email records documented	Locker D
E118	C059	Documentary	CCTV recording stored	Evidence Room 1
E119	C060	Documentary	Glass fragments collected	Locker C
E120	C060	Biological	Mobile data extracted and stored	Forensic Lab
E121	C061	Biological	Mobile data extracted and stored	Locker A
E122	C061	Digital	Financial transaction logs archived	Locker A
E123	C062	Physical	DNA sample preserved	Evidence Room 2
E124	C062	Documentary	DNA sample preserved	Locker C
E125	C063	Biological	Blood sample secured	Locker C
E126	C063	Biological	Fingerprint sample preserved	Evidence Room 2
E127	C064	Biological	Weapon sealed as evidence	Locker A
E128	C064	Physical	Financial transaction logs archived	Locker A
E129	C065	Physical	Photographic evidence recorded	Evidence Room 2
E130	C065	Digital	Fingerprint sample preserved	Locker D
E131	C066	Documentary	DNA sample preserved	Evidence Room 2
E132	C066	Documentary	Glass fragments collected	Locker C
E133	C067	Digital	Financial transaction logs archived	Evidence Room 1
E134	C067	Physical	Blood sample secured	Locker C
E135	C068	Digital	Blood sample secured	Forensic Lab
E136	C068	Physical	Blood sample secured	Locker A
E137	C069	Biological	CCTV recording stored	Locker D
E138	C069	Biological	Fingerprint sample preserved	Evidence Room 1
E139	C070	Digital	Photographic evidence recorded	Locker B
E140	C070	Documentary	Email records documented	Evidence Room 1
E141	C071	Documentary	Fingerprint sample preserved	Forensic Lab
E142	C071	Digital	CCTV recording stored	Locker C
E143	C072	Documentary	Photographic evidence recorded	Evidence Room 2
E144	C072	Digital	Glass fragments collected	Evidence Room 1
E145	C073	Digital	Mobile data extracted and stored	Evidence Room 2
E146	C073	Physical	Blood sample secured	Locker C
E147	C074	Physical	CCTV recording stored	Locker D
E148	C074	Documentary	Mobile data extracted and stored	Forensic Lab
E149	C075	Biological	Fingerprint sample preserved	Locker C
E150	C075	Biological	Weapon sealed as evidence	Locker D
E151	C076	Biological	Fingerprint sample preserved	Locker B
E152	C076	Biological	Fingerprint sample preserved	Locker D
E153	C077	Digital	Photographic evidence recorded	Evidence Room 1
E154	C077	Physical	Mobile data extracted and stored	Locker B
E155	C078	Digital	Financial transaction logs archived	Evidence Room 2
E156	C078	Biological	Weapon sealed as evidence	Evidence Room 2
E157	C079	Biological	DNA sample preserved	Locker A
E158	C079	Digital	Financial transaction logs archived	Evidence Room 1
E159	C080	Digital	Glass fragments collected	Locker D
E160	C080	Physical	Mobile data extracted and stored	Locker D
E161	C081	Digital	Fingerprint sample preserved	Locker A
E162	C081	Biological	DNA sample preserved	Locker B
E163	C082	Digital	Blood sample secured	Forensic Lab
E164	C082	Digital	Financial transaction logs archived	Locker C
E165	C083	Documentary	Fingerprint sample preserved	Locker C
E166	C083	Documentary	Email records documented	Evidence Room 1
E167	C084	Digital	CCTV recording stored	Locker D
E168	C084	Physical	Mobile data extracted and stored	Locker C
E169	C085	Biological	Glass fragments collected	Locker D
E170	C085	Physical	Glass fragments collected	Evidence Room 2
E171	C086	Documentary	DNA sample preserved	Locker A
E172	C086	Documentary	Blood sample secured	Locker B
E173	C087	Physical	Glass fragments collected	Evidence Room 2
E174	C087	Physical	Blood sample secured	Evidence Room 2
E175	C088	Biological	DNA sample preserved	Locker A
E176	C088	Digital	Photographic evidence recorded	Forensic Lab
E177	C089	Digital	CCTV recording stored	Locker B
E178	C089	Biological	DNA sample preserved	Locker B
E179	C090	Physical	Fingerprint sample preserved	Evidence Room 2
E180	C090	Physical	Weapon sealed as evidence	Forensic Lab
E181	C091	Physical	Glass fragments collected	Forensic Lab
E182	C091	Biological	Financial transaction logs archived	Locker D
E183	C092	Biological	DNA sample preserved	Forensic Lab
E184	C092	Biological	Glass fragments collected	Evidence Room 1
E185	C093	Digital	DNA sample preserved	Forensic Lab
E186	C093	Biological	Blood sample secured	Locker A
E187	C094	Digital	Fingerprint sample preserved	Locker A
E188	C094	Digital	Weapon sealed as evidence	Locker A
E189	C095	Digital	Fingerprint sample preserved	Locker C
E190	C095	Documentary	Financial transaction logs archived	Locker A
E191	C096	Biological	DNA sample preserved	Locker D
E192	C096	Physical	Fingerprint sample preserved	Locker B
E193	C097	Biological	Glass fragments collected	Evidence Room 2
E194	C097	Digital	Glass fragments collected	Locker D
E195	C098	Physical	Glass fragments collected	Locker A
E196	C098	Documentary	DNA sample preserved	Evidence Room 2
E197	C099	Documentary	Glass fragments collected	Evidence Room 1
E198	C099	Biological	Weapon sealed as evidence	Locker B
E199	C100	Biological	Weapon sealed as evidence	Forensic Lab
E200	C100	Digital	Weapon sealed as evidence	Evidence Room 2
E201	C101	Documentary	Weapon sealed as evidence	Locker C
E202	C101	Biological	Blood sample secured	Evidence Room 2
E203	C102	Biological	Blood sample secured	Locker C
E204	C102	Documentary	Fingerprint sample preserved	Locker C
E205	C103	Physical	Weapon sealed as evidence	Locker A
E206	C103	Biological	Financial transaction logs archived	Locker A
E207	C104	Documentary	CCTV recording stored	Locker B
E208	C104	Biological	CCTV recording stored	Evidence Room 1
E209	C105	Biological	Glass fragments collected	Locker D
E210	C105	Biological	Financial transaction logs archived	Locker B
E211	C106	Biological	DNA sample preserved	Locker A
E212	C106	Biological	Photographic evidence recorded	Locker C
E213	C107	Documentary	Fingerprint sample preserved	Evidence Room 1
E214	C107	Biological	DNA sample preserved	Locker A
E215	C108	Biological	Mobile data extracted and stored	Forensic Lab
E216	C108	Biological	Financial transaction logs archived	Locker C
E217	C109	Physical	Photographic evidence recorded	Locker B
E218	C109	Physical	Mobile data extracted and stored	Locker B
E219	C110	Documentary	CCTV recording stored	Locker A
E220	C110	Biological	DNA sample preserved	Locker B
\.


--
-- TOC entry 4923 (class 0 OID 16469)
-- Dependencies: 218
-- Data for Name: officer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.officer (officer_id, name, officer_rank, department) FROM stdin;
O001	Arjun Mehta	Assistant Commissioner	Special Task Force
O002	Deepak Sharma	Sub-Inspector	Crime Branch
O003	Rohit Joshi	Assistant Commissioner	Cyber Cell
O004	Deepak Das	Sub-Inspector	Cyber Cell
O005	Suresh Nair	Inspector	Cyber Cell
O006	Amit Reddy	Head Constable	Cyber Cell
O007	Anjali Patel	Assistant Commissioner	Local Police
O008	Nitin Mehta	Inspector	Local Police
O009	Kavita Singh	Inspector	Crime Branch
O010	Vikram Mehta	Assistant Commissioner	Cyber Cell
O011	Kavita Nair	Inspector	Crime Branch
O012	Deepak Sharma	Sub-Inspector	Fraud Investigation Unit
O013	Simran Mehta	Inspector	Crime Branch
O014	Pooja Das	Inspector	Fraud Investigation Unit
O015	Sneha Patel	Sub-Inspector	Local Police
O016	Anita Nair	Sub-Inspector	Cyber Cell
O017	Ayesha Das	Head Constable	Fraud Investigation Unit
O018	Rohit Singh	Inspector	Special Task Force
O019	Deepak Reddy	Sub-Inspector	Special Task Force
O020	Simran Joshi	Inspector	Fraud Investigation Unit
O021	Nitin Sharma	Assistant Commissioner	Crime Branch
O022	Manoj Das	Sub-Inspector	Special Task Force
O023	Anita Nair	Sub-Inspector	Cyber Cell
O024	Riya Das	Head Constable	Local Police
O025	Simran Das	Inspector	Crime Branch
O026	Vikram Gupta	Assistant Commissioner	Crime Branch
O027	Anjali Reddy	Assistant Commissioner	Fraud Investigation Unit
O028	Vikram Reddy	Sub-Inspector	Special Task Force
O029	Vikram Gupta	Head Constable	Crime Branch
O030	Vikram Mehta	Head Constable	Local Police
O031	Vikram Gupta	Inspector	Special Task Force
O032	Anita Patel	Sub-Inspector	Fraud Investigation Unit
O033	Amit Khan	Assistant Commissioner	Special Task Force
O034	Amit Joshi	Head Constable	Local Police
O035	Vikram Gupta	Head Constable	Fraud Investigation Unit
O036	Deepak Khan	Sub-Inspector	Special Task Force
O037	Ayesha Nair	Head Constable	Cyber Cell
O038	Anita Gupta	Sub-Inspector	Cyber Cell
O039	Neha Sharma	Head Constable	Special Task Force
O040	Neha Khan	Inspector	Fraud Investigation Unit
O041	Suresh Singh	Sub-Inspector	Local Police
O042	Anita Gupta	Head Constable	Cyber Cell
O043	Karan Sharma	Inspector	Cyber Cell
O044	Pooja Das	Assistant Commissioner	Crime Branch
O045	Rohit Gupta	Head Constable	Special Task Force
O046	Anita Singh	Inspector	Crime Branch
O047	Priya Mehta	Sub-Inspector	Special Task Force
O048	Ayesha Reddy	Inspector	Crime Branch
O049	Suresh Das	Assistant Commissioner	Fraud Investigation Unit
O050	Anjali Patel	Assistant Commissioner	Special Task Force
O051	Priya Singh	Sub-Inspector	Special Task Force
O052	Rahul Reddy	Assistant Commissioner	Local Police
O053	Neha Khan	Sub-Inspector	Crime Branch
O054	Pooja Das	Inspector	Fraud Investigation Unit
O055	Neha Singh	Inspector	Fraud Investigation Unit
O056	Rahul Sharma	Assistant Commissioner	Crime Branch
O057	Amit Patel	Sub-Inspector	Special Task Force
O058	Rohit Das	Sub-Inspector	Local Police
O059	Rohit Patel	Inspector	Crime Branch
O060	Vikram Khan	Head Constable	Local Police
O061	Manoj Singh	Inspector	Fraud Investigation Unit
O062	Neha Gupta	Sub-Inspector	Special Task Force
O063	Vikram Patel	Assistant Commissioner	Crime Branch
O064	Rahul Patel	Assistant Commissioner	Cyber Cell
O065	Riya Sharma	Sub-Inspector	Fraud Investigation Unit
O066	Neha Joshi	Assistant Commissioner	Crime Branch
O067	Kavita Joshi	Assistant Commissioner	Local Police
O068	Vikram Nair	Head Constable	Fraud Investigation Unit
O069	Deepak Patel	Sub-Inspector	Fraud Investigation Unit
O070	Manoj Joshi	Sub-Inspector	Crime Branch
O071	Anita Nair	Sub-Inspector	Cyber Cell
O072	Vikram Singh	Sub-Inspector	Local Police
O073	Deepak Reddy	Inspector	Cyber Cell
O074	Vikram Sharma	Sub-Inspector	Special Task Force
O075	Manoj Gupta	Inspector	Crime Branch
O076	Anjali Das	Sub-Inspector	Cyber Cell
O077	Kavita Das	Sub-Inspector	Cyber Cell
O078	Arjun Patel	Sub-Inspector	Crime Branch
O079	Karan Reddy	Sub-Inspector	Cyber Cell
O080	Anita Patel	Sub-Inspector	Fraud Investigation Unit
O081	Ayesha Patel	Assistant Commissioner	Crime Branch
O082	Kavita Joshi	Sub-Inspector	Fraud Investigation Unit
O083	Nitin Khan	Inspector	Local Police
O084	Kavita Sharma	Assistant Commissioner	Local Police
O085	Anita Reddy	Inspector	Local Police
O086	Rohit Patel	Inspector	Local Police
O087	Arjun Das	Head Constable	Local Police
O088	Karan Gupta	Assistant Commissioner	Fraud Investigation Unit
O089	Kavita Sharma	Head Constable	Fraud Investigation Unit
O090	Sneha Mehta	Head Constable	Fraud Investigation Unit
O091	Nitin Reddy	Assistant Commissioner	Local Police
O092	Rohit Patel	Head Constable	Special Task Force
O093	Nitin Das	Head Constable	Local Police
O094	Deepak Joshi	Head Constable	Local Police
O095	Simran Gupta	Assistant Commissioner	Crime Branch
O096	Simran Nair	Sub-Inspector	Local Police
O097	Rohit Singh	Sub-Inspector	Special Task Force
O098	Vikram Singh	Inspector	Special Task Force
O099	Deepak Joshi	Inspector	Fraud Investigation Unit
O100	Anita Patel	Inspector	Special Task Force
\.


--
-- TOC entry 4931 (class 0 OID 16501)
-- Dependencies: 226
-- Data for Name: verdict; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.verdict (verdict_id, case_id, decision, date, remarks) FROM stdin;
V001	C001	Accused Sentenced to 3 Years Imprisonment	2024-01-04	Insufficient evidence to prove guilt beyond reasonable doubt.
V002	C002	Accused Sentenced to 5 Years Imprisonment	2024-03-14	Further hearings scheduled; proceedings ongoing.
V003	C003	Case Under Investigation	2024-08-11	Judgment delivered after reviewing all evidence and witness statements.
V004	C004	Accused Acquitted	2024-01-15	Sentence pronounced considering severity of the crime.
V005	C005	Case Under Investigation	2025-07-21	Bail granted with conditions pending further trial.
V006	C006	Case Dismissed	2025-01-27	Insufficient evidence to prove guilt beyond reasonable doubt.
V007	C007	Accused Sentenced to 5 Years Imprisonment	2024-02-21	Bail granted with conditions pending further trial.
V008	C008	Case Under Investigation	2024-01-31	Sentence pronounced considering severity of the crime.
V009	C009	Accused Sentenced to 5 Years Imprisonment	2024-11-27	Further hearings scheduled; proceedings ongoing.
V010	C010	Trial Ongoing	2025-05-09	Further hearings scheduled; proceedings ongoing.
V011	C011	Case Under Investigation	2024-03-02	Conviction based on strong forensic and documentary evidence.
V012	C012	Bail Granted	2024-09-18	Case dismissed due to lack of substantial proof.
V013	C013	Accused Convicted	2023-07-05	Case dismissed due to lack of substantial proof.
V014	C014	Accused Convicted	2025-05-04	Judgment delivered after reviewing all evidence and witness statements.
V015	C015	Accused Convicted	2025-02-01	Case dismissed due to lack of substantial proof.
V016	C016	Trial Ongoing	2024-10-25	Insufficient evidence to prove guilt beyond reasonable doubt.
V017	C017	Case Dismissed	2023-02-10	Bail granted with conditions pending further trial.
V018	C018	Case Under Investigation	2025-11-05	Case dismissed due to lack of substantial proof.
V019	C019	Trial Ongoing	2023-06-21	Conviction based on strong forensic and documentary evidence.
V020	C020	Accused Sentenced to 5 Years Imprisonment	2024-09-23	Case dismissed due to lack of substantial proof.
V021	C021	Accused Sentenced to 3 Years Imprisonment	2024-09-20	Investigation continues with additional leads being examined.
V022	C022	Accused Acquitted	2023-09-24	Judgment delivered after reviewing all evidence and witness statements.
V023	C023	Accused Convicted	2023-08-31	Conviction based on strong forensic and documentary evidence.
V024	C024	Bail Granted	2025-01-20	Further hearings scheduled; proceedings ongoing.
V025	C025	Accused Convicted	2024-01-29	Judgment delivered after reviewing all evidence and witness statements.
V026	C026	Accused Convicted	2023-03-15	Judgment delivered after reviewing all evidence and witness statements.
V027	C027	Accused Acquitted	2023-06-23	Further hearings scheduled; proceedings ongoing.
V028	C028	Case Under Investigation	2025-03-03	Bail granted with conditions pending further trial.
V029	C029	Bail Granted	2024-12-28	Case dismissed due to lack of substantial proof.
V030	C030	Accused Sentenced to 5 Years Imprisonment	2026-01-21	Judgment delivered after reviewing all evidence and witness statements.
V031	C031	Bail Granted	2023-03-18	Judgment delivered after reviewing all evidence and witness statements.
V032	C032	Case Under Investigation	2025-11-17	Bail granted with conditions pending further trial.
V033	C033	Accused Acquitted	2024-10-25	Further hearings scheduled; proceedings ongoing.
V034	C034	Accused Sentenced to 3 Years Imprisonment	2024-02-01	Further hearings scheduled; proceedings ongoing.
V035	C035	Accused Acquitted	2024-02-19	Sentence pronounced considering severity of the crime.
V036	C036	Trial Ongoing	2024-11-26	Insufficient evidence to prove guilt beyond reasonable doubt.
V037	C037	Accused Acquitted	2025-04-16	Insufficient evidence to prove guilt beyond reasonable doubt.
V038	C038	Case Dismissed	2026-03-18	Conviction based on strong forensic and documentary evidence.
V039	C039	Accused Sentenced to 5 Years Imprisonment	2025-05-25	Case dismissed due to lack of substantial proof.
V040	C040	Bail Granted	2025-08-19	Conviction based on strong forensic and documentary evidence.
V041	C041	Trial Ongoing	2024-07-24	Conviction based on strong forensic and documentary evidence.
V042	C042	Bail Granted	2023-11-22	Conviction based on strong forensic and documentary evidence.
V043	C043	Accused Sentenced to 3 Years Imprisonment	2024-01-04	Case dismissed due to lack of substantial proof.
V044	C044	Accused Acquitted	2026-01-04	Judgment delivered after reviewing all evidence and witness statements.
V045	C045	Bail Granted	2023-01-10	Conviction based on strong forensic and documentary evidence.
V046	C046	Accused Sentenced to 3 Years Imprisonment	2025-06-06	Sentence pronounced considering severity of the crime.
V047	C047	Case Under Investigation	2025-03-07	Case dismissed due to lack of substantial proof.
V048	C048	Bail Granted	2025-02-15	Insufficient evidence to prove guilt beyond reasonable doubt.
V049	C049	Case Dismissed	2023-11-29	Further hearings scheduled; proceedings ongoing.
V050	C050	Accused Convicted	2024-03-06	Investigation continues with additional leads being examined.
V051	C051	Accused Sentenced to 5 Years Imprisonment	2025-06-10	Further hearings scheduled; proceedings ongoing.
V052	C052	Accused Acquitted	2023-08-10	Investigation continues with additional leads being examined.
V053	C053	Accused Sentenced to 5 Years Imprisonment	2023-04-08	Sentence pronounced considering severity of the crime.
V054	C054	Accused Convicted	2025-04-21	Investigation continues with additional leads being examined.
V055	C055	Trial Ongoing	2023-08-05	Further hearings scheduled; proceedings ongoing.
V056	C056	Case Dismissed	2025-05-17	Investigation continues with additional leads being examined.
V057	C057	Bail Granted	2024-08-28	Investigation continues with additional leads being examined.
V058	C058	Bail Granted	2023-08-18	Further hearings scheduled; proceedings ongoing.
V059	C059	Accused Sentenced to 3 Years Imprisonment	2025-06-19	Investigation continues with additional leads being examined.
V060	C060	Accused Sentenced to 3 Years Imprisonment	2024-03-27	Case dismissed due to lack of substantial proof.
V061	C061	Accused Convicted	2024-04-15	Insufficient evidence to prove guilt beyond reasonable doubt.
V062	C062	Case Under Investigation	2023-09-28	Case dismissed due to lack of substantial proof.
V063	C063	Case Under Investigation	2025-05-28	Conviction based on strong forensic and documentary evidence.
V064	C064	Bail Granted	2024-10-05	Bail granted with conditions pending further trial.
V065	C065	Accused Convicted	2025-02-06	Insufficient evidence to prove guilt beyond reasonable doubt.
V066	C066	Accused Acquitted	2024-11-14	Judgment delivered after reviewing all evidence and witness statements.
V067	C067	Accused Acquitted	2025-09-16	Investigation continues with additional leads being examined.
V068	C068	Case Dismissed	2025-10-13	Sentence pronounced considering severity of the crime.
V069	C069	Trial Ongoing	2024-01-03	Case dismissed due to lack of substantial proof.
V070	C070	Accused Acquitted	2024-09-21	Case dismissed due to lack of substantial proof.
V071	C071	Case Dismissed	2025-04-22	Further hearings scheduled; proceedings ongoing.
V072	C072	Bail Granted	2025-07-18	Further hearings scheduled; proceedings ongoing.
V073	C073	Bail Granted	2024-09-24	Sentence pronounced considering severity of the crime.
V074	C074	Accused Sentenced to 3 Years Imprisonment	2026-01-02	Bail granted with conditions pending further trial.
V075	C075	Accused Acquitted	2023-02-13	Insufficient evidence to prove guilt beyond reasonable doubt.
V076	C076	Case Under Investigation	2024-05-14	Conviction based on strong forensic and documentary evidence.
V077	C077	Case Under Investigation	2023-02-15	Insufficient evidence to prove guilt beyond reasonable doubt.
V078	C078	Trial Ongoing	2024-10-22	Judgment delivered after reviewing all evidence and witness statements.
V079	C079	Accused Acquitted	2025-08-17	Conviction based on strong forensic and documentary evidence.
V080	C080	Case Under Investigation	2024-12-08	Investigation continues with additional leads being examined.
V081	C081	Accused Acquitted	2024-02-10	Judgment delivered after reviewing all evidence and witness statements.
V082	C082	Case Dismissed	2025-06-14	Insufficient evidence to prove guilt beyond reasonable doubt.
V083	C083	Accused Acquitted	2023-06-06	Judgment delivered after reviewing all evidence and witness statements.
V084	C084	Accused Sentenced to 3 Years Imprisonment	2023-12-23	Further hearings scheduled; proceedings ongoing.
V085	C085	Accused Convicted	2025-07-10	Further hearings scheduled; proceedings ongoing.
V086	C086	Case Under Investigation	2025-04-30	Investigation continues with additional leads being examined.
V087	C087	Trial Ongoing	2025-11-16	Investigation continues with additional leads being examined.
V088	C088	Accused Convicted	2025-08-08	Case dismissed due to lack of substantial proof.
V089	C089	Accused Sentenced to 3 Years Imprisonment	2024-12-18	Further hearings scheduled; proceedings ongoing.
V090	C090	Bail Granted	2025-07-16	Case dismissed due to lack of substantial proof.
V091	C091	Trial Ongoing	2025-05-01	Conviction based on strong forensic and documentary evidence.
V092	C092	Accused Convicted	2023-04-23	Investigation continues with additional leads being examined.
V093	C093	Accused Convicted	2023-06-12	Case dismissed due to lack of substantial proof.
V094	C094	Bail Granted	2024-08-17	Insufficient evidence to prove guilt beyond reasonable doubt.
V095	C095	Bail Granted	2023-03-10	Case dismissed due to lack of substantial proof.
V096	C096	Accused Convicted	2024-12-02	Further hearings scheduled; proceedings ongoing.
V097	C097	Case Dismissed	2023-05-06	Case dismissed due to lack of substantial proof.
V098	C098	Trial Ongoing	2023-08-02	Further hearings scheduled; proceedings ongoing.
V099	C099	Accused Sentenced to 5 Years Imprisonment	2024-06-29	Case dismissed due to lack of substantial proof.
V100	C100	Case Dismissed	2024-01-12	Conviction based on strong forensic and documentary evidence.
\.


-- Completed on 2026-07-25 17:03:05

--
-- PostgreSQL database dump complete
--

\unrestrict Q5Ng0lkhXsvbWidoycaNXGdzXRgSDxCApKNhhawmeZzyZDy5yCqzFV5QdrngYYq

