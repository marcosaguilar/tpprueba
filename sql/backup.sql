--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: administracion_rango; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE administracion_rango (
    id integer NOT NULL,
    prioridad double precision NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE administracion_rango OWNER TO postgres;

--
-- Name: administracion_rango_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE administracion_rango_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administracion_rango_id_seq OWNER TO postgres;

--
-- Name: administracion_rango_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE administracion_rango_id_seq OWNED BY administracion_rango.id;


--
-- Name: administracion_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE administracion_usuario (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    ci character varying(15) NOT NULL,
    rango_id integer,
    penalizacion double precision NOT NULL
);


ALTER TABLE administracion_usuario OWNER TO postgres;

--
-- Name: administracion_usuario_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE administracion_usuario_groups (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE administracion_usuario_groups OWNER TO postgres;

--
-- Name: administracion_usuario_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE administracion_usuario_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administracion_usuario_groups_id_seq OWNER TO postgres;

--
-- Name: administracion_usuario_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE administracion_usuario_groups_id_seq OWNED BY administracion_usuario_groups.id;


--
-- Name: administracion_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE administracion_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administracion_usuario_id_seq OWNER TO postgres;

--
-- Name: administracion_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE administracion_usuario_id_seq OWNED BY administracion_usuario.id;


--
-- Name: administracion_usuario_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE administracion_usuario_user_permissions (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE administracion_usuario_user_permissions OWNER TO postgres;

--
-- Name: administracion_usuario_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE administracion_usuario_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administracion_usuario_user_permissions_id_seq OWNER TO postgres;

--
-- Name: administracion_usuario_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE administracion_usuario_user_permissions_id_seq OWNED BY administracion_usuario_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO postgres;

--
-- Name: mantenimiento_mantenimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE mantenimiento_mantenimiento (
    id integer NOT NULL,
    detalle text NOT NULL,
    tipo character varying(1) NOT NULL,
    estado character varying(1) NOT NULL,
    recurso_id integer NOT NULL
);


ALTER TABLE mantenimiento_mantenimiento OWNER TO postgres;

--
-- Name: mantenimiento_mantenimiento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mantenimiento_mantenimiento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mantenimiento_mantenimiento_id_seq OWNER TO postgres;

--
-- Name: mantenimiento_mantenimiento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE mantenimiento_mantenimiento_id_seq OWNED BY mantenimiento_mantenimiento.id;


--
-- Name: notificaciones_notificacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notificaciones_notificacion (
    id integer NOT NULL,
    titulo character varying(40) NOT NULL,
    texto text NOT NULL
);


ALTER TABLE notificaciones_notificacion OWNER TO postgres;

--
-- Name: notificaciones_notificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notificaciones_notificacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notificaciones_notificacion_id_seq OWNER TO postgres;

--
-- Name: notificaciones_notificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE notificaciones_notificacion_id_seq OWNED BY notificaciones_notificacion.id;


--
-- Name: recursos_recurso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE recursos_recurso (
    id integer NOT NULL,
    codigo character varying(10) NOT NULL,
    disponible boolean NOT NULL,
    caracteristica text NOT NULL,
    dias_vida_util integer NOT NULL,
    ultimo_mantenimiento date,
    fecha_creacion date NOT NULL,
    administrador_id integer,
    tipo_id integer NOT NULL,
    averiado boolean NOT NULL
);


ALTER TABLE recursos_recurso OWNER TO postgres;

--
-- Name: recursos_recurso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE recursos_recurso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recursos_recurso_id_seq OWNER TO postgres;

--
-- Name: recursos_recurso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE recursos_recurso_id_seq OWNED BY recursos_recurso.id;


--
-- Name: recursos_tiporecurso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE recursos_tiporecurso (
    id integer NOT NULL,
    nombre character varying(32) NOT NULL,
    descripcion_defecto text NOT NULL
);


ALTER TABLE recursos_tiporecurso OWNER TO postgres;

--
-- Name: recursos_tiporecurso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE recursos_tiporecurso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE recursos_tiporecurso_id_seq OWNER TO postgres;

--
-- Name: recursos_tiporecurso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE recursos_tiporecurso_id_seq OWNED BY recursos_tiporecurso.id;


--
-- Name: reservas_coladeprioridades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reservas_coladeprioridades (
    id integer NOT NULL,
    fecha date NOT NULL,
    hora_catedra integer NOT NULL,
    cola character varying(255) NOT NULL,
    recurso_id integer NOT NULL
);


ALTER TABLE reservas_coladeprioridades OWNER TO postgres;

--
-- Name: reservas_coladeprioridades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE reservas_coladeprioridades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reservas_coladeprioridades_id_seq OWNER TO postgres;

--
-- Name: reservas_coladeprioridades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE reservas_coladeprioridades_id_seq OWNED BY reservas_coladeprioridades.id;


--
-- Name: reservas_controlreserva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reservas_controlreserva (
    id integer NOT NULL,
    estado character varying(1) NOT NULL,
    obs character varying(300) NOT NULL,
    reserva_id integer NOT NULL
);


ALTER TABLE reservas_controlreserva OWNER TO postgres;

--
-- Name: reservas_controlreserva_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE reservas_controlreserva_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reservas_controlreserva_id_seq OWNER TO postgres;

--
-- Name: reservas_controlreserva_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE reservas_controlreserva_id_seq OWNED BY reservas_controlreserva.id;


--
-- Name: reservas_reserva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE reservas_reserva (
    id integer NOT NULL,
    fecha date NOT NULL,
    hora_inicio integer NOT NULL,
    hora_fin integer NOT NULL,
    tipo character varying(1) NOT NULL,
    estado character varying(1) NOT NULL,
    posicion integer NOT NULL,
    recurso_id integer NOT NULL,
    responsable_id integer NOT NULL
);


ALTER TABLE reservas_reserva OWNER TO postgres;

--
-- Name: reservas_reserva_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE reservas_reserva_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reservas_reserva_id_seq OWNER TO postgres;

--
-- Name: reservas_reserva_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE reservas_reserva_id_seq OWNED BY reservas_reserva.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_rango ALTER COLUMN id SET DEFAULT nextval('administracion_rango_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario ALTER COLUMN id SET DEFAULT nextval('administracion_usuario_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_groups ALTER COLUMN id SET DEFAULT nextval('administracion_usuario_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_user_permissions ALTER COLUMN id SET DEFAULT nextval('administracion_usuario_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mantenimiento_mantenimiento ALTER COLUMN id SET DEFAULT nextval('mantenimiento_mantenimiento_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notificaciones_notificacion ALTER COLUMN id SET DEFAULT nextval('notificaciones_notificacion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recursos_recurso ALTER COLUMN id SET DEFAULT nextval('recursos_recurso_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recursos_tiporecurso ALTER COLUMN id SET DEFAULT nextval('recursos_tiporecurso_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_coladeprioridades ALTER COLUMN id SET DEFAULT nextval('reservas_coladeprioridades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_controlreserva ALTER COLUMN id SET DEFAULT nextval('reservas_controlreserva_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_reserva ALTER COLUMN id SET DEFAULT nextval('reservas_reserva_id_seq'::regclass);


--
-- Data for Name: administracion_rango; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO administracion_rango VALUES (1, 0, 'Sumo Pontifice');
INSERT INTO administracion_rango VALUES (2, 5, 'Vice-asistente junior');


--
-- Name: administracion_rango_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('administracion_rango_id_seq', 2, true);


--
-- Data for Name: administracion_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO administracion_usuario VALUES (2, 'pbkdf2_sha256$30000$yfqjzqDqDSMF$EldcS7gfKJ4URnPhpKyHUwQlD9QGpMD8/eCGnNCZB2U=', '2017-06-02 18:54:44-04', false, 'general', 'General', 'Mostaza', 'a@b.com', true, true, '2017-06-02 18:12:35-04', '123456', NULL, 0);
INSERT INTO administracion_usuario VALUES (3, 'pbkdf2_sha256$30000$RHSbw53cpCkS$H2kQDZCmZrg0O+kl4Nfz3u7oGb8E1qgyOLm53vaiex0=', '2017-06-02 19:05:59.235662-04', false, 'recursos', 'Recurso', 'Dave', 'recursos@b.com', true, true, '2017-06-02 19:05:12.216497-04', '2345567', NULL, 0);
INSERT INTO administracion_usuario VALUES (4, 'pbkdf2_sha256$30000$6xvmE9VWylZ5$rRGKZCZqrJC+3jE3rX3LJEInmbyc+19bsw45mA64HUo=', '2017-06-02 19:09:02.828557-04', false, 'reservas', 'Pepe', 'Reservas', 'pepe@kek.com', true, true, '2017-06-02 19:08:16.872438-04', '456789', NULL, 0);
INSERT INTO administracion_usuario VALUES (5, 'pbkdf2_sha256$30000$R3Wo8rLI3OUG$g5lmCBgIu+42PKtOLl098mbYC6RUyU8WDH7FCV1JRSI=', '2017-06-02 21:11:38.031491-04', false, 'solicitante', 'Juan', 'Perez', 'juan@b.com', true, true, '2017-06-02 19:12:47.558782-04', '6789', 1, 0);
INSERT INTO administracion_usuario VALUES (1, 'pbkdf2_sha256$30000$TGNxr0r1Krz2$ukBHvo7njPWGOTAWhZnA84ftr8trD7yWXycg3+hKbVM=', '2017-06-03 09:45:35.709361-04', true, 'santiago', '', '', 'santitortora@gmail.com', true, true, '2017-06-02 17:41:02.26641-04', '', NULL, 0);
INSERT INTO administracion_usuario VALUES (6, 'pbkdf2_sha256$30000$IW41DkbiEtPU$VRLX+V9ZiP/8vapHy8An+fReiwFDPptINihWBkJLfBE=', '2017-06-03 09:47:15.830548-04', false, 'pedro', 'Pedro', 'Perez', 'santi.tortora@gmail.com', true, true, '2017-06-03 09:45:19.369456-04', '23456765432', 2, 0);


--
-- Data for Name: administracion_usuario_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO administracion_usuario_groups VALUES (1, 2, 1);
INSERT INTO administracion_usuario_groups VALUES (2, 3, 2);
INSERT INTO administracion_usuario_groups VALUES (3, 4, 4);
INSERT INTO administracion_usuario_groups VALUES (4, 5, 3);
INSERT INTO administracion_usuario_groups VALUES (5, 6, 3);


--
-- Name: administracion_usuario_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('administracion_usuario_groups_id_seq', 5, true);


--
-- Name: administracion_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('administracion_usuario_id_seq', 6, true);


--
-- Data for Name: administracion_usuario_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: administracion_usuario_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('administracion_usuario_user_permissions_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_group VALUES (1, 'Administrador General');
INSERT INTO auth_group VALUES (2, 'Administrador de Recursos');
INSERT INTO auth_group VALUES (4, 'Administrador de Reservas');
INSERT INTO auth_group VALUES (3, 'Solicitante');


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_id_seq', 4, true);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_group_permissions VALUES (1, 1, 1);
INSERT INTO auth_group_permissions VALUES (2, 1, 2);
INSERT INTO auth_group_permissions VALUES (3, 1, 3);
INSERT INTO auth_group_permissions VALUES (4, 1, 4);
INSERT INTO auth_group_permissions VALUES (5, 1, 5);
INSERT INTO auth_group_permissions VALUES (6, 1, 6);
INSERT INTO auth_group_permissions VALUES (7, 1, 7);
INSERT INTO auth_group_permissions VALUES (8, 1, 8);
INSERT INTO auth_group_permissions VALUES (9, 1, 9);
INSERT INTO auth_group_permissions VALUES (10, 1, 10);
INSERT INTO auth_group_permissions VALUES (11, 1, 11);
INSERT INTO auth_group_permissions VALUES (12, 1, 12);
INSERT INTO auth_group_permissions VALUES (13, 1, 13);
INSERT INTO auth_group_permissions VALUES (14, 1, 14);
INSERT INTO auth_group_permissions VALUES (15, 1, 15);
INSERT INTO auth_group_permissions VALUES (16, 1, 16);
INSERT INTO auth_group_permissions VALUES (17, 1, 17);
INSERT INTO auth_group_permissions VALUES (18, 1, 18);
INSERT INTO auth_group_permissions VALUES (19, 1, 19);
INSERT INTO auth_group_permissions VALUES (20, 1, 20);
INSERT INTO auth_group_permissions VALUES (21, 1, 21);
INSERT INTO auth_group_permissions VALUES (22, 1, 22);
INSERT INTO auth_group_permissions VALUES (23, 1, 23);
INSERT INTO auth_group_permissions VALUES (24, 1, 24);
INSERT INTO auth_group_permissions VALUES (25, 1, 25);
INSERT INTO auth_group_permissions VALUES (26, 1, 26);
INSERT INTO auth_group_permissions VALUES (27, 1, 27);
INSERT INTO auth_group_permissions VALUES (28, 1, 28);
INSERT INTO auth_group_permissions VALUES (29, 1, 29);
INSERT INTO auth_group_permissions VALUES (30, 1, 30);
INSERT INTO auth_group_permissions VALUES (31, 1, 31);
INSERT INTO auth_group_permissions VALUES (32, 1, 32);
INSERT INTO auth_group_permissions VALUES (33, 1, 33);
INSERT INTO auth_group_permissions VALUES (34, 1, 34);
INSERT INTO auth_group_permissions VALUES (35, 1, 35);
INSERT INTO auth_group_permissions VALUES (36, 1, 36);
INSERT INTO auth_group_permissions VALUES (37, 1, 37);
INSERT INTO auth_group_permissions VALUES (38, 1, 38);
INSERT INTO auth_group_permissions VALUES (39, 1, 39);
INSERT INTO auth_group_permissions VALUES (40, 2, 32);
INSERT INTO auth_group_permissions VALUES (41, 2, 33);
INSERT INTO auth_group_permissions VALUES (42, 2, 16);
INSERT INTO auth_group_permissions VALUES (43, 2, 17);
INSERT INTO auth_group_permissions VALUES (44, 2, 18);
INSERT INTO auth_group_permissions VALUES (45, 2, 19);
INSERT INTO auth_group_permissions VALUES (46, 2, 20);
INSERT INTO auth_group_permissions VALUES (47, 2, 21);
INSERT INTO auth_group_permissions VALUES (48, 2, 31);
INSERT INTO auth_group_permissions VALUES (49, 3, 37);
INSERT INTO auth_group_permissions VALUES (50, 3, 39);
INSERT INTO auth_group_permissions VALUES (51, 4, 26);
INSERT INTO auth_group_permissions VALUES (52, 4, 35);
INSERT INTO auth_group_permissions VALUES (53, 4, 34);
INSERT INTO auth_group_permissions VALUES (54, 4, 36);
INSERT INTO auth_group_permissions VALUES (55, 3, 38);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 55, true);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_permission VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO auth_permission VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO auth_permission VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO auth_permission VALUES (4, 'Can add permission', 2, 'add_permission');
INSERT INTO auth_permission VALUES (5, 'Can change permission', 2, 'change_permission');
INSERT INTO auth_permission VALUES (6, 'Can delete permission', 2, 'delete_permission');
INSERT INTO auth_permission VALUES (7, 'Can add group', 3, 'add_group');
INSERT INTO auth_permission VALUES (8, 'Can change group', 3, 'change_group');
INSERT INTO auth_permission VALUES (9, 'Can delete group', 3, 'delete_group');
INSERT INTO auth_permission VALUES (10, 'Can add content type', 4, 'add_contenttype');
INSERT INTO auth_permission VALUES (11, 'Can change content type', 4, 'change_contenttype');
INSERT INTO auth_permission VALUES (12, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO auth_permission VALUES (13, 'Can add session', 5, 'add_session');
INSERT INTO auth_permission VALUES (14, 'Can change session', 5, 'change_session');
INSERT INTO auth_permission VALUES (15, 'Can delete session', 5, 'delete_session');
INSERT INTO auth_permission VALUES (16, 'Can add tipo recurso', 6, 'add_tiporecurso');
INSERT INTO auth_permission VALUES (17, 'Can change tipo recurso', 6, 'change_tiporecurso');
INSERT INTO auth_permission VALUES (18, 'Can delete tipo recurso', 6, 'delete_tiporecurso');
INSERT INTO auth_permission VALUES (19, 'Can add recurso', 7, 'add_recurso');
INSERT INTO auth_permission VALUES (20, 'Can change recurso', 7, 'change_recurso');
INSERT INTO auth_permission VALUES (21, 'Can delete recurso', 7, 'delete_recurso');
INSERT INTO auth_permission VALUES (22, 'Can add rango', 8, 'add_rango');
INSERT INTO auth_permission VALUES (23, 'Can change rango', 8, 'change_rango');
INSERT INTO auth_permission VALUES (24, 'Can delete rango', 8, 'delete_rango');
INSERT INTO auth_permission VALUES (25, 'Can add user', 9, 'add_usuario');
INSERT INTO auth_permission VALUES (26, 'Can change user', 9, 'change_usuario');
INSERT INTO auth_permission VALUES (27, 'Can delete user', 9, 'delete_usuario');
INSERT INTO auth_permission VALUES (28, 'Can add notificacion', 10, 'add_notificacion');
INSERT INTO auth_permission VALUES (29, 'Can change notificacion', 10, 'change_notificacion');
INSERT INTO auth_permission VALUES (30, 'Can delete notificacion', 10, 'delete_notificacion');
INSERT INTO auth_permission VALUES (31, 'Can add mantenimiento', 11, 'add_mantenimiento');
INSERT INTO auth_permission VALUES (32, 'Can change mantenimiento', 11, 'change_mantenimiento');
INSERT INTO auth_permission VALUES (33, 'Can delete mantenimiento', 11, 'delete_mantenimiento');
INSERT INTO auth_permission VALUES (34, 'Can add reserva', 12, 'add_reserva');
INSERT INTO auth_permission VALUES (35, 'Can change reserva', 12, 'change_reserva');
INSERT INTO auth_permission VALUES (36, 'Can delete reserva', 12, 'delete_reserva');
INSERT INTO auth_permission VALUES (37, 'Can add mi reserva', 12, 'add_mireserva');
INSERT INTO auth_permission VALUES (38, 'Can change mi reserva', 12, 'change_mireserva');
INSERT INTO auth_permission VALUES (39, 'Can delete mi reserva', 12, 'delete_mireserva');
INSERT INTO auth_permission VALUES (43, 'Can add cola de prioridades', 15, 'add_coladeprioridades');
INSERT INTO auth_permission VALUES (44, 'Can change cola de prioridades', 15, 'change_coladeprioridades');
INSERT INTO auth_permission VALUES (45, 'Can delete cola de prioridades', 15, 'delete_coladeprioridades');
INSERT INTO auth_permission VALUES (46, 'Can add control reserva', 16, 'add_controlreserva');
INSERT INTO auth_permission VALUES (47, 'Can change control reserva', 16, 'change_controlreserva');
INSERT INTO auth_permission VALUES (48, 'Can delete control reserva', 16, 'delete_controlreserva');


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_permission_id_seq', 48, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_admin_log VALUES (1, '2017-06-02 17:46:51.074066-04', '1', 'Administrador General', 1, '[{"added": {}}]', 3, 1);
INSERT INTO django_admin_log VALUES (2, '2017-06-02 17:49:08.086275-04', '2', 'Administrador de Recursos', 1, '[{"added": {}}]', 3, 1);
INSERT INTO django_admin_log VALUES (3, '2017-06-02 17:50:16.201273-04', '3', 'Solicitante', 1, '[{"added": {}}]', 3, 1);
INSERT INTO django_admin_log VALUES (4, '2017-06-02 17:50:52.571999-04', '4', 'Administrador de Reservas', 1, '[{"added": {}}]', 3, 1);
INSERT INTO django_admin_log VALUES (5, '2017-06-02 18:55:15.475121-04', '2', 'general', 2, '[{"changed": {"fields": ["groups"]}}]', 9, 1);
INSERT INTO django_admin_log VALUES (6, '2017-06-02 19:05:50.85147-04', '3', 'recursos', 2, '[{"changed": {"fields": ["is_staff", "is_active"]}}]', 9, 2);
INSERT INTO django_admin_log VALUES (7, '2017-06-02 19:08:45.83167-04', '4', 'reservas', 2, '[{"changed": {"fields": ["is_staff", "is_active"]}}]', 9, 1);
INSERT INTO django_admin_log VALUES (8, '2017-06-02 19:13:40.74591-04', '1', 'Sumo Pontifice', 1, '[{"added": {}}]', 8, 1);
INSERT INTO django_admin_log VALUES (9, '2017-06-02 19:13:56.520556-04', '2', 'Vice-asistente junior', 1, '[{"added": {}}]', 8, 1);
INSERT INTO django_admin_log VALUES (10, '2017-06-02 19:14:11.137318-04', '5', 'solicitante', 2, '[{"changed": {"fields": ["is_staff", "is_active", "rango"]}}]', 9, 1);
INSERT INTO django_admin_log VALUES (11, '2017-06-02 19:16:15.388022-04', '1', 'Aula F31', 1, '[{"added": {}}]', 7, 1);
INSERT INTO django_admin_log VALUES (12, '2017-06-02 19:17:01.407573-04', '2', 'Proyector 9001', 1, '[{"added": {}}]', 7, 1);
INSERT INTO django_admin_log VALUES (13, '2017-06-02 19:17:25.571049-04', '3', 'Proyector 9002', 1, '[{"added": {}}]', 7, 1);
INSERT INTO django_admin_log VALUES (14, '2017-06-02 19:18:43.008773-04', '4', 'Aula A55', 1, '[{"added": {}}]', 7, 1);
INSERT INTO django_admin_log VALUES (15, '2017-06-02 20:43:26.425064-04', '5', 'Aula A55 para fecha: 2017-06-03', 1, '[{"added": {}}]', 13, 1);
INSERT INTO django_admin_log VALUES (16, '2017-06-02 21:08:53.300997-04', '5', 'Aula A55 para santiago', 2, '[{"changed": {"fields": ["hora_fin"]}}]', 12, 1);
INSERT INTO django_admin_log VALUES (17, '2017-06-02 21:10:30.855784-04', '5', 'Aula A55 para santiago', 2, '[{"changed": {"fields": ["hora_fin"]}}]', 12, 1);
INSERT INTO django_admin_log VALUES (18, '2017-06-02 21:11:58.077711-04', '6', 'Proyector 9001 para fecha: 2017-06-03', 1, '[{"added": {}}]', 13, 5);
INSERT INTO django_admin_log VALUES (19, '2017-06-02 21:12:59.278224-04', '3', 'Solicitante', 2, '[]', 3, 1);
INSERT INTO django_admin_log VALUES (20, '2017-06-02 21:18:04.919015-04', '2', 'Aula A55 para solicitante', 2, '[]', 12, 5);
INSERT INTO django_admin_log VALUES (21, '2017-06-02 21:18:37.476341-04', '7', 'Aula A55 para fecha: 2017-06-03', 1, '[{"added": {}}]', 13, 5);
INSERT INTO django_admin_log VALUES (22, '2017-06-02 21:19:21.879698-04', '2', 'Aula A55 para solicitante', 2, '[{"changed": {"fields": ["hora_inicio"]}}]', 12, 5);
INSERT INTO django_admin_log VALUES (23, '2017-06-03 08:20:54.239568-04', '1', 'Proyector 9002 para fecha: 2017-06-06', 1, '[{"added": {}}]', 13, 5);
INSERT INTO django_admin_log VALUES (24, '2017-06-03 08:25:29.782321-04', '2', 'Proyector 9001 para fecha: 2017-06-03', 1, '[{"added": {}}]', 13, 5);
INSERT INTO django_admin_log VALUES (25, '2017-06-03 09:44:35.884312-04', '3', 'Proyector 9001 para fecha: 2017-06-03', 1, '[{"added": {}}]', 13, 5);
INSERT INTO django_admin_log VALUES (26, '2017-06-03 09:46:00.742666-04', '6', 'pedro', 2, '[{"changed": {"fields": ["is_active", "rango"]}}]', 9, 1);
INSERT INTO django_admin_log VALUES (27, '2017-06-03 09:47:29.722397-04', '4', 'Proyector 9001 para fecha: 2017-06-03', 1, '[{"added": {}}]', 13, 6);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 27, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_content_type VALUES (1, 'admin', 'logentry');
INSERT INTO django_content_type VALUES (2, 'auth', 'permission');
INSERT INTO django_content_type VALUES (3, 'auth', 'group');
INSERT INTO django_content_type VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO django_content_type VALUES (5, 'sessions', 'session');
INSERT INTO django_content_type VALUES (6, 'recursos', 'tiporecurso');
INSERT INTO django_content_type VALUES (7, 'recursos', 'recurso');
INSERT INTO django_content_type VALUES (8, 'administracion', 'rango');
INSERT INTO django_content_type VALUES (9, 'administracion', 'usuario');
INSERT INTO django_content_type VALUES (10, 'notificaciones', 'notificacion');
INSERT INTO django_content_type VALUES (11, 'mantenimiento', 'mantenimiento');
INSERT INTO django_content_type VALUES (12, 'reservas', 'reserva');
INSERT INTO django_content_type VALUES (13, 'reservas', 'mireserva');
INSERT INTO django_content_type VALUES (15, 'reservas', 'coladeprioridades');
INSERT INTO django_content_type VALUES (16, 'reservas', 'controlreserva');


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_content_type_id_seq', 16, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_migrations VALUES (45, 'contenttypes', '0001_initial', '2017-06-03 09:43:13.982155-04');
INSERT INTO django_migrations VALUES (46, 'contenttypes', '0002_remove_content_type_name', '2017-06-03 09:43:13.99927-04');
INSERT INTO django_migrations VALUES (47, 'auth', '0001_initial', '2017-06-03 09:43:14.009947-04');
INSERT INTO django_migrations VALUES (48, 'auth', '0002_alter_permission_name_max_length', '2017-06-03 09:43:14.021231-04');
INSERT INTO django_migrations VALUES (49, 'auth', '0003_alter_user_email_max_length', '2017-06-03 09:43:14.032311-04');
INSERT INTO django_migrations VALUES (50, 'auth', '0004_alter_user_username_opts', '2017-06-03 09:43:14.043738-04');
INSERT INTO django_migrations VALUES (51, 'auth', '0005_alter_user_last_login_null', '2017-06-03 09:43:14.063853-04');
INSERT INTO django_migrations VALUES (52, 'auth', '0006_require_contenttypes_0002', '2017-06-03 09:43:14.07704-04');
INSERT INTO django_migrations VALUES (53, 'auth', '0007_alter_validators_add_error_messages', '2017-06-03 09:43:14.088359-04');
INSERT INTO django_migrations VALUES (54, 'auth', '0008_alter_user_username_max_length', '2017-06-03 09:43:14.099266-04');
INSERT INTO django_migrations VALUES (55, 'administracion', '0001_initial', '2017-06-03 09:43:14.110239-04');
INSERT INTO django_migrations VALUES (56, 'admin', '0001_initial', '2017-06-03 09:43:14.121167-04');
INSERT INTO django_migrations VALUES (57, 'admin', '0002_logentry_remove_auto_add', '2017-06-03 09:43:14.132196-04');
INSERT INTO django_migrations VALUES (58, 'recursos', '0001_initial', '2017-06-03 09:43:14.143694-04');
INSERT INTO django_migrations VALUES (59, 'mantenimiento', '0001_initial', '2017-06-03 09:43:14.154466-04');
INSERT INTO django_migrations VALUES (60, 'notificaciones', '0001_initial', '2017-06-03 09:43:14.165486-04');
INSERT INTO django_migrations VALUES (61, 'reservas', '0001_initial', '2017-06-03 09:43:14.177877-04');
INSERT INTO django_migrations VALUES (62, 'sessions', '0001_initial', '2017-06-03 09:43:14.187837-04');


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_migrations_id_seq', 62, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_session VALUES ('2kmaxg3ladznsn84tjbzc39fhnkq1f84', 'NGE5ZjJiMjY0YjAzZDRhM2RiMTkzYzdiMTBhZDE0N2RmZDlmMDI3Mjp7Il9hdXRoX3VzZXJfaGFzaCI6IjhiZjlhMWM4ZjdmODdjZWFkNGI0ZjE3YTg5ZmZhOWJiMDEwNjU2NzkiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2017-06-16 18:54:44.315185-04');
INSERT INTO django_session VALUES ('8dn0z73gc95e0ipm9rn4xpc84d4cm95h', 'NmY5MmViZTIxMTY5ZWVjZmEzOWUwZjg5ODEwYmY4ZDE1MjlkZjkwMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjU5YTVlNGNmMjBlMzY5Zjc5MWU4MmE1ZjA2YmMzODU0M2ZhYTI1YTgiLCJfYXV0aF91c2VyX2lkIjoiMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2017-06-16 19:05:59.246968-04');
INSERT INTO django_session VALUES ('mnq18zfeej1uddias9ss80tjzs1pm4mw', 'NjVlYzUxMzZjNjQxMjIzNDlkZTFlYmY1YTkxMjUyZjA5MDE2NTUyNjp7Il9hdXRoX3VzZXJfaGFzaCI6ImFhMmE3Nzc5NDVkNWM0ZWIxYTJjMDBmZmFlNDJjZWI4MmMyMTdlNjkiLCJfYXV0aF91c2VyX2lkIjoiNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2017-06-16 19:09:02.840219-04');
INSERT INTO django_session VALUES ('x81m2wqnt0ihys1oocuo6mz9z9qxgb54', 'NDcxOWE1MzczOGQwMTkzNTYxOWQ1ODI1ZmY2NTMxMTI5ZWM5YzZmZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjUiLCJfYXV0aF91c2VyX2hhc2giOiIxYjFmZmYyZDlmMGQyZTIzMzMyNjhhNDRkNzE0ZjQyYWE1NDdkMzQ0In0=', '2017-06-16 19:23:00.217584-04');
INSERT INTO django_session VALUES ('af4454az94gui7eqsz8wupnr2f5p26ki', 'ODczYTNlMzdmZTJmNmJlMDVkNGZiMjQ0YjUxNDNjMjdmNWQ5ZjFiODp7Il9hdXRoX3VzZXJfaGFzaCI6IjgzNjNjNWU2YmE5MjQ5ODViMTM2N2ZmN2YzOTU4MWUyM2I0MTFlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2017-06-16 21:10:46.272667-04');
INSERT INTO django_session VALUES ('oaj4mbxv5ln9zpc1tauglli043rlddmg', 'M2Q4NTI0ZTU2MDk4YTk3MGU3YTY5MTI0MDU1MmM2NzhmNTkzNTE3MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjYiLCJfYXV0aF91c2VyX2hhc2giOiJhZTlkNDI0OGMxZTg5OTQ3YmMzYWQ1ZmExZjZlZjg4ODg3NmM4NjRiIn0=', '2017-06-17 09:47:15.842066-04');


--
-- Data for Name: mantenimiento_mantenimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: mantenimiento_mantenimiento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mantenimiento_mantenimiento_id_seq', 1, false);


--
-- Data for Name: notificaciones_notificacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO notificaciones_notificacion VALUES (1, 'Solicitud Aceptada', 'Su solicitud de registro fue aprobada correctamente, ya puede iniciar sesion en el SGR');
INSERT INTO notificaciones_notificacion VALUES (2, 'Solicitud Rechazada', 'Su solicitud de registro fue rechazada, verfique sus datos y vuelva a intentarlo');
INSERT INTO notificaciones_notificacion VALUES (3, 'Mantenimiento Preventivo', 'El tiempo de vida util del recurso con el codigo señalado llego a su fin');
INSERT INTO notificaciones_notificacion VALUES (4, 'Reserva Acreditada', 'Se le ha acreditado la reserva solicitada, a continuacion se detalla informacion referente a la reserva(La misma servira como comprobante)');
INSERT INTO notificaciones_notificacion VALUES (5, 'Equipo Averiado', 'El recurso con el codigo señalado, paso por mantenimiento correctivo y no se pudo llegar a una solucion, por lo que se solicita la baja de la misma del sistema.');
INSERT INTO notificaciones_notificacion VALUES (6, 'Mantenimiento Correctivo', 'El recurso con el codigo señalado presento problemas por lo que requiere mantenimiento correctivo');
INSERT INTO notificaciones_notificacion VALUES (7, 'Finalizacion Reserva', 'Se finalizo la reserva, a continuacion se detalla informacion referente a la misma');
INSERT INTO notificaciones_notificacion VALUES (8, 'Reserva Cancelada por Mantenimiento', 'Le informamos que su reserva ha sido cancelada debido a inconvenientes con el recurso reservado y el mismo fue llevado a mantenimiento.A continuacion se detalla informacion referente a su reserva cancelada:');
INSERT INTO notificaciones_notificacion VALUES (9, 'Reserva Cancelada por Equipo averiado', 'Le informamos que su reserva ha sido cancelada debido a que el recurso se encuentra averiado.
A continuacion se detalla informacion referente a su reserva cancelada:');


--
-- Name: notificaciones_notificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('notificaciones_notificacion_id_seq', 9, true);


--
-- Data for Name: recursos_recurso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO recursos_recurso VALUES (1, 'F31', true, 'Bloque: F', 9000, NULL, '2017-06-02', 3, 1, false);
INSERT INTO recursos_recurso VALUES (2, '9001', true, 'Modelo 9001', 1000, NULL, '2017-06-02', 3, 2, false);
INSERT INTO recursos_recurso VALUES (3, '9002', true, 'Modelo 9002', 1000, NULL, '2017-06-02', 3, 2, false);
INSERT INTO recursos_recurso VALUES (4, 'A55', true, 'Bloque A', 9000, NULL, '2017-06-02', 3, 1, false);


--
-- Name: recursos_recurso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('recursos_recurso_id_seq', 4, true);


--
-- Data for Name: recursos_tiporecurso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO recursos_tiporecurso VALUES (1, 'Aula', 'Bloque:');
INSERT INTO recursos_tiporecurso VALUES (2, 'Proyector', 'Modelo:');


--
-- Name: recursos_tiporecurso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('recursos_tiporecurso_id_seq', 1, false);


--
-- Data for Name: reservas_coladeprioridades; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: reservas_coladeprioridades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('reservas_coladeprioridades_id_seq', 1, true);


--
-- Data for Name: reservas_controlreserva; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: reservas_controlreserva_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('reservas_controlreserva_id_seq', 3, true);


--
-- Data for Name: reservas_reserva; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: reservas_reserva_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('reservas_reserva_id_seq', 4, true);


--
-- Name: administracion_rango_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_rango
    ADD CONSTRAINT administracion_rango_pkey PRIMARY KEY (id);


--
-- Name: administracion_rango_prioridad_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_rango
    ADD CONSTRAINT administracion_rango_prioridad_key UNIQUE (prioridad);


--
-- Name: administracion_usuario_ci_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario
    ADD CONSTRAINT administracion_usuario_ci_key UNIQUE (ci);


--
-- Name: administracion_usuario_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_groups
    ADD CONSTRAINT administracion_usuario_groups_pkey PRIMARY KEY (id);


--
-- Name: administracion_usuario_groups_usuario_id_0f621652_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_groups
    ADD CONSTRAINT administracion_usuario_groups_usuario_id_0f621652_uniq UNIQUE (usuario_id, group_id);


--
-- Name: administracion_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario
    ADD CONSTRAINT administracion_usuario_pkey PRIMARY KEY (id);


--
-- Name: administracion_usuario_user_permission_usuario_id_3ee5a0db_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_user_permissions
    ADD CONSTRAINT administracion_usuario_user_permission_usuario_id_3ee5a0db_uniq UNIQUE (usuario_id, permission_id);


--
-- Name: administracion_usuario_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_user_permissions
    ADD CONSTRAINT administracion_usuario_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: administracion_usuario_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario
    ADD CONSTRAINT administracion_usuario_username_key UNIQUE (username);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: mantenimiento_mantenimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mantenimiento_mantenimiento
    ADD CONSTRAINT mantenimiento_mantenimiento_pkey PRIMARY KEY (id);


--
-- Name: mantenimiento_mantenimiento_recurso_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mantenimiento_mantenimiento
    ADD CONSTRAINT mantenimiento_mantenimiento_recurso_id_key UNIQUE (recurso_id);


--
-- Name: notificaciones_notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notificaciones_notificacion
    ADD CONSTRAINT notificaciones_notificacion_pkey PRIMARY KEY (id);


--
-- Name: recursos_recurso_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recursos_recurso
    ADD CONSTRAINT recursos_recurso_codigo_key UNIQUE (codigo);


--
-- Name: recursos_recurso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recursos_recurso
    ADD CONSTRAINT recursos_recurso_pkey PRIMARY KEY (id);


--
-- Name: recursos_tiporecurso_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recursos_tiporecurso
    ADD CONSTRAINT recursos_tiporecurso_nombre_key UNIQUE (nombre);


--
-- Name: recursos_tiporecurso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recursos_tiporecurso
    ADD CONSTRAINT recursos_tiporecurso_pkey PRIMARY KEY (id);


--
-- Name: reservas_coladeprioridades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_coladeprioridades
    ADD CONSTRAINT reservas_coladeprioridades_pkey PRIMARY KEY (id);


--
-- Name: reservas_controlreserva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_controlreserva
    ADD CONSTRAINT reservas_controlreserva_pkey PRIMARY KEY (id);


--
-- Name: reservas_reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_reserva
    ADD CONSTRAINT reservas_reserva_pkey PRIMARY KEY (id);


--
-- Name: administracion_usuario_ci_1c8bc276_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX administracion_usuario_ci_1c8bc276_like ON administracion_usuario USING btree (ci varchar_pattern_ops);


--
-- Name: administracion_usuario_ead1bb1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX administracion_usuario_ead1bb1c ON administracion_usuario USING btree (rango_id);


--
-- Name: administracion_usuario_groups_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX administracion_usuario_groups_0e939a4f ON administracion_usuario_groups USING btree (group_id);


--
-- Name: administracion_usuario_groups_abfe0f96; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX administracion_usuario_groups_abfe0f96 ON administracion_usuario_groups USING btree (usuario_id);


--
-- Name: administracion_usuario_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX administracion_usuario_user_permissions_8373b171 ON administracion_usuario_user_permissions USING btree (permission_id);


--
-- Name: administracion_usuario_user_permissions_abfe0f96; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX administracion_usuario_user_permissions_abfe0f96 ON administracion_usuario_user_permissions USING btree (usuario_id);


--
-- Name: administracion_usuario_username_b5973f5e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX administracion_usuario_username_b5973f5e_like ON administracion_usuario USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: recursos_recurso_52b17844; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recursos_recurso_52b17844 ON recursos_recurso USING btree (administrador_id);


--
-- Name: recursos_recurso_codigo_086c9733_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recursos_recurso_codigo_086c9733_like ON recursos_recurso USING btree (codigo varchar_pattern_ops);


--
-- Name: recursos_recurso_d3c0c18a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recursos_recurso_d3c0c18a ON recursos_recurso USING btree (tipo_id);


--
-- Name: recursos_tiporecurso_nombre_1df10353_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recursos_tiporecurso_nombre_1df10353_like ON recursos_tiporecurso USING btree (nombre varchar_pattern_ops);


--
-- Name: reservas_coladeprioridades_7ac639be; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reservas_coladeprioridades_7ac639be ON reservas_coladeprioridades USING btree (recurso_id);


--
-- Name: reservas_controlreserva_7faa80b1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reservas_controlreserva_7faa80b1 ON reservas_controlreserva USING btree (reserva_id);


--
-- Name: reservas_reserva_1ba06e10; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reservas_reserva_1ba06e10 ON reservas_reserva USING btree (responsable_id);


--
-- Name: reservas_reserva_7ac639be; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reservas_reserva_7ac639be ON reservas_reserva USING btree (recurso_id);


--
-- Name: administracion_usu_permission_id_2d79f549_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_user_permissions
    ADD CONSTRAINT administracion_usu_permission_id_2d79f549_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: administracion_usu_rango_id_e6b14edf_fk_administracion_rango_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario
    ADD CONSTRAINT administracion_usu_rango_id_e6b14edf_fk_administracion_rango_id FOREIGN KEY (rango_id) REFERENCES administracion_rango(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: administracion_usuario_group_group_id_871fc8d5_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_groups
    ADD CONSTRAINT administracion_usuario_group_group_id_871fc8d5_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: administracion_usuario_id_9b730783_fk_administracion_usuario_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_groups
    ADD CONSTRAINT administracion_usuario_id_9b730783_fk_administracion_usuario_id FOREIGN KEY (usuario_id) REFERENCES administracion_usuario(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: administracion_usuario_id_b5e59549_fk_administracion_usuario_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administracion_usuario_user_permissions
    ADD CONSTRAINT administracion_usuario_id_b5e59549_fk_administracion_usuario_id FOREIGN KEY (usuario_id) REFERENCES administracion_usuario(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_administracion_usuario_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_administracion_usuario_id FOREIGN KEY (user_id) REFERENCES administracion_usuario(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mantenimiento_manten_recurso_id_ac43ce76_fk_recursos_recurso_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mantenimiento_mantenimiento
    ADD CONSTRAINT mantenimiento_manten_recurso_id_ac43ce76_fk_recursos_recurso_id FOREIGN KEY (recurso_id) REFERENCES recursos_recurso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: recursos_administrador_id_05b98234_fk_administracion_usuario_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recursos_recurso
    ADD CONSTRAINT recursos_administrador_id_05b98234_fk_administracion_usuario_id FOREIGN KEY (administrador_id) REFERENCES administracion_usuario(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: recursos_recurso_tipo_id_45fc50a9_fk_recursos_tiporecurso_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY recursos_recurso
    ADD CONSTRAINT recursos_recurso_tipo_id_45fc50a9_fk_recursos_tiporecurso_id FOREIGN KEY (tipo_id) REFERENCES recursos_tiporecurso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reservas_coladeprior_recurso_id_e15d505c_fk_recursos_recurso_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_coladeprioridades
    ADD CONSTRAINT reservas_coladeprior_recurso_id_e15d505c_fk_recursos_recurso_id FOREIGN KEY (recurso_id) REFERENCES recursos_recurso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reservas_controlrese_reserva_id_26d9c9e1_fk_reservas_reserva_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_controlreserva
    ADD CONSTRAINT reservas_controlrese_reserva_id_26d9c9e1_fk_reservas_reserva_id FOREIGN KEY (reserva_id) REFERENCES reservas_reserva(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reservas_r_responsable_id_c602b02e_fk_administracion_usuario_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_reserva
    ADD CONSTRAINT reservas_r_responsable_id_c602b02e_fk_administracion_usuario_id FOREIGN KEY (responsable_id) REFERENCES administracion_usuario(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reservas_reserva_recurso_id_a76afacd_fk_recursos_recurso_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservas_reserva
    ADD CONSTRAINT reservas_reserva_recurso_id_a76afacd_fk_recursos_recurso_id FOREIGN KEY (recurso_id) REFERENCES recursos_recurso(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
