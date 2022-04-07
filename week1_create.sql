--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2

-- Started on 2022-04-07 23:35:39

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
-- TOC entry 210 (class 1259 OID 16390)
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    country_id character(2) NOT NULL,
    country_name character varying(40),
    region_id integer
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16410)
-- Name: deparments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deparments (
    department_id integer NOT NULL,
    department_name character varying(30),
    manager_id integer,
    location_id integer
);


ALTER TABLE public.deparments OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16425)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    first_name character varying(20),
    last_name character varying(25),
    email character varying(25),
    phone_number character varying(20),
    hire_date date,
    job_id character varying(10),
    salary integer,
    commission_pct integer,
    manager_id integer,
    department_id integer
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16457)
-- Name: job_grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_grades (
    grade_level character varying(2) NOT NULL,
    lowest_sal integer,
    highest_sal integer
);


ALTER TABLE public.job_grades OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16445)
-- Name: job_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_history (
    employee_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    job_id character varying(10),
    department_id integer
);


ALTER TABLE public.job_history OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16435)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    job_id character varying(10) NOT NULL,
    job_title character varying(35),
    min_salary integer,
    max_salary integer
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 49152)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    location_id integer NOT NULL,
    street_address character varying(25),
    postal_code character varying(12),
    city character varying(30),
    state_province character varying(12),
    country_id character(2)
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    region_id integer NOT NULL,
    region_name character varying(25)
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- TOC entry 3197 (class 2606 OID 16394)
-- Name: countries countries_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pk PRIMARY KEY (country_id);


--
-- TOC entry 3201 (class 2606 OID 16429)
-- Name: employees employees_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pk PRIMARY KEY (employee_id);


--
-- TOC entry 3207 (class 2606 OID 16461)
-- Name: job_grades job_grades_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_grades
    ADD CONSTRAINT job_grades_pk PRIMARY KEY (grade_level);


--
-- TOC entry 3205 (class 2606 OID 24586)
-- Name: job_history job_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_pk PRIMARY KEY (employee_id, start_date);


--
-- TOC entry 3203 (class 2606 OID 16439)
-- Name: jobs jobs_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pk PRIMARY KEY (job_id);


--
-- TOC entry 3209 (class 2606 OID 49156)
-- Name: locations locations_pk0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pk0 PRIMARY KEY (location_id);


--
-- TOC entry 3199 (class 2606 OID 16414)
-- Name: deparments newtable_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deparments
    ADD CONSTRAINT newtable_pk PRIMARY KEY (department_id);


--
-- TOC entry 3195 (class 2606 OID 16389)
-- Name: regions regions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pk PRIMARY KEY (region_id);


--
-- TOC entry 3210 (class 2606 OID 49167)
-- Name: countries countries_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_fk FOREIGN KEY (region_id) REFERENCES public.regions(region_id);


--
-- TOC entry 3211 (class 2606 OID 16430)
-- Name: employees employees_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_fk FOREIGN KEY (department_id) REFERENCES public.deparments(department_id);


--
-- TOC entry 3212 (class 2606 OID 16440)
-- Name: employees employees_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_fk2 FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- TOC entry 3213 (class 2606 OID 16452)
-- Name: job_history job_history_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_fk FOREIGN KEY (job_id) REFERENCES public.jobs(job_id);


--
-- TOC entry 3214 (class 2606 OID 32899)
-- Name: job_history job_history_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_fk2 FOREIGN KEY (department_id) REFERENCES public.deparments(department_id);


--
-- TOC entry 3215 (class 2606 OID 49172)
-- Name: job_history job_history_fk3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_history
    ADD CONSTRAINT job_history_fk3 FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- TOC entry 3216 (class 2606 OID 49162)
-- Name: locations locations_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_fk FOREIGN KEY (country_id) REFERENCES public.countries(country_id);


-- Completed on 2022-04-07 23:35:39

--
-- PostgreSQL database dump complete
--

