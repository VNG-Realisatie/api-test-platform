--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md53175bce1d3201d16594cebf9d7eb3f9d';






\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ac; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE ac WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE ac OWNER TO postgres;

\connect ac

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authorizations_applicatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_applicatie (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    client_ids character varying(50)[] NOT NULL,
    label character varying(100) NOT NULL,
    heeft_alle_autorisaties boolean NOT NULL
);


ALTER TABLE public.authorizations_applicatie OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_applicatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_applicatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_applicatie_id_seq OWNED BY public.authorizations_applicatie.id;


--
-- Name: authorizations_authorizationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_authorizationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    component character varying(50) NOT NULL
);


ALTER TABLE public.authorizations_authorizationsconfig OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_authorizationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_authorizationsconfig_id_seq OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_authorizationsconfig_id_seq OWNED BY public.authorizations_authorizationsconfig.id;


--
-- Name: authorizations_autorisatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_autorisatie (
    id integer NOT NULL,
    component character varying(50) NOT NULL,
    zaaktype character varying(1000) NOT NULL,
    scopes character varying(100)[] NOT NULL,
    max_vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    applicatie_id integer NOT NULL,
    besluittype character varying(1000) NOT NULL,
    informatieobjecttype character varying(1000) NOT NULL
);


ALTER TABLE public.authorizations_autorisatie OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_autorisatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_autorisatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_autorisatie_id_seq OWNED BY public.authorizations_autorisatie.id;


--
-- Name: axes_accessattempt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accessattempt (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    get_data text NOT NULL,
    post_data text NOT NULL,
    failures_since_start integer NOT NULL,
    CONSTRAINT axes_accessattempt_failures_since_start_check CHECK ((failures_since_start >= 0))
);


ALTER TABLE public.axes_accessattempt OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accessattempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accessattempt_id_seq OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accessattempt_id_seq OWNED BY public.axes_accessattempt.id;


--
-- Name: axes_accesslog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accesslog (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    logout_time timestamp with time zone
);


ALTER TABLE public.axes_accesslog OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accesslog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accesslog_id_seq OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accesslog_id_seq OWNED BY public.axes_accesslog.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: notifications_notificationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_notificationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL
);


ALTER TABLE public.notifications_notificationsconfig OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notificationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_notificationsconfig_id_seq OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notificationsconfig_id_seq OWNED BY public.notifications_notificationsconfig.id;


--
-- Name: notifications_subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_subscription (
    id integer NOT NULL,
    callback_url character varying(200) NOT NULL,
    client_id character varying(50) NOT NULL,
    secret character varying(50) NOT NULL,
    channels character varying(100)[] NOT NULL,
    config_id integer NOT NULL,
    _subscription character varying(200) NOT NULL
);


ALTER TABLE public.notifications_subscription OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_subscription_id_seq OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_subscription_id_seq OWNED BY public.notifications_subscription.id;


--
-- Name: vng_api_common_apicredential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_apicredential (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    client_id character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    label character varying(100) NOT NULL,
    user_id character varying(255) NOT NULL,
    user_representation character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_apicredential OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_apicredential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_apicredential_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_apicredential_id_seq OWNED BY public.vng_api_common_apicredential.id;


--
-- Name: vng_api_common_jwtsecret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_jwtsecret (
    id integer NOT NULL,
    identifier character varying(50) NOT NULL,
    secret character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_jwtsecret OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_jwtsecret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_jwtsecret_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_jwtsecret_id_seq OWNED BY public.vng_api_common_jwtsecret.id;


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: authorizations_applicatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_applicatie_id_seq'::regclass);


--
-- Name: authorizations_authorizationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig ALTER COLUMN id SET DEFAULT nextval('public.authorizations_authorizationsconfig_id_seq'::regclass);


--
-- Name: authorizations_autorisatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_autorisatie_id_seq'::regclass);


--
-- Name: axes_accessattempt id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt ALTER COLUMN id SET DEFAULT nextval('public.axes_accessattempt_id_seq'::regclass);


--
-- Name: axes_accesslog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog ALTER COLUMN id SET DEFAULT nextval('public.axes_accesslog_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: notifications_notificationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig ALTER COLUMN id SET DEFAULT nextval('public.notifications_notificationsconfig_id_seq'::regclass);


--
-- Name: notifications_subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription ALTER COLUMN id SET DEFAULT nextval('public.notifications_subscription_id_seq'::regclass);


--
-- Name: vng_api_common_apicredential id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_apicredential_id_seq'::regclass);


--
-- Name: vng_api_common_jwtsecret id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_jwtsecret_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$120000$MnTdamKhPaEQ$H+DUxZKyX9Ih3kNWd/Rblask7u0mIA9XkL2+mQ+bjeM=	2019-06-13 10:21:33.888519+00	t	admin				t	t	2019-06-07 12:16:57.312322+00
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add content type	1	add_contenttype
2	Can change content type	1	change_contenttype
3	Can delete content type	1	delete_contenttype
4	Can view content type	1	view_contenttype
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add session	4	add_session
14	Can change session	4	change_session
15	Can delete session	4	delete_session
16	Can view session	4	view_session
17	Can add site	5	add_site
18	Can change site	5	change_site
19	Can delete site	5	delete_site
20	Can view site	5	view_site
21	Can add log entry	6	add_logentry
22	Can change log entry	6	change_logentry
23	Can delete log entry	6	delete_logentry
24	Can view log entry	6	view_logentry
25	Can add access attempt	7	add_accessattempt
26	Can change access attempt	7	change_accessattempt
27	Can delete access attempt	7	delete_accessattempt
28	Can view access attempt	7	view_accessattempt
29	Can add access log	8	add_accesslog
30	Can change access log	8	change_accesslog
31	Can delete access log	8	delete_accesslog
32	Can view access log	8	view_accesslog
33	Can add cors model	9	add_corsmodel
34	Can change cors model	9	change_corsmodel
35	Can delete cors model	9	delete_corsmodel
36	Can view cors model	9	view_corsmodel
37	Can add client credential	10	add_jwtsecret
38	Can change client credential	10	change_jwtsecret
39	Can delete client credential	10	delete_jwtsecret
40	Can view client credential	10	view_jwtsecret
41	Can add external API credential	11	add_apicredential
42	Can change external API credential	11	change_apicredential
43	Can delete external API credential	11	delete_apicredential
44	Can view external API credential	11	view_apicredential
45	Can add applicatie	12	add_applicatie
46	Can change applicatie	12	change_applicatie
47	Can delete applicatie	12	delete_applicatie
48	Can view applicatie	12	view_applicatie
49	Can add autorisatie	13	add_autorisatie
50	Can change autorisatie	13	change_autorisatie
51	Can delete autorisatie	13	delete_autorisatie
52	Can view autorisatie	13	view_autorisatie
53	Can add Autorisatiecomponentconfiguratie	14	add_authorizationsconfig
54	Can change Autorisatiecomponentconfiguratie	14	change_authorizationsconfig
55	Can delete Autorisatiecomponentconfiguratie	14	delete_authorizationsconfig
56	Can view Autorisatiecomponentconfiguratie	14	view_authorizationsconfig
57	Can add Notificatiescomponentconfiguratie	15	add_notificationsconfig
58	Can change Notificatiescomponentconfiguratie	15	change_notificationsconfig
59	Can delete Notificatiescomponentconfiguratie	15	delete_notificationsconfig
60	Can view Notificatiescomponentconfiguratie	15	view_notificationsconfig
61	Can add Webhook subscription	16	add_subscription
62	Can change Webhook subscription	16	change_subscription
63	Can delete Webhook subscription	16	delete_subscription
64	Can view Webhook subscription	16	view_subscription
65	Can add user	17	add_user
66	Can change user	17	change_user
67	Can delete user	17	delete_user
68	Can view user	17	view_user
\.


--
-- Data for Name: authorizations_applicatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_applicatie (id, uuid, client_ids, label, heeft_alle_autorisaties) FROM stdin;
2	5d83fd8e-395c-4232-9afa-754bd4822ef3	{demo}	nrc	t
3	b7622797-5f85-40e3-8abd-8f3ff476cf70	{demo}	ac	t
1	533fe769-b1f1-49ff-b9fb-5bd01cfe868b	{demo}	zrc	t
\.


--
-- Data for Name: authorizations_authorizationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_authorizationsconfig (id, api_root, component) FROM stdin;
1	http://BASE_IP:8005/api/v1/	AC
\.


--
-- Data for Name: authorizations_autorisatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_autorisatie (id, component, zaaktype, scopes, max_vertrouwelijkheidaanduiding, applicatie_id, besluittype, informatieobjecttype) FROM stdin;
\.


--
-- Data for Name: axes_accessattempt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accessattempt (id, user_agent, ip_address, username, http_accept, path_info, attempt_time, get_data, post_data, failures_since_start) FROM stdin;
\.


--
-- Data for Name: axes_accesslog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accesslog (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, logout_time) FROM stdin;
2	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.14	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:19:23.775378+00	2019-06-13 10:21:23.072908+00
1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.13	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-07 12:17:20.369241+00	2019-06-13 10:21:23.072908+00
3	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.12	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:21:33.895274+00	\N
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-06-07 12:18:18.676465+00	1	BASE_IP:8000	2	[{"changed": {"fields": ["domain", "name"]}}]	5	1
2	2019-06-07 12:18:19.368862+00	1	BASE_IP:8000	2	[]	5	1
3	2019-06-07 12:18:42.26735+00	1	BASE_IP:8005	2	[{"changed": {"fields": ["domain", "name"]}}]	5	1
4	2019-06-07 12:20:27.76497+00	1	demo	1	[{"added": {}}]	10	1
5	2019-06-07 12:23:23.563019+00	1	Applicatie (demo)	1	[{"added": {}}]	12	1
6	2019-06-07 12:33:48.361041+00	2	Applicatie (nrc)	1	[{"added": {}}]	12	1
7	2019-06-07 12:49:29.264186+00	1	autorisaties - http://BASE_IP:8004/api/v1/callback	1	[{"added": {}}]	16	1
8	2019-06-07 12:50:06.668501+00	1	http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["api_root"]}}]	15	1
9	2019-06-07 12:50:57.165096+00	1	http://BASE_IP:8004/api/v1/	2	[{"changed": {"name": "Webhook subscription", "object": "autorisaties - http://BASE_IP:8004/api/v1/", "fields": ["callback_url"]}}]	15	1
10	2019-06-07 12:52:40.27237+00	1	http://BASE_IP:8004/api/v1/	1	[{"added": {}}]	11	1
11	2019-06-07 12:54:01.375499+00	2	http://BASE_IP:8005/api/v1/	1	[{"added": {}}]	11	1
12	2019-06-07 12:55:43.662729+00	1	Applicatie (ac)	2	[{"changed": {"fields": ["label"]}}]	12	1
13	2019-06-07 12:56:33.672208+00	3	Applicatie (ac)	1	[{"added": {}}]	12	1
14	2019-06-07 12:56:46.762849+00	1	Applicatie (zrc)	2	[{"changed": {"fields": ["label"]}}]	12	1
15	2019-06-07 12:57:15.463117+00	1	http://BASE_IP:8005/api/v1/	2	[{"changed": {"fields": ["api_root", "component"]}}]	14	1
16	2019-06-07 13:02:04.071946+00	1	autorisaties - http://BASE_IP:8004/api/v1/callback	2	[{"changed": {"fields": ["callback_url"]}}]	16	1
17	2019-06-07 14:18:53.865104+00	3	http://BASE_IP:8003/api/v1/	1	[{"added": {}}]	11	1
18	2019-06-07 14:19:30.869554+00	4	http://BASE_IP:8002/api/v1/	1	[{"added": {}}]	11	1
19	2019-06-07 14:19:44.074564+00	5	http://BASE_IP:8001/api/v1/	1	[{"added": {}}]	11	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	contenttypes	contenttype
2	auth	permission
3	auth	group
4	sessions	session
5	sites	site
6	admin	logentry
7	axes	accessattempt
8	axes	accesslog
9	corsheaders	corsmodel
10	vng_api_common	jwtsecret
11	vng_api_common	apicredential
12	authorizations	applicatie
13	authorizations	autorisatie
14	authorizations	authorizationsconfig
15	notifications	notificationsconfig
16	notifications	subscription
17	accounts	user
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-06-13 08:13:57.298413+00
2	contenttypes	0002_remove_content_type_name	2019-06-13 08:13:57.431117+00
3	auth	0001_initial	2019-06-13 08:13:58.381117+00
4	auth	0002_alter_permission_name_max_length	2019-06-13 08:13:58.472355+00
5	auth	0003_alter_user_email_max_length	2019-06-13 08:13:58.51199+00
6	auth	0004_alter_user_username_opts	2019-06-13 08:13:58.614762+00
7	auth	0005_alter_user_last_login_null	2019-06-13 08:13:58.714884+00
8	auth	0006_require_contenttypes_0002	2019-06-13 08:13:58.728225+00
9	auth	0007_alter_validators_add_error_messages	2019-06-13 08:13:58.82354+00
10	auth	0008_alter_user_username_max_length	2019-06-13 08:13:58.924852+00
11	accounts	0001_initial	2019-06-13 08:13:59.905705+00
12	admin	0001_initial	2019-06-13 08:14:00.417438+00
13	admin	0002_logentry_remove_auto_add	2019-06-13 08:14:00.580324+00
14	admin	0003_logentry_add_action_flag_choices	2019-06-13 08:14:00.700317+00
15	auth	0009_alter_user_last_name_max_length	2019-06-13 08:14:00.794894+00
16	authorizations	0001_initial	2019-06-13 08:14:01.311714+00
17	authorizations	0002_authorizationsconfig	2019-06-13 08:14:01.508307+00
18	authorizations	0003_auto_20190502_0409	2019-06-13 08:14:01.583987+00
19	authorizations	0004_auto_20190503_0941	2019-06-13 08:14:01.693725+00
20	authorizations	0005_auto_20190506_0842	2019-06-13 08:14:01.791987+00
21	authorizations	0006_auto_20190506_0901	2019-06-13 08:14:02.371551+00
22	authorizations	0007_auto_20190506_1212	2019-06-13 08:14:02.499293+00
23	axes	0001_initial	2019-06-13 08:14:02.90282+00
24	axes	0002_auto_20151217_2044	2019-06-13 08:14:03.490422+00
25	axes	0003_auto_20160322_0929	2019-06-13 08:14:03.800542+00
26	axes	0004_auto_20181024_1538	2019-06-13 08:14:04.197068+00
27	axes	0005_remove_accessattempt_trusted	2019-06-13 08:14:04.293049+00
28	notifications	0001_initial	2019-06-13 08:14:04.78344+00
29	notifications	0002_subscription__subscription	2019-06-13 08:14:04.878916+00
30	notifications	0003_auto_20190319_1048	2019-06-13 08:14:05.202865+00
31	notifications	0004_auto_20190325_1313	2019-06-13 08:14:05.305836+00
32	notifications	0005_fix_default_nrc	2019-06-13 08:14:05.524651+00
33	notifications	0006_auto_20190417_1142	2019-06-13 08:14:05.717119+00
34	notifications	0007_auto_20190429_1442	2019-06-13 08:14:05.818181+00
35	notifications	0008_auto_20190502_0415	2019-06-13 08:14:05.905968+00
36	sessions	0001_initial	2019-06-13 08:14:06.110676+00
37	sites	0001_initial	2019-06-13 08:14:06.222895+00
38	sites	0002_alter_domain_unique	2019-06-13 08:14:06.395681+00
39	vng_api_common	0001_initial	2019-06-13 08:14:06.526258+00
40	vng_api_common	0002_apicredential	2019-06-13 08:14:06.727137+00
41	vng_api_common	0003_auto_20190417_1145	2019-06-13 08:14:06.917988+00
42	vng_api_common	0004_auto_20190517_0903	2019-06-13 08:14:07.011039+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
odwprqlpbudzxfy20zli3ox5iru18nl6	Mjk2YjZhODgyNjA5YTlkZjA5MjE4MzkyM2I0ZDUyOGViNzQ3NzYwZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxM2RkYjhmZTc0M2EzZDEzYTZmMmE0YTE3MzIzMGU4N2NlM2VmOTRiIn0=	2019-06-21 12:17:20.373451+00
s2amnkbqmymm33j4cih5l459b03np6ti	Mjk2YjZhODgyNjA5YTlkZjA5MjE4MzkyM2I0ZDUyOGViNzQ3NzYwZjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxM2RkYjhmZTc0M2EzZDEzYTZmMmE0YTE3MzIzMGU4N2NlM2VmOTRiIn0=	2019-06-27 10:21:33.980689+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	BASE_IP:8005	BASE_IP:8005
\.


--
-- Data for Name: notifications_notificationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_notificationsconfig (id, api_root) FROM stdin;
1	http://BASE_IP:8004/api/v1/
\.


--
-- Data for Name: notifications_subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_subscription (id, callback_url, client_id, secret, channels, config_id, _subscription) FROM stdin;
1	http://BASE_IP:8004/api/v1/callback	demo	demo	{autorisaties}	1
\.


--
-- Data for Name: vng_api_common_apicredential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_apicredential (id, api_root, client_id, secret, label, user_id, user_representation) FROM stdin;
1	http://BASE_IP:8004/api/v1/	demo	demo	nrc	system	system
2	http://BASE_IP:8005/api/v1/	demo	demo	ac	system	system
3	http://BASE_IP:8003/api/v1/	demo	demo	brc	system	system
4	http://BASE_IP:8002/api/v1/	demo	demo	ztc	system	system
5	http://BASE_IP:8001/api/v1/	demo	demo	drc	system	system
\.


--
-- Data for Name: vng_api_common_jwtsecret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_jwtsecret (id, identifier, secret) FROM stdin;
1	demo	demo
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 1, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 68, true);


--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_applicatie_id_seq', 3, true);


--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_authorizationsconfig_id_seq', 1, false);


--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_autorisatie_id_seq', 1, false);


--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accessattempt_id_seq', 1, false);


--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accesslog_id_seq', 3, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 19, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 17, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 42, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notificationsconfig_id_seq', 1, false);


--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_subscription_id_seq', 1, true);


--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_apicredential_id_seq', 5, true);


--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_jwtsecret_id_seq', 1, true);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_uuid_key UNIQUE (uuid);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_api_root_key UNIQUE (api_root);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_pkey PRIMARY KEY (id);


--
-- Name: authorizations_autorisatie authorizations_autorisatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autorisatie_pkey PRIMARY KEY (id);


--
-- Name: axes_accessattempt axes_accessattempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt
    ADD CONSTRAINT axes_accessattempt_pkey PRIMARY KEY (id);


--
-- Name: axes_accesslog axes_accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog
    ADD CONSTRAINT axes_accesslog_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_api_root_e4030d56_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_api_root_e4030d56_uniq UNIQUE (api_root);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_pkey PRIMARY KEY (id);


--
-- Name: notifications_subscription notifications_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscription_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_api_root_key UNIQUE (api_root);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_identifier_key UNIQUE (identifier);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authorizations_authorizationsconfig_api_root_0b54af71_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_authorizationsconfig_api_root_0b54af71_like ON public.authorizations_authorizationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: authorizations_autorisatie_applicatie_id_44348ea1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_autorisatie_applicatie_id_44348ea1 ON public.authorizations_autorisatie USING btree (applicatie_id);


--
-- Name: axes_accessattempt_ip_address_10922d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_ip_address_10922d9c ON public.axes_accessattempt USING btree (ip_address);


--
-- Name: axes_accessattempt_user_agent_ad89678b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b ON public.axes_accessattempt USING btree (user_agent);


--
-- Name: axes_accessattempt_user_agent_ad89678b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b_like ON public.axes_accessattempt USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accessattempt_username_3f2d4ca0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0 ON public.axes_accessattempt USING btree (username);


--
-- Name: axes_accessattempt_username_3f2d4ca0_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0_like ON public.axes_accessattempt USING btree (username varchar_pattern_ops);


--
-- Name: axes_accesslog_ip_address_86b417e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_ip_address_86b417e5 ON public.axes_accesslog USING btree (ip_address);


--
-- Name: axes_accesslog_trusted_496c5681; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_trusted_496c5681 ON public.axes_accesslog USING btree (trusted);


--
-- Name: axes_accesslog_user_agent_0e659004; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004 ON public.axes_accesslog USING btree (user_agent);


--
-- Name: axes_accesslog_user_agent_0e659004_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004_like ON public.axes_accesslog USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accesslog_username_df93064b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b ON public.axes_accesslog USING btree (username);


--
-- Name: axes_accesslog_username_df93064b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b_like ON public.axes_accesslog USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: notifications_notificationsconfig_api_root_e4030d56_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_notificationsconfig_api_root_e4030d56_like ON public.notifications_notificationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: notifications_subscription_config_id_3567b13c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_subscription_config_id_3567b13c ON public.notifications_subscription USING btree (config_id);


--
-- Name: vng_api_common_apicredential_api_root_cb3905ed_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_apicredential_api_root_cb3905ed_like ON public.vng_api_common_apicredential USING btree (api_root varchar_pattern_ops);


--
-- Name: vng_api_common_jwtsecret_identifier_e89b809e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_jwtsecret_identifier_e89b809e_like ON public.vng_api_common_jwtsecret USING btree (identifier varchar_pattern_ops);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authorizations_autorisatie authorizations_autor_applicatie_id_44348ea1_fk_authoriza; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autor_applicatie_id_44348ea1_fk_authoriza FOREIGN KEY (applicatie_id) REFERENCES public.authorizations_applicatie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_subscription notifications_subscr_config_id_3567b13c_fk_notificat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscr_config_id_3567b13c_fk_notificat FOREIGN KEY (config_id) REFERENCES public.notifications_notificationsconfig(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: brc; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE brc WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE brc OWNER TO postgres;

\connect brc

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: audittrails_audittrail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audittrails_audittrail (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    bron character varying(50) NOT NULL,
    actie character varying(50) NOT NULL,
    actie_weergave character varying(200) NOT NULL,
    resultaat integer NOT NULL,
    hoofd_object character varying(1000) NOT NULL,
    resource character varying(50) NOT NULL,
    resource_url character varying(1000) NOT NULL,
    aanmaakdatum timestamp with time zone NOT NULL,
    oud jsonb,
    nieuw jsonb,
    applicatie_id character varying(100) NOT NULL,
    applicatie_weergave character varying(200) NOT NULL,
    gebruikers_id character varying(255) NOT NULL,
    gebruikers_weergave character varying(255) NOT NULL,
    toelichting text NOT NULL
);


ALTER TABLE public.audittrails_audittrail OWNER TO postgres;

--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audittrails_audittrail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audittrails_audittrail_id_seq OWNER TO postgres;

--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audittrails_audittrail_id_seq OWNED BY public.audittrails_audittrail.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authorizations_applicatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_applicatie (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    client_ids character varying(50)[] NOT NULL,
    label character varying(100) NOT NULL,
    heeft_alle_autorisaties boolean NOT NULL
);


ALTER TABLE public.authorizations_applicatie OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_applicatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_applicatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_applicatie_id_seq OWNED BY public.authorizations_applicatie.id;


--
-- Name: authorizations_authorizationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_authorizationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    component character varying(50) NOT NULL
);


ALTER TABLE public.authorizations_authorizationsconfig OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_authorizationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_authorizationsconfig_id_seq OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_authorizationsconfig_id_seq OWNED BY public.authorizations_authorizationsconfig.id;


--
-- Name: authorizations_autorisatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_autorisatie (
    id integer NOT NULL,
    component character varying(50) NOT NULL,
    zaaktype character varying(1000) NOT NULL,
    scopes character varying(100)[] NOT NULL,
    max_vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    applicatie_id integer NOT NULL,
    besluittype character varying(1000) NOT NULL,
    informatieobjecttype character varying(1000) NOT NULL
);


ALTER TABLE public.authorizations_autorisatie OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_autorisatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_autorisatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_autorisatie_id_seq OWNED BY public.authorizations_autorisatie.id;


--
-- Name: axes_accessattempt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accessattempt (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    get_data text NOT NULL,
    post_data text NOT NULL,
    failures_since_start integer NOT NULL,
    CONSTRAINT axes_accessattempt_failures_since_start_check CHECK ((failures_since_start >= 0))
);


ALTER TABLE public.axes_accessattempt OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accessattempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accessattempt_id_seq OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accessattempt_id_seq OWNED BY public.axes_accessattempt.id;


--
-- Name: axes_accesslog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accesslog (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    logout_time timestamp with time zone
);


ALTER TABLE public.axes_accesslog OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accesslog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accesslog_id_seq OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accesslog_id_seq OWNED BY public.axes_accesslog.id;


--
-- Name: datamodel_besluit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_besluit (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    identificatie character varying(50) NOT NULL,
    verantwoordelijke_organisatie character varying(9) NOT NULL,
    besluittype character varying(200) NOT NULL,
    zaak character varying(200) NOT NULL,
    datum date NOT NULL,
    toelichting text NOT NULL,
    bestuursorgaan character varying(50) NOT NULL,
    ingangsdatum date NOT NULL,
    vervaldatum date,
    publicatiedatum date,
    verzenddatum date,
    uiterlijke_reactiedatum date,
    vervalreden character varying(30) NOT NULL,
    _zaakbesluit character varying(200) NOT NULL
);


ALTER TABLE public.datamodel_besluit OWNER TO postgres;

--
-- Name: datamodel_besluit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_besluit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_besluit_id_seq OWNER TO postgres;

--
-- Name: datamodel_besluit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_besluit_id_seq OWNED BY public.datamodel_besluit.id;


--
-- Name: datamodel_besluitinformatieobject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_besluitinformatieobject (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    informatieobject character varying(1000) NOT NULL,
    besluit_id integer NOT NULL,
    aard_relatie character varying(20) NOT NULL
);


ALTER TABLE public.datamodel_besluitinformatieobject OWNER TO postgres;

--
-- Name: datamodel_besluitinformatieobject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_besluitinformatieobject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_besluitinformatieobject_id_seq OWNER TO postgres;

--
-- Name: datamodel_besluitinformatieobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_besluitinformatieobject_id_seq OWNED BY public.datamodel_besluitinformatieobject.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: notifications_notificationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_notificationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL
);


ALTER TABLE public.notifications_notificationsconfig OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notificationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_notificationsconfig_id_seq OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notificationsconfig_id_seq OWNED BY public.notifications_notificationsconfig.id;


--
-- Name: notifications_subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_subscription (
    id integer NOT NULL,
    callback_url character varying(200) NOT NULL,
    client_id character varying(50) NOT NULL,
    secret character varying(50) NOT NULL,
    channels character varying(100)[] NOT NULL,
    config_id integer NOT NULL,
    _subscription character varying(200) NOT NULL
);


ALTER TABLE public.notifications_subscription OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_subscription_id_seq OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_subscription_id_seq OWNED BY public.notifications_subscription.id;


--
-- Name: vng_api_common_apicredential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_apicredential (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    client_id character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    label character varying(100) NOT NULL,
    user_id character varying(255) NOT NULL,
    user_representation character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_apicredential OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_apicredential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_apicredential_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_apicredential_id_seq OWNED BY public.vng_api_common_apicredential.id;


--
-- Name: vng_api_common_jwtsecret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_jwtsecret (
    id integer NOT NULL,
    identifier character varying(50) NOT NULL,
    secret character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_jwtsecret OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_jwtsecret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_jwtsecret_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_jwtsecret_id_seq OWNED BY public.vng_api_common_jwtsecret.id;


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: audittrails_audittrail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail ALTER COLUMN id SET DEFAULT nextval('public.audittrails_audittrail_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: authorizations_applicatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_applicatie_id_seq'::regclass);


--
-- Name: authorizations_authorizationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig ALTER COLUMN id SET DEFAULT nextval('public.authorizations_authorizationsconfig_id_seq'::regclass);


--
-- Name: authorizations_autorisatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_autorisatie_id_seq'::regclass);


--
-- Name: axes_accessattempt id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt ALTER COLUMN id SET DEFAULT nextval('public.axes_accessattempt_id_seq'::regclass);


--
-- Name: axes_accesslog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog ALTER COLUMN id SET DEFAULT nextval('public.axes_accesslog_id_seq'::regclass);


--
-- Name: datamodel_besluit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluit ALTER COLUMN id SET DEFAULT nextval('public.datamodel_besluit_id_seq'::regclass);


--
-- Name: datamodel_besluitinformatieobject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluitinformatieobject ALTER COLUMN id SET DEFAULT nextval('public.datamodel_besluitinformatieobject_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: notifications_notificationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig ALTER COLUMN id SET DEFAULT nextval('public.notifications_notificationsconfig_id_seq'::regclass);


--
-- Name: notifications_subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription ALTER COLUMN id SET DEFAULT nextval('public.notifications_subscription_id_seq'::regclass);


--
-- Name: vng_api_common_apicredential id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_apicredential_id_seq'::regclass);


--
-- Name: vng_api_common_jwtsecret id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_jwtsecret_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$150000$Mqs1KNU8t3ZY$QbeI221pQq1a8MtRUeE/SHn26gOOZb/U0Oxy6cHZqfI=	2019-06-13 10:36:37.17542+00	t	admin				t	t	2019-06-07 13:19:18.668316+00
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: audittrails_audittrail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audittrails_audittrail (id, uuid, bron, actie, actie_weergave, resultaat, hoofd_object, resource, resource_url, aanmaakdatum, oud, nieuw, applicatie_id, applicatie_weergave, gebruikers_id, gebruikers_weergave, toelichting) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add content type	1	add_contenttype
2	Can change content type	1	change_contenttype
3	Can delete content type	1	delete_contenttype
4	Can view content type	1	view_contenttype
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add session	4	add_session
14	Can change session	4	change_session
15	Can delete session	4	delete_session
16	Can view session	4	view_session
17	Can add site	5	add_site
18	Can change site	5	change_site
19	Can delete site	5	delete_site
20	Can view site	5	view_site
21	Can add log entry	6	add_logentry
22	Can change log entry	6	change_logentry
23	Can delete log entry	6	delete_logentry
24	Can view log entry	6	view_logentry
25	Can add access attempt	7	add_accessattempt
26	Can change access attempt	7	change_accessattempt
27	Can delete access attempt	7	delete_accessattempt
28	Can view access attempt	7	view_accessattempt
29	Can add access log	8	add_accesslog
30	Can change access log	8	change_accesslog
31	Can delete access log	8	delete_accesslog
32	Can view access log	8	view_accesslog
33	Can add cors model	9	add_corsmodel
34	Can change cors model	9	change_corsmodel
35	Can delete cors model	9	delete_corsmodel
36	Can view cors model	9	view_corsmodel
37	Can add client credential	10	add_jwtsecret
38	Can change client credential	10	change_jwtsecret
39	Can delete client credential	10	delete_jwtsecret
40	Can view client credential	10	view_jwtsecret
41	Can add external API credential	11	add_apicredential
42	Can change external API credential	11	change_apicredential
43	Can delete external API credential	11	delete_apicredential
44	Can view external API credential	11	view_apicredential
45	Can add Notificatiescomponentconfiguratie	12	add_notificationsconfig
46	Can change Notificatiescomponentconfiguratie	12	change_notificationsconfig
47	Can delete Notificatiescomponentconfiguratie	12	delete_notificationsconfig
48	Can view Notificatiescomponentconfiguratie	12	view_notificationsconfig
49	Can add Webhook subscription	13	add_subscription
50	Can change Webhook subscription	13	change_subscription
51	Can delete Webhook subscription	13	delete_subscription
52	Can view Webhook subscription	13	view_subscription
53	Can add applicatie	14	add_applicatie
54	Can change applicatie	14	change_applicatie
55	Can delete applicatie	14	delete_applicatie
56	Can view applicatie	14	view_applicatie
57	Can add autorisatie	15	add_autorisatie
58	Can change autorisatie	15	change_autorisatie
59	Can delete autorisatie	15	delete_autorisatie
60	Can view autorisatie	15	view_autorisatie
61	Can add Autorisatiecomponentconfiguratie	16	add_authorizationsconfig
62	Can change Autorisatiecomponentconfiguratie	16	change_authorizationsconfig
63	Can delete Autorisatiecomponentconfiguratie	16	delete_authorizationsconfig
64	Can view Autorisatiecomponentconfiguratie	16	view_authorizationsconfig
65	Can add audit trail	17	add_audittrail
66	Can change audit trail	17	change_audittrail
67	Can delete audit trail	17	delete_audittrail
68	Can view audit trail	17	view_audittrail
69	Can add user	18	add_user
70	Can change user	18	change_user
71	Can delete user	18	delete_user
72	Can view user	18	view_user
73	Can add besluit	19	add_besluit
74	Can change besluit	19	change_besluit
75	Can delete besluit	19	delete_besluit
76	Can view besluit	19	view_besluit
77	Can add besluitinformatieobject	20	add_besluitinformatieobject
78	Can change besluitinformatieobject	20	change_besluitinformatieobject
79	Can delete besluitinformatieobject	20	delete_besluitinformatieobject
80	Can view besluitinformatieobject	20	view_besluitinformatieobject
\.


--
-- Data for Name: authorizations_applicatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_applicatie (id, uuid, client_ids, label, heeft_alle_autorisaties) FROM stdin;
\.


--
-- Data for Name: authorizations_authorizationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_authorizationsconfig (id, api_root, component) FROM stdin;
1	http://BASE_IP:8005/api/v1/	BRC
\.


--
-- Data for Name: authorizations_autorisatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_autorisatie (id, component, zaaktype, scopes, max_vertrouwelijkheidaanduiding, applicatie_id, besluittype, informatieobjecttype) FROM stdin;
\.


--
-- Data for Name: axes_accessattempt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accessattempt (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, get_data, post_data, failures_since_start) FROM stdin;
1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.13	admin	f	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-07 13:18:31.363108+00	next=/admin/	csrfmiddlewaretoken=Ml8qDU79EtsZ2BAa7QkADknuR0JG6EmuOTrIh7uiUi0DVMtBrf52hiucoSNAfVTk\nusername=admin\nnext=/admin/	1
\.


--
-- Data for Name: axes_accesslog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accesslog (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, logout_time) FROM stdin;
1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.13	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-07 13:19:42.96529+00	\N
2	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.12	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:36:37.179645+00	\N
\.


--
-- Data for Name: datamodel_besluit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_besluit (id, uuid, identificatie, verantwoordelijke_organisatie, besluittype, zaak, datum, toelichting, bestuursorgaan, ingangsdatum, vervaldatum, publicatiedatum, verzenddatum, uiterlijke_reactiedatum, vervalreden, _zaakbesluit) FROM stdin;
\.


--
-- Data for Name: datamodel_besluitinformatieobject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_besluitinformatieobject (id, uuid, informatieobject, besluit_id, aard_relatie) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-06-07 13:20:05.96895+00	1	BASE_IP:8003	2	[{"changed": {"fields": ["domain", "name"]}}]	5	1
2	2019-06-07 13:21:34.667206+00	1	http://BASE_IP:8005/api/v1/	2	[{"changed": {"fields": ["api_root", "component"]}}]	16	1
3	2019-06-07 13:22:08.565686+00	1	http://BASE_IP:8004/api/v1/	1	[{"added": {}}]	11	1
4	2019-06-07 13:22:38.965729+00	2	http://BASE_IP:8003/api/v1/	1	[{"added": {}}]	11	1
5	2019-06-07 13:22:44.067092+00	1	http://BASE_IP:8005/api/v1/	2	[{"changed": {"fields": ["api_root"]}}]	11	1
6	2019-06-07 13:22:49.789159+00	2	http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["api_root"]}}]	11	1
7	2019-06-07 13:24:11.067986+00	1	http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["api_root"]}}, {"added": {"name": "Webhook subscription", "object": "autorisaties - http://BASE_IP:8004/api/v1/callback"}}]	12	1
8	2019-06-07 13:52:23.969213+00	1	autorisaties - http://BASE_IP:8003/api/v1/callback	2	[{"changed": {"fields": ["callback_url"]}}]	13	1
9	2019-06-07 14:17:17.56678+00	3	http://BASE_IP:8003/api/v1/	1	[{"added": {}}]	11	1
10	2019-06-07 14:17:31.48455+00	4	http://BASE_IP:8002/api/v1/	1	[{"added": {}}]	11	1
11	2019-06-07 14:17:43.965855+00	5	http://BASE_IP:8001/api/v1/	1	[{"added": {}}]	11	1
12	2019-06-13 10:36:43.475034+00	1	demo	1	[{"added": {}}]	10	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	contenttypes	contenttype
2	auth	permission
3	auth	group
4	sessions	session
5	sites	site
6	admin	logentry
7	axes	accessattempt
8	axes	accesslog
9	corsheaders	corsmodel
10	vng_api_common	jwtsecret
11	vng_api_common	apicredential
12	notifications	notificationsconfig
13	notifications	subscription
14	authorizations	applicatie
15	authorizations	autorisatie
16	authorizations	authorizationsconfig
17	audittrails	audittrail
18	accounts	user
19	datamodel	besluit
20	datamodel	besluitinformatieobject
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-06-13 08:13:56.137367+00
2	contenttypes	0002_remove_content_type_name	2019-06-13 08:13:56.275019+00
3	auth	0001_initial	2019-06-13 08:13:56.61644+00
4	auth	0002_alter_permission_name_max_length	2019-06-13 08:13:57.212857+00
5	auth	0003_alter_user_email_max_length	2019-06-13 08:13:57.320548+00
6	auth	0004_alter_user_username_opts	2019-06-13 08:13:57.435826+00
7	auth	0005_alter_user_last_login_null	2019-06-13 08:13:57.540788+00
8	auth	0006_require_contenttypes_0002	2019-06-13 08:13:57.559297+00
9	auth	0007_alter_validators_add_error_messages	2019-06-13 08:13:57.627755+00
10	auth	0008_alter_user_username_max_length	2019-06-13 08:13:57.716086+00
11	auth	0009_alter_user_last_name_max_length	2019-06-13 08:13:57.821394+00
12	accounts	0001_initial	2019-06-13 08:13:58.196997+00
13	admin	0001_initial	2019-06-13 08:13:59.023049+00
14	admin	0002_logentry_remove_auto_add	2019-06-13 08:13:59.375048+00
15	admin	0003_logentry_add_action_flag_choices	2019-06-13 08:13:59.491025+00
16	audittrails	0001_initial	2019-06-13 08:13:59.742197+00
17	audittrails	0002_auto_20190516_0830	2019-06-13 08:13:59.825895+00
18	audittrails	0003_auto_20190517_0844	2019-06-13 08:14:00.282979+00
19	audittrails	0004_auto_20190520_1238	2019-06-13 08:14:00.394292+00
20	audittrails	0005_auto_20190520_1450	2019-06-13 08:14:00.481068+00
21	audittrails	0006_audittrail_toelichting	2019-06-13 08:14:00.507269+00
22	audittrails	0007_auto_20190522_0916	2019-06-13 08:14:00.654413+00
23	auth	0010_alter_group_name_max_length	2019-06-13 08:14:00.810174+00
24	auth	0011_update_proxy_permissions	2019-06-13 08:14:00.920819+00
25	authorizations	0001_initial	2019-06-13 08:14:01.273797+00
26	authorizations	0002_authorizationsconfig	2019-06-13 08:14:01.502177+00
27	authorizations	0003_auto_20190502_0409	2019-06-13 08:14:01.618002+00
28	authorizations	0004_auto_20190503_0941	2019-06-13 08:14:01.705278+00
29	authorizations	0005_auto_20190506_0842	2019-06-13 08:14:01.783817+00
30	authorizations	0006_auto_20190506_0901	2019-06-13 08:14:02.396155+00
31	authorizations	0007_auto_20190506_1212	2019-06-13 08:14:02.508545+00
32	axes	0001_initial	2019-06-13 08:14:02.901862+00
33	axes	0002_auto_20151217_2044	2019-06-13 08:14:03.486902+00
34	axes	0003_auto_20160322_0929	2019-06-13 08:14:03.7996+00
35	datamodel	0001_initial	2019-06-13 08:14:04.103124+00
36	datamodel	0002_auto_20180906_0950	2019-06-13 08:14:04.221941+00
37	datamodel	0003_besluit_vervalreden	2019-06-13 08:14:04.316805+00
38	datamodel	0004_auto_20181029_0959	2019-06-13 08:14:04.586918+00
39	datamodel	0005_auto_20181029_1150	2019-06-13 08:14:04.784541+00
40	datamodel	0006_auto_20181119_0828	2019-06-13 08:14:04.812688+00
41	datamodel	0007_auto_20190528_0940	2019-06-13 08:14:05.117255+00
42	datamodel	0008_besluit__zaakbesluit	2019-06-13 08:14:05.205158+00
43	notifications	0001_initial	2019-06-13 08:14:05.482092+00
44	notifications	0002_subscription__subscription	2019-06-13 08:14:05.636934+00
45	notifications	0003_auto_20190319_1048	2019-06-13 08:14:05.989748+00
46	notifications	0004_auto_20190325_1313	2019-06-13 08:14:06.01308+00
47	notifications	0005_fix_default_nrc	2019-06-13 08:14:06.372294+00
48	notifications	0006_auto_20190417_1142	2019-06-13 08:14:06.50937+00
49	notifications	0007_auto_20190429_1442	2019-06-13 08:14:07.326145+00
50	notifications	0008_auto_20190502_0415	2019-06-13 08:14:07.395914+00
51	sessions	0001_initial	2019-06-13 08:14:07.503547+00
52	sites	0001_initial	2019-06-13 08:14:07.721057+00
53	sites	0002_alter_domain_unique	2019-06-13 08:14:07.873057+00
54	vng_api_common	0001_initial	2019-06-13 08:14:08.020976+00
55	vng_api_common	0002_apicredential	2019-06-13 08:14:08.407713+00
56	vng_api_common	0003_auto_20190417_1145	2019-06-13 08:14:08.611593+00
57	vng_api_common	0004_auto_20190517_0903	2019-06-13 08:14:08.690938+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
bgm6bvragksrejuvrvsco1ryhjtx1104	NWVkNzhlY2VhYmI2NDc3MTdhNGIxOGI2NzRjZTAwNTAzZDJjMzMwOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYmMxNTE4ZGI2MDFkYWZjMWM0ODE1N2VlODkxOGM3N2UzMTc1MzRlIn0=	2019-06-21 13:19:42.969416+00
qjiapws1vrt74kfla7zllfvdf3dcjum1	NWVkNzhlY2VhYmI2NDc3MTdhNGIxOGI2NzRjZTAwNTAzZDJjMzMwOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYmMxNTE4ZGI2MDFkYWZjMWM0ODE1N2VlODkxOGM3N2UzMTc1MzRlIn0=	2019-06-27 10:36:37.184166+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	BASE_IP:8003	BASE_IP:8003
\.


--
-- Data for Name: notifications_notificationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_notificationsconfig (id, api_root) FROM stdin;
1	http://BASE_IP:8004/api/v1/
\.


--
-- Data for Name: notifications_subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_subscription (id, callback_url, client_id, secret, channels, config_id, _subscription) FROM stdin;
1	http://BASE_IP:8003/api/v1/callback	demo	demo	{autorisaties}	1	http://BASE_IP:8004/api/v1/abonnement/4a8f0ab6-8600-4069-a4a2-caa13a72c815
\.


--
-- Data for Name: vng_api_common_apicredential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_apicredential (id, api_root, client_id, secret, label, user_id, user_representation) FROM stdin;
1	http://BASE_IP:8005/api/v1/	demo	demo	ac	system	system
2	http://BASE_IP:8004/api/v1/	demo	demo	nrc	system	system
3	http://BASE_IP:8003/api/v1/	demo	demo	brc	system	system
4	http://BASE_IP:8002/api/v1/	demo	demo	ztc	system	system
5	http://BASE_IP:8001/api/v1/	demo	demo	drc	system	system
\.


--
-- Data for Name: vng_api_common_jwtsecret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_jwtsecret (id, identifier, secret) FROM stdin;
1	demo	demo
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 1, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audittrails_audittrail_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 80, true);


--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_applicatie_id_seq', 1, false);


--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_authorizationsconfig_id_seq', 1, false);


--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_autorisatie_id_seq', 1, false);


--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accessattempt_id_seq', 1, true);


--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accesslog_id_seq', 2, true);


--
-- Name: datamodel_besluit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_besluit_id_seq', 1, false);


--
-- Name: datamodel_besluitinformatieobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_besluitinformatieobject_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 12, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 20, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 57, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notificationsconfig_id_seq', 1, false);


--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_subscription_id_seq', 1, true);


--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_apicredential_id_seq', 5, true);


--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_jwtsecret_id_seq', 1, true);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: audittrails_audittrail audittrails_audittrail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail
    ADD CONSTRAINT audittrails_audittrail_pkey PRIMARY KEY (id);


--
-- Name: audittrails_audittrail audittrails_audittrail_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail
    ADD CONSTRAINT audittrails_audittrail_uuid_key UNIQUE (uuid);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_uuid_key UNIQUE (uuid);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_api_root_key UNIQUE (api_root);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_pkey PRIMARY KEY (id);


--
-- Name: authorizations_autorisatie authorizations_autorisatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autorisatie_pkey PRIMARY KEY (id);


--
-- Name: axes_accessattempt axes_accessattempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt
    ADD CONSTRAINT axes_accessattempt_pkey PRIMARY KEY (id);


--
-- Name: axes_accesslog axes_accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog
    ADD CONSTRAINT axes_accesslog_pkey PRIMARY KEY (id);


--
-- Name: datamodel_besluit datamodel_besluit_identificatie_verantwoor_15e165db_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluit
    ADD CONSTRAINT datamodel_besluit_identificatie_verantwoor_15e165db_uniq UNIQUE (identificatie, verantwoordelijke_organisatie);


--
-- Name: datamodel_besluit datamodel_besluit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluit
    ADD CONSTRAINT datamodel_besluit_pkey PRIMARY KEY (id);


--
-- Name: datamodel_besluitinformatieobject datamodel_besluitinforma_besluit_id_informatieobj_874d222d_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluitinformatieobject
    ADD CONSTRAINT datamodel_besluitinforma_besluit_id_informatieobj_874d222d_uniq UNIQUE (besluit_id, informatieobject);


--
-- Name: datamodel_besluitinformatieobject datamodel_besluitinformatieobject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluitinformatieobject
    ADD CONSTRAINT datamodel_besluitinformatieobject_pkey PRIMARY KEY (id);


--
-- Name: datamodel_besluitinformatieobject datamodel_besluitinformatieobject_uuid_170a5345_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluitinformatieobject
    ADD CONSTRAINT datamodel_besluitinformatieobject_uuid_170a5345_uniq UNIQUE (uuid);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_api_root_e4030d56_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_api_root_e4030d56_uniq UNIQUE (api_root);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_pkey PRIMARY KEY (id);


--
-- Name: notifications_subscription notifications_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscription_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_api_root_key UNIQUE (api_root);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_identifier_key UNIQUE (identifier);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authorizations_authorizationsconfig_api_root_0b54af71_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_authorizationsconfig_api_root_0b54af71_like ON public.authorizations_authorizationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: authorizations_autorisatie_applicatie_id_44348ea1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_autorisatie_applicatie_id_44348ea1 ON public.authorizations_autorisatie USING btree (applicatie_id);


--
-- Name: axes_accessattempt_ip_address_10922d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_ip_address_10922d9c ON public.axes_accessattempt USING btree (ip_address);


--
-- Name: axes_accessattempt_trusted_0eddf52e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_trusted_0eddf52e ON public.axes_accessattempt USING btree (trusted);


--
-- Name: axes_accessattempt_user_agent_ad89678b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b ON public.axes_accessattempt USING btree (user_agent);


--
-- Name: axes_accessattempt_user_agent_ad89678b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b_like ON public.axes_accessattempt USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accessattempt_username_3f2d4ca0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0 ON public.axes_accessattempt USING btree (username);


--
-- Name: axes_accessattempt_username_3f2d4ca0_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0_like ON public.axes_accessattempt USING btree (username varchar_pattern_ops);


--
-- Name: axes_accesslog_ip_address_86b417e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_ip_address_86b417e5 ON public.axes_accesslog USING btree (ip_address);


--
-- Name: axes_accesslog_trusted_496c5681; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_trusted_496c5681 ON public.axes_accesslog USING btree (trusted);


--
-- Name: axes_accesslog_user_agent_0e659004; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004 ON public.axes_accesslog USING btree (user_agent);


--
-- Name: axes_accesslog_user_agent_0e659004_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004_like ON public.axes_accesslog USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accesslog_username_df93064b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b ON public.axes_accesslog USING btree (username);


--
-- Name: axes_accesslog_username_df93064b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b_like ON public.axes_accesslog USING btree (username varchar_pattern_ops);


--
-- Name: datamodel_besluitinformatieobject_besluit_id_4510d2fe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_besluitinformatieobject_besluit_id_4510d2fe ON public.datamodel_besluitinformatieobject USING btree (besluit_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: notifications_notificationsconfig_api_root_e4030d56_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_notificationsconfig_api_root_e4030d56_like ON public.notifications_notificationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: notifications_subscription_config_id_3567b13c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_subscription_config_id_3567b13c ON public.notifications_subscription USING btree (config_id);


--
-- Name: vng_api_common_apicredential_api_root_cb3905ed_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_apicredential_api_root_cb3905ed_like ON public.vng_api_common_apicredential USING btree (api_root varchar_pattern_ops);


--
-- Name: vng_api_common_jwtsecret_identifier_e89b809e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_jwtsecret_identifier_e89b809e_like ON public.vng_api_common_jwtsecret USING btree (identifier varchar_pattern_ops);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authorizations_autorisatie authorizations_autor_applicatie_id_44348ea1_fk_authoriza; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autor_applicatie_id_44348ea1_fk_authoriza FOREIGN KEY (applicatie_id) REFERENCES public.authorizations_applicatie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_besluitinformatieobject datamodel_besluitinf_besluit_id_4510d2fe_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluitinformatieobject
    ADD CONSTRAINT datamodel_besluitinf_besluit_id_4510d2fe_fk_datamodel FOREIGN KEY (besluit_id) REFERENCES public.datamodel_besluit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_subscription notifications_subscr_config_id_3567b13c_fk_notificat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscr_config_id_3567b13c_fk_notificat FOREIGN KEY (config_id) REFERENCES public.notifications_notificationsconfig(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: drc; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE drc WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE drc OWNER TO postgres;

\connect drc

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: audittrails_audittrail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audittrails_audittrail (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    bron character varying(50) NOT NULL,
    actie character varying(50) NOT NULL,
    actie_weergave character varying(200) NOT NULL,
    resultaat integer NOT NULL,
    hoofd_object character varying(1000) NOT NULL,
    resource character varying(50) NOT NULL,
    resource_url character varying(1000) NOT NULL,
    aanmaakdatum timestamp with time zone NOT NULL,
    oud jsonb,
    nieuw jsonb,
    applicatie_id character varying(100) NOT NULL,
    applicatie_weergave character varying(200) NOT NULL,
    gebruikers_id character varying(255) NOT NULL,
    gebruikers_weergave character varying(255) NOT NULL,
    toelichting text NOT NULL
);


ALTER TABLE public.audittrails_audittrail OWNER TO postgres;

--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audittrails_audittrail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audittrails_audittrail_id_seq OWNER TO postgres;

--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audittrails_audittrail_id_seq OWNED BY public.audittrails_audittrail.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authorizations_applicatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_applicatie (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    client_ids character varying(50)[] NOT NULL,
    label character varying(100) NOT NULL,
    heeft_alle_autorisaties boolean NOT NULL
);


ALTER TABLE public.authorizations_applicatie OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_applicatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_applicatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_applicatie_id_seq OWNED BY public.authorizations_applicatie.id;


--
-- Name: authorizations_authorizationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_authorizationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    component character varying(50) NOT NULL
);


ALTER TABLE public.authorizations_authorizationsconfig OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_authorizationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_authorizationsconfig_id_seq OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_authorizationsconfig_id_seq OWNED BY public.authorizations_authorizationsconfig.id;


--
-- Name: authorizations_autorisatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_autorisatie (
    id integer NOT NULL,
    component character varying(50) NOT NULL,
    zaaktype character varying(1000) NOT NULL,
    scopes character varying(100)[] NOT NULL,
    max_vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    applicatie_id integer NOT NULL,
    besluittype character varying(1000) NOT NULL,
    informatieobjecttype character varying(1000) NOT NULL
);


ALTER TABLE public.authorizations_autorisatie OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_autorisatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_autorisatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_autorisatie_id_seq OWNED BY public.authorizations_autorisatie.id;


--
-- Name: axes_accessattempt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accessattempt (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    get_data text NOT NULL,
    post_data text NOT NULL,
    failures_since_start integer NOT NULL,
    CONSTRAINT axes_accessattempt_failures_since_start_check CHECK ((failures_since_start >= 0))
);


ALTER TABLE public.axes_accessattempt OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accessattempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accessattempt_id_seq OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accessattempt_id_seq OWNED BY public.axes_accessattempt.id;


--
-- Name: axes_accesslog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accesslog (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    logout_time timestamp with time zone
);


ALTER TABLE public.axes_accesslog OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accesslog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accesslog_id_seq OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accesslog_id_seq OWNED BY public.axes_accesslog.id;


--
-- Name: datamodel_enkelvoudiginformatieobject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_enkelvoudiginformatieobject (
    id integer NOT NULL,
    identificatie character varying(40) NOT NULL,
    bronorganisatie character varying(9) NOT NULL,
    creatiedatum date NOT NULL,
    titel character varying(200) NOT NULL,
    auteur character varying(200) NOT NULL,
    formaat character varying(255) NOT NULL,
    taal character varying(3) NOT NULL,
    inhoud character varying(100) NOT NULL,
    uuid uuid NOT NULL,
    vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    beschrijving text NOT NULL,
    informatieobjecttype character varying(200) NOT NULL,
    link character varying(200) NOT NULL,
    bestandsnaam character varying(255) NOT NULL,
    integriteit_algoritme character varying(20) NOT NULL,
    integriteit_datum date,
    integriteit_waarde character varying(128) NOT NULL,
    ontvangstdatum date,
    indicatie_gebruiksrecht boolean,
    verzenddatum date,
    ondertekening_datum date,
    ondertekening_soort character varying(10) NOT NULL,
    status character varying(20) NOT NULL,
    lock character varying(100) NOT NULL
);


ALTER TABLE public.datamodel_enkelvoudiginformatieobject OWNER TO postgres;

--
-- Name: datamodel_enkelvoudiginformatieobject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_enkelvoudiginformatieobject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_enkelvoudiginformatieobject_id_seq OWNER TO postgres;

--
-- Name: datamodel_enkelvoudiginformatieobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_enkelvoudiginformatieobject_id_seq OWNED BY public.datamodel_enkelvoudiginformatieobject.id;


--
-- Name: datamodel_gebruiksrechten; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_gebruiksrechten (
    id integer NOT NULL,
    omschrijving_voorwaarden text NOT NULL,
    startdatum timestamp with time zone NOT NULL,
    einddatum timestamp with time zone,
    informatieobject_id integer NOT NULL,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_gebruiksrechten OWNER TO postgres;

--
-- Name: datamodel_gebruiksrechten_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_gebruiksrechten_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_gebruiksrechten_id_seq OWNER TO postgres;

--
-- Name: datamodel_gebruiksrechten_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_gebruiksrechten_id_seq OWNED BY public.datamodel_gebruiksrechten.id;


--
-- Name: datamodel_objectinformatieobject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_objectinformatieobject (
    id integer NOT NULL,
    informatieobject_id integer NOT NULL,
    uuid uuid NOT NULL,
    object character varying(200) NOT NULL,
    object_type character varying(100) NOT NULL
);


ALTER TABLE public.datamodel_objectinformatieobject OWNER TO postgres;

--
-- Name: datamodel_zaakinformatieobject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakinformatieobject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakinformatieobject_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakinformatieobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakinformatieobject_id_seq OWNED BY public.datamodel_objectinformatieobject.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: notifications_notificationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_notificationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL
);


ALTER TABLE public.notifications_notificationsconfig OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notificationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_notificationsconfig_id_seq OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notificationsconfig_id_seq OWNED BY public.notifications_notificationsconfig.id;


--
-- Name: notifications_subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_subscription (
    id integer NOT NULL,
    callback_url character varying(200) NOT NULL,
    client_id character varying(50) NOT NULL,
    secret character varying(50) NOT NULL,
    channels character varying(100)[] NOT NULL,
    config_id integer NOT NULL,
    _subscription character varying(200) NOT NULL
);


ALTER TABLE public.notifications_subscription OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_subscription_id_seq OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_subscription_id_seq OWNED BY public.notifications_subscription.id;


--
-- Name: vng_api_common_apicredential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_apicredential (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    client_id character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    label character varying(100) NOT NULL,
    user_id character varying(255) NOT NULL,
    user_representation character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_apicredential OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_apicredential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_apicredential_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_apicredential_id_seq OWNED BY public.vng_api_common_apicredential.id;


--
-- Name: vng_api_common_jwtsecret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_jwtsecret (
    id integer NOT NULL,
    identifier character varying(50) NOT NULL,
    secret character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_jwtsecret OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_jwtsecret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_jwtsecret_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_jwtsecret_id_seq OWNED BY public.vng_api_common_jwtsecret.id;


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: audittrails_audittrail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail ALTER COLUMN id SET DEFAULT nextval('public.audittrails_audittrail_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: authorizations_applicatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_applicatie_id_seq'::regclass);


--
-- Name: authorizations_authorizationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig ALTER COLUMN id SET DEFAULT nextval('public.authorizations_authorizationsconfig_id_seq'::regclass);


--
-- Name: authorizations_autorisatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_autorisatie_id_seq'::regclass);


--
-- Name: axes_accessattempt id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt ALTER COLUMN id SET DEFAULT nextval('public.axes_accessattempt_id_seq'::regclass);


--
-- Name: axes_accesslog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog ALTER COLUMN id SET DEFAULT nextval('public.axes_accesslog_id_seq'::regclass);


--
-- Name: datamodel_enkelvoudiginformatieobject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_enkelvoudiginformatieobject ALTER COLUMN id SET DEFAULT nextval('public.datamodel_enkelvoudiginformatieobject_id_seq'::regclass);


--
-- Name: datamodel_gebruiksrechten id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_gebruiksrechten ALTER COLUMN id SET DEFAULT nextval('public.datamodel_gebruiksrechten_id_seq'::regclass);


--
-- Name: datamodel_objectinformatieobject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_objectinformatieobject ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakinformatieobject_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: notifications_notificationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig ALTER COLUMN id SET DEFAULT nextval('public.notifications_notificationsconfig_id_seq'::regclass);


--
-- Name: notifications_subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription ALTER COLUMN id SET DEFAULT nextval('public.notifications_subscription_id_seq'::regclass);


--
-- Name: vng_api_common_apicredential id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_apicredential_id_seq'::regclass);


--
-- Name: vng_api_common_jwtsecret id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_jwtsecret_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$150000$V85wgSFjoEux$8F++zQzwOvAn1PI/4U6OFD3Athtq4uAsDQg7SWIWazs=	2019-06-13 10:35:04.879558+00	t	admin				t	t	2019-06-07 14:00:49.97769+00
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: audittrails_audittrail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audittrails_audittrail (id, uuid, bron, actie, actie_weergave, resultaat, hoofd_object, resource, resource_url, aanmaakdatum, oud, nieuw, applicatie_id, applicatie_weergave, gebruikers_id, gebruikers_weergave, toelichting) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add content type	1	add_contenttype
2	Can change content type	1	change_contenttype
3	Can delete content type	1	delete_contenttype
4	Can view content type	1	view_contenttype
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add session	4	add_session
14	Can change session	4	change_session
15	Can delete session	4	delete_session
16	Can view session	4	view_session
17	Can add site	5	add_site
18	Can change site	5	change_site
19	Can delete site	5	delete_site
20	Can view site	5	view_site
21	Can add log entry	6	add_logentry
22	Can change log entry	6	change_logentry
23	Can delete log entry	6	delete_logentry
24	Can view log entry	6	view_logentry
25	Can add access attempt	7	add_accessattempt
26	Can change access attempt	7	change_accessattempt
27	Can delete access attempt	7	delete_accessattempt
28	Can view access attempt	7	view_accessattempt
29	Can add access log	8	add_accesslog
30	Can change access log	8	change_accesslog
31	Can delete access log	8	delete_accesslog
32	Can view access log	8	view_accesslog
33	Can add cors model	9	add_corsmodel
34	Can change cors model	9	change_corsmodel
35	Can delete cors model	9	delete_corsmodel
36	Can view cors model	9	view_corsmodel
37	Can add client credential	10	add_jwtsecret
38	Can change client credential	10	change_jwtsecret
39	Can delete client credential	10	delete_jwtsecret
40	Can view client credential	10	view_jwtsecret
41	Can add external API credential	11	add_apicredential
42	Can change external API credential	11	change_apicredential
43	Can delete external API credential	11	delete_apicredential
44	Can view external API credential	11	view_apicredential
45	Can add applicatie	12	add_applicatie
46	Can change applicatie	12	change_applicatie
47	Can delete applicatie	12	delete_applicatie
48	Can view applicatie	12	view_applicatie
49	Can add autorisatie	13	add_autorisatie
50	Can change autorisatie	13	change_autorisatie
51	Can delete autorisatie	13	delete_autorisatie
52	Can view autorisatie	13	view_autorisatie
53	Can add Autorisatiecomponentconfiguratie	14	add_authorizationsconfig
54	Can change Autorisatiecomponentconfiguratie	14	change_authorizationsconfig
55	Can delete Autorisatiecomponentconfiguratie	14	delete_authorizationsconfig
56	Can view Autorisatiecomponentconfiguratie	14	view_authorizationsconfig
57	Can add audit trail	15	add_audittrail
58	Can change audit trail	15	change_audittrail
59	Can delete audit trail	15	delete_audittrail
60	Can view audit trail	15	view_audittrail
61	Can add Notificatiescomponentconfiguratie	16	add_notificationsconfig
62	Can change Notificatiescomponentconfiguratie	16	change_notificationsconfig
63	Can delete Notificatiescomponentconfiguratie	16	delete_notificationsconfig
64	Can view Notificatiescomponentconfiguratie	16	view_notificationsconfig
65	Can add Webhook subscription	17	add_subscription
66	Can change Webhook subscription	17	change_subscription
67	Can delete Webhook subscription	17	delete_subscription
68	Can view Webhook subscription	17	view_subscription
69	Can add user	18	add_user
70	Can change user	18	change_user
71	Can delete user	18	delete_user
72	Can view user	18	view_user
73	Can add informatieobject	19	add_enkelvoudiginformatieobject
74	Can change informatieobject	19	change_enkelvoudiginformatieobject
75	Can delete informatieobject	19	delete_enkelvoudiginformatieobject
76	Can view informatieobject	19	view_enkelvoudiginformatieobject
77	Can add Zaakinformatieobject	20	add_objectinformatieobject
78	Can change Zaakinformatieobject	20	change_objectinformatieobject
79	Can delete Zaakinformatieobject	20	delete_objectinformatieobject
80	Can view Zaakinformatieobject	20	view_objectinformatieobject
81	Can add gebruiksrecht informatieobject	21	add_gebruiksrechten
82	Can change gebruiksrecht informatieobject	21	change_gebruiksrechten
83	Can delete gebruiksrecht informatieobject	21	delete_gebruiksrechten
84	Can view gebruiksrecht informatieobject	21	view_gebruiksrechten
\.


--
-- Data for Name: authorizations_applicatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_applicatie (id, uuid, client_ids, label, heeft_alle_autorisaties) FROM stdin;
\.


--
-- Data for Name: authorizations_authorizationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_authorizationsconfig (id, api_root, component) FROM stdin;
1	http://BASE_IP:8005/api/v1/	DRC
\.


--
-- Data for Name: authorizations_autorisatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_autorisatie (id, component, zaaktype, scopes, max_vertrouwelijkheidaanduiding, applicatie_id, besluittype, informatieobjecttype) FROM stdin;
\.


--
-- Data for Name: axes_accessattempt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accessattempt (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, get_data, post_data, failures_since_start) FROM stdin;
\.


--
-- Data for Name: axes_accesslog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accesslog (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, logout_time) FROM stdin;
1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.13	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-07 14:01:03.173534+00	\N
2	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.14	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:35:04.969237+00	\N
\.


--
-- Data for Name: datamodel_enkelvoudiginformatieobject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_enkelvoudiginformatieobject (id, identificatie, bronorganisatie, creatiedatum, titel, auteur, formaat, taal, inhoud, uuid, vertrouwelijkheidaanduiding, beschrijving, informatieobjecttype, link, bestandsnaam, integriteit_algoritme, integriteit_datum, integriteit_waarde, ontvangstdatum, indicatie_gebruiksrecht, verzenddatum, ondertekening_datum, ondertekening_soort, status, lock) FROM stdin;
\.


--
-- Data for Name: datamodel_gebruiksrechten; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_gebruiksrechten (id, omschrijving_voorwaarden, startdatum, einddatum, informatieobject_id, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_objectinformatieobject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_objectinformatieobject (id, informatieobject_id, uuid, object, object_type) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-06-07 14:01:19.768931+00	1	BASE_IP:8001	2	[{"changed": {"fields": ["domain", "name"]}}]	5	1
2	2019-06-07 14:02:02.366397+00	1	http://BASE_IP:8005/api/v1/	2	[{"changed": {"fields": ["api_root", "component"]}}]	14	1
3	2019-06-07 14:02:35.764426+00	1	http://BASE_IP:8005/api/v1/	1	[{"added": {}}]	11	1
4	2019-06-07 14:02:50.869902+00	2	http://BASE_IP:8004/api/v1/	1	[{"added": {}}]	11	1
5	2019-06-07 14:03:39.164386+00	1	http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["api_root"]}}, {"added": {"name": "Webhook subscription", "object": "autorisaties - http://BASE_IP:8001/api/v1/callback"}}]	16	1
6	2019-06-07 14:05:10.561505+00	1	BASE_IP:8001	2	[]	5	1
7	2019-06-07 14:13:59.765836+00	3	http://BASE_IP:8003/api/v1/	1	[{"added": {}}]	11	1
8	2019-06-07 14:14:16.06538+00	4	http://BASE_IP:8002/api/v1/	1	[{"added": {}}]	11	1
9	2019-06-07 14:14:28.665135+00	5	http://BASE_IP:8001/api/v1/	1	[{"added": {}}]	11	1
10	2019-06-13 10:35:15.275164+00	1	demo	1	[{"added": {}}]	10	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	contenttypes	contenttype
2	auth	permission
3	auth	group
4	sessions	session
5	sites	site
6	admin	logentry
7	axes	accessattempt
8	axes	accesslog
9	corsheaders	corsmodel
10	vng_api_common	jwtsecret
11	vng_api_common	apicredential
12	authorizations	applicatie
13	authorizations	autorisatie
14	authorizations	authorizationsconfig
15	audittrails	audittrail
16	notifications	notificationsconfig
17	notifications	subscription
18	accounts	user
19	datamodel	enkelvoudiginformatieobject
20	datamodel	objectinformatieobject
21	datamodel	gebruiksrechten
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-06-13 08:13:57.437251+00
2	contenttypes	0002_remove_content_type_name	2019-06-13 08:13:57.552874+00
3	auth	0001_initial	2019-06-13 08:13:57.930946+00
4	auth	0002_alter_permission_name_max_length	2019-06-13 08:13:58.616094+00
5	auth	0003_alter_user_email_max_length	2019-06-13 08:13:58.720048+00
6	auth	0004_alter_user_username_opts	2019-06-13 08:13:58.810858+00
7	auth	0005_alter_user_last_login_null	2019-06-13 08:13:58.918991+00
8	auth	0006_require_contenttypes_0002	2019-06-13 08:13:58.931517+00
9	auth	0007_alter_validators_add_error_messages	2019-06-13 08:13:59.010865+00
10	auth	0008_alter_user_username_max_length	2019-06-13 08:13:59.090868+00
11	accounts	0001_initial	2019-06-13 08:13:59.483312+00
12	admin	0001_initial	2019-06-13 08:14:00.316146+00
13	admin	0002_logentry_remove_auto_add	2019-06-13 08:14:00.789829+00
14	admin	0003_logentry_add_action_flag_choices	2019-06-13 08:14:00.926706+00
15	audittrails	0001_initial	2019-06-13 08:14:01.103848+00
16	audittrails	0002_auto_20190516_0830	2019-06-13 08:14:01.205268+00
17	audittrails	0003_auto_20190517_0844	2019-06-13 08:14:01.687067+00
18	audittrails	0004_auto_20190520_1238	2019-06-13 08:14:01.778887+00
19	audittrails	0005_auto_20190520_1450	2019-06-13 08:14:01.823412+00
20	audittrails	0006_audittrail_toelichting	2019-06-13 08:14:01.907044+00
21	audittrails	0007_auto_20190522_0916	2019-06-13 08:14:01.972051+00
22	auth	0009_alter_user_last_name_max_length	2019-06-13 08:14:02.188296+00
23	auth	0010_alter_group_name_max_length	2019-06-13 08:14:02.297568+00
24	auth	0011_update_proxy_permissions	2019-06-13 08:14:02.488048+00
25	authorizations	0001_initial	2019-06-13 08:14:02.797006+00
26	authorizations	0002_authorizationsconfig	2019-06-13 08:14:03.115994+00
27	authorizations	0003_auto_20190502_0409	2019-06-13 08:14:03.220041+00
28	authorizations	0004_auto_20190503_0941	2019-06-13 08:14:03.386597+00
29	authorizations	0005_auto_20190506_0842	2019-06-13 08:14:03.484499+00
30	authorizations	0006_auto_20190506_0901	2019-06-13 08:14:04.270476+00
31	authorizations	0007_auto_20190506_1212	2019-06-13 08:14:04.386822+00
32	axes	0001_initial	2019-06-13 08:14:04.692029+00
33	axes	0002_auto_20151217_2044	2019-06-13 08:14:05.309096+00
34	axes	0003_auto_20160322_0929	2019-06-13 08:14:05.729335+00
35	datamodel	0001_initial	2019-06-13 08:14:05.916026+00
36	datamodel	0002_auto_20180629_1504	2019-06-13 08:14:06.173137+00
37	datamodel	0003_auto_20180701_0713	2019-06-13 08:14:06.221003+00
38	datamodel	0004_auto_20180701_0818	2019-06-13 08:14:06.32067+00
39	datamodel	0005_auto_20180724_1049	2019-06-13 08:14:06.488912+00
40	datamodel	0006_auto_20180724_1049	2019-06-13 08:14:06.776001+00
41	datamodel	0007_auto_20180724_1051	2019-06-13 08:14:07.591746+00
42	datamodel	0008_auto_20180730_1252	2019-06-13 08:14:07.805294+00
43	datamodel	0009_enkelvoudiginformatieobject_vertrouwelijkheidsaanduiding	2019-06-13 08:14:07.999311+00
44	datamodel	0010_auto_20180815_1221	2019-06-13 08:14:08.026887+00
45	datamodel	0010_auto_20180815_1104	2019-06-13 08:14:08.274872+00
46	datamodel	0011_merge_20180815_1426	2019-06-13 08:14:08.28956+00
47	datamodel	0012_auto_20180815_1609	2019-06-13 08:14:08.422475+00
48	datamodel	0013_auto_20180919_1002	2019-06-13 08:14:09.135228+00
49	datamodel	0014_auto_20180919_1008	2019-06-13 08:14:09.410864+00
50	datamodel	0015_remove_objectinformatieobject_zaak	2019-06-13 08:14:09.487864+00
51	datamodel	0016_auto_20180920_1240	2019-06-13 08:14:09.534749+00
52	datamodel	0017_auto_20181010_1548	2019-06-13 08:14:09.627474+00
53	datamodel	0018_auto_20181010_1611	2019-06-13 08:14:09.70685+00
54	datamodel	0019_auto_20181024_1313	2019-06-13 08:14:09.813443+00
55	datamodel	0020_objectinformatieobject_aard_relatie	2019-06-13 08:14:09.894292+00
56	datamodel	0021_enkelvoudiginformatieobject_bestandsnaam	2019-06-13 08:14:09.934907+00
57	datamodel	0022_auto_20181213_1332_squashed_0024_auto_20181213_1442	2019-06-13 08:14:10.231236+00
58	datamodel	0023_enkelvoudiginformatieobject_ontvangstdatum	2019-06-13 08:14:10.320779+00
59	datamodel	0024_enkelvoudiginformatieobject_indicatie_gebruiksrecht	2019-06-13 08:14:10.413848+00
60	datamodel	0025_enkelvoudiginformatieobject_verzenddatum	2019-06-13 08:14:10.483884+00
61	datamodel	0026_auto_20181219_1336	2019-06-13 08:14:10.618898+00
62	datamodel	0027_auto_20181219_1411	2019-06-13 08:14:10.825811+00
63	datamodel	0028_enkelvoudiginformatieobject_status	2019-06-13 08:14:10.898501+00
64	datamodel	0029_auto_20181224_1042	2019-06-13 08:14:10.937572+00
65	datamodel	0030_gebruiksrechten	2019-06-13 08:14:11.07608+00
66	datamodel	0031_gebruiksrechten_uuid	2019-06-13 08:14:11.193911+00
67	datamodel	0032_auto_20190129_1031	2019-06-13 08:14:11.276302+00
68	datamodel	0033_auto_20190301_1442	2019-06-13 08:14:11.342557+00
69	datamodel	0034_auto_20190528_0927	2019-06-13 08:14:11.594917+00
70	datamodel	0034_auto_20190524_1455	2019-06-13 08:14:12.042272+00
71	datamodel	0035_merge_20190605_1036	2019-06-13 08:14:12.083203+00
72	datamodel	0036_auto_20190605_1047	2019-06-13 08:14:12.24563+00
73	notifications	0001_initial	2019-06-13 08:14:12.409551+00
74	notifications	0002_subscription__subscription	2019-06-13 08:14:12.541519+00
75	notifications	0003_auto_20190319_1048	2019-06-13 08:14:12.88708+00
76	notifications	0004_auto_20190325_1313	2019-06-13 08:14:12.988184+00
77	notifications	0005_fix_default_nrc	2019-06-13 08:14:13.341988+00
78	notifications	0006_auto_20190417_1142	2019-06-13 08:14:13.529176+00
79	notifications	0007_auto_20190429_1442	2019-06-13 08:14:13.647432+00
80	notifications	0008_auto_20190502_0415	2019-06-13 08:14:13.705152+00
81	sessions	0001_initial	2019-06-13 08:14:13.782099+00
82	sites	0001_initial	2019-06-13 08:14:13.878103+00
83	sites	0002_alter_domain_unique	2019-06-13 08:14:13.97336+00
84	vng_api_common	0001_initial	2019-06-13 08:14:14.036677+00
85	vng_api_common	0002_apicredential	2019-06-13 08:14:14.201161+00
86	vng_api_common	0003_auto_20190417_1145	2019-06-13 08:14:14.307085+00
87	vng_api_common	0004_auto_20190517_0903	2019-06-13 08:14:14.409043+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
g5tkvuo7emjve3h2x9amjl66sbmjzx3p	NDZmYzk4NjliMjBjMTFhMDdmYzhkOTVmODM1MGIxOWZiN2Y0MzNjMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZGI2NGNkOTRmYzE5NzAzNzljY2UwZjBlYjMwMjcxNWY5MjZlZDdlIn0=	2019-06-21 14:01:03.263786+00
5m8u7jrkspn1l8npyjq6noi8f174xt5i	NDZmYzk4NjliMjBjMTFhMDdmYzhkOTVmODM1MGIxOWZiN2Y0MzNjMTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZGI2NGNkOTRmYzE5NzAzNzljY2UwZjBlYjMwMjcxNWY5MjZlZDdlIn0=	2019-06-27 10:35:04.973431+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	BASE_IP:8001	BASE_IP:8001
\.


--
-- Data for Name: notifications_notificationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_notificationsconfig (id, api_root) FROM stdin;
1	http://BASE_IP:8004/api/v1/
\.


--
-- Data for Name: notifications_subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_subscription (id, callback_url, client_id, secret, channels, config_id, _subscription) FROM stdin;
1	http://BASE_IP:8001/api/v1/callback	demo	demo	{autorisaties}	1	http://BASE_IP:8004/api/v1/abonnement/78406012-abf8-4297-98db-8998c0f2b0ff
\.


--
-- Data for Name: vng_api_common_apicredential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_apicredential (id, api_root, client_id, secret, label, user_id, user_representation) FROM stdin;
1	http://BASE_IP:8005/api/v1/	demo	demo	ac	system	system
2	http://BASE_IP:8004/api/v1/	demo	demo	nrc	system	system
3	http://BASE_IP:8003/api/v1/	demo	demo	brc	system	system
4	http://BASE_IP:8002/api/v1/	demo	demo	ztc	system	system
5	http://BASE_IP:8001/api/v1/	demo	demo	drc	system	system
\.


--
-- Data for Name: vng_api_common_jwtsecret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_jwtsecret (id, identifier, secret) FROM stdin;
1	demo	demo
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 1, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audittrails_audittrail_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 84, true);


--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_applicatie_id_seq', 1, false);


--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_authorizationsconfig_id_seq', 1, false);


--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_autorisatie_id_seq', 1, false);


--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accessattempt_id_seq', 1, false);


--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accesslog_id_seq', 2, true);


--
-- Name: datamodel_enkelvoudiginformatieobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_enkelvoudiginformatieobject_id_seq', 1, false);


--
-- Name: datamodel_gebruiksrechten_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_gebruiksrechten_id_seq', 1, false);


--
-- Name: datamodel_zaakinformatieobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakinformatieobject_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 10, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 21, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 87, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notificationsconfig_id_seq', 1, false);


--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_subscription_id_seq', 1, true);


--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_apicredential_id_seq', 5, true);


--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_jwtsecret_id_seq', 1, true);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: audittrails_audittrail audittrails_audittrail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail
    ADD CONSTRAINT audittrails_audittrail_pkey PRIMARY KEY (id);


--
-- Name: audittrails_audittrail audittrails_audittrail_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail
    ADD CONSTRAINT audittrails_audittrail_uuid_key UNIQUE (uuid);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_uuid_key UNIQUE (uuid);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_api_root_key UNIQUE (api_root);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_pkey PRIMARY KEY (id);


--
-- Name: authorizations_autorisatie authorizations_autorisatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autorisatie_pkey PRIMARY KEY (id);


--
-- Name: axes_accessattempt axes_accessattempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt
    ADD CONSTRAINT axes_accessattempt_pkey PRIMARY KEY (id);


--
-- Name: axes_accesslog axes_accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog
    ADD CONSTRAINT axes_accesslog_pkey PRIMARY KEY (id);


--
-- Name: datamodel_enkelvoudiginformatieobject datamodel_enkelvoudiginf_bronorganisatie_identifi_7b55c9c0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_enkelvoudiginformatieobject
    ADD CONSTRAINT datamodel_enkelvoudiginf_bronorganisatie_identifi_7b55c9c0_uniq UNIQUE (bronorganisatie, identificatie);


--
-- Name: datamodel_enkelvoudiginformatieobject datamodel_enkelvoudiginformatieobject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_enkelvoudiginformatieobject
    ADD CONSTRAINT datamodel_enkelvoudiginformatieobject_pkey PRIMARY KEY (id);


--
-- Name: datamodel_enkelvoudiginformatieobject datamodel_enkelvoudiginformatieobject_uuid_d76540ec_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_enkelvoudiginformatieobject
    ADD CONSTRAINT datamodel_enkelvoudiginformatieobject_uuid_d76540ec_uniq UNIQUE (uuid);


--
-- Name: datamodel_gebruiksrechten datamodel_gebruiksrechten_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_gebruiksrechten
    ADD CONSTRAINT datamodel_gebruiksrechten_pkey PRIMARY KEY (id);


--
-- Name: datamodel_gebruiksrechten datamodel_gebruiksrechten_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_gebruiksrechten
    ADD CONSTRAINT datamodel_gebruiksrechten_uuid_key UNIQUE (uuid);


--
-- Name: datamodel_objectinformatieobject datamodel_objectinformat_informatieobject_id_obje_053e4542_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_objectinformatieobject
    ADD CONSTRAINT datamodel_objectinformat_informatieobject_id_obje_053e4542_uniq UNIQUE (informatieobject_id, object);


--
-- Name: datamodel_objectinformatieobject datamodel_zaakinformatieobject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_objectinformatieobject
    ADD CONSTRAINT datamodel_zaakinformatieobject_pkey PRIMARY KEY (id);


--
-- Name: datamodel_objectinformatieobject datamodel_zaakinformatieobject_uuid_6638285d_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_objectinformatieobject
    ADD CONSTRAINT datamodel_zaakinformatieobject_uuid_6638285d_uniq UNIQUE (uuid);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_api_root_e4030d56_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_api_root_e4030d56_uniq UNIQUE (api_root);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_pkey PRIMARY KEY (id);


--
-- Name: notifications_subscription notifications_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscription_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_api_root_key UNIQUE (api_root);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_identifier_key UNIQUE (identifier);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authorizations_authorizationsconfig_api_root_0b54af71_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_authorizationsconfig_api_root_0b54af71_like ON public.authorizations_authorizationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: authorizations_autorisatie_applicatie_id_44348ea1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_autorisatie_applicatie_id_44348ea1 ON public.authorizations_autorisatie USING btree (applicatie_id);


--
-- Name: axes_accessattempt_ip_address_10922d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_ip_address_10922d9c ON public.axes_accessattempt USING btree (ip_address);


--
-- Name: axes_accessattempt_trusted_0eddf52e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_trusted_0eddf52e ON public.axes_accessattempt USING btree (trusted);


--
-- Name: axes_accessattempt_user_agent_ad89678b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b ON public.axes_accessattempt USING btree (user_agent);


--
-- Name: axes_accessattempt_user_agent_ad89678b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b_like ON public.axes_accessattempt USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accessattempt_username_3f2d4ca0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0 ON public.axes_accessattempt USING btree (username);


--
-- Name: axes_accessattempt_username_3f2d4ca0_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0_like ON public.axes_accessattempt USING btree (username varchar_pattern_ops);


--
-- Name: axes_accesslog_ip_address_86b417e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_ip_address_86b417e5 ON public.axes_accesslog USING btree (ip_address);


--
-- Name: axes_accesslog_trusted_496c5681; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_trusted_496c5681 ON public.axes_accesslog USING btree (trusted);


--
-- Name: axes_accesslog_user_agent_0e659004; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004 ON public.axes_accesslog USING btree (user_agent);


--
-- Name: axes_accesslog_user_agent_0e659004_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004_like ON public.axes_accesslog USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accesslog_username_df93064b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b ON public.axes_accesslog USING btree (username);


--
-- Name: axes_accesslog_username_df93064b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b_like ON public.axes_accesslog USING btree (username varchar_pattern_ops);


--
-- Name: datamodel_gebruiksrechten_informatieobject_id_5b8276f9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_gebruiksrechten_informatieobject_id_5b8276f9 ON public.datamodel_gebruiksrechten USING btree (informatieobject_id);


--
-- Name: datamodel_zaakinformatieobject_informatieobject_id_7c8bd9fa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakinformatieobject_informatieobject_id_7c8bd9fa ON public.datamodel_objectinformatieobject USING btree (informatieobject_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: notifications_notificationsconfig_api_root_e4030d56_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_notificationsconfig_api_root_e4030d56_like ON public.notifications_notificationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: notifications_subscription_config_id_3567b13c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_subscription_config_id_3567b13c ON public.notifications_subscription USING btree (config_id);


--
-- Name: vng_api_common_apicredential_api_root_cb3905ed_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_apicredential_api_root_cb3905ed_like ON public.vng_api_common_apicredential USING btree (api_root varchar_pattern_ops);


--
-- Name: vng_api_common_jwtsecret_identifier_e89b809e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_jwtsecret_identifier_e89b809e_like ON public.vng_api_common_jwtsecret USING btree (identifier varchar_pattern_ops);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authorizations_autorisatie authorizations_autor_applicatie_id_44348ea1_fk_authoriza; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autor_applicatie_id_44348ea1_fk_authoriza FOREIGN KEY (applicatie_id) REFERENCES public.authorizations_applicatie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_gebruiksrechten datamodel_gebruiksre_informatieobject_id_5b8276f9_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_gebruiksrechten
    ADD CONSTRAINT datamodel_gebruiksre_informatieobject_id_5b8276f9_fk_datamodel FOREIGN KEY (informatieobject_id) REFERENCES public.datamodel_enkelvoudiginformatieobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_objectinformatieobject datamodel_zaakinform_informatieobject_id_7c8bd9fa_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_objectinformatieobject
    ADD CONSTRAINT datamodel_zaakinform_informatieobject_id_7c8bd9fa_fk_datamodel FOREIGN KEY (informatieobject_id) REFERENCES public.datamodel_enkelvoudiginformatieobject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_subscription notifications_subscr_config_id_3567b13c_fk_notificat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscr_config_id_3567b13c_fk_notificat FOREIGN KEY (config_id) REFERENCES public.notifications_notificationsconfig(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: nrc; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE nrc WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE nrc OWNER TO postgres;

\connect nrc

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authorizations_applicatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_applicatie (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    client_ids character varying(50)[] NOT NULL,
    label character varying(100) NOT NULL,
    heeft_alle_autorisaties boolean NOT NULL
);


ALTER TABLE public.authorizations_applicatie OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_applicatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_applicatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_applicatie_id_seq OWNED BY public.authorizations_applicatie.id;


--
-- Name: authorizations_authorizationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_authorizationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    component character varying(50) NOT NULL
);


ALTER TABLE public.authorizations_authorizationsconfig OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_authorizationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_authorizationsconfig_id_seq OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_authorizationsconfig_id_seq OWNED BY public.authorizations_authorizationsconfig.id;


--
-- Name: authorizations_autorisatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_autorisatie (
    id integer NOT NULL,
    component character varying(50) NOT NULL,
    zaaktype character varying(1000) NOT NULL,
    scopes character varying(100)[] NOT NULL,
    max_vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    applicatie_id integer NOT NULL,
    besluittype character varying(1000) NOT NULL,
    informatieobjecttype character varying(1000) NOT NULL
);


ALTER TABLE public.authorizations_autorisatie OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_autorisatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_autorisatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_autorisatie_id_seq OWNED BY public.authorizations_autorisatie.id;


--
-- Name: axes_accessattempt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accessattempt (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    get_data text NOT NULL,
    post_data text NOT NULL,
    failures_since_start integer NOT NULL,
    CONSTRAINT axes_accessattempt_failures_since_start_check CHECK ((failures_since_start >= 0))
);


ALTER TABLE public.axes_accessattempt OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accessattempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accessattempt_id_seq OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accessattempt_id_seq OWNED BY public.axes_accessattempt.id;


--
-- Name: axes_accesslog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accesslog (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    logout_time timestamp with time zone
);


ALTER TABLE public.axes_accesslog OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accesslog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accesslog_id_seq OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accesslog_id_seq OWNED BY public.axes_accesslog.id;


--
-- Name: datamodel_abonnement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_abonnement (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    callback_url character varying(200) NOT NULL,
    auth character varying(1000) NOT NULL,
    client_id character varying(100) NOT NULL
);


ALTER TABLE public.datamodel_abonnement OWNER TO postgres;

--
-- Name: datamodel_abonnement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_abonnement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_abonnement_id_seq OWNER TO postgres;

--
-- Name: datamodel_abonnement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_abonnement_id_seq OWNED BY public.datamodel_abonnement.id;


--
-- Name: datamodel_filter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_filter (
    id integer NOT NULL,
    key character varying(100) NOT NULL,
    value character varying(1000) NOT NULL,
    filter_group_id integer NOT NULL
);


ALTER TABLE public.datamodel_filter OWNER TO postgres;

--
-- Name: datamodel_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_filter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_filter_id_seq OWNER TO postgres;

--
-- Name: datamodel_filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_filter_id_seq OWNED BY public.datamodel_filter.id;


--
-- Name: datamodel_filtergroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_filtergroup (
    id integer NOT NULL,
    abonnement_id integer NOT NULL,
    kanaal_id integer NOT NULL
);


ALTER TABLE public.datamodel_filtergroup OWNER TO postgres;

--
-- Name: datamodel_filtergroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_filtergroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_filtergroup_id_seq OWNER TO postgres;

--
-- Name: datamodel_filtergroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_filtergroup_id_seq OWNED BY public.datamodel_filtergroup.id;


--
-- Name: datamodel_kanaal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_kanaal (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    naam character varying(50) NOT NULL,
    documentatie_link character varying(200) NOT NULL,
    filters character varying(100)[] NOT NULL
);


ALTER TABLE public.datamodel_kanaal OWNER TO postgres;

--
-- Name: datamodel_kanaal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_kanaal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_kanaal_id_seq OWNER TO postgres;

--
-- Name: datamodel_kanaal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_kanaal_id_seq OWNED BY public.datamodel_kanaal.id;


--
-- Name: datamodel_notificatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_notificatie (
    id integer NOT NULL,
    forwarded_msg jsonb NOT NULL,
    kanaal_id integer NOT NULL
);


ALTER TABLE public.datamodel_notificatie OWNER TO postgres;

--
-- Name: datamodel_notificatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_notificatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_notificatie_id_seq OWNER TO postgres;

--
-- Name: datamodel_notificatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_notificatie_id_seq OWNED BY public.datamodel_notificatie.id;


--
-- Name: datamodel_notificatieresponse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_notificatieresponse (
    id integer NOT NULL,
    response_status character varying(20) NOT NULL,
    abonnement_id integer NOT NULL,
    notificatie_id integer NOT NULL,
    exception character varying(1000) NOT NULL
);


ALTER TABLE public.datamodel_notificatieresponse OWNER TO postgres;

--
-- Name: datamodel_notificatieresponse_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_notificatieresponse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_notificatieresponse_id_seq OWNER TO postgres;

--
-- Name: datamodel_notificatieresponse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_notificatieresponse_id_seq OWNED BY public.datamodel_notificatieresponse.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: notifications_notificationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_notificationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL
);


ALTER TABLE public.notifications_notificationsconfig OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notificationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_notificationsconfig_id_seq OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notificationsconfig_id_seq OWNED BY public.notifications_notificationsconfig.id;


--
-- Name: notifications_subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_subscription (
    id integer NOT NULL,
    callback_url character varying(200) NOT NULL,
    client_id character varying(50) NOT NULL,
    secret character varying(50) NOT NULL,
    channels character varying(100)[] NOT NULL,
    config_id integer NOT NULL,
    _subscription character varying(200) NOT NULL
);


ALTER TABLE public.notifications_subscription OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_subscription_id_seq OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_subscription_id_seq OWNED BY public.notifications_subscription.id;


--
-- Name: vng_api_common_apicredential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_apicredential (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    client_id character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    label character varying(100) NOT NULL,
    user_id character varying(255) NOT NULL,
    user_representation character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_apicredential OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_apicredential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_apicredential_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_apicredential_id_seq OWNED BY public.vng_api_common_apicredential.id;


--
-- Name: vng_api_common_jwtsecret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_jwtsecret (
    id integer NOT NULL,
    identifier character varying(50) NOT NULL,
    secret character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_jwtsecret OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_jwtsecret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_jwtsecret_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_jwtsecret_id_seq OWNED BY public.vng_api_common_jwtsecret.id;


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: authorizations_applicatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_applicatie_id_seq'::regclass);


--
-- Name: authorizations_authorizationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig ALTER COLUMN id SET DEFAULT nextval('public.authorizations_authorizationsconfig_id_seq'::regclass);


--
-- Name: authorizations_autorisatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_autorisatie_id_seq'::regclass);


--
-- Name: axes_accessattempt id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt ALTER COLUMN id SET DEFAULT nextval('public.axes_accessattempt_id_seq'::regclass);


--
-- Name: axes_accesslog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog ALTER COLUMN id SET DEFAULT nextval('public.axes_accesslog_id_seq'::regclass);


--
-- Name: datamodel_abonnement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_abonnement ALTER COLUMN id SET DEFAULT nextval('public.datamodel_abonnement_id_seq'::regclass);


--
-- Name: datamodel_filter id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_filter ALTER COLUMN id SET DEFAULT nextval('public.datamodel_filter_id_seq'::regclass);


--
-- Name: datamodel_filtergroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_filtergroup ALTER COLUMN id SET DEFAULT nextval('public.datamodel_filtergroup_id_seq'::regclass);


--
-- Name: datamodel_kanaal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_kanaal ALTER COLUMN id SET DEFAULT nextval('public.datamodel_kanaal_id_seq'::regclass);


--
-- Name: datamodel_notificatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_notificatie ALTER COLUMN id SET DEFAULT nextval('public.datamodel_notificatie_id_seq'::regclass);


--
-- Name: datamodel_notificatieresponse id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_notificatieresponse ALTER COLUMN id SET DEFAULT nextval('public.datamodel_notificatieresponse_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: notifications_notificationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig ALTER COLUMN id SET DEFAULT nextval('public.notifications_notificationsconfig_id_seq'::regclass);


--
-- Name: notifications_subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription ALTER COLUMN id SET DEFAULT nextval('public.notifications_subscription_id_seq'::regclass);


--
-- Name: vng_api_common_apicredential id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_apicredential_id_seq'::regclass);


--
-- Name: vng_api_common_jwtsecret id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_jwtsecret_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$120000$5whFMunA0oKn$ipFL9ZIBj9lfZ3PD7lxfNyCZie6xO4eUE9LufGGfVfk=	2019-06-13 10:36:58.979763+00	t	admin				t	t	2019-06-07 12:25:50.411475+00
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add content type	1	add_contenttype
2	Can change content type	1	change_contenttype
3	Can delete content type	1	delete_contenttype
4	Can view content type	1	view_contenttype
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add session	4	add_session
14	Can change session	4	change_session
15	Can delete session	4	delete_session
16	Can view session	4	view_session
17	Can add log entry	5	add_logentry
18	Can change log entry	5	change_logentry
19	Can delete log entry	5	delete_logentry
20	Can view log entry	5	view_logentry
21	Can add access attempt	6	add_accessattempt
22	Can change access attempt	6	change_accessattempt
23	Can delete access attempt	6	delete_accessattempt
24	Can view access attempt	6	view_accessattempt
25	Can add access log	7	add_accesslog
26	Can change access log	7	change_accesslog
27	Can delete access log	7	delete_accesslog
28	Can view access log	7	view_accesslog
29	Can add cors model	8	add_corsmodel
30	Can change cors model	8	change_corsmodel
31	Can delete cors model	8	delete_corsmodel
32	Can view cors model	8	view_corsmodel
33	Can add client credential	9	add_jwtsecret
34	Can change client credential	9	change_jwtsecret
35	Can delete client credential	9	delete_jwtsecret
36	Can view client credential	9	view_jwtsecret
37	Can add external API credential	10	add_apicredential
38	Can change external API credential	10	change_apicredential
39	Can delete external API credential	10	delete_apicredential
40	Can view external API credential	10	view_apicredential
41	Can add applicatie	11	add_applicatie
42	Can change applicatie	11	change_applicatie
43	Can delete applicatie	11	delete_applicatie
44	Can view applicatie	11	view_applicatie
45	Can add autorisatie	12	add_autorisatie
46	Can change autorisatie	12	change_autorisatie
47	Can delete autorisatie	12	delete_autorisatie
48	Can view autorisatie	12	view_autorisatie
49	Can add Autorisatiecomponentconfiguratie	13	add_authorizationsconfig
50	Can change Autorisatiecomponentconfiguratie	13	change_authorizationsconfig
51	Can delete Autorisatiecomponentconfiguratie	13	delete_authorizationsconfig
52	Can view Autorisatiecomponentconfiguratie	13	view_authorizationsconfig
53	Can add Notificatiescomponentconfiguratie	14	add_notificationsconfig
54	Can change Notificatiescomponentconfiguratie	14	change_notificationsconfig
55	Can delete Notificatiescomponentconfiguratie	14	delete_notificationsconfig
56	Can view Notificatiescomponentconfiguratie	14	view_notificationsconfig
57	Can add Webhook subscription	15	add_subscription
58	Can change Webhook subscription	15	change_subscription
59	Can delete Webhook subscription	15	delete_subscription
60	Can view Webhook subscription	15	view_subscription
61	Can add user	16	add_user
62	Can change user	16	change_user
63	Can delete user	16	delete_user
64	Can view user	16	view_user
65	Can add abonnement	17	add_abonnement
66	Can change abonnement	17	change_abonnement
67	Can delete abonnement	17	delete_abonnement
68	Can view abonnement	17	view_abonnement
69	Can add filter-onderdeel	18	add_filter
70	Can change filter-onderdeel	18	change_filter
71	Can delete filter-onderdeel	18	delete_filter
72	Can view filter-onderdeel	18	view_filter
73	Can add filter	19	add_filtergroup
74	Can change filter	19	change_filtergroup
75	Can delete filter	19	delete_filtergroup
76	Can view filter	19	view_filtergroup
77	Can add kanaal	20	add_kanaal
78	Can change kanaal	20	change_kanaal
79	Can delete kanaal	20	delete_kanaal
80	Can view kanaal	20	view_kanaal
81	Can add notificatie	21	add_notificatie
82	Can change notificatie	21	change_notificatie
83	Can delete notificatie	21	delete_notificatie
84	Can view notificatie	21	view_notificatie
85	Can add notificatie response	22	add_notificatieresponse
86	Can change notificatie response	22	change_notificatieresponse
87	Can delete notificatie response	22	delete_notificatieresponse
88	Can view notificatie response	22	view_notificatieresponse
\.


--
-- Data for Name: authorizations_applicatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_applicatie (id, uuid, client_ids, label, heeft_alle_autorisaties) FROM stdin;
1	5d83fd8e-395c-4232-9afa-754bd4822ef3	{demo}	nrc	t
2	533fe769-b1f1-49ff-b9fb-5bd01cfe868b	{demo}	demo	t
3	ff75594a-d446-45f5-a101-14f3a0963b83	{demo}	ac	t
4	6cf6a781-6c4d-46a6-89ff-7c61395d7991	{demo}	brc	t
\.


--
-- Data for Name: authorizations_authorizationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_authorizationsconfig (id, api_root, component) FROM stdin;
1	http://BASE_IP:8005/api/v1/	NRC
\.


--
-- Data for Name: authorizations_autorisatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_autorisatie (id, component, zaaktype, scopes, max_vertrouwelijkheidaanduiding, applicatie_id, besluittype, informatieobjecttype) FROM stdin;
\.


--
-- Data for Name: axes_accessattempt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accessattempt (id, user_agent, ip_address, username, http_accept, path_info, attempt_time, get_data, post_data, failures_since_start) FROM stdin;
1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.20.1.1	admin	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:36:53.275807+00	next=/admin/vng_api_common/jwtsecret/	csrfmiddlewaretoken=k0CoyDvee2PKg8akLMZbV55DgvIwsHnFNL84yChho09Aq83V8wM89Sba8fMoU063\nusername=admin\nnext=/admin/vng_api_common/jwtsecret/	1
\.


--
-- Data for Name: axes_accesslog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accesslog (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, logout_time) FROM stdin;
1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.13	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-07 12:26:07.184997+00	\N
2	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.14	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:36:58.982903+00	\N
\.


--
-- Data for Name: datamodel_abonnement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_abonnement (id, uuid, callback_url, auth, client_id) FROM stdin;
1	8ae92a74-da77-4e16-83a6-e297c5d8e4ba	http://BASE_IP:8004/api/v1/callback	Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImNsaWVudF9pZGVudGlmaWVyIjoiZGVtbyJ9.eyJpc3MiOiJkZW1vIiwiaWF0IjoxNTU5OTEzNDI5LCJjbGllbnRfaWQiOiJkZW1vIiwidXNlcl9pZCI6IiIsInVzZXJfcmVwcmVzZW50YXRpb24iOiIiLCJ6ZHMiOnsic2NvcGVzIjpbIm5vdGlmaWNhdGllcy5wdWJsaWNlcmVuIl19fQ.ezD-49fd2qes3Qq9XjyNx4uDRM_YqxG3eW3_8L0L0V4	demo
2	4a8f0ab6-8600-4069-a4a2-caa13a72c815	http://BASE_IP:8003/api/v1/callback	Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImNsaWVudF9pZGVudGlmaWVyIjoiZGVtbyJ9.eyJpc3MiOiJkZW1vIiwiaWF0IjoxNTU5OTE1NTU0LCJjbGllbnRfaWQiOiJkZW1vIiwidXNlcl9pZCI6IiIsInVzZXJfcmVwcmVzZW50YXRpb24iOiIiLCJ6ZHMiOnsic2NvcGVzIjpbIm5vdGlmaWNhdGllcy5wdWJsaWNlcmVuIl19fQ.noS96Mh3658t8ANswgGmLzUPuY55RUZh10SDkPa5ONk	demo
3	093e7470-ce50-4796-a4bf-e3b71b8848fd	http://BASE_IP:8002/api/v1/	Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImNsaWVudF9pZGVudGlmaWVyIjoiZGVtbyJ9.eyJpc3MiOiJkZW1vIiwiaWF0IjoxNTU5OTE1OTY2LCJjbGllbnRfaWQiOiJkZW1vIiwidXNlcl9pZCI6IiIsInVzZXJfcmVwcmVzZW50YXRpb24iOiIiLCJ6ZHMiOnsic2NvcGVzIjpbIm5vdGlmaWNhdGllcy5wdWJsaWNlcmVuIl19fQ.03iibulJyGgzIhhEECQ766vuaS6Em-M71QlLZrhRqB8	demo
4	78406012-abf8-4297-98db-8998c0f2b0ff	http://BASE_IP:8001/api/v1/callback	Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImNsaWVudF9pZGVudGlmaWVyIjoiZGVtbyJ9.eyJpc3MiOiJkZW1vIiwiaWF0IjoxNTU5OTE2MjM1LCJjbGllbnRfaWQiOiJkZW1vIiwidXNlcl9pZCI6IiIsInVzZXJfcmVwcmVzZW50YXRpb24iOiIiLCJ6ZHMiOnsic2NvcGVzIjpbIm5vdGlmaWNhdGllcy5wdWJsaWNlcmVuIl19fQ.uW00eUdwbesruH7lUanxcNJS1Ld5_R2Y86GmTrevxKY	demo
5	bdb29216-57e6-4d9d-b865-ac46524a5b83	http://BASE_IP:8000/api/v1/callback	Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImNsaWVudF9pZGVudGlmaWVyIjoiZGVtbyJ9.eyJpc3MiOiJkZW1vIiwiaWF0IjoxNTU5OTE2MjcwLCJjbGllbnRfaWQiOiJkZW1vIiwidXNlcl9pZCI6IiIsInVzZXJfcmVwcmVzZW50YXRpb24iOiIiLCJ6ZHMiOnsic2NvcGVzIjpbIm5vdGlmaWNhdGllcy5wdWJsaWNlcmVuIl19fQ.gaO3pZ9P9je1pk4aB53J2Axwhzhudd9ZzUK2bw1xe1k	demo
\.


--
-- Data for Name: datamodel_filter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_filter (id, key, value, filter_group_id) FROM stdin;
\.


--
-- Data for Name: datamodel_filtergroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_filtergroup (id, abonnement_id, kanaal_id) FROM stdin;
\.


--
-- Data for Name: datamodel_kanaal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_kanaal (id, uuid, naam, documentatie_link, filters) FROM stdin;
1	e39ab6c3-11f1-4293-8191-695a1b9aab53	autorisaties	http://BASE_IP:8005/ref/kanalen/#autorisaties	{}
2	01d410c2-ad54-461b-96b4-eccaf6e91a4f	besluiten	http://BASE_IP:8003/ref/kanalen/#besluiten	{verantwoordelijke_organisatie,besluittype}
\.


--
-- Data for Name: datamodel_notificatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_notificatie (id, forwarded_msg, kanaal_id) FROM stdin;
\.


--
-- Data for Name: datamodel_notificatieresponse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_notificatieresponse (id, response_status, abonnement_id, notificatie_id, exception) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-06-07 12:27:26.265914+00	1	demo	1	[{"added": {}}]	9	1
2	2019-06-07 12:33:24.664233+00	1	http://BASE_IP:8005/api/v1/	2	[{"changed": {"fields": ["api_root"]}}]	13	1
3	2019-06-07 12:34:22.26595+00	1	http://BASE_IP:8005/api/v1/	1	[{"added": {}}]	10	1
4	2019-06-07 12:39:27.476978+00	1	http://BASE_IP:8004/	2	[{"changed": {"fields": ["api_root"]}}]	14	1
5	2019-06-07 12:40:09.663346+00	1	http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["api_root"]}}, {"added": {"name": "Webhook subscription", "object": "autorisaties - http://BASE_IP:8004/api/v1/callback"}}]	14	1
6	2019-06-07 12:40:40.172688+00	2	http://34.90.134.90:8004/api/v1/	1	[{"added": {}}]	10	1
7	2019-06-07 12:41:45.162357+00	2	http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["api_root"]}}]	10	1
8	2019-06-07 12:41:56.267544+00	1	http://BASE_IP:8005/api/v1/	2	[{"changed": {"fields": ["component"]}}]	13	1
9	2019-06-07 13:00:08.965408+00	3	Applicatie (ac)	1	[{"added": {}}]	11	1
10	2019-06-07 13:01:44.169332+00	1	autorisaties - http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["callback_url"]}}]	15	1
11	2019-06-07 13:02:10.569282+00	1	autorisaties - http://BASE_IP:8004/api/v1/callback	2	[{"changed": {"fields": ["callback_url"]}}]	15	1
12	2019-06-07 13:31:38.962894+00	4	Applicatie (brc)	1	[{"added": {}}]	11	1
13	2019-06-07 14:18:06.165823+00	3	http://BASE_IP:8003/api/v1/	1	[{"added": {}}]	10	1
14	2019-06-07 14:18:18.665526+00	4	http://BASE_IP:8002/api/v1/	1	[{"added": {}}]	10	1
15	2019-06-07 14:18:32.565894+00	5	http://BASE_IP:8001/api/v1/	1	[{"added": {}}]	10	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	contenttypes	contenttype
2	auth	permission
3	auth	group
4	sessions	session
5	admin	logentry
6	axes	accessattempt
7	axes	accesslog
8	corsheaders	corsmodel
9	vng_api_common	jwtsecret
10	vng_api_common	apicredential
11	authorizations	applicatie
12	authorizations	autorisatie
13	authorizations	authorizationsconfig
14	notifications	notificationsconfig
15	notifications	subscription
16	accounts	user
17	datamodel	abonnement
18	datamodel	filter
19	datamodel	filtergroup
20	datamodel	kanaal
21	datamodel	notificatie
22	datamodel	notificatieresponse
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-06-13 08:13:54.993206+00
2	contenttypes	0002_remove_content_type_name	2019-06-13 08:13:55.117255+00
3	auth	0001_initial	2019-06-13 08:13:55.376912+00
4	auth	0002_alter_permission_name_max_length	2019-06-13 08:13:55.436815+00
5	auth	0003_alter_user_email_max_length	2019-06-13 08:13:55.522378+00
6	auth	0004_alter_user_username_opts	2019-06-13 08:13:55.62162+00
7	auth	0005_alter_user_last_login_null	2019-06-13 08:13:55.714274+00
8	auth	0006_require_contenttypes_0002	2019-06-13 08:13:55.726207+00
9	auth	0007_alter_validators_add_error_messages	2019-06-13 08:13:55.816549+00
10	auth	0008_alter_user_username_max_length	2019-06-13 08:13:55.917906+00
11	accounts	0001_initial	2019-06-13 08:13:56.803855+00
12	admin	0001_initial	2019-06-13 08:13:57.319285+00
13	admin	0002_logentry_remove_auto_add	2019-06-13 08:13:57.534178+00
14	admin	0003_logentry_add_action_flag_choices	2019-06-13 08:13:57.61487+00
15	auth	0009_alter_user_last_name_max_length	2019-06-13 08:13:57.769539+00
16	authorizations	0001_initial	2019-06-13 08:13:58.200858+00
17	authorizations	0002_authorizationsconfig	2019-06-13 08:13:58.499908+00
18	authorizations	0003_auto_20190502_0409	2019-06-13 08:13:58.591872+00
19	authorizations	0004_auto_20190503_0941	2019-06-13 08:13:58.691989+00
20	authorizations	0005_auto_20190506_0842	2019-06-13 08:13:58.786242+00
21	authorizations	0006_auto_20190506_0901	2019-06-13 08:13:59.593061+00
22	authorizations	0007_auto_20190506_1212	2019-06-13 08:13:59.752906+00
23	axes	0001_initial	2019-06-13 08:14:00.125112+00
24	axes	0002_auto_20151217_2044	2019-06-13 08:14:00.827326+00
25	axes	0003_auto_20160322_0929	2019-06-13 08:14:01.072279+00
26	axes	0004_auto_20181024_1538	2019-06-13 08:14:01.396341+00
27	axes	0005_remove_accessattempt_trusted	2019-06-13 08:14:01.417442+00
28	datamodel	0001_initial	2019-06-13 08:14:02.590375+00
29	datamodel	0002_auto_20190318_1844	2019-06-13 08:14:03.122827+00
30	datamodel	0003_auto_20190319_1151	2019-06-13 08:14:03.373116+00
31	datamodel	0004_notificatie_notificatieresponse	2019-06-13 08:14:03.871425+00
32	datamodel	0005_kanaal_filters	2019-06-13 08:14:03.996129+00
33	datamodel	0006_auto_20190327_1101	2019-06-13 08:14:04.13031+00
34	datamodel	0007_auto_20190327_1126	2019-06-13 08:14:04.274665+00
35	datamodel	0008_auto_20190409_1422	2019-06-13 08:14:04.579339+00
36	notifications	0001_initial	2019-06-13 08:14:05.083042+00
37	notifications	0002_subscription__subscription	2019-06-13 08:14:05.199044+00
38	notifications	0003_auto_20190319_1048	2019-06-13 08:14:05.526576+00
39	notifications	0004_auto_20190325_1313	2019-06-13 08:14:06.302135+00
40	notifications	0005_fix_default_nrc	2019-06-13 08:14:06.61123+00
41	notifications	0006_auto_20190417_1142	2019-06-13 08:14:06.785917+00
42	notifications	0007_auto_20190429_1442	2019-06-13 08:14:06.834068+00
43	notifications	0008_auto_20190502_0415	2019-06-13 08:14:06.904042+00
44	sessions	0001_initial	2019-06-13 08:14:07.075255+00
45	vng_api_common	0001_initial	2019-06-13 08:14:07.20829+00
46	vng_api_common	0002_apicredential	2019-06-13 08:14:07.501237+00
47	vng_api_common	0003_auto_20190417_1145	2019-06-13 08:14:07.602029+00
48	vng_api_common	0004_auto_20190517_0903	2019-06-13 08:14:07.784066+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
wb43t83i0tegr9shyzrehc0b5pgvzqfb	NGI2MmQwYzA1ZGRmMjc5MDA0ODljYjM3NTYwNmFlNjhhYmFjZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkOTk2NDkyMDhjYTJlNjg5NThlYjYxYTZiMTQ1ZDE2ZGUwOTc2ZTcxIn0=	2019-06-21 12:26:07.261911+00
n06b2wk0mv2vvycfggewxi89ch6y1p63	NGI2MmQwYzA1ZGRmMjc5MDA0ODljYjM3NTYwNmFlNjhhYmFjZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkOTk2NDkyMDhjYTJlNjg5NThlYjYxYTZiMTQ1ZDE2ZGUwOTc2ZTcxIn0=	2019-06-27 10:36:59.072795+00
\.


--
-- Data for Name: notifications_notificationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_notificationsconfig (id, api_root) FROM stdin;
1	http://BASE_IP:8004/api/v1/
\.


--
-- Data for Name: notifications_subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_subscription (id, callback_url, client_id, secret, channels, config_id, _subscription) FROM stdin;
1	http://BASE_IP:8004/api/v1/callback	demo	demo	{autorisaties}	1	http://BASE_IP:8004/api/v1/abonnement/8ae92a74-da77-4e16-83a6-e297c5d8e4ba
\.


--
-- Data for Name: vng_api_common_apicredential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_apicredential (id, api_root, client_id, secret, label, user_id, user_representation) FROM stdin;
1	http://BASE_IP:8005/api/v1/	demo	demo	ac	system	system
2	http://BASE_IP:8004/api/v1/	demo	demo	nrc	system	system
3	http://BASE_IP:8003/api/v1/	demo	demo	brc	system	system
4	http://BASE_IP:8002/api/v1/	demo	demo	ztc	system	system
5	http://BASE_IP:8001/api/v1/	demo	demo	drc	system	system
\.


--
-- Data for Name: vng_api_common_jwtsecret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_jwtsecret (id, identifier, secret) FROM stdin;
1	demo	demo
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 1, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 88, true);


--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_applicatie_id_seq', 4, true);


--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_authorizationsconfig_id_seq', 1, false);


--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_autorisatie_id_seq', 1, false);


--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accessattempt_id_seq', 1, true);


--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accesslog_id_seq', 2, true);


--
-- Name: datamodel_abonnement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_abonnement_id_seq', 5, true);


--
-- Name: datamodel_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_filter_id_seq', 1, false);


--
-- Name: datamodel_filtergroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_filtergroup_id_seq', 5, true);


--
-- Name: datamodel_kanaal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_kanaal_id_seq', 2, true);


--
-- Name: datamodel_notificatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_notificatie_id_seq', 1, false);


--
-- Name: datamodel_notificatieresponse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_notificatieresponse_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 15, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 22, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 48, true);


--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notificationsconfig_id_seq', 1, false);


--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_subscription_id_seq', 1, true);


--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_apicredential_id_seq', 5, true);


--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_jwtsecret_id_seq', 1, true);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_uuid_key UNIQUE (uuid);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_api_root_key UNIQUE (api_root);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_pkey PRIMARY KEY (id);


--
-- Name: authorizations_autorisatie authorizations_autorisatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autorisatie_pkey PRIMARY KEY (id);


--
-- Name: axes_accessattempt axes_accessattempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt
    ADD CONSTRAINT axes_accessattempt_pkey PRIMARY KEY (id);


--
-- Name: axes_accesslog axes_accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog
    ADD CONSTRAINT axes_accesslog_pkey PRIMARY KEY (id);


--
-- Name: datamodel_abonnement datamodel_abonnement_callback_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_abonnement
    ADD CONSTRAINT datamodel_abonnement_callback_url_key UNIQUE (callback_url);


--
-- Name: datamodel_abonnement datamodel_abonnement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_abonnement
    ADD CONSTRAINT datamodel_abonnement_pkey PRIMARY KEY (id);


--
-- Name: datamodel_abonnement datamodel_abonnement_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_abonnement
    ADD CONSTRAINT datamodel_abonnement_uuid_key UNIQUE (uuid);


--
-- Name: datamodel_filter datamodel_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_filter
    ADD CONSTRAINT datamodel_filter_pkey PRIMARY KEY (id);


--
-- Name: datamodel_filtergroup datamodel_filtergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_filtergroup
    ADD CONSTRAINT datamodel_filtergroup_pkey PRIMARY KEY (id);


--
-- Name: datamodel_kanaal datamodel_kanaal_naam_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_kanaal
    ADD CONSTRAINT datamodel_kanaal_naam_key UNIQUE (naam);


--
-- Name: datamodel_kanaal datamodel_kanaal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_kanaal
    ADD CONSTRAINT datamodel_kanaal_pkey PRIMARY KEY (id);


--
-- Name: datamodel_kanaal datamodel_kanaal_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_kanaal
    ADD CONSTRAINT datamodel_kanaal_uuid_key UNIQUE (uuid);


--
-- Name: datamodel_notificatie datamodel_notificatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_notificatie
    ADD CONSTRAINT datamodel_notificatie_pkey PRIMARY KEY (id);


--
-- Name: datamodel_notificatieresponse datamodel_notificatieresponse_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_notificatieresponse
    ADD CONSTRAINT datamodel_notificatieresponse_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_api_root_e4030d56_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_api_root_e4030d56_uniq UNIQUE (api_root);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_pkey PRIMARY KEY (id);


--
-- Name: notifications_subscription notifications_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscription_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_api_root_key UNIQUE (api_root);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_identifier_key UNIQUE (identifier);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authorizations_authorizationsconfig_api_root_0b54af71_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_authorizationsconfig_api_root_0b54af71_like ON public.authorizations_authorizationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: authorizations_autorisatie_applicatie_id_44348ea1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_autorisatie_applicatie_id_44348ea1 ON public.authorizations_autorisatie USING btree (applicatie_id);


--
-- Name: axes_accessattempt_ip_address_10922d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_ip_address_10922d9c ON public.axes_accessattempt USING btree (ip_address);


--
-- Name: axes_accessattempt_user_agent_ad89678b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b ON public.axes_accessattempt USING btree (user_agent);


--
-- Name: axes_accessattempt_user_agent_ad89678b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b_like ON public.axes_accessattempt USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accessattempt_username_3f2d4ca0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0 ON public.axes_accessattempt USING btree (username);


--
-- Name: axes_accessattempt_username_3f2d4ca0_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0_like ON public.axes_accessattempt USING btree (username varchar_pattern_ops);


--
-- Name: axes_accesslog_ip_address_86b417e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_ip_address_86b417e5 ON public.axes_accesslog USING btree (ip_address);


--
-- Name: axes_accesslog_trusted_496c5681; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_trusted_496c5681 ON public.axes_accesslog USING btree (trusted);


--
-- Name: axes_accesslog_user_agent_0e659004; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004 ON public.axes_accesslog USING btree (user_agent);


--
-- Name: axes_accesslog_user_agent_0e659004_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004_like ON public.axes_accesslog USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accesslog_username_df93064b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b ON public.axes_accesslog USING btree (username);


--
-- Name: axes_accesslog_username_df93064b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b_like ON public.axes_accesslog USING btree (username varchar_pattern_ops);


--
-- Name: datamodel_abonnement_callback_url_80bf69d5_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_abonnement_callback_url_80bf69d5_like ON public.datamodel_abonnement USING btree (callback_url varchar_pattern_ops);


--
-- Name: datamodel_filter_filter_group_id_e0d69329; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_filter_filter_group_id_e0d69329 ON public.datamodel_filter USING btree (filter_group_id);


--
-- Name: datamodel_filtergroup_abonnement_id_46373690; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_filtergroup_abonnement_id_46373690 ON public.datamodel_filtergroup USING btree (abonnement_id);


--
-- Name: datamodel_filtergroup_kanaal_id_22983681; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_filtergroup_kanaal_id_22983681 ON public.datamodel_filtergroup USING btree (kanaal_id);


--
-- Name: datamodel_kanaal_naam_13be4daa_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_kanaal_naam_13be4daa_like ON public.datamodel_kanaal USING btree (naam varchar_pattern_ops);


--
-- Name: datamodel_notificatie_kanaal_id_b4a6abfd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_notificatie_kanaal_id_b4a6abfd ON public.datamodel_notificatie USING btree (kanaal_id);


--
-- Name: datamodel_notificatieresponse_abonnement_id_3c6e2869; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_notificatieresponse_abonnement_id_3c6e2869 ON public.datamodel_notificatieresponse USING btree (abonnement_id);


--
-- Name: datamodel_notificatieresponse_notificatie_id_57d1635f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_notificatieresponse_notificatie_id_57d1635f ON public.datamodel_notificatieresponse USING btree (notificatie_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: notifications_notificationsconfig_api_root_e4030d56_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_notificationsconfig_api_root_e4030d56_like ON public.notifications_notificationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: notifications_subscription_config_id_3567b13c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_subscription_config_id_3567b13c ON public.notifications_subscription USING btree (config_id);


--
-- Name: vng_api_common_apicredential_api_root_cb3905ed_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_apicredential_api_root_cb3905ed_like ON public.vng_api_common_apicredential USING btree (api_root varchar_pattern_ops);


--
-- Name: vng_api_common_jwtsecret_identifier_e89b809e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_jwtsecret_identifier_e89b809e_like ON public.vng_api_common_jwtsecret USING btree (identifier varchar_pattern_ops);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authorizations_autorisatie authorizations_autor_applicatie_id_44348ea1_fk_authoriza; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autor_applicatie_id_44348ea1_fk_authoriza FOREIGN KEY (applicatie_id) REFERENCES public.authorizations_applicatie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_filter datamodel_filter_filter_group_id_e0d69329_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_filter
    ADD CONSTRAINT datamodel_filter_filter_group_id_e0d69329_fk_datamodel FOREIGN KEY (filter_group_id) REFERENCES public.datamodel_filtergroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_filtergroup datamodel_filtergrou_abonnement_id_46373690_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_filtergroup
    ADD CONSTRAINT datamodel_filtergrou_abonnement_id_46373690_fk_datamodel FOREIGN KEY (abonnement_id) REFERENCES public.datamodel_abonnement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_filtergroup datamodel_filtergroup_kanaal_id_22983681_fk_datamodel_kanaal_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_filtergroup
    ADD CONSTRAINT datamodel_filtergroup_kanaal_id_22983681_fk_datamodel_kanaal_id FOREIGN KEY (kanaal_id) REFERENCES public.datamodel_kanaal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_notificatieresponse datamodel_notificati_abonnement_id_3c6e2869_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_notificatieresponse
    ADD CONSTRAINT datamodel_notificati_abonnement_id_3c6e2869_fk_datamodel FOREIGN KEY (abonnement_id) REFERENCES public.datamodel_abonnement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_notificatieresponse datamodel_notificati_notificatie_id_57d1635f_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_notificatieresponse
    ADD CONSTRAINT datamodel_notificati_notificatie_id_57d1635f_fk_datamodel FOREIGN KEY (notificatie_id) REFERENCES public.datamodel_notificatie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_notificatie datamodel_notificatie_kanaal_id_b4a6abfd_fk_datamodel_kanaal_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_notificatie
    ADD CONSTRAINT datamodel_notificatie_kanaal_id_b4a6abfd_fk_datamodel_kanaal_id FOREIGN KEY (kanaal_id) REFERENCES public.datamodel_kanaal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_subscription notifications_subscr_config_id_3567b13c_fk_notificat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscr_config_id_3567b13c_fk_notificat FOREIGN KEY (config_id) REFERENCES public.notifications_notificationsconfig(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: zrc; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE zrc WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE zrc OWNER TO postgres;

\connect zrc

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: audittrails_audittrail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audittrails_audittrail (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    bron character varying(50) NOT NULL,
    actie character varying(50) NOT NULL,
    actie_weergave character varying(200) NOT NULL,
    resultaat integer NOT NULL,
    hoofd_object character varying(1000) NOT NULL,
    resource character varying(50) NOT NULL,
    resource_url character varying(1000) NOT NULL,
    aanmaakdatum timestamp with time zone NOT NULL,
    oud jsonb,
    nieuw jsonb,
    applicatie_id character varying(100) NOT NULL,
    applicatie_weergave character varying(200) NOT NULL,
    gebruikers_id character varying(255) NOT NULL,
    gebruikers_weergave character varying(255) NOT NULL,
    toelichting text NOT NULL
);


ALTER TABLE public.audittrails_audittrail OWNER TO postgres;

--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audittrails_audittrail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audittrails_audittrail_id_seq OWNER TO postgres;

--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audittrails_audittrail_id_seq OWNED BY public.audittrails_audittrail.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authorizations_applicatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_applicatie (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    client_ids character varying(50)[] NOT NULL,
    label character varying(100) NOT NULL,
    heeft_alle_autorisaties boolean NOT NULL
);


ALTER TABLE public.authorizations_applicatie OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_applicatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_applicatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_applicatie_id_seq OWNED BY public.authorizations_applicatie.id;


--
-- Name: authorizations_authorizationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_authorizationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    component character varying(50) NOT NULL
);


ALTER TABLE public.authorizations_authorizationsconfig OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_authorizationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_authorizationsconfig_id_seq OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_authorizationsconfig_id_seq OWNED BY public.authorizations_authorizationsconfig.id;


--
-- Name: authorizations_autorisatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_autorisatie (
    id integer NOT NULL,
    component character varying(50) NOT NULL,
    zaaktype character varying(1000) NOT NULL,
    scopes character varying(100)[] NOT NULL,
    max_vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    applicatie_id integer NOT NULL,
    besluittype character varying(1000) NOT NULL,
    informatieobjecttype character varying(1000) NOT NULL
);


ALTER TABLE public.authorizations_autorisatie OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_autorisatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_autorisatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_autorisatie_id_seq OWNED BY public.authorizations_autorisatie.id;


--
-- Name: axes_accessattempt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accessattempt (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    get_data text NOT NULL,
    post_data text NOT NULL,
    failures_since_start integer NOT NULL,
    CONSTRAINT axes_accessattempt_failures_since_start_check CHECK ((failures_since_start >= 0))
);


ALTER TABLE public.axes_accessattempt OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accessattempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accessattempt_id_seq OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accessattempt_id_seq OWNED BY public.axes_accessattempt.id;


--
-- Name: axes_accesslog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accesslog (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    logout_time timestamp with time zone
);


ALTER TABLE public.axes_accesslog OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accesslog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accesslog_id_seq OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accesslog_id_seq OWNED BY public.axes_accesslog.id;


--
-- Name: datamodel_klantcontact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_klantcontact (
    id integer NOT NULL,
    identificatie character varying(14) NOT NULL,
    datumtijd timestamp with time zone NOT NULL,
    kanaal character varying(20) NOT NULL,
    zaak_id integer NOT NULL,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_klantcontact OWNER TO postgres;

--
-- Name: datamodel_klantcontact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_klantcontact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_klantcontact_id_seq OWNER TO postgres;

--
-- Name: datamodel_klantcontact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_klantcontact_id_seq OWNED BY public.datamodel_klantcontact.id;


--
-- Name: datamodel_resultaat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_resultaat (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    resultaat_type character varying(1000) NOT NULL,
    toelichting text NOT NULL,
    zaak_id integer NOT NULL
);


ALTER TABLE public.datamodel_resultaat OWNER TO postgres;

--
-- Name: datamodel_resultaat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_resultaat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_resultaat_id_seq OWNER TO postgres;

--
-- Name: datamodel_resultaat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_resultaat_id_seq OWNED BY public.datamodel_resultaat.id;


--
-- Name: datamodel_rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_rol (
    id integer NOT NULL,
    rolomschrijving character varying(80) NOT NULL,
    roltoelichting text NOT NULL,
    zaak_id integer NOT NULL,
    uuid uuid NOT NULL,
    betrokkene character varying(1000) NOT NULL,
    betrokkene_type character varying(100) NOT NULL
);


ALTER TABLE public.datamodel_rol OWNER TO postgres;

--
-- Name: datamodel_rol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_rol_id_seq OWNER TO postgres;

--
-- Name: datamodel_rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_rol_id_seq OWNED BY public.datamodel_rol.id;


--
-- Name: datamodel_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_status (
    id integer NOT NULL,
    status_type character varying(1000) NOT NULL,
    datum_status_gezet timestamp with time zone NOT NULL,
    statustoelichting text NOT NULL,
    zaak_id integer NOT NULL,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_status OWNER TO postgres;

--
-- Name: datamodel_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_status_id_seq OWNER TO postgres;

--
-- Name: datamodel_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_status_id_seq OWNED BY public.datamodel_status.id;


--
-- Name: datamodel_zaak; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaak (
    id integer NOT NULL,
    identificatie character varying(40) NOT NULL,
    zaaktype character varying(1000) NOT NULL,
    registratiedatum date NOT NULL,
    toelichting text NOT NULL,
    zaakgeometrie public.geometry(Geometry,4326),
    bronorganisatie character varying(9) NOT NULL,
    uuid uuid NOT NULL,
    einddatum date,
    einddatum_gepland date,
    startdatum date NOT NULL,
    omschrijving character varying(80) NOT NULL,
    uiterlijke_einddatum_afdoening date,
    verantwoordelijke_organisatie character varying(9) NOT NULL,
    publicatiedatum date,
    communicatiekanaal character varying(1000) NOT NULL,
    vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    betalingsindicatie character varying(20) NOT NULL,
    laatste_betaaldatum timestamp with time zone,
    verlenging_duur interval,
    verlenging_reden character varying(200) NOT NULL,
    opschorting_indicatie boolean NOT NULL,
    opschorting_reden character varying(200) NOT NULL,
    selectielijstklasse character varying(1000) NOT NULL,
    hoofdzaak_id integer,
    relevante_andere_zaken character varying(1000)[] NOT NULL,
    producten_of_diensten character varying(1000)[] NOT NULL,
    archiefactiedatum date,
    archiefnominatie character varying(40),
    archiefstatus character varying(40) NOT NULL
);


ALTER TABLE public.datamodel_zaak OWNER TO postgres;

--
-- Name: datamodel_zaak_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaak_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaak_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaak_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaak_id_seq OWNED BY public.datamodel_zaak.id;


--
-- Name: datamodel_zaakbesluit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaakbesluit (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    besluit character varying(1000) NOT NULL,
    zaak_id integer NOT NULL
);


ALTER TABLE public.datamodel_zaakbesluit OWNER TO postgres;

--
-- Name: datamodel_zaakbesluit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakbesluit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakbesluit_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakbesluit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakbesluit_id_seq OWNED BY public.datamodel_zaakbesluit.id;


--
-- Name: datamodel_zaakeigenschap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaakeigenschap (
    id integer NOT NULL,
    eigenschap character varying(1000) NOT NULL,
    waarde text NOT NULL,
    zaak_id integer NOT NULL,
    uuid uuid NOT NULL,
    _naam character varying(20) NOT NULL
);


ALTER TABLE public.datamodel_zaakeigenschap OWNER TO postgres;

--
-- Name: datamodel_zaakeigenschap_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakeigenschap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakeigenschap_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakeigenschap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakeigenschap_id_seq OWNED BY public.datamodel_zaakeigenschap.id;


--
-- Name: datamodel_zaakinformatieobject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaakinformatieobject (
    id integer NOT NULL,
    informatieobject character varying(1000) NOT NULL,
    zaak_id integer NOT NULL,
    uuid uuid NOT NULL,
    aard_relatie character varying(20) NOT NULL,
    beschrijving text NOT NULL,
    registratiedatum timestamp with time zone NOT NULL,
    titel character varying(200) NOT NULL
);


ALTER TABLE public.datamodel_zaakinformatieobject OWNER TO postgres;

--
-- Name: datamodel_zaakinformatieobject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakinformatieobject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakinformatieobject_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakinformatieobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakinformatieobject_id_seq OWNED BY public.datamodel_zaakinformatieobject.id;


--
-- Name: datamodel_zaakkenmerk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaakkenmerk (
    id integer NOT NULL,
    kenmerk character varying(40) NOT NULL,
    bron character varying(40) NOT NULL,
    zaak_id integer NOT NULL
);


ALTER TABLE public.datamodel_zaakkenmerk OWNER TO postgres;

--
-- Name: datamodel_zaakkenmerk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakkenmerk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakkenmerk_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakkenmerk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakkenmerk_id_seq OWNED BY public.datamodel_zaakkenmerk.id;


--
-- Name: datamodel_zaakobject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaakobject (
    id integer NOT NULL,
    object character varying(1000) NOT NULL,
    relatieomschrijving character varying(80) NOT NULL,
    zaak_id integer NOT NULL,
    uuid uuid NOT NULL,
    object_type character varying(100) NOT NULL
);


ALTER TABLE public.datamodel_zaakobject OWNER TO postgres;

--
-- Name: datamodel_zaakobject_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakobject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakobject_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakobject_id_seq OWNED BY public.datamodel_zaakobject.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: notifications_notificationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_notificationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL
);


ALTER TABLE public.notifications_notificationsconfig OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notificationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_notificationsconfig_id_seq OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notificationsconfig_id_seq OWNED BY public.notifications_notificationsconfig.id;


--
-- Name: notifications_subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_subscription (
    id integer NOT NULL,
    callback_url character varying(200) NOT NULL,
    client_id character varying(50) NOT NULL,
    secret character varying(50) NOT NULL,
    channels character varying(100)[] NOT NULL,
    config_id integer NOT NULL,
    _subscription character varying(200) NOT NULL
);


ALTER TABLE public.notifications_subscription OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_subscription_id_seq OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_subscription_id_seq OWNED BY public.notifications_subscription.id;


--
-- Name: vng_api_common_apicredential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_apicredential (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    client_id character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    label character varying(100) NOT NULL,
    user_id character varying(255) NOT NULL,
    user_representation character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_apicredential OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_apicredential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_apicredential_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_apicredential_id_seq OWNED BY public.vng_api_common_apicredential.id;


--
-- Name: vng_api_common_jwtsecret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_jwtsecret (
    id integer NOT NULL,
    identifier character varying(50) NOT NULL,
    secret character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_jwtsecret OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_jwtsecret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_jwtsecret_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_jwtsecret_id_seq OWNED BY public.vng_api_common_jwtsecret.id;


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: audittrails_audittrail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail ALTER COLUMN id SET DEFAULT nextval('public.audittrails_audittrail_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: authorizations_applicatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_applicatie_id_seq'::regclass);


--
-- Name: authorizations_authorizationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig ALTER COLUMN id SET DEFAULT nextval('public.authorizations_authorizationsconfig_id_seq'::regclass);


--
-- Name: authorizations_autorisatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_autorisatie_id_seq'::regclass);


--
-- Name: axes_accessattempt id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt ALTER COLUMN id SET DEFAULT nextval('public.axes_accessattempt_id_seq'::regclass);


--
-- Name: axes_accesslog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog ALTER COLUMN id SET DEFAULT nextval('public.axes_accesslog_id_seq'::regclass);


--
-- Name: datamodel_klantcontact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_klantcontact ALTER COLUMN id SET DEFAULT nextval('public.datamodel_klantcontact_id_seq'::regclass);


--
-- Name: datamodel_resultaat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaat ALTER COLUMN id SET DEFAULT nextval('public.datamodel_resultaat_id_seq'::regclass);


--
-- Name: datamodel_rol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_rol ALTER COLUMN id SET DEFAULT nextval('public.datamodel_rol_id_seq'::regclass);


--
-- Name: datamodel_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_status ALTER COLUMN id SET DEFAULT nextval('public.datamodel_status_id_seq'::regclass);


--
-- Name: datamodel_zaak id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaak ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaak_id_seq'::regclass);


--
-- Name: datamodel_zaakbesluit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakbesluit ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakbesluit_id_seq'::regclass);


--
-- Name: datamodel_zaakeigenschap id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakeigenschap ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakeigenschap_id_seq'::regclass);


--
-- Name: datamodel_zaakinformatieobject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobject ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakinformatieobject_id_seq'::regclass);


--
-- Name: datamodel_zaakkenmerk id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakkenmerk ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakkenmerk_id_seq'::regclass);


--
-- Name: datamodel_zaakobject id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobject ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakobject_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: notifications_notificationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig ALTER COLUMN id SET DEFAULT nextval('public.notifications_notificationsconfig_id_seq'::regclass);


--
-- Name: notifications_subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription ALTER COLUMN id SET DEFAULT nextval('public.notifications_subscription_id_seq'::regclass);


--
-- Name: vng_api_common_apicredential id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_apicredential_id_seq'::regclass);


--
-- Name: vng_api_common_jwtsecret id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_jwtsecret_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$150000$RrwQTRAN7cb0$8HnotTQyZjj+U7XfPR1fRgQGCk5QlJJvGII/p83lOcA=	2019-06-13 10:34:52.586809+00	t	admin				t	t	2019-06-07 12:15:50.087756+00
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: audittrails_audittrail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audittrails_audittrail (id, uuid, bron, actie, actie_weergave, resultaat, hoofd_object, resource, resource_url, aanmaakdatum, oud, nieuw, applicatie_id, applicatie_weergave, gebruikers_id, gebruikers_weergave, toelichting) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add content type	1	add_contenttype
2	Can change content type	1	change_contenttype
3	Can delete content type	1	delete_contenttype
4	Can view content type	1	view_contenttype
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add session	4	add_session
14	Can change session	4	change_session
15	Can delete session	4	delete_session
16	Can view session	4	view_session
17	Can add site	5	add_site
18	Can change site	5	change_site
19	Can delete site	5	delete_site
20	Can view site	5	view_site
21	Can add log entry	6	add_logentry
22	Can change log entry	6	change_logentry
23	Can delete log entry	6	delete_logentry
24	Can view log entry	6	view_logentry
25	Can add access attempt	7	add_accessattempt
26	Can change access attempt	7	change_accessattempt
27	Can delete access attempt	7	delete_accessattempt
28	Can view access attempt	7	view_accessattempt
29	Can add access log	8	add_accesslog
30	Can change access log	8	change_accesslog
31	Can delete access log	8	delete_accesslog
32	Can view access log	8	view_accesslog
33	Can add cors model	9	add_corsmodel
34	Can change cors model	9	change_corsmodel
35	Can delete cors model	9	delete_corsmodel
36	Can view cors model	9	view_corsmodel
37	Can add client credential	10	add_jwtsecret
38	Can change client credential	10	change_jwtsecret
39	Can delete client credential	10	delete_jwtsecret
40	Can view client credential	10	view_jwtsecret
41	Can add external API credential	11	add_apicredential
42	Can change external API credential	11	change_apicredential
43	Can delete external API credential	11	delete_apicredential
44	Can view external API credential	11	view_apicredential
45	Can add applicatie	12	add_applicatie
46	Can change applicatie	12	change_applicatie
47	Can delete applicatie	12	delete_applicatie
48	Can view applicatie	12	view_applicatie
49	Can add autorisatie	13	add_autorisatie
50	Can change autorisatie	13	change_autorisatie
51	Can delete autorisatie	13	delete_autorisatie
52	Can view autorisatie	13	view_autorisatie
53	Can add Autorisatiecomponentconfiguratie	14	add_authorizationsconfig
54	Can change Autorisatiecomponentconfiguratie	14	change_authorizationsconfig
55	Can delete Autorisatiecomponentconfiguratie	14	delete_authorizationsconfig
56	Can view Autorisatiecomponentconfiguratie	14	view_authorizationsconfig
57	Can add audit trail	15	add_audittrail
58	Can change audit trail	15	change_audittrail
59	Can delete audit trail	15	delete_audittrail
60	Can view audit trail	15	view_audittrail
61	Can add Notificatiescomponentconfiguratie	16	add_notificationsconfig
62	Can change Notificatiescomponentconfiguratie	16	change_notificationsconfig
63	Can delete Notificatiescomponentconfiguratie	16	delete_notificationsconfig
64	Can view Notificatiescomponentconfiguratie	16	view_notificationsconfig
65	Can add Webhook subscription	17	add_subscription
66	Can change Webhook subscription	17	change_subscription
67	Can delete Webhook subscription	17	delete_subscription
68	Can view Webhook subscription	17	view_subscription
69	Can add user	18	add_user
70	Can change user	18	change_user
71	Can delete user	18	delete_user
72	Can view user	18	view_user
73	Can add status	19	add_status
74	Can change status	19	change_status
75	Can delete status	19	delete_status
76	Can view status	19	view_status
77	Can add zaak	20	add_zaak
78	Can change zaak	20	change_zaak
79	Can delete zaak	20	delete_zaak
80	Can view zaak	20	view_zaak
81	Can add zaakobject	21	add_zaakobject
82	Can change zaakobject	21	change_zaakobject
83	Can delete zaakobject	21	delete_zaakobject
84	Can view zaakobject	21	view_zaakobject
85	Can add klantcontact	22	add_klantcontact
86	Can change klantcontact	22	change_klantcontact
87	Can delete klantcontact	22	delete_klantcontact
88	Can view klantcontact	22	view_klantcontact
89	Can add Rol	23	add_rol
90	Can change Rol	23	change_rol
91	Can delete Rol	23	delete_rol
92	Can view Rol	23	view_rol
93	Can add zaakeigenschap	24	add_zaakeigenschap
94	Can change zaakeigenschap	24	change_zaakeigenschap
95	Can delete zaakeigenschap	24	delete_zaakeigenschap
96	Can view zaakeigenschap	24	view_zaakeigenschap
97	Can add zaak kenmerk	25	add_zaakkenmerk
98	Can change zaak kenmerk	25	change_zaakkenmerk
99	Can delete zaak kenmerk	25	delete_zaakkenmerk
100	Can view zaak kenmerk	25	view_zaakkenmerk
101	Can add zaakinformatieobject	26	add_zaakinformatieobject
102	Can change zaakinformatieobject	26	change_zaakinformatieobject
103	Can delete zaakinformatieobject	26	delete_zaakinformatieobject
104	Can view zaakinformatieobject	26	view_zaakinformatieobject
105	Can add resultaat	27	add_resultaat
106	Can change resultaat	27	change_resultaat
107	Can delete resultaat	27	delete_resultaat
108	Can view resultaat	27	view_resultaat
109	Can add zaakbesluit	28	add_zaakbesluit
110	Can change zaakbesluit	28	change_zaakbesluit
111	Can delete zaakbesluit	28	delete_zaakbesluit
112	Can view zaakbesluit	28	view_zaakbesluit
\.


--
-- Data for Name: authorizations_applicatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_applicatie (id, uuid, client_ids, label, heeft_alle_autorisaties) FROM stdin;
1	b7622797-5f85-40e3-8abd-8f3ff476cf70	{demo}	ac	t
2	5d83fd8e-395c-4232-9afa-754bd4822ef3	{demo}	nrc	t
3	533fe769-b1f1-49ff-b9fb-5bd01cfe868b	{demo}	zrc	t
\.


--
-- Data for Name: authorizations_authorizationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_authorizationsconfig (id, api_root, component) FROM stdin;
1	http://BASE_IP:8005/api/v1/	ZRC
\.


--
-- Data for Name: authorizations_autorisatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_autorisatie (id, component, zaaktype, scopes, max_vertrouwelijkheidaanduiding, applicatie_id, besluittype, informatieobjecttype) FROM stdin;
\.


--
-- Data for Name: axes_accessattempt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accessattempt (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, get_data, post_data, failures_since_start) FROM stdin;
\.


--
-- Data for Name: axes_accesslog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accesslog (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, logout_time) FROM stdin;
1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.13	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-07 12:16:09.266924+00	\N
2	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.12	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:34:52.590283+00	\N
\.


--
-- Data for Name: datamodel_klantcontact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_klantcontact (id, identificatie, datumtijd, kanaal, zaak_id, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_resultaat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_resultaat (id, uuid, resultaat_type, toelichting, zaak_id) FROM stdin;
\.


--
-- Data for Name: datamodel_rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_rol (id, rolomschrijving, roltoelichting, zaak_id, uuid, betrokkene, betrokkene_type) FROM stdin;
\.


--
-- Data for Name: datamodel_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_status (id, status_type, datum_status_gezet, statustoelichting, zaak_id, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_zaak; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaak (id, identificatie, zaaktype, registratiedatum, toelichting, zaakgeometrie, bronorganisatie, uuid, einddatum, einddatum_gepland, startdatum, omschrijving, uiterlijke_einddatum_afdoening, verantwoordelijke_organisatie, publicatiedatum, communicatiekanaal, vertrouwelijkheidaanduiding, betalingsindicatie, laatste_betaaldatum, verlenging_duur, verlenging_reden, opschorting_indicatie, opschorting_reden, selectielijstklasse, hoofdzaak_id, relevante_andere_zaken, producten_of_diensten, archiefactiedatum, archiefnominatie, archiefstatus) FROM stdin;
\.


--
-- Data for Name: datamodel_zaakbesluit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaakbesluit (id, uuid, besluit, zaak_id) FROM stdin;
\.


--
-- Data for Name: datamodel_zaakeigenschap; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaakeigenschap (id, eigenschap, waarde, zaak_id, uuid, _naam) FROM stdin;
\.


--
-- Data for Name: datamodel_zaakinformatieobject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaakinformatieobject (id, informatieobject, zaak_id, uuid, aard_relatie, beschrijving, registratiedatum, titel) FROM stdin;
\.


--
-- Data for Name: datamodel_zaakkenmerk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaakkenmerk (id, kenmerk, bron, zaak_id) FROM stdin;
\.


--
-- Data for Name: datamodel_zaakobject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaakobject (id, object, relatieomschrijving, zaak_id, uuid, object_type) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-06-07 12:18:47.268981+00	1	BASE_IP:8000	2	[{"changed": {"fields": ["domain", "name"]}}]	5	1
2	2019-06-07 12:21:00.663705+00	1	http://BASE_IP:8005/api/v1/	1	[{"added": {}}]	11	1
3	2019-06-07 12:21:37.974538+00	1	http://BASE_IP:8005/api/v1/	2	[{"changed": {"fields": ["api_root"]}}]	14	1
4	2019-06-07 12:22:40.064848+00	1	demo	1	[{"added": {}}]	10	1
5	2019-06-07 12:27:55.389771+00	2	http://BASE_IP:8004/api/v1/	1	[{"added": {}}]	11	1
6	2019-06-07 12:30:31.163535+00	1	https://ref.tst.vng.cloud/nrc/api/v1/	2	[{"added": {"name": "Webhook subscription", "object": "autorisaties - http://BASE_IP:8004/api/v1/"}}]	16	1
7	2019-06-07 12:51:16.968338+00	1	http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["api_root"]}}, {"changed": {"name": "Webhook subscription", "object": "autorisaties - http://BASE_IP:8004/api/v1/callback", "fields": ["callback_url"]}}]	16	1
8	2019-06-07 14:04:26.570766+00	1	autorisaties - http://BASE_IP:8000/api/v1/callback	2	[{"changed": {"fields": ["callback_url"]}}]	17	1
9	2019-06-07 14:07:22.467487+00	1	http://BASE_IP:8005/api/v1/	2	[]	11	1
10	2019-06-07 14:08:32.067724+00	3	http://BASE_IP:8001/api/v1/	1	[{"added": {}}]	11	1
11	2019-06-07 14:09:23.467672+00	4	http://BASE_IP:8002/api/v1/	1	[{"added": {}}]	11	1
12	2019-06-07 14:09:44.072649+00	5	http://BASE_IP:8003/api/v1/	1	[{"added": {}}]	11	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	contenttypes	contenttype
2	auth	permission
3	auth	group
4	sessions	session
5	sites	site
6	admin	logentry
7	axes	accessattempt
8	axes	accesslog
9	corsheaders	corsmodel
10	vng_api_common	jwtsecret
11	vng_api_common	apicredential
12	authorizations	applicatie
13	authorizations	autorisatie
14	authorizations	authorizationsconfig
15	audittrails	audittrail
16	notifications	notificationsconfig
17	notifications	subscription
18	accounts	user
19	datamodel	status
20	datamodel	zaak
21	datamodel	zaakobject
22	datamodel	klantcontact
23	datamodel	rol
24	datamodel	zaakeigenschap
25	datamodel	zaakkenmerk
26	datamodel	zaakinformatieobject
27	datamodel	resultaat
28	datamodel	zaakbesluit
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-06-13 08:14:21.301382+00
2	contenttypes	0002_remove_content_type_name	2019-06-13 08:14:21.478131+00
3	auth	0001_initial	2019-06-13 08:14:21.724297+00
4	auth	0002_alter_permission_name_max_length	2019-06-13 08:14:21.828082+00
5	auth	0003_alter_user_email_max_length	2019-06-13 08:14:21.926064+00
6	auth	0004_alter_user_username_opts	2019-06-13 08:14:22.015967+00
7	auth	0005_alter_user_last_login_null	2019-06-13 08:14:22.119907+00
8	auth	0006_require_contenttypes_0002	2019-06-13 08:14:22.127826+00
9	auth	0007_alter_validators_add_error_messages	2019-06-13 08:14:22.218062+00
10	auth	0008_alter_user_username_max_length	2019-06-13 08:14:22.356972+00
11	accounts	0001_initial	2019-06-13 08:14:22.496245+00
12	admin	0001_initial	2019-06-13 08:14:22.739222+00
13	admin	0002_logentry_remove_auto_add	2019-06-13 08:14:22.819889+00
14	admin	0003_logentry_add_action_flag_choices	2019-06-13 08:14:22.970361+00
15	audittrails	0001_initial	2019-06-13 08:14:23.040066+00
16	audittrails	0002_auto_20190516_0830	2019-06-13 08:14:23.118829+00
17	audittrails	0003_auto_20190517_0844	2019-06-13 08:14:23.588385+00
18	audittrails	0004_auto_20190520_1238	2019-06-13 08:14:23.687222+00
19	audittrails	0005_auto_20190520_1450	2019-06-13 08:14:23.787037+00
20	audittrails	0006_audittrail_toelichting	2019-06-13 08:14:23.831987+00
21	audittrails	0007_auto_20190522_0916	2019-06-13 08:14:23.903335+00
22	auth	0009_alter_user_last_name_max_length	2019-06-13 08:14:24.025476+00
23	auth	0010_alter_group_name_max_length	2019-06-13 08:14:24.124471+00
24	auth	0011_update_proxy_permissions	2019-06-13 08:14:24.327884+00
25	authorizations	0001_initial	2019-06-13 08:14:24.480917+00
26	authorizations	0002_authorizationsconfig	2019-06-13 08:14:24.592888+00
27	authorizations	0003_auto_20190502_0409	2019-06-13 08:14:24.643209+00
28	authorizations	0004_auto_20190503_0941	2019-06-13 08:14:24.723069+00
29	authorizations	0005_auto_20190506_0842	2019-06-13 08:14:24.893617+00
30	authorizations	0006_auto_20190506_0901	2019-06-13 08:14:25.378132+00
31	authorizations	0007_auto_20190506_1212	2019-06-13 08:14:25.484819+00
32	axes	0001_initial	2019-06-13 08:14:25.578055+00
33	axes	0002_auto_20151217_2044	2019-06-13 08:14:25.911791+00
34	axes	0003_auto_20160322_0929	2019-06-13 08:14:26.283913+00
35	datamodel	0001_initial	2019-06-13 08:14:26.404211+00
36	datamodel	0002_zaak_zaaktype	2019-06-13 08:14:26.495852+00
37	datamodel	0003_auto_20180608_1605	2019-06-13 08:14:27.281568+00
38	datamodel	0004_zaakobject	2019-06-13 08:14:27.317046+00
39	datamodel	0005_zaak_registratiedatum	2019-06-13 08:14:27.411181+00
40	datamodel	0006_zaak_toelichting	2019-06-13 08:14:27.502056+00
41	datamodel	0007_zaak_domein_data	2019-06-13 08:14:27.582017+00
42	datamodel	0008_auto_20180611_1247	2019-06-13 08:14:27.802452+00
43	datamodel	0009_klantcontact	2019-06-13 08:14:27.906738+00
44	datamodel	0010_klantcontact_zaak	2019-06-13 08:14:27.986185+00
45	datamodel	0011_zaakinformatieobject	2019-06-13 08:14:28.111763+00
46	datamodel	0012_zaak_zaakgeometrie	2019-06-13 08:14:28.198051+00
47	datamodel	0013_organisatorischeeenheid_rol	2019-06-13 08:14:28.406844+00
48	datamodel	0014_auto_20180629_1512	2019-06-13 08:14:28.588177+00
49	datamodel	0015_auto_20180701_1127	2019-06-13 08:14:28.690638+00
50	datamodel	0016_auto_20180711_1346	2019-06-13 08:14:28.981141+00
51	datamodel	0017_zaak_bronorganisatie	2019-06-13 08:14:29.086105+00
52	datamodel	0018_auto_20180716_1259	2019-06-13 08:14:29.190856+00
53	datamodel	0019_auto_20180724_0941	2019-06-13 08:14:29.910291+00
54	datamodel	0020_auto_20180724_0941	2019-06-13 08:14:30.298919+00
55	datamodel	0021_auto_20180724_0941	2019-06-13 08:14:31.115178+00
56	datamodel	0022_auto_20180724_0958	2019-06-13 08:14:31.806704+00
57	datamodel	0023_auto_20180725_1511	2019-06-13 08:14:32.297123+00
58	datamodel	0024_zaakobject_object_type	2019-06-13 08:14:32.399383+00
59	datamodel	0025_remove_rol_betrokkene	2019-06-13 08:14:32.59784+00
60	datamodel	0026_rol_betrokkene	2019-06-13 08:14:32.69547+00
61	datamodel	0027_delete_organisatorischeeenheid	2019-06-13 08:14:32.701885+00
62	datamodel	0028_rol_betrokkene_type	2019-06-13 08:14:32.802508+00
63	datamodel	0029_auto_20180725_1548	2019-06-13 08:14:32.973305+00
64	datamodel	0030_auto_20180813_0855	2019-06-13 08:14:33.077714+00
65	datamodel	0031_auto_20180815_1525	2019-06-13 08:14:33.294137+00
66	datamodel	0032_auto_20180816_1451	2019-06-13 08:14:33.510486+00
67	datamodel	0032_auto_20180816_1352	2019-06-13 08:14:33.696639+00
68	datamodel	0033_merge_20180816_1624	2019-06-13 08:14:33.700804+00
69	datamodel	0034_auto_20180817_1747	2019-06-13 08:14:34.185975+00
70	datamodel	0035_auto_20180919_1103	2019-06-13 08:14:34.590303+00
71	datamodel	0036_zaakinformatieobject_uuid	2019-06-13 08:14:34.786065+00
72	datamodel	0037_auto_20181129_1016	2019-06-13 08:14:34.911526+00
73	datamodel	0038_auto_20181219_1027	2019-06-13 08:14:35.17686+00
74	datamodel	0039_auto_20181224_1626	2019-06-13 08:14:35.488048+00
75	datamodel	0040_zaak_communicatiekanaal	2019-06-13 08:14:35.687011+00
76	datamodel	0041_zaak_vertrouwlijkheidaanduiding	2019-06-13 08:14:35.799353+00
77	datamodel	0042_zet_vertrouwelijkheidaanduiding	2019-06-13 08:14:36.18404+00
78	datamodel	0043_auto_20181227_1532	2019-06-13 08:14:36.295262+00
79	datamodel	0044_zaak_resultaattoelichting	2019-06-13 08:14:36.499055+00
80	datamodel	0045_zaak_betalingsindicatie	2019-06-13 08:14:36.6811+00
81	datamodel	0046_zaak_laatste_betaaldatum	2019-06-13 08:14:36.791036+00
82	datamodel	0047_auto_20190103_1353	2019-06-13 08:14:37.093108+00
83	datamodel	0048_auto_20190103_1649	2019-06-13 08:14:37.395035+00
84	datamodel	0049_zaak_selectielijstklasse	2019-06-13 08:14:37.599595+00
85	datamodel	0050_zaak_hoofdzaak	2019-06-13 08:14:37.785045+00
86	datamodel	0051_zaak_relevante_andere_zaken	2019-06-13 08:14:37.981146+00
87	datamodel	0052_auto_20190128_0933	2019-06-13 08:14:38.183587+00
88	datamodel	0053_auto_20190128_1044	2019-06-13 08:14:38.315825+00
89	datamodel	0054_auto_20190129_1204	2019-06-13 08:14:38.685916+00
90	datamodel	0055_auto_20190226_1254	2019-06-13 08:14:39.695894+00
91	datamodel	0056_auto_20190311_1015	2019-06-13 08:14:41.502247+00
92	datamodel	0057_auto_20190523_1513	2019-06-13 08:14:41.800234+00
93	datamodel	0057_auto_20190517_1351	2019-06-13 08:14:41.996931+00
94	datamodel	0058_merge_20190531_1435	2019-06-13 08:14:41.999491+00
95	datamodel	0059_auto_20190531_1512	2019-06-13 08:14:42.683429+00
96	datamodel	0060_auto_20190605_0941	2019-06-13 08:14:42.790988+00
97	notifications	0001_initial	2019-06-13 08:14:42.906897+00
98	notifications	0002_subscription__subscription	2019-06-13 08:14:42.996999+00
99	notifications	0003_auto_20190319_1048	2019-06-13 08:14:43.283911+00
100	notifications	0004_auto_20190325_1313	2019-06-13 08:14:43.30258+00
101	notifications	0005_fix_default_nrc	2019-06-13 08:14:44.775206+00
102	notifications	0006_auto_20190417_1142	2019-06-13 08:14:44.972344+00
103	notifications	0007_auto_20190429_1442	2019-06-13 08:14:45.000335+00
104	notifications	0008_auto_20190502_0415	2019-06-13 08:14:45.089304+00
105	sessions	0001_initial	2019-06-13 08:14:45.19713+00
106	sites	0001_initial	2019-06-13 08:14:45.212817+00
107	sites	0002_alter_domain_unique	2019-06-13 08:14:45.298621+00
108	vng_api_common	0001_initial	2019-06-13 08:14:45.396426+00
109	vng_api_common	0002_apicredential	2019-06-13 08:14:45.415285+00
110	vng_api_common	0003_auto_20190417_1145	2019-06-13 08:14:45.584913+00
111	vng_api_common	0004_auto_20190517_0903	2019-06-13 08:14:45.684918+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
7vb3mrvvbvzkm1nlfh1ko8ptm0au9wa7	NzYyMjVlYzM2NTRhNGI1ZmQ1MWM0MjAwZjIwZDk2MjczMGFhZDE4OTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmNDM3ODg4Y2UyMzg1NWRjZGJkZTNhNGMxNjZhYjdlZDA5NmE0NDM4In0=	2019-06-21 12:16:09.276538+00
3li9ipzqeibvizcgrnzv3a7t27t9omti	NzYyMjVlYzM2NTRhNGI1ZmQ1MWM0MjAwZjIwZDk2MjczMGFhZDE4OTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmNDM3ODg4Y2UyMzg1NWRjZGJkZTNhNGMxNjZhYjdlZDA5NmE0NDM4In0=	2019-06-27 10:34:52.681373+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	BASE_IP:8000	BASE_IP:8000
\.


--
-- Data for Name: notifications_notificationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_notificationsconfig (id, api_root) FROM stdin;
1	http://BASE_IP:8004/api/v1/
\.


--
-- Data for Name: notifications_subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_subscription (id, callback_url, client_id, secret, channels, config_id, _subscription) FROM stdin;
1	http://BASE_IP:8000/api/v1/callback	demo	demo	{autorisaties}	1	http://BASE_IP:8004/api/v1/abonnement/bdb29216-57e6-4d9d-b865-ac46524a5b83
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: vng_api_common_apicredential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_apicredential (id, api_root, client_id, secret, label, user_id, user_representation) FROM stdin;
2	http://BASE_IP:8004/api/v1/	demo	demo	nrc	system	system
1	http://BASE_IP:8005/api/v1/	demo	demo	ac	system	system
3	http://BASE_IP:8001/api/v1/	demo	demo	drc	system	system
4	http://BASE_IP:8002/api/v1/	demo	demo	ztc	system	system
5	http://BASE_IP:8003/api/v1/	demo	demo	brc	system	system
\.


--
-- Data for Name: vng_api_common_jwtsecret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_jwtsecret (id, identifier, secret) FROM stdin;
1	demo	demo
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 1, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: audittrails_audittrail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audittrails_audittrail_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 112, true);


--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_applicatie_id_seq', 3, true);


--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_authorizationsconfig_id_seq', 1, false);


--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_autorisatie_id_seq', 1, false);


--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accessattempt_id_seq', 1, false);


--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accesslog_id_seq', 2, true);


--
-- Name: datamodel_klantcontact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_klantcontact_id_seq', 1, false);


--
-- Name: datamodel_resultaat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_resultaat_id_seq', 1, false);


--
-- Name: datamodel_rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_rol_id_seq', 1, false);


--
-- Name: datamodel_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_status_id_seq', 1, false);


--
-- Name: datamodel_zaak_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaak_id_seq', 1, false);


--
-- Name: datamodel_zaakbesluit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakbesluit_id_seq', 1, false);


--
-- Name: datamodel_zaakeigenschap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakeigenschap_id_seq', 1, false);


--
-- Name: datamodel_zaakinformatieobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakinformatieobject_id_seq', 1, false);


--
-- Name: datamodel_zaakkenmerk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakkenmerk_id_seq', 1, false);


--
-- Name: datamodel_zaakobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakobject_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 12, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 28, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 111, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notificationsconfig_id_seq', 1, false);


--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_subscription_id_seq', 1, true);


--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_apicredential_id_seq', 5, true);


--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_jwtsecret_id_seq', 1, true);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: audittrails_audittrail audittrails_audittrail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail
    ADD CONSTRAINT audittrails_audittrail_pkey PRIMARY KEY (id);


--
-- Name: audittrails_audittrail audittrails_audittrail_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audittrails_audittrail
    ADD CONSTRAINT audittrails_audittrail_uuid_key UNIQUE (uuid);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_uuid_key UNIQUE (uuid);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_api_root_key UNIQUE (api_root);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_pkey PRIMARY KEY (id);


--
-- Name: authorizations_autorisatie authorizations_autorisatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autorisatie_pkey PRIMARY KEY (id);


--
-- Name: axes_accessattempt axes_accessattempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt
    ADD CONSTRAINT axes_accessattempt_pkey PRIMARY KEY (id);


--
-- Name: axes_accesslog axes_accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog
    ADD CONSTRAINT axes_accesslog_pkey PRIMARY KEY (id);


--
-- Name: datamodel_klantcontact datamodel_klantcontact_identificatie_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_klantcontact
    ADD CONSTRAINT datamodel_klantcontact_identificatie_key UNIQUE (identificatie);


--
-- Name: datamodel_klantcontact datamodel_klantcontact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_klantcontact
    ADD CONSTRAINT datamodel_klantcontact_pkey PRIMARY KEY (id);


--
-- Name: datamodel_klantcontact datamodel_klantcontact_uuid_a23a9e39_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_klantcontact
    ADD CONSTRAINT datamodel_klantcontact_uuid_a23a9e39_uniq UNIQUE (uuid);


--
-- Name: datamodel_resultaat datamodel_resultaat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaat
    ADD CONSTRAINT datamodel_resultaat_pkey PRIMARY KEY (id);


--
-- Name: datamodel_resultaat datamodel_resultaat_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaat
    ADD CONSTRAINT datamodel_resultaat_uuid_key UNIQUE (uuid);


--
-- Name: datamodel_resultaat datamodel_resultaat_zaak_id_fe54ffac_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaat
    ADD CONSTRAINT datamodel_resultaat_zaak_id_fe54ffac_uniq UNIQUE (zaak_id);


--
-- Name: datamodel_rol datamodel_rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_rol
    ADD CONSTRAINT datamodel_rol_pkey PRIMARY KEY (id);


--
-- Name: datamodel_rol datamodel_rol_uuid_96d38089_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_rol
    ADD CONSTRAINT datamodel_rol_uuid_96d38089_uniq UNIQUE (uuid);


--
-- Name: datamodel_status datamodel_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_status
    ADD CONSTRAINT datamodel_status_pkey PRIMARY KEY (id);


--
-- Name: datamodel_status datamodel_status_uuid_4454e3e3_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_status
    ADD CONSTRAINT datamodel_status_uuid_4454e3e3_uniq UNIQUE (uuid);


--
-- Name: datamodel_status datamodel_status_zaak_id_datum_status_gezet_72963ee8_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_status
    ADD CONSTRAINT datamodel_status_zaak_id_datum_status_gezet_72963ee8_uniq UNIQUE (zaak_id, datum_status_gezet);


--
-- Name: datamodel_zaak datamodel_zaak_bronorganisatie_zaakidentificatie_2a46647c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaak
    ADD CONSTRAINT datamodel_zaak_bronorganisatie_zaakidentificatie_2a46647c_uniq UNIQUE (bronorganisatie, identificatie);


--
-- Name: datamodel_zaak datamodel_zaak_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaak
    ADD CONSTRAINT datamodel_zaak_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaak datamodel_zaak_uuid_14ad8c1e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaak
    ADD CONSTRAINT datamodel_zaak_uuid_14ad8c1e_uniq UNIQUE (uuid);


--
-- Name: datamodel_zaakbesluit datamodel_zaakbesluit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakbesluit
    ADD CONSTRAINT datamodel_zaakbesluit_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaakbesluit datamodel_zaakbesluit_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakbesluit
    ADD CONSTRAINT datamodel_zaakbesluit_uuid_key UNIQUE (uuid);


--
-- Name: datamodel_zaakbesluit datamodel_zaakbesluit_zaak_id_besluit_2b528cb4_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakbesluit
    ADD CONSTRAINT datamodel_zaakbesluit_zaak_id_besluit_2b528cb4_uniq UNIQUE (zaak_id, besluit);


--
-- Name: datamodel_zaakeigenschap datamodel_zaakeigenschap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakeigenschap
    ADD CONSTRAINT datamodel_zaakeigenschap_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaakeigenschap datamodel_zaakeigenschap_uuid_864a1979_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakeigenschap
    ADD CONSTRAINT datamodel_zaakeigenschap_uuid_864a1979_uniq UNIQUE (uuid);


--
-- Name: datamodel_zaakinformatieobject datamodel_zaakinformatie_zaak_id_informatieobject_f083b9c0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobject
    ADD CONSTRAINT datamodel_zaakinformatie_zaak_id_informatieobject_f083b9c0_uniq UNIQUE (zaak_id, informatieobject);


--
-- Name: datamodel_zaakinformatieobject datamodel_zaakinformatieobject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobject
    ADD CONSTRAINT datamodel_zaakinformatieobject_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaakinformatieobject datamodel_zaakinformatieobject_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobject
    ADD CONSTRAINT datamodel_zaakinformatieobject_uuid_key UNIQUE (uuid);


--
-- Name: datamodel_zaakkenmerk datamodel_zaakkenmerk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakkenmerk
    ADD CONSTRAINT datamodel_zaakkenmerk_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaakobject datamodel_zaakobject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobject
    ADD CONSTRAINT datamodel_zaakobject_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaakobject datamodel_zaakobject_uuid_f6e3c417_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobject
    ADD CONSTRAINT datamodel_zaakobject_uuid_f6e3c417_uniq UNIQUE (uuid);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_api_root_e4030d56_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_api_root_e4030d56_uniq UNIQUE (api_root);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_pkey PRIMARY KEY (id);


--
-- Name: notifications_subscription notifications_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscription_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_api_root_key UNIQUE (api_root);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_identifier_key UNIQUE (identifier);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authorizations_authorizationsconfig_api_root_0b54af71_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_authorizationsconfig_api_root_0b54af71_like ON public.authorizations_authorizationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: authorizations_autorisatie_applicatie_id_44348ea1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_autorisatie_applicatie_id_44348ea1 ON public.authorizations_autorisatie USING btree (applicatie_id);


--
-- Name: axes_accessattempt_ip_address_10922d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_ip_address_10922d9c ON public.axes_accessattempt USING btree (ip_address);


--
-- Name: axes_accessattempt_trusted_0eddf52e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_trusted_0eddf52e ON public.axes_accessattempt USING btree (trusted);


--
-- Name: axes_accessattempt_user_agent_ad89678b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b ON public.axes_accessattempt USING btree (user_agent);


--
-- Name: axes_accessattempt_user_agent_ad89678b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b_like ON public.axes_accessattempt USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accessattempt_username_3f2d4ca0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0 ON public.axes_accessattempt USING btree (username);


--
-- Name: axes_accessattempt_username_3f2d4ca0_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0_like ON public.axes_accessattempt USING btree (username varchar_pattern_ops);


--
-- Name: axes_accesslog_ip_address_86b417e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_ip_address_86b417e5 ON public.axes_accesslog USING btree (ip_address);


--
-- Name: axes_accesslog_trusted_496c5681; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_trusted_496c5681 ON public.axes_accesslog USING btree (trusted);


--
-- Name: axes_accesslog_user_agent_0e659004; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004 ON public.axes_accesslog USING btree (user_agent);


--
-- Name: axes_accesslog_user_agent_0e659004_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004_like ON public.axes_accesslog USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accesslog_username_df93064b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b ON public.axes_accesslog USING btree (username);


--
-- Name: axes_accesslog_username_df93064b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b_like ON public.axes_accesslog USING btree (username varchar_pattern_ops);


--
-- Name: datamodel_klantcontact_identificatie_4be256df_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_klantcontact_identificatie_4be256df_like ON public.datamodel_klantcontact USING btree (identificatie varchar_pattern_ops);


--
-- Name: datamodel_klantcontact_zaak_id_d07c3982; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_klantcontact_zaak_id_d07c3982 ON public.datamodel_klantcontact USING btree (zaak_id);


--
-- Name: datamodel_rol_zaak_id_63fbf835; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_rol_zaak_id_63fbf835 ON public.datamodel_rol USING btree (zaak_id);


--
-- Name: datamodel_status_zaak_id_f17d1887; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_status_zaak_id_f17d1887 ON public.datamodel_status USING btree (zaak_id);


--
-- Name: datamodel_zaak_hoofdzaak_id_44040845; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaak_hoofdzaak_id_44040845 ON public.datamodel_zaak USING btree (hoofdzaak_id);


--
-- Name: datamodel_zaak_zaakgeometrie_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaak_zaakgeometrie_id ON public.datamodel_zaak USING gist (zaakgeometrie);


--
-- Name: datamodel_zaak_zaakidentificatie_a620cc10_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaak_zaakidentificatie_a620cc10_like ON public.datamodel_zaak USING btree (identificatie varchar_pattern_ops);


--
-- Name: datamodel_zaakbesluit_zaak_id_524e716f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakbesluit_zaak_id_524e716f ON public.datamodel_zaakbesluit USING btree (zaak_id);


--
-- Name: datamodel_zaakeigenschap_zaak_id_4b0c8bf3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakeigenschap_zaak_id_4b0c8bf3 ON public.datamodel_zaakeigenschap USING btree (zaak_id);


--
-- Name: datamodel_zaakinformatieobject_zaak_id_bbf43c6f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakinformatieobject_zaak_id_bbf43c6f ON public.datamodel_zaakinformatieobject USING btree (zaak_id);


--
-- Name: datamodel_zaakkenmerk_zaak_id_cfd84b8a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakkenmerk_zaak_id_cfd84b8a ON public.datamodel_zaakkenmerk USING btree (zaak_id);


--
-- Name: datamodel_zaakobject_zaak_id_ebe3e4e8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakobject_zaak_id_ebe3e4e8 ON public.datamodel_zaakobject USING btree (zaak_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: notifications_notificationsconfig_api_root_e4030d56_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_notificationsconfig_api_root_e4030d56_like ON public.notifications_notificationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: notifications_subscription_config_id_3567b13c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_subscription_config_id_3567b13c ON public.notifications_subscription USING btree (config_id);


--
-- Name: vng_api_common_apicredential_api_root_cb3905ed_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_apicredential_api_root_cb3905ed_like ON public.vng_api_common_apicredential USING btree (api_root varchar_pattern_ops);


--
-- Name: vng_api_common_jwtsecret_identifier_e89b809e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_jwtsecret_identifier_e89b809e_like ON public.vng_api_common_jwtsecret USING btree (identifier varchar_pattern_ops);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authorizations_autorisatie authorizations_autor_applicatie_id_44348ea1_fk_authoriza; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autor_applicatie_id_44348ea1_fk_authoriza FOREIGN KEY (applicatie_id) REFERENCES public.authorizations_applicatie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_klantcontact datamodel_klantcontact_zaak_id_d07c3982_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_klantcontact
    ADD CONSTRAINT datamodel_klantcontact_zaak_id_d07c3982_fk_datamodel_zaak_id FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_resultaat datamodel_resultaat_zaak_id_fe54ffac_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaat
    ADD CONSTRAINT datamodel_resultaat_zaak_id_fe54ffac_fk_datamodel_zaak_id FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_rol datamodel_rol_zaak_id_63fbf835_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_rol
    ADD CONSTRAINT datamodel_rol_zaak_id_63fbf835_fk_datamodel_zaak_id FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_status datamodel_status_zaak_id_f17d1887_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_status
    ADD CONSTRAINT datamodel_status_zaak_id_f17d1887_fk_datamodel_zaak_id FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaak datamodel_zaak_hoofdzaak_id_44040845_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaak
    ADD CONSTRAINT datamodel_zaak_hoofdzaak_id_44040845_fk_datamodel_zaak_id FOREIGN KEY (hoofdzaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakbesluit datamodel_zaakbesluit_zaak_id_524e716f_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakbesluit
    ADD CONSTRAINT datamodel_zaakbesluit_zaak_id_524e716f_fk_datamodel_zaak_id FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakeigenschap datamodel_zaakeigenschap_zaak_id_4b0c8bf3_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakeigenschap
    ADD CONSTRAINT datamodel_zaakeigenschap_zaak_id_4b0c8bf3_fk_datamodel_zaak_id FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakinformatieobject datamodel_zaakinform_zaak_id_bbf43c6f_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobject
    ADD CONSTRAINT datamodel_zaakinform_zaak_id_bbf43c6f_fk_datamodel FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakkenmerk datamodel_zaakkenmerk_zaak_id_cfd84b8a_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakkenmerk
    ADD CONSTRAINT datamodel_zaakkenmerk_zaak_id_cfd84b8a_fk_datamodel_zaak_id FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakobject datamodel_zaakobject_zaak_id_ebe3e4e8_fk_datamodel_zaak_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobject
    ADD CONSTRAINT datamodel_zaakobject_zaak_id_ebe3e4e8_fk_datamodel_zaak_id FOREIGN KEY (zaak_id) REFERENCES public.datamodel_zaak(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_subscription notifications_subscr_config_id_3567b13c_fk_notificat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscr_config_id_3567b13c_fk_notificat FOREIGN KEY (config_id) REFERENCES public.notifications_notificationsconfig(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ztc; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE ztc WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE ztc OWNER TO postgres;

\connect ztc

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


--
-- Name: admin_index_appgroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_index_appgroup (
    id integer NOT NULL,
    "order" integer NOT NULL,
    name character varying(200) NOT NULL,
    slug character varying(50) NOT NULL,
    CONSTRAINT admin_index_appgroup_order_check CHECK (("order" >= 0))
);


ALTER TABLE public.admin_index_appgroup OWNER TO postgres;

--
-- Name: admin_index_appgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_index_appgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_index_appgroup_id_seq OWNER TO postgres;

--
-- Name: admin_index_appgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_index_appgroup_id_seq OWNED BY public.admin_index_appgroup.id;


--
-- Name: admin_index_appgroup_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_index_appgroup_models (
    id integer NOT NULL,
    appgroup_id integer NOT NULL,
    contenttypeproxy_id integer NOT NULL
);


ALTER TABLE public.admin_index_appgroup_models OWNER TO postgres;

--
-- Name: admin_index_appgroup_models_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_index_appgroup_models_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_index_appgroup_models_id_seq OWNER TO postgres;

--
-- Name: admin_index_appgroup_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_index_appgroup_models_id_seq OWNED BY public.admin_index_appgroup_models.id;


--
-- Name: admin_index_applink; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_index_applink (
    id integer NOT NULL,
    "order" integer NOT NULL,
    name character varying(200) NOT NULL,
    link character varying(200) NOT NULL,
    app_group_id integer NOT NULL,
    CONSTRAINT admin_index_applink_order_check CHECK (("order" >= 0))
);


ALTER TABLE public.admin_index_applink OWNER TO postgres;

--
-- Name: admin_index_applink_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_index_applink_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_index_applink_id_seq OWNER TO postgres;

--
-- Name: admin_index_applink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_index_applink_id_seq OWNED BY public.admin_index_applink.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authorizations_applicatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_applicatie (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    client_ids character varying(50)[] NOT NULL,
    label character varying(100) NOT NULL,
    heeft_alle_autorisaties boolean NOT NULL
);


ALTER TABLE public.authorizations_applicatie OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_applicatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_applicatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_applicatie_id_seq OWNED BY public.authorizations_applicatie.id;


--
-- Name: authorizations_authorizationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_authorizationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    component character varying(50) NOT NULL
);


ALTER TABLE public.authorizations_authorizationsconfig OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_authorizationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_authorizationsconfig_id_seq OWNER TO postgres;

--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_authorizationsconfig_id_seq OWNED BY public.authorizations_authorizationsconfig.id;


--
-- Name: authorizations_autorisatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authorizations_autorisatie (
    id integer NOT NULL,
    component character varying(50) NOT NULL,
    zaaktype character varying(1000) NOT NULL,
    scopes character varying(100)[] NOT NULL,
    max_vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    applicatie_id integer NOT NULL,
    besluittype character varying(1000) NOT NULL,
    informatieobjecttype character varying(1000) NOT NULL
);


ALTER TABLE public.authorizations_autorisatie OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authorizations_autorisatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authorizations_autorisatie_id_seq OWNER TO postgres;

--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authorizations_autorisatie_id_seq OWNED BY public.authorizations_autorisatie.id;


--
-- Name: axes_accessattempt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accessattempt (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    get_data text NOT NULL,
    post_data text NOT NULL,
    failures_since_start integer NOT NULL,
    CONSTRAINT axes_accessattempt_failures_since_start_check CHECK ((failures_since_start >= 0))
);


ALTER TABLE public.axes_accessattempt OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accessattempt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accessattempt_id_seq OWNER TO postgres;

--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accessattempt_id_seq OWNED BY public.axes_accessattempt.id;


--
-- Name: axes_accesslog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.axes_accesslog (
    id integer NOT NULL,
    user_agent character varying(255) NOT NULL,
    ip_address inet,
    username character varying(255),
    trusted boolean NOT NULL,
    http_accept character varying(1025) NOT NULL,
    path_info character varying(255) NOT NULL,
    attempt_time timestamp with time zone NOT NULL,
    logout_time timestamp with time zone
);


ALTER TABLE public.axes_accesslog OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.axes_accesslog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.axes_accesslog_id_seq OWNER TO postgres;

--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.axes_accesslog_id_seq OWNED BY public.axes_accesslog.id;


--
-- Name: datamodel_besluittype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_besluittype (
    id integer NOT NULL,
    omschrijving character varying(80) NOT NULL,
    omschrijving_generiek character varying(80) NOT NULL,
    besluitcategorie character varying(40) NOT NULL,
    publicatie_indicatie boolean NOT NULL,
    publicatietekst text NOT NULL,
    toelichting text NOT NULL,
    catalogus_id integer NOT NULL,
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date,
    publicatietermijn interval,
    reactietermijn interval,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_besluittype OWNER TO postgres;

--
-- Name: datamodel_besluittype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_besluittype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_besluittype_id_seq OWNER TO postgres;

--
-- Name: datamodel_besluittype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_besluittype_id_seq OWNED BY public.datamodel_besluittype.id;


--
-- Name: datamodel_besluittype_informatieobjecttypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_besluittype_informatieobjecttypes (
    id integer NOT NULL,
    besluittype_id integer NOT NULL,
    informatieobjecttype_id integer NOT NULL
);


ALTER TABLE public.datamodel_besluittype_informatieobjecttypes OWNER TO postgres;

--
-- Name: datamodel_besluittype_resultaattypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_besluittype_resultaattypes (
    id integer NOT NULL,
    besluittype_id integer NOT NULL,
    resultaattype_id integer NOT NULL
);


ALTER TABLE public.datamodel_besluittype_resultaattypes OWNER TO postgres;

--
-- Name: datamodel_besluittype_is_resultaat_van_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_besluittype_is_resultaat_van_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_besluittype_is_resultaat_van_id_seq OWNER TO postgres;

--
-- Name: datamodel_besluittype_is_resultaat_van_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_besluittype_is_resultaat_van_id_seq OWNED BY public.datamodel_besluittype_resultaattypes.id;


--
-- Name: datamodel_besluittype_wordt_vastgelegd_in_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_besluittype_wordt_vastgelegd_in_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_besluittype_wordt_vastgelegd_in_id_seq OWNER TO postgres;

--
-- Name: datamodel_besluittype_wordt_vastgelegd_in_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_besluittype_wordt_vastgelegd_in_id_seq OWNED BY public.datamodel_besluittype_informatieobjecttypes.id;


--
-- Name: datamodel_besluittype_zaaktypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_besluittype_zaaktypes (
    id integer NOT NULL,
    besluittype_id integer NOT NULL,
    zaaktype_id integer NOT NULL
);


ALTER TABLE public.datamodel_besluittype_zaaktypes OWNER TO postgres;

--
-- Name: datamodel_besluittype_zaaktypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_besluittype_zaaktypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_besluittype_zaaktypes_id_seq OWNER TO postgres;

--
-- Name: datamodel_besluittype_zaaktypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_besluittype_zaaktypes_id_seq OWNED BY public.datamodel_besluittype_zaaktypes.id;


--
-- Name: datamodel_broncatalogus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_broncatalogus (
    id integer NOT NULL,
    domein character varying(30) NOT NULL,
    rsin character varying(9) NOT NULL
);


ALTER TABLE public.datamodel_broncatalogus OWNER TO postgres;

--
-- Name: datamodel_broncatalogus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_broncatalogus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_broncatalogus_id_seq OWNER TO postgres;

--
-- Name: datamodel_broncatalogus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_broncatalogus_id_seq OWNED BY public.datamodel_broncatalogus.id;


--
-- Name: datamodel_bronzaaktype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_bronzaaktype (
    id integer NOT NULL,
    zaaktype_identificatie integer NOT NULL,
    zaaktype_omschrijving character varying(80) NOT NULL,
    CONSTRAINT datamodel_bronzaaktype_zaaktype_identificatie_check CHECK ((zaaktype_identificatie >= 0))
);


ALTER TABLE public.datamodel_bronzaaktype OWNER TO postgres;

--
-- Name: datamodel_bronzaaktype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_bronzaaktype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_bronzaaktype_id_seq OWNER TO postgres;

--
-- Name: datamodel_bronzaaktype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_bronzaaktype_id_seq OWNED BY public.datamodel_bronzaaktype.id;


--
-- Name: datamodel_catalogus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_catalogus (
    id integer NOT NULL,
    domein character varying(5) NOT NULL,
    rsin character varying(9) NOT NULL,
    contactpersoon_beheer_naam character varying(40) NOT NULL,
    contactpersoon_beheer_telefoonnummer character varying(20) NOT NULL,
    contactpersoon_beheer_emailadres character varying(254) NOT NULL,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_catalogus OWNER TO postgres;

--
-- Name: datamodel_catalogus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_catalogus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_catalogus_id_seq OWNER TO postgres;

--
-- Name: datamodel_catalogus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_catalogus_id_seq OWNED BY public.datamodel_catalogus.id;


--
-- Name: datamodel_checklistitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_checklistitem (
    id integer NOT NULL,
    itemnaam character varying(30) NOT NULL,
    vraagstelling character varying(255) NOT NULL,
    verplicht character varying(1) NOT NULL,
    toelichting character varying(1000)
);


ALTER TABLE public.datamodel_checklistitem OWNER TO postgres;

--
-- Name: datamodel_checklistitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_checklistitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_checklistitem_id_seq OWNER TO postgres;

--
-- Name: datamodel_checklistitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_checklistitem_id_seq OWNED BY public.datamodel_checklistitem.id;


--
-- Name: datamodel_eigenschap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_eigenschap (
    id integer NOT NULL,
    eigenschapnaam character varying(20) NOT NULL,
    definitie character varying(255) NOT NULL,
    toelichting character varying(1000) NOT NULL,
    is_van_id integer NOT NULL,
    referentie_naar_eigenschap_id integer,
    specificatie_van_eigenschap_id integer,
    status_type_id integer,
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_eigenschap OWNER TO postgres;

--
-- Name: datamodel_eigenschap_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_eigenschap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_eigenschap_id_seq OWNER TO postgres;

--
-- Name: datamodel_eigenschap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_eigenschap_id_seq OWNED BY public.datamodel_eigenschap.id;


--
-- Name: datamodel_eigenschapreferentie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_eigenschapreferentie (
    id integer NOT NULL,
    objecttype character varying(40),
    informatiemodel character varying(80),
    namespace character varying(200) NOT NULL,
    schemalocatie character varying(200) NOT NULL,
    x_path_element character varying(255),
    entiteittype character varying(80) NOT NULL
);


ALTER TABLE public.datamodel_eigenschapreferentie OWNER TO postgres;

--
-- Name: datamodel_eigenschapreferentie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_eigenschapreferentie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_eigenschapreferentie_id_seq OWNER TO postgres;

--
-- Name: datamodel_eigenschapreferentie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_eigenschapreferentie_id_seq OWNED BY public.datamodel_eigenschapreferentie.id;


--
-- Name: datamodel_eigenschapspecificatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_eigenschapspecificatie (
    id integer NOT NULL,
    groep character varying(32) NOT NULL,
    formaat character varying(20) NOT NULL,
    lengte character varying(14) NOT NULL,
    kardinaliteit character varying(3) NOT NULL,
    waardenverzameling character varying(100)[] NOT NULL
);


ALTER TABLE public.datamodel_eigenschapspecificatie OWNER TO postgres;

--
-- Name: datamodel_eigenschapspecificatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_eigenschapspecificatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_eigenschapspecificatie_id_seq OWNER TO postgres;

--
-- Name: datamodel_eigenschapspecificatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_eigenschapspecificatie_id_seq OWNED BY public.datamodel_eigenschapspecificatie.id;


--
-- Name: datamodel_formulier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_formulier (
    id integer NOT NULL,
    naam character varying(80) NOT NULL,
    link character varying(200)
);


ALTER TABLE public.datamodel_formulier OWNER TO postgres;

--
-- Name: datamodel_formulier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_formulier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_formulier_id_seq OWNER TO postgres;

--
-- Name: datamodel_formulier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_formulier_id_seq OWNED BY public.datamodel_formulier.id;


--
-- Name: datamodel_informatieobjecttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_informatieobjecttype (
    id integer NOT NULL,
    omschrijving character varying(80) NOT NULL,
    informatieobjectcategorie character varying(80) NOT NULL,
    trefwoord character varying(30)[] NOT NULL,
    vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    model character varying(200)[] NOT NULL,
    toelichting character varying(1000),
    omschrijving_generiek_id integer,
    catalogus_id integer NOT NULL,
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_informatieobjecttype OWNER TO postgres;

--
-- Name: datamodel_informatieobjecttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_informatieobjecttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_informatieobjecttype_id_seq OWNER TO postgres;

--
-- Name: datamodel_informatieobjecttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_informatieobjecttype_id_seq OWNED BY public.datamodel_informatieobjecttype.id;


--
-- Name: datamodel_informatieobjecttypeomschrijvinggeneriek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_informatieobjecttypeomschrijvinggeneriek (
    id integer NOT NULL,
    informatieobjecttype_omschrijving_generiek character varying(80) NOT NULL,
    definitie_informatieobjecttype_omschrijving_generiek character varying(255) NOT NULL,
    herkomst_informatieobjecttype_omschrijving_generiek character varying(12) NOT NULL,
    hierarchie_informatieobjecttype_omschrijving_generiek character varying(80) NOT NULL,
    opmerking_informatieobjecttype_omschrijving_generiek character varying(255),
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date
);


ALTER TABLE public.datamodel_informatieobjecttypeomschrijvinggeneriek OWNER TO postgres;

--
-- Name: datamodel_informatieobjecttypeomschrijvinggeneriek_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_informatieobjecttypeomschrijvinggeneriek_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_informatieobjecttypeomschrijvinggeneriek_id_seq OWNER TO postgres;

--
-- Name: datamodel_informatieobjecttypeomschrijvinggeneriek_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_informatieobjecttypeomschrijvinggeneriek_id_seq OWNED BY public.datamodel_informatieobjecttypeomschrijvinggeneriek.id;


--
-- Name: datamodel_mogelijkebetrokkene; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_mogelijkebetrokkene (
    id integer NOT NULL,
    betrokkene character varying(200) NOT NULL,
    betrokkene_type character varying(100) NOT NULL,
    roltype_id integer NOT NULL,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_mogelijkebetrokkene OWNER TO postgres;

--
-- Name: datamodel_mogelijkebetrokkene_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_mogelijkebetrokkene_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_mogelijkebetrokkene_id_seq OWNER TO postgres;

--
-- Name: datamodel_mogelijkebetrokkene_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_mogelijkebetrokkene_id_seq OWNED BY public.datamodel_mogelijkebetrokkene.id;


--
-- Name: datamodel_resultaattype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_resultaattype (
    id integer NOT NULL,
    omschrijving character varying(20) NOT NULL,
    selectielijstklasse character varying(1000) NOT NULL,
    toelichting text NOT NULL,
    heeft_voor_brondatum_archiefprocedure_relevante_id integer,
    zaaktype_id integer NOT NULL,
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date,
    resultaattypeomschrijving character varying(1000) NOT NULL,
    uuid uuid NOT NULL,
    archiefactietermijn interval,
    archiefnominatie character varying(20) NOT NULL,
    brondatum_archiefprocedure_afleidingswijze character varying(20) NOT NULL,
    brondatum_archiefprocedure_datumkenmerk character varying(80) NOT NULL,
    brondatum_archiefprocedure_einddatum_bekend boolean NOT NULL,
    brondatum_archiefprocedure_objecttype character varying(80) NOT NULL,
    brondatum_archiefprocedure_registratie character varying(80) NOT NULL,
    brondatum_archiefprocedure_procestermijn interval,
    omschrijving_generiek character varying(20) NOT NULL
);


ALTER TABLE public.datamodel_resultaattype OWNER TO postgres;

--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_resultaattype_heeft_verplichte_ziot (
    id integer NOT NULL,
    resultaattype_id integer NOT NULL,
    zaakinformatieobjecttype_id integer NOT NULL
);


ALTER TABLE public.datamodel_resultaattype_heeft_verplichte_ziot OWNER TO postgres;

--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_resultaattype_heeft_verplichte_ziot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_resultaattype_heeft_verplichte_ziot_id_seq OWNER TO postgres;

--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_resultaattype_heeft_verplichte_ziot_id_seq OWNED BY public.datamodel_resultaattype_heeft_verplichte_ziot.id;


--
-- Name: datamodel_resultaattype_heeft_verplichte_zot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_resultaattype_heeft_verplichte_zot (
    id integer NOT NULL,
    resultaattype_id integer NOT NULL,
    zaakobjecttype_id integer NOT NULL
);


ALTER TABLE public.datamodel_resultaattype_heeft_verplichte_zot OWNER TO postgres;

--
-- Name: datamodel_resultaattype_heeft_verplichte_zot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_resultaattype_heeft_verplichte_zot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_resultaattype_heeft_verplichte_zot_id_seq OWNER TO postgres;

--
-- Name: datamodel_resultaattype_heeft_verplichte_zot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_resultaattype_heeft_verplichte_zot_id_seq OWNED BY public.datamodel_resultaattype_heeft_verplichte_zot.id;


--
-- Name: datamodel_resultaattype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_resultaattype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_resultaattype_id_seq OWNER TO postgres;

--
-- Name: datamodel_resultaattype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_resultaattype_id_seq OWNED BY public.datamodel_resultaattype.id;


--
-- Name: datamodel_roltype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_roltype (
    id integer NOT NULL,
    omschrijving character varying(20) NOT NULL,
    omschrijving_generiek character varying(20) NOT NULL,
    soort_betrokkene character varying(80)[] NOT NULL,
    zaaktype_id integer NOT NULL,
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date,
    uuid uuid NOT NULL
);


ALTER TABLE public.datamodel_roltype OWNER TO postgres;

--
-- Name: datamodel_roltype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_roltype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_roltype_id_seq OWNER TO postgres;

--
-- Name: datamodel_roltype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_roltype_id_seq OWNED BY public.datamodel_roltype.id;


--
-- Name: datamodel_statustype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_statustype (
    id integer NOT NULL,
    statustype_omschrijving character varying(80) NOT NULL,
    statustype_omschrijving_generiek character varying(80) NOT NULL,
    statustypevolgnummer smallint NOT NULL,
    doorlooptijd_status smallint,
    informeren character varying(1) NOT NULL,
    statustekst character varying(1000) NOT NULL,
    toelichting character varying(1000),
    zaaktype_id integer NOT NULL,
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date,
    uuid uuid NOT NULL,
    CONSTRAINT datamodel_statustype_doorlooptijd_status_check CHECK ((doorlooptijd_status >= 0)),
    CONSTRAINT datamodel_statustype_statustypevolgnummer_check CHECK ((statustypevolgnummer >= 0))
);


ALTER TABLE public.datamodel_statustype OWNER TO postgres;

--
-- Name: datamodel_statustype_checklistitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_statustype_checklistitem (
    id integer NOT NULL,
    statustype_id integer NOT NULL,
    checklistitem_id integer NOT NULL
);


ALTER TABLE public.datamodel_statustype_checklistitem OWNER TO postgres;

--
-- Name: datamodel_statustype_checklistitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_statustype_checklistitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_statustype_checklistitem_id_seq OWNER TO postgres;

--
-- Name: datamodel_statustype_checklistitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_statustype_checklistitem_id_seq OWNED BY public.datamodel_statustype_checklistitem.id;


--
-- Name: datamodel_statustype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_statustype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_statustype_id_seq OWNER TO postgres;

--
-- Name: datamodel_statustype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_statustype_id_seq OWNED BY public.datamodel_statustype.id;


--
-- Name: datamodel_statustype_roltypen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_statustype_roltypen (
    id integer NOT NULL,
    statustype_id integer NOT NULL,
    roltype_id integer NOT NULL
);


ALTER TABLE public.datamodel_statustype_roltypen OWNER TO postgres;

--
-- Name: datamodel_statustype_roltypen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_statustype_roltypen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_statustype_roltypen_id_seq OWNER TO postgres;

--
-- Name: datamodel_statustype_roltypen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_statustype_roltypen_id_seq OWNED BY public.datamodel_statustype_roltypen.id;


--
-- Name: datamodel_zaakinformatieobjecttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaakinformatieobjecttype (
    id integer NOT NULL,
    volgnummer smallint NOT NULL,
    richting character varying(20) NOT NULL,
    informatie_object_type_id integer NOT NULL,
    status_type_id integer,
    zaaktype_id integer NOT NULL,
    uuid uuid NOT NULL,
    CONSTRAINT datamodel_zaakinformatieobjecttype_volgnummer_e9130f66_check CHECK ((volgnummer >= 0))
);


ALTER TABLE public.datamodel_zaakinformatieobjecttype OWNER TO postgres;

--
-- Name: datamodel_zaakinformatieobjecttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakinformatieobjecttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakinformatieobjecttype_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakinformatieobjecttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakinformatieobjecttype_id_seq OWNED BY public.datamodel_zaakinformatieobjecttype.id;


--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaakinformatieobjecttypearchiefregime (
    id integer NOT NULL,
    selectielijstklasse character varying(500),
    archiefnominatie character varying(16) NOT NULL,
    archiefactietermijn smallint NOT NULL,
    resultaattype_id integer NOT NULL,
    zaak_informatieobject_type_id integer NOT NULL,
    CONSTRAINT datamodel_zaakinformatieobjecttypearc_archiefactietermijn_check CHECK ((archiefactietermijn >= 0))
);


ALTER TABLE public.datamodel_zaakinformatieobjecttypearchiefregime OWNER TO postgres;

--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakinformatieobjecttypearchiefregime_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakinformatieobjecttypearchiefregime_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakinformatieobjecttypearchiefregime_id_seq OWNED BY public.datamodel_zaakinformatieobjecttypearchiefregime.id;


--
-- Name: datamodel_zaakobjecttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaakobjecttype (
    id integer NOT NULL,
    objecttype character varying(50) NOT NULL,
    ander_objecttype character varying(1) NOT NULL,
    relatieomschrijving character varying(80) NOT NULL,
    is_relevant_voor_id integer NOT NULL,
    status_type_id integer,
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date
);


ALTER TABLE public.datamodel_zaakobjecttype OWNER TO postgres;

--
-- Name: datamodel_zaakobjecttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaakobjecttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaakobjecttype_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaakobjecttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaakobjecttype_id_seq OWNED BY public.datamodel_zaakobjecttype.id;


--
-- Name: datamodel_zaaktype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaaktype (
    id integer NOT NULL,
    zaaktype_identificatie integer NOT NULL,
    zaaktype_omschrijving character varying(80) NOT NULL,
    zaaktype_omschrijving_generiek character varying(80) NOT NULL,
    zaakcategorie character varying(40) NOT NULL,
    doel text NOT NULL,
    aanleiding text NOT NULL,
    toelichting text NOT NULL,
    indicatie_intern_of_extern character varying(6) NOT NULL,
    handeling_initiator character varying(20) NOT NULL,
    onderwerp character varying(80) NOT NULL,
    handeling_behandelaar character varying(20) NOT NULL,
    opschorting_en_aanhouding_mogelijk boolean NOT NULL,
    verlenging_mogelijk boolean NOT NULL,
    trefwoorden character varying(30)[] NOT NULL,
    archiefclassificatiecode character varying(20),
    vertrouwelijkheidaanduiding character varying(20) NOT NULL,
    verantwoordelijke character varying(50) NOT NULL,
    publicatie_indicatie boolean NOT NULL,
    publicatietekst text NOT NULL,
    verantwoordingsrelatie character varying(40)[] NOT NULL,
    broncatalogus_id integer,
    bronzaaktype_id integer,
    catalogus_id integer NOT NULL,
    datum_begin_geldigheid date NOT NULL,
    datum_einde_geldigheid date,
    versiedatum date NOT NULL,
    uuid uuid NOT NULL,
    doorlooptijd_behandeling interval NOT NULL,
    servicenorm_behandeling interval,
    verlengingstermijn interval,
    referentieproces_link character varying(200) NOT NULL,
    referentieproces_naam character varying(80) NOT NULL,
    producten_of_diensten character varying(1000)[] NOT NULL,
    selectielijst_procestype character varying(200) NOT NULL,
    CONSTRAINT datamodel_zaaktype_zaaktype_identificatie_check CHECK ((zaaktype_identificatie >= 0))
);


ALTER TABLE public.datamodel_zaaktype OWNER TO postgres;

--
-- Name: datamodel_zaaktype_formulier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaaktype_formulier (
    id integer NOT NULL,
    zaaktype_id integer NOT NULL,
    formulier_id integer NOT NULL
);


ALTER TABLE public.datamodel_zaaktype_formulier OWNER TO postgres;

--
-- Name: datamodel_zaaktype_formulier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaaktype_formulier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaaktype_formulier_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaaktype_formulier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaaktype_formulier_id_seq OWNED BY public.datamodel_zaaktype_formulier.id;


--
-- Name: datamodel_zaaktype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaaktype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaaktype_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaaktype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaaktype_id_seq OWNED BY public.datamodel_zaaktype.id;


--
-- Name: datamodel_zaaktype_is_deelzaaktype_van; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaaktype_is_deelzaaktype_van (
    id integer NOT NULL,
    from_zaaktype_id integer NOT NULL,
    to_zaaktype_id integer NOT NULL
);


ALTER TABLE public.datamodel_zaaktype_is_deelzaaktype_van OWNER TO postgres;

--
-- Name: datamodel_zaaktype_is_deelzaaktype_van_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaaktype_is_deelzaaktype_van_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaaktype_is_deelzaaktype_van_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaaktype_is_deelzaaktype_van_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaaktype_is_deelzaaktype_van_id_seq OWNED BY public.datamodel_zaaktype_is_deelzaaktype_van.id;


--
-- Name: datamodel_zaaktypenrelatie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datamodel_zaaktypenrelatie (
    id integer NOT NULL,
    aard_relatie character varying(15) NOT NULL,
    toelichting character varying(255) NOT NULL,
    zaaktype_id integer NOT NULL,
    gerelateerd_zaaktype character varying(200) NOT NULL
);


ALTER TABLE public.datamodel_zaaktypenrelatie OWNER TO postgres;

--
-- Name: datamodel_zaaktypenrelatie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.datamodel_zaaktypenrelatie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datamodel_zaaktypenrelatie_id_seq OWNER TO postgres;

--
-- Name: datamodel_zaaktypenrelatie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.datamodel_zaaktypenrelatie_id_seq OWNED BY public.datamodel_zaaktypenrelatie.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: notifications_notificationsconfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_notificationsconfig (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL
);


ALTER TABLE public.notifications_notificationsconfig OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notificationsconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_notificationsconfig_id_seq OWNER TO postgres;

--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notificationsconfig_id_seq OWNED BY public.notifications_notificationsconfig.id;


--
-- Name: notifications_subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications_subscription (
    id integer NOT NULL,
    callback_url character varying(200) NOT NULL,
    client_id character varying(50) NOT NULL,
    secret character varying(50) NOT NULL,
    channels character varying(100)[] NOT NULL,
    config_id integer NOT NULL,
    _subscription character varying(200) NOT NULL
);


ALTER TABLE public.notifications_subscription OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_subscription_id_seq OWNER TO postgres;

--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_subscription_id_seq OWNED BY public.notifications_subscription.id;


--
-- Name: vng_api_common_apicredential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_apicredential (
    id integer NOT NULL,
    api_root character varying(200) NOT NULL,
    client_id character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    label character varying(100) NOT NULL,
    user_id character varying(255) NOT NULL,
    user_representation character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_apicredential OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_apicredential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_apicredential_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_apicredential_id_seq OWNED BY public.vng_api_common_apicredential.id;


--
-- Name: vng_api_common_jwtsecret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vng_api_common_jwtsecret (
    id integer NOT NULL,
    identifier character varying(50) NOT NULL,
    secret character varying(255) NOT NULL
);


ALTER TABLE public.vng_api_common_jwtsecret OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vng_api_common_jwtsecret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vng_api_common_jwtsecret_id_seq OWNER TO postgres;

--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vng_api_common_jwtsecret_id_seq OWNED BY public.vng_api_common_jwtsecret.id;


--
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


--
-- Name: admin_index_appgroup id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_appgroup ALTER COLUMN id SET DEFAULT nextval('public.admin_index_appgroup_id_seq'::regclass);


--
-- Name: admin_index_appgroup_models id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_appgroup_models ALTER COLUMN id SET DEFAULT nextval('public.admin_index_appgroup_models_id_seq'::regclass);


--
-- Name: admin_index_applink id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_applink ALTER COLUMN id SET DEFAULT nextval('public.admin_index_applink_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: authorizations_applicatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_applicatie_id_seq'::regclass);


--
-- Name: authorizations_authorizationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig ALTER COLUMN id SET DEFAULT nextval('public.authorizations_authorizationsconfig_id_seq'::regclass);


--
-- Name: authorizations_autorisatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie ALTER COLUMN id SET DEFAULT nextval('public.authorizations_autorisatie_id_seq'::regclass);


--
-- Name: axes_accessattempt id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt ALTER COLUMN id SET DEFAULT nextval('public.axes_accessattempt_id_seq'::regclass);


--
-- Name: axes_accesslog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog ALTER COLUMN id SET DEFAULT nextval('public.axes_accesslog_id_seq'::regclass);


--
-- Name: datamodel_besluittype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_besluittype_id_seq'::regclass);


--
-- Name: datamodel_besluittype_informatieobjecttypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_informatieobjecttypes ALTER COLUMN id SET DEFAULT nextval('public.datamodel_besluittype_wordt_vastgelegd_in_id_seq'::regclass);


--
-- Name: datamodel_besluittype_resultaattypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_resultaattypes ALTER COLUMN id SET DEFAULT nextval('public.datamodel_besluittype_is_resultaat_van_id_seq'::regclass);


--
-- Name: datamodel_besluittype_zaaktypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_zaaktypes ALTER COLUMN id SET DEFAULT nextval('public.datamodel_besluittype_zaaktypes_id_seq'::regclass);


--
-- Name: datamodel_broncatalogus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_broncatalogus ALTER COLUMN id SET DEFAULT nextval('public.datamodel_broncatalogus_id_seq'::regclass);


--
-- Name: datamodel_bronzaaktype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_bronzaaktype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_bronzaaktype_id_seq'::regclass);


--
-- Name: datamodel_catalogus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_catalogus ALTER COLUMN id SET DEFAULT nextval('public.datamodel_catalogus_id_seq'::regclass);


--
-- Name: datamodel_checklistitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_checklistitem ALTER COLUMN id SET DEFAULT nextval('public.datamodel_checklistitem_id_seq'::regclass);


--
-- Name: datamodel_eigenschap id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschap ALTER COLUMN id SET DEFAULT nextval('public.datamodel_eigenschap_id_seq'::regclass);


--
-- Name: datamodel_eigenschapreferentie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschapreferentie ALTER COLUMN id SET DEFAULT nextval('public.datamodel_eigenschapreferentie_id_seq'::regclass);


--
-- Name: datamodel_eigenschapspecificatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschapspecificatie ALTER COLUMN id SET DEFAULT nextval('public.datamodel_eigenschapspecificatie_id_seq'::regclass);


--
-- Name: datamodel_formulier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_formulier ALTER COLUMN id SET DEFAULT nextval('public.datamodel_formulier_id_seq'::regclass);


--
-- Name: datamodel_informatieobjecttype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_informatieobjecttype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_informatieobjecttype_id_seq'::regclass);


--
-- Name: datamodel_informatieobjecttypeomschrijvinggeneriek id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_informatieobjecttypeomschrijvinggeneriek ALTER COLUMN id SET DEFAULT nextval('public.datamodel_informatieobjecttypeomschrijvinggeneriek_id_seq'::regclass);


--
-- Name: datamodel_mogelijkebetrokkene id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_mogelijkebetrokkene ALTER COLUMN id SET DEFAULT nextval('public.datamodel_mogelijkebetrokkene_id_seq'::regclass);


--
-- Name: datamodel_resultaattype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_resultaattype_id_seq'::regclass);


--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_ziot ALTER COLUMN id SET DEFAULT nextval('public.datamodel_resultaattype_heeft_verplichte_ziot_id_seq'::regclass);


--
-- Name: datamodel_resultaattype_heeft_verplichte_zot id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_zot ALTER COLUMN id SET DEFAULT nextval('public.datamodel_resultaattype_heeft_verplichte_zot_id_seq'::regclass);


--
-- Name: datamodel_roltype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_roltype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_roltype_id_seq'::regclass);


--
-- Name: datamodel_statustype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_statustype_id_seq'::regclass);


--
-- Name: datamodel_statustype_checklistitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_checklistitem ALTER COLUMN id SET DEFAULT nextval('public.datamodel_statustype_checklistitem_id_seq'::regclass);


--
-- Name: datamodel_statustype_roltypen id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_roltypen ALTER COLUMN id SET DEFAULT nextval('public.datamodel_statustype_roltypen_id_seq'::regclass);


--
-- Name: datamodel_zaakinformatieobjecttype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakinformatieobjecttype_id_seq'::regclass);


--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttypearchiefregime ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakinformatieobjecttypearchiefregime_id_seq'::regclass);


--
-- Name: datamodel_zaakobjecttype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobjecttype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaakobjecttype_id_seq'::regclass);


--
-- Name: datamodel_zaaktype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaaktype_id_seq'::regclass);


--
-- Name: datamodel_zaaktype_formulier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_formulier ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaaktype_formulier_id_seq'::regclass);


--
-- Name: datamodel_zaaktype_is_deelzaaktype_van id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_is_deelzaaktype_van ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaaktype_is_deelzaaktype_van_id_seq'::regclass);


--
-- Name: datamodel_zaaktypenrelatie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktypenrelatie ALTER COLUMN id SET DEFAULT nextval('public.datamodel_zaaktypenrelatie_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: notifications_notificationsconfig id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig ALTER COLUMN id SET DEFAULT nextval('public.notifications_notificationsconfig_id_seq'::regclass);


--
-- Name: notifications_subscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription ALTER COLUMN id SET DEFAULT nextval('public.notifications_subscription_id_seq'::regclass);


--
-- Name: vng_api_common_apicredential id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_apicredential_id_seq'::regclass);


--
-- Name: vng_api_common_jwtsecret id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret ALTER COLUMN id SET DEFAULT nextval('public.vng_api_common_jwtsecret_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$100000$HA36LCR3y9v1$TvDuzwlOBp/amUibyad58zkW0bh6fRNMY6QZ3n5D2pI=	2019-06-13 10:31:59.973445+00	t	admin				t	t	2019-06-07 13:51:13.876541+00
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: admin_index_appgroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_index_appgroup (id, "order", name, slug) FROM stdin;
\.


--
-- Data for Name: admin_index_appgroup_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_index_appgroup_models (id, appgroup_id, contenttypeproxy_id) FROM stdin;
\.


--
-- Data for Name: admin_index_applink; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_index_applink (id, "order", name, link, app_group_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add content type	1	add_contenttype
2	Can change content type	1	change_contenttype
3	Can delete content type	1	delete_contenttype
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add session	4	add_session
11	Can change session	4	change_session
12	Can delete session	4	delete_session
13	Can add site	5	add_site
14	Can change site	5	change_site
15	Can delete site	5	delete_site
16	Can add application group	6	add_appgroup
17	Can change application group	6	change_appgroup
18	Can delete application group	6	delete_appgroup
19	Can add application link	7	add_applink
20	Can change application link	7	change_applink
21	Can delete application link	7	delete_applink
22	Can add content type proxy	1	add_contenttypeproxy
23	Can change content type proxy	1	change_contenttypeproxy
24	Can delete content type proxy	1	delete_contenttypeproxy
25	Can add log entry	9	add_logentry
26	Can change log entry	9	change_logentry
27	Can delete log entry	9	delete_logentry
28	Can add access attempt	10	add_accessattempt
29	Can change access attempt	10	change_accessattempt
30	Can delete access attempt	10	delete_accessattempt
31	Can add access log	11	add_accesslog
32	Can change access log	11	change_accesslog
33	Can delete access log	11	delete_accesslog
34	Can add cors model	12	add_corsmodel
35	Can change cors model	12	change_corsmodel
36	Can delete cors model	12	delete_corsmodel
37	Can add client credential	13	add_jwtsecret
38	Can change client credential	13	change_jwtsecret
39	Can delete client credential	13	delete_jwtsecret
40	Can add external API credential	14	add_apicredential
41	Can change external API credential	14	change_apicredential
42	Can delete external API credential	14	delete_apicredential
43	Can add applicatie	15	add_applicatie
44	Can change applicatie	15	change_applicatie
45	Can delete applicatie	15	delete_applicatie
46	Can add autorisatie	16	add_autorisatie
47	Can change autorisatie	16	change_autorisatie
48	Can delete autorisatie	16	delete_autorisatie
49	Can add Autorisatiecomponentconfiguratie	17	add_authorizationsconfig
50	Can change Autorisatiecomponentconfiguratie	17	change_authorizationsconfig
51	Can delete Autorisatiecomponentconfiguratie	17	delete_authorizationsconfig
52	Can add Notificatiescomponentconfiguratie	18	add_notificationsconfig
53	Can change Notificatiescomponentconfiguratie	18	change_notificationsconfig
54	Can delete Notificatiescomponentconfiguratie	18	delete_notificationsconfig
55	Can add Webhook subscription	19	add_subscription
56	Can change Webhook subscription	19	change_subscription
57	Can delete Webhook subscription	19	delete_subscription
58	Can add user	20	add_user
59	Can change user	20	change_user
60	Can delete user	20	delete_user
61	Can add besluittype	21	add_besluittype
62	Can change besluittype	21	change_besluittype
63	Can delete besluittype	21	delete_besluittype
64	Can add Bron catalogus	22	add_broncatalogus
65	Can change Bron catalogus	22	change_broncatalogus
66	Can delete Bron catalogus	22	delete_broncatalogus
67	Can add Bron zaaktype	23	add_bronzaaktype
68	Can change Bron zaaktype	23	change_bronzaaktype
69	Can delete Bron zaaktype	23	delete_bronzaaktype
70	Can add catalogus	24	add_catalogus
71	Can change catalogus	24	change_catalogus
72	Can delete catalogus	24	delete_catalogus
73	Can add check list item	25	add_checklistitem
74	Can change check list item	25	change_checklistitem
75	Can delete check list item	25	delete_checklistitem
76	Can add Eigenschap	26	add_eigenschap
77	Can change Eigenschap	26	change_eigenschap
78	Can delete Eigenschap	26	delete_eigenschap
79	Can add Eigenschap referentie	27	add_eigenschapreferentie
80	Can change Eigenschap referentie	27	change_eigenschapreferentie
81	Can delete Eigenschap referentie	27	delete_eigenschapreferentie
82	Can add Eigenschap specificatie	28	add_eigenschapspecificatie
83	Can change Eigenschap specificatie	28	change_eigenschapspecificatie
84	Can delete Eigenschap specificatie	28	delete_eigenschapspecificatie
85	Can add Formulier	29	add_formulier
86	Can change Formulier	29	change_formulier
87	Can delete Formulier	29	delete_formulier
88	Can add Informatieobjecttype	30	add_informatieobjecttype
89	Can change Informatieobjecttype	30	change_informatieobjecttype
90	Can delete Informatieobjecttype	30	delete_informatieobjecttype
91	Can add Generieke informatieobjecttype-omschrijving	31	add_informatieobjecttypeomschrijvinggeneriek
92	Can change Generieke informatieobjecttype-omschrijving	31	change_informatieobjecttypeomschrijvinggeneriek
93	Can delete Generieke informatieobjecttype-omschrijving	31	delete_informatieobjecttypeomschrijvinggeneriek
94	Can add resultaattype	32	add_resultaattype
95	Can change resultaattype	32	change_resultaattype
96	Can delete resultaattype	32	delete_resultaattype
97	Can add Roltype	33	add_roltype
98	Can change Roltype	33	change_roltype
99	Can delete Roltype	33	delete_roltype
100	Can add Statustype	34	add_statustype
101	Can change Statustype	34	change_statustype
102	Can delete Statustype	34	delete_statustype
103	Can add Zaak-Informatieobject-Type	35	add_zaakinformatieobjecttype
104	Can change Zaak-Informatieobject-Type	35	change_zaakinformatieobjecttype
105	Can delete Zaak-Informatieobject-Type	35	delete_zaakinformatieobjecttype
106	Can add Zaak-Informatieobject-Type Archiefregime	36	add_zaakinformatieobjecttypearchiefregime
107	Can change Zaak-Informatieobject-Type Archiefregime	36	change_zaakinformatieobjecttypearchiefregime
108	Can delete Zaak-Informatieobject-Type Archiefregime	36	delete_zaakinformatieobjecttypearchiefregime
109	Can add Zaakobjecttype	37	add_zaakobjecttype
110	Can change Zaakobjecttype	37	change_zaakobjecttype
111	Can delete Zaakobjecttype	37	delete_zaakobjecttype
112	Can add Zaaktype	38	add_zaaktype
113	Can change Zaaktype	38	change_zaaktype
114	Can delete Zaaktype	38	delete_zaaktype
115	Can add Zaaktypenrelatie	39	add_zaaktypenrelatie
116	Can change Zaaktypenrelatie	39	change_zaaktypenrelatie
117	Can delete Zaaktypenrelatie	39	delete_zaaktypenrelatie
118	Can add mogelijke betrokkene	40	add_mogelijkebetrokkene
119	Can change mogelijke betrokkene	40	change_mogelijkebetrokkene
120	Can delete mogelijke betrokkene	40	delete_mogelijkebetrokkene
\.


--
-- Data for Name: authorizations_applicatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_applicatie (id, uuid, client_ids, label, heeft_alle_autorisaties) FROM stdin;
1	b7622797-5f85-40e3-8abd-8f3ff476cf70	{demo}	ac	t
2	5d83fd8e-395c-4232-9afa-754bd4822ef3	{demo}	nrc	t
3	533fe769-b1f1-49ff-b9fb-5bd01cfe868b	{demo}	zrc	t
\.


--
-- Data for Name: authorizations_authorizationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_authorizationsconfig (id, api_root, component) FROM stdin;
1	http://BASE_IP:8005/api/v1/	ZTC
\.


--
-- Data for Name: authorizations_autorisatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authorizations_autorisatie (id, component, zaaktype, scopes, max_vertrouwelijkheidaanduiding, applicatie_id, besluittype, informatieobjecttype) FROM stdin;
\.


--
-- Data for Name: axes_accessattempt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accessattempt (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, get_data, post_data, failures_since_start) FROM stdin;
1	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.20.1.1	admin	f	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:31:46.27527+00	next=/admin/	csrfmiddlewaretoken=AVfUpaKR6DSQSAsy8cWWn5VfHWfKROGw6fg7bEP6MHqizVt9hUiP2aeMbAYNMjnk\nusername=admin\nnext=/admin/	1
2	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.14	admin	f	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:31:52.07288+00	next=/admin/	csrfmiddlewaretoken=LgrBiL7QrY87YFxxCF81prAyBmmy1RlghAsO4fc572GzF0y8LnuU4wT5505BWm24\nusername=admin\nnext=/admin/	1
\.


--
-- Data for Name: axes_accesslog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.axes_accesslog (id, user_agent, ip_address, username, trusted, http_accept, path_info, attempt_time, logout_time) FROM stdin;
2	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0	10.164.0.12	admin	t	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8	/admin/login/	2019-06-13 10:31:59.976462+00	\N
\.


--
-- Data for Name: datamodel_besluittype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_besluittype (id, omschrijving, omschrijving_generiek, besluitcategorie, publicatie_indicatie, publicatietekst, toelichting, catalogus_id, datum_begin_geldigheid, datum_einde_geldigheid, publicatietermijn, reactietermijn, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_besluittype_informatieobjecttypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_besluittype_informatieobjecttypes (id, besluittype_id, informatieobjecttype_id) FROM stdin;
\.


--
-- Data for Name: datamodel_besluittype_resultaattypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_besluittype_resultaattypes (id, besluittype_id, resultaattype_id) FROM stdin;
\.


--
-- Data for Name: datamodel_besluittype_zaaktypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_besluittype_zaaktypes (id, besluittype_id, zaaktype_id) FROM stdin;
\.


--
-- Data for Name: datamodel_broncatalogus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_broncatalogus (id, domein, rsin) FROM stdin;
\.


--
-- Data for Name: datamodel_bronzaaktype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_bronzaaktype (id, zaaktype_identificatie, zaaktype_omschrijving) FROM stdin;
\.


--
-- Data for Name: datamodel_catalogus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_catalogus (id, domein, rsin, contactpersoon_beheer_naam, contactpersoon_beheer_telefoonnummer, contactpersoon_beheer_emailadres, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_checklistitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_checklistitem (id, itemnaam, vraagstelling, verplicht, toelichting) FROM stdin;
\.


--
-- Data for Name: datamodel_eigenschap; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_eigenschap (id, eigenschapnaam, definitie, toelichting, is_van_id, referentie_naar_eigenschap_id, specificatie_van_eigenschap_id, status_type_id, datum_begin_geldigheid, datum_einde_geldigheid, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_eigenschapreferentie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_eigenschapreferentie (id, objecttype, informatiemodel, namespace, schemalocatie, x_path_element, entiteittype) FROM stdin;
\.


--
-- Data for Name: datamodel_eigenschapspecificatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_eigenschapspecificatie (id, groep, formaat, lengte, kardinaliteit, waardenverzameling) FROM stdin;
\.


--
-- Data for Name: datamodel_formulier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_formulier (id, naam, link) FROM stdin;
\.


--
-- Data for Name: datamodel_informatieobjecttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_informatieobjecttype (id, omschrijving, informatieobjectcategorie, trefwoord, vertrouwelijkheidaanduiding, model, toelichting, omschrijving_generiek_id, catalogus_id, datum_begin_geldigheid, datum_einde_geldigheid, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_informatieobjecttypeomschrijvinggeneriek; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_informatieobjecttypeomschrijvinggeneriek (id, informatieobjecttype_omschrijving_generiek, definitie_informatieobjecttype_omschrijving_generiek, herkomst_informatieobjecttype_omschrijving_generiek, hierarchie_informatieobjecttype_omschrijving_generiek, opmerking_informatieobjecttype_omschrijving_generiek, datum_begin_geldigheid, datum_einde_geldigheid) FROM stdin;
\.


--
-- Data for Name: datamodel_mogelijkebetrokkene; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_mogelijkebetrokkene (id, betrokkene, betrokkene_type, roltype_id, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_resultaattype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_resultaattype (id, omschrijving, selectielijstklasse, toelichting, heeft_voor_brondatum_archiefprocedure_relevante_id, zaaktype_id, datum_begin_geldigheid, datum_einde_geldigheid, resultaattypeomschrijving, uuid, archiefactietermijn, archiefnominatie, brondatum_archiefprocedure_afleidingswijze, brondatum_archiefprocedure_datumkenmerk, brondatum_archiefprocedure_einddatum_bekend, brondatum_archiefprocedure_objecttype, brondatum_archiefprocedure_registratie, brondatum_archiefprocedure_procestermijn, omschrijving_generiek) FROM stdin;
\.


--
-- Data for Name: datamodel_resultaattype_heeft_verplichte_ziot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_resultaattype_heeft_verplichte_ziot (id, resultaattype_id, zaakinformatieobjecttype_id) FROM stdin;
\.


--
-- Data for Name: datamodel_resultaattype_heeft_verplichte_zot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_resultaattype_heeft_verplichte_zot (id, resultaattype_id, zaakobjecttype_id) FROM stdin;
\.


--
-- Data for Name: datamodel_roltype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_roltype (id, omschrijving, omschrijving_generiek, soort_betrokkene, zaaktype_id, datum_begin_geldigheid, datum_einde_geldigheid, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_statustype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_statustype (id, statustype_omschrijving, statustype_omschrijving_generiek, statustypevolgnummer, doorlooptijd_status, informeren, statustekst, toelichting, zaaktype_id, datum_begin_geldigheid, datum_einde_geldigheid, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_statustype_checklistitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_statustype_checklistitem (id, statustype_id, checklistitem_id) FROM stdin;
\.


--
-- Data for Name: datamodel_statustype_roltypen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_statustype_roltypen (id, statustype_id, roltype_id) FROM stdin;
\.


--
-- Data for Name: datamodel_zaakinformatieobjecttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaakinformatieobjecttype (id, volgnummer, richting, informatie_object_type_id, status_type_id, zaaktype_id, uuid) FROM stdin;
\.


--
-- Data for Name: datamodel_zaakinformatieobjecttypearchiefregime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaakinformatieobjecttypearchiefregime (id, selectielijstklasse, archiefnominatie, archiefactietermijn, resultaattype_id, zaak_informatieobject_type_id) FROM stdin;
\.


--
-- Data for Name: datamodel_zaakobjecttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaakobjecttype (id, objecttype, ander_objecttype, relatieomschrijving, is_relevant_voor_id, status_type_id, datum_begin_geldigheid, datum_einde_geldigheid) FROM stdin;
\.


--
-- Data for Name: datamodel_zaaktype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaaktype (id, zaaktype_identificatie, zaaktype_omschrijving, zaaktype_omschrijving_generiek, zaakcategorie, doel, aanleiding, toelichting, indicatie_intern_of_extern, handeling_initiator, onderwerp, handeling_behandelaar, opschorting_en_aanhouding_mogelijk, verlenging_mogelijk, trefwoorden, archiefclassificatiecode, vertrouwelijkheidaanduiding, verantwoordelijke, publicatie_indicatie, publicatietekst, verantwoordingsrelatie, broncatalogus_id, bronzaaktype_id, catalogus_id, datum_begin_geldigheid, datum_einde_geldigheid, versiedatum, uuid, doorlooptijd_behandeling, servicenorm_behandeling, verlengingstermijn, referentieproces_link, referentieproces_naam, producten_of_diensten, selectielijst_procestype) FROM stdin;
\.


--
-- Data for Name: datamodel_zaaktype_formulier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaaktype_formulier (id, zaaktype_id, formulier_id) FROM stdin;
\.


--
-- Data for Name: datamodel_zaaktype_is_deelzaaktype_van; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaaktype_is_deelzaaktype_van (id, from_zaaktype_id, to_zaaktype_id) FROM stdin;
\.


--
-- Data for Name: datamodel_zaaktypenrelatie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datamodel_zaaktypenrelatie (id, aard_relatie, toelichting, zaaktype_id, gerelateerd_zaaktype) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-06-07 13:53:16.26671+00	1	http://BASE_IP:8002	2	[{"changed": {"fields": ["domain", "name"]}}]	5	1
2	2019-06-07 13:53:34.062915+00	1	BASE_IP:8002	2	[{"changed": {"fields": ["domain", "name"]}}]	5	1
3	2019-06-07 13:54:30.765228+00	1	http://BASE_IP:8005/api/v1/	2	[{"changed": {"fields": ["api_root", "component"]}}]	17	1
4	2019-06-07 13:55:00.466487+00	1	http://BASE_IP:8005/api/v1/	1	[{"added": {}}]	14	1
5	2019-06-07 13:57:12.5655+00	1	http://BASE_IP:8004/api/v1/	2	[{"changed": {"fields": ["api_root"]}}, {"added": {"name": "Webhook subscription", "object": "autorisaties - http://BASE_IP:8002/api/v1/"}}]	18	1
6	2019-06-07 13:59:07.067854+00	2	http://BASE_IP:8004/api/v1/	1	[{"added": {}}]	14	1
7	2019-06-07 14:16:08.567137+00	3	http://BASE_IP:8003/api/v1/	1	[{"added": {}}]	14	1
8	2019-06-07 14:16:25.575453+00	4	http://BASE_IP:8002/api/v1/	1	[{"added": {}}]	14	1
9	2019-06-07 14:16:38.266133+00	5	http://BASE_IP:8001/api/v1/	1	[{"added": {}}]	14	1
10	2019-06-13 10:32:31.273985+00	1	demo	1	[{"added": {}}]	13	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	contenttypes	contenttype
2	auth	permission
3	auth	group
4	sessions	session
5	sites	site
6	admin_index	appgroup
7	admin_index	applink
8	admin_index	contenttypeproxy
9	admin	logentry
10	axes	accessattempt
11	axes	accesslog
12	corsheaders	corsmodel
13	vng_api_common	jwtsecret
14	vng_api_common	apicredential
15	authorizations	applicatie
16	authorizations	autorisatie
17	authorizations	authorizationsconfig
18	notifications	notificationsconfig
19	notifications	subscription
20	accounts	user
21	datamodel	besluittype
22	datamodel	broncatalogus
23	datamodel	bronzaaktype
24	datamodel	catalogus
25	datamodel	checklistitem
26	datamodel	eigenschap
27	datamodel	eigenschapreferentie
28	datamodel	eigenschapspecificatie
29	datamodel	formulier
30	datamodel	informatieobjecttype
31	datamodel	informatieobjecttypeomschrijvinggeneriek
32	datamodel	resultaattype
33	datamodel	roltype
34	datamodel	statustype
35	datamodel	zaakinformatieobjecttype
36	datamodel	zaakinformatieobjecttypearchiefregime
37	datamodel	zaakobjecttype
38	datamodel	zaaktype
39	datamodel	zaaktypenrelatie
40	datamodel	mogelijkebetrokkene
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-06-13 08:13:58.002373+00
2	contenttypes	0002_remove_content_type_name	2019-06-13 08:13:58.20174+00
3	auth	0001_initial	2019-06-13 08:13:59.206287+00
4	auth	0002_alter_permission_name_max_length	2019-06-13 08:13:59.307075+00
5	auth	0003_alter_user_email_max_length	2019-06-13 08:13:59.402682+00
6	auth	0004_alter_user_username_opts	2019-06-13 08:13:59.509926+00
7	auth	0005_alter_user_last_login_null	2019-06-13 08:13:59.598842+00
8	auth	0006_require_contenttypes_0002	2019-06-13 08:13:59.60825+00
9	auth	0007_alter_validators_add_error_messages	2019-06-13 08:13:59.734515+00
10	auth	0008_alter_user_username_max_length	2019-06-13 08:13:59.799206+00
11	accounts	0001_initial	2019-06-13 08:14:00.731128+00
12	admin	0001_initial	2019-06-13 08:14:01.204138+00
13	admin	0002_logentry_remove_auto_add	2019-06-13 08:14:01.380003+00
14	admin_index	0001_initial	2019-06-13 08:14:02.197326+00
15	admin_index	0002_auto_20170802_1754	2019-06-13 08:14:02.307005+00
16	auth	0009_alter_user_last_name_max_length	2019-06-13 08:14:02.479303+00
17	authorizations	0001_initial	2019-06-13 08:14:02.899229+00
18	authorizations	0002_authorizationsconfig	2019-06-13 08:14:03.129647+00
19	authorizations	0003_auto_20190502_0409	2019-06-13 08:14:03.197877+00
20	authorizations	0004_auto_20190503_0941	2019-06-13 08:14:03.379054+00
21	authorizations	0005_auto_20190506_0842	2019-06-13 08:14:03.485521+00
22	authorizations	0006_auto_20190506_0901	2019-06-13 08:14:04.210842+00
23	authorizations	0007_auto_20190506_1212	2019-06-13 08:14:04.33209+00
24	axes	0001_initial	2019-06-13 08:14:04.696655+00
25	axes	0002_auto_20151217_2044	2019-06-13 08:14:05.310911+00
26	axes	0003_auto_20160322_0929	2019-06-13 08:14:05.724041+00
27	datamodel	0001_initial	2019-06-13 08:14:25.328089+00
28	datamodel	0002_auto_20180130_1059	2019-06-13 08:14:27.106286+00
29	datamodel	0003_auto_20180221_1119	2019-06-13 08:14:35.292242+00
30	datamodel	0004_auto_20180226_1153	2019-06-13 08:14:35.797467+00
31	datamodel	0005_auto_20180517_1455	2019-06-13 08:14:49.399667+00
32	datamodel	0006_migrate_stuf_date_to_date	2019-06-13 08:14:50.392995+00
33	datamodel	0007_auto_20180517_1544	2019-06-13 08:14:59.270808+00
34	datamodel	0008_auto_20180517_1547	2019-06-13 08:15:08.290544+00
35	datamodel	0009_auto_20180517_1642	2019-06-13 08:15:11.791661+00
36	datamodel	0010_auto_20180618_1042	2019-06-13 08:15:12.888675+00
37	datamodel	0011_auto_20180618_1044	2019-06-13 08:15:13.2926+00
38	datamodel	0012_auto_20180618_1102	2019-06-13 08:15:14.486399+00
39	datamodel	0013_auto_20180709_1638	2019-06-13 08:15:14.999102+00
40	datamodel	0014_auto_20180724_1433	2019-06-13 08:15:18.991969+00
41	datamodel	0015_auto_20180724_1434	2019-06-13 08:15:19.690387+00
42	datamodel	0016_auto_20180725_1418	2019-06-13 08:15:20.890763+00
43	datamodel	0017_auto_20180730_1637	2019-06-13 08:15:21.591264+00
44	datamodel	0018_auto_20180730_1637	2019-06-13 08:15:22.185238+00
45	datamodel	0019_auto_20180809_1745	2019-06-13 08:15:24.29973+00
46	datamodel	0020_auto_20180809_1747	2019-06-13 08:15:24.689932+00
47	datamodel	0021_mogelijkebetrokkene	2019-06-13 08:15:25.199371+00
48	datamodel	0022_auto_20180813_1211	2019-06-13 08:15:25.675125+00
49	datamodel	0023_auto_20180813_1211	2019-06-13 08:15:26.28689+00
50	datamodel	0024_auto_20180813_1213	2019-06-13 08:15:29.886503+00
51	datamodel	0025_informatieobjecttype_uuid	2019-06-13 08:15:30.190729+00
52	datamodel	0026_auto_20180816_1658	2019-06-13 08:15:30.48748+00
53	datamodel	0027_auto_20180906_1748	2019-06-13 08:15:33.190561+00
54	datamodel	0028_auto_20180906_1800	2019-06-13 08:15:37.79994+00
55	datamodel	0029_besluittype_uuid	2019-06-13 08:15:40.883109+00
56	datamodel	0030_set_besluittype_uuid	2019-06-13 08:15:41.481455+00
57	datamodel	0031_auto_20180911_1020	2019-06-13 08:15:41.794019+00
58	datamodel	0032_auto_20181029_1037	2019-06-13 08:15:42.578013+00
59	datamodel	0033_auto_20181203_1441	2019-06-13 08:15:42.894166+00
60	datamodel	0034_auto_20181211_1725	2019-06-13 08:15:44.077179+00
61	datamodel	0035_auto_20181211_1746	2019-06-13 08:15:46.183139+00
62	datamodel	0036_auto_20181227_1548	2019-06-13 08:15:46.575469+00
63	datamodel	0037_auto_20190108_1640	2019-06-13 08:15:46.888669+00
64	datamodel	0038_auto_20190108_1643	2019-06-13 08:15:47.28637+00
65	datamodel	0039_auto_20190108_1655	2019-06-13 08:15:47.681415+00
66	datamodel	0040_auto_20190108_1723	2019-06-13 08:15:47.98825+00
67	datamodel	0041_auto_20190108_1733	2019-06-13 08:15:50.873493+00
68	datamodel	0042_auto_20190108_1742	2019-06-13 08:15:51.184839+00
69	datamodel	0043_auto_20190108_1750	2019-06-13 08:15:51.577172+00
70	datamodel	0044_auto_20190108_1801	2019-06-13 08:15:51.877304+00
71	datamodel	0045_auto_20190114_1246	2019-06-13 08:15:52.89037+00
72	datamodel	0046_ja_nee_to_boolean	2019-06-13 08:15:54.78472+00
73	datamodel	0047_auto_20190114_1250	2019-06-13 08:15:55.177886+00
74	datamodel	0048_auto_20190114_1254	2019-06-13 08:15:56.209448+00
75	datamodel	0049_auto_20190114_1546	2019-06-13 08:15:56.884615+00
76	datamodel	0050_convert_verlengingstermijn	2019-06-13 08:15:57.570747+00
77	datamodel	0051_remove_zaaktype_old_verlengingstermijn	2019-06-13 08:15:57.880804+00
78	datamodel	0052_auto_20190114_1614	2019-06-13 08:15:58.269479+00
79	datamodel	0053_auto_20190114_1615	2019-06-13 08:15:58.579654+00
80	datamodel	0054_auto_20190114_1616	2019-06-13 08:16:01.47692+00
81	datamodel	0055_auto_20190114_1641	2019-06-13 08:16:01.780075+00
82	datamodel	0056_auto_20190114_1654	2019-06-13 08:16:02.078641+00
83	datamodel	0057_auto_20190115_1028	2019-06-13 08:16:02.482322+00
84	datamodel	0058_auto_20190115_1032	2019-06-13 08:16:03.174986+00
85	datamodel	0059_migrate_referentieproces_data	2019-06-13 08:16:03.769522+00
86	datamodel	0060_remove_zaaktype_referentieproces_old	2019-06-13 08:16:04.177502+00
87	datamodel	0061_delete_referentieproces	2019-06-13 08:16:04.185386+00
88	datamodel	0062_auto_20190115_1135	2019-06-13 08:16:04.375499+00
89	datamodel	0063_auto_20190115_1212	2019-06-13 08:16:04.881327+00
90	datamodel	0064_auto_20190115_1301	2019-06-13 08:16:05.579129+00
91	datamodel	0065_delete_productdienst	2019-06-13 08:16:05.673207+00
92	datamodel	0066_zaaktype_selectielijst_procestype	2019-06-13 08:16:05.97637+00
93	datamodel	0067_auto_20190115_1645	2019-06-13 08:16:06.279666+00
94	datamodel	0068_auto_20190115_1651	2019-06-13 08:16:07.289569+00
95	datamodel	0069_migrate_zaaktyperelaties	2019-06-13 08:16:07.877528+00
96	datamodel	0070_remove_zaaktypenrelatie_zaaktype_naar	2019-06-13 08:16:08.280463+00
97	datamodel	0071_auto_20190117_1037	2019-06-13 08:16:12.379378+00
98	datamodel	0072_set_uuid_ziot	2019-06-13 08:16:12.970653+00
99	datamodel	0073_auto_20190117_1039	2019-06-13 08:16:13.283418+00
100	datamodel	0074_auto_20190129_1050	2019-06-13 08:16:13.672725+00
101	datamodel	0075_auto_20190129_1103	2019-06-13 08:16:13.973383+00
102	datamodel	0076_auto_20190129_1113	2019-06-13 08:16:14.295346+00
103	datamodel	0077_auto_20190220_1147	2019-06-13 08:16:15.371182+00
104	datamodel	0078_auto_20190220_1148	2019-06-13 08:16:15.679521+00
105	datamodel	0079_auto_20190220_1307	2019-06-13 08:16:17.082154+00
106	datamodel	0080_resultaattype__omschrijving_generiek	2019-06-13 08:16:17.381283+00
107	datamodel	0081_auto_20190220_1436	2019-06-13 08:16:23.173374+00
108	datamodel	0082_auto_20190220_1443	2019-06-13 08:16:23.474457+00
109	datamodel	0083_auto_20190220_1523	2019-06-13 08:16:23.877137+00
110	datamodel	0084_auto_20190220_1817	2019-06-13 08:16:24.781283+00
111	datamodel	0085_auto_20190221_1232	2019-06-13 08:16:26.172459+00
112	datamodel	0086_auto_20190225_1450	2019-06-13 08:16:26.775686+00
113	datamodel	0087_auto_20190225_1450	2019-06-13 08:16:27.078752+00
114	datamodel	0088_resultaattype_brondatum_archiefprocedure_procestermijn	2019-06-13 08:16:27.380671+00
115	datamodel	0089_auto_20190226_1302	2019-06-13 08:16:27.773413+00
116	datamodel	0090_auto_20190226_1305	2019-06-13 08:16:28.677651+00
117	datamodel	0091_auto_20190226_1416	2019-06-13 08:16:28.98073+00
118	datamodel	0092_auto_20190226_1602	2019-06-13 08:16:31.978757+00
119	datamodel	0093_auto_20190305_1555	2019-06-13 08:16:33.975796+00
120	datamodel	0094_auto_20190305_1557	2019-06-13 08:16:34.276045+00
121	datamodel	0093_auto_20190304_1620	2019-06-13 08:16:35.475874+00
122	datamodel	0095_merge_20190327_1650	2019-06-13 08:16:35.47876+00
123	notifications	0001_initial	2019-06-13 08:16:35.676546+00
124	notifications	0002_subscription__subscription	2019-06-13 08:16:35.772594+00
125	notifications	0003_auto_20190319_1048	2019-06-13 08:16:35.981382+00
126	notifications	0004_auto_20190325_1313	2019-06-13 08:16:36.072777+00
127	notifications	0005_fix_default_nrc	2019-06-13 08:16:36.57903+00
128	notifications	0006_auto_20190417_1142	2019-06-13 08:16:36.779075+00
129	notifications	0007_auto_20190429_1442	2019-06-13 08:16:36.874555+00
130	notifications	0008_auto_20190502_0415	2019-06-13 08:16:36.971558+00
131	sessions	0001_initial	2019-06-13 08:16:36.991294+00
132	sites	0001_initial	2019-06-13 08:16:37.07779+00
133	sites	0002_alter_domain_unique	2019-06-13 08:16:37.171846+00
134	vng_api_common	0001_initial	2019-06-13 08:16:37.187846+00
135	vng_api_common	0002_apicredential	2019-06-13 08:16:37.28285+00
136	vng_api_common	0003_auto_20190417_1145	2019-06-13 08:16:37.379266+00
137	vng_api_common	0004_auto_20190517_0903	2019-06-13 08:16:37.481034+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
lila61jrrj7kdnwy6cpnzscq0kfklunz	MjcxZWUzNzM2MzczNjUwNjMyNDU0ZDlmNmU2OTNmY2E0M2NjZTI0MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGQzZjlhM2UxNTI4MGEyNjZlMDkyYTc0OTVjOTU0YmJiMjk5MDE1In0=	2019-06-21 13:52:49.963337+00
8q5djb7dt38sely8skwrmcp3mx3f6o39	MjcxZWUzNzM2MzczNjUwNjMyNDU0ZDlmNmU2OTNmY2E0M2NjZTI0MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMGQzZjlhM2UxNTI4MGEyNjZlMDkyYTc0OTVjOTU0YmJiMjk5MDE1In0=	2019-06-27 10:31:59.979807+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
1	BASE_IP:8002	BASE_IP:8002
\.


--
-- Data for Name: notifications_notificationsconfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_notificationsconfig (id, api_root) FROM stdin;
1	http://BASE_IP:8004/api/v1/
\.


--
-- Data for Name: notifications_subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications_subscription (id, callback_url, client_id, secret, channels, config_id, _subscription) FROM stdin;
1	http://BASE_IP:8002/api/v1/	demo	demo	{autorisaties}	1	http://BASE_IP:8004/api/v1/abonnement/093e7470-ce50-4796-a4bf-e3b71b8848fd
\.


--
-- Data for Name: vng_api_common_apicredential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_apicredential (id, api_root, client_id, secret, label, user_id, user_representation) FROM stdin;
1	http://BASE_IP:8005/api/v1/	demo	demo	ac	system	system
2	http://BASE_IP:8004/api/v1/	demo	demo	nrc	system	system
3	http://BASE_IP:8003/api/v1/	demo	demo	brc	system	system
4	http://BASE_IP:8002/api/v1/	demo	demo	ztc	system	system
5	http://BASE_IP:8001/api/v1/	demo	demo	drc	system	system
\.


--
-- Data for Name: vng_api_common_jwtsecret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vng_api_common_jwtsecret (id, identifier, secret) FROM stdin;
1	demo	demo
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 1, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: admin_index_appgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_index_appgroup_id_seq', 1, false);


--
-- Name: admin_index_appgroup_models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_index_appgroup_models_id_seq', 1, false);


--
-- Name: admin_index_applink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_index_applink_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 120, true);


--
-- Name: authorizations_applicatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_applicatie_id_seq', 3, true);


--
-- Name: authorizations_authorizationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_authorizationsconfig_id_seq', 1, false);


--
-- Name: authorizations_autorisatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authorizations_autorisatie_id_seq', 1, false);


--
-- Name: axes_accessattempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accessattempt_id_seq', 2, true);


--
-- Name: axes_accesslog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.axes_accesslog_id_seq', 2, true);


--
-- Name: datamodel_besluittype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_besluittype_id_seq', 1, false);


--
-- Name: datamodel_besluittype_is_resultaat_van_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_besluittype_is_resultaat_van_id_seq', 1, false);


--
-- Name: datamodel_besluittype_wordt_vastgelegd_in_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_besluittype_wordt_vastgelegd_in_id_seq', 1, false);


--
-- Name: datamodel_besluittype_zaaktypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_besluittype_zaaktypes_id_seq', 1, false);


--
-- Name: datamodel_broncatalogus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_broncatalogus_id_seq', 1, false);


--
-- Name: datamodel_bronzaaktype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_bronzaaktype_id_seq', 1, false);


--
-- Name: datamodel_catalogus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_catalogus_id_seq', 1, false);


--
-- Name: datamodel_checklistitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_checklistitem_id_seq', 1, false);


--
-- Name: datamodel_eigenschap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_eigenschap_id_seq', 1, false);


--
-- Name: datamodel_eigenschapreferentie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_eigenschapreferentie_id_seq', 1, false);


--
-- Name: datamodel_eigenschapspecificatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_eigenschapspecificatie_id_seq', 1, false);


--
-- Name: datamodel_formulier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_formulier_id_seq', 1, false);


--
-- Name: datamodel_informatieobjecttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_informatieobjecttype_id_seq', 1, false);


--
-- Name: datamodel_informatieobjecttypeomschrijvinggeneriek_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_informatieobjecttypeomschrijvinggeneriek_id_seq', 1, false);


--
-- Name: datamodel_mogelijkebetrokkene_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_mogelijkebetrokkene_id_seq', 1, false);


--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_resultaattype_heeft_verplichte_ziot_id_seq', 1, false);


--
-- Name: datamodel_resultaattype_heeft_verplichte_zot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_resultaattype_heeft_verplichte_zot_id_seq', 1, false);


--
-- Name: datamodel_resultaattype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_resultaattype_id_seq', 1, false);


--
-- Name: datamodel_roltype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_roltype_id_seq', 1, false);


--
-- Name: datamodel_statustype_checklistitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_statustype_checklistitem_id_seq', 1, false);


--
-- Name: datamodel_statustype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_statustype_id_seq', 1, false);


--
-- Name: datamodel_statustype_roltypen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_statustype_roltypen_id_seq', 1, false);


--
-- Name: datamodel_zaakinformatieobjecttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakinformatieobjecttype_id_seq', 1, false);


--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakinformatieobjecttypearchiefregime_id_seq', 1, false);


--
-- Name: datamodel_zaakobjecttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaakobjecttype_id_seq', 1, false);


--
-- Name: datamodel_zaaktype_formulier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaaktype_formulier_id_seq', 1, false);


--
-- Name: datamodel_zaaktype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaaktype_id_seq', 1, false);


--
-- Name: datamodel_zaaktype_is_deelzaaktype_van_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaaktype_is_deelzaaktype_van_id_seq', 1, false);


--
-- Name: datamodel_zaaktypenrelatie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datamodel_zaaktypenrelatie_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 10, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 40, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 137, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: notifications_notificationsconfig_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notificationsconfig_id_seq', 1, false);


--
-- Name: notifications_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_subscription_id_seq', 1, true);


--
-- Name: vng_api_common_apicredential_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_apicredential_id_seq', 5, true);


--
-- Name: vng_api_common_jwtsecret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vng_api_common_jwtsecret_id_seq', 1, true);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: admin_index_appgroup_models admin_index_appgroup_mod_appgroup_id_contenttypep_71f704bb_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_appgroup_models
    ADD CONSTRAINT admin_index_appgroup_mod_appgroup_id_contenttypep_71f704bb_uniq UNIQUE (appgroup_id, contenttypeproxy_id);


--
-- Name: admin_index_appgroup_models admin_index_appgroup_models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_appgroup_models
    ADD CONSTRAINT admin_index_appgroup_models_pkey PRIMARY KEY (id);


--
-- Name: admin_index_appgroup admin_index_appgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_appgroup
    ADD CONSTRAINT admin_index_appgroup_pkey PRIMARY KEY (id);


--
-- Name: admin_index_appgroup admin_index_appgroup_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_appgroup
    ADD CONSTRAINT admin_index_appgroup_slug_key UNIQUE (slug);


--
-- Name: admin_index_applink admin_index_applink_app_group_id_link_827f6133_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_applink
    ADD CONSTRAINT admin_index_applink_app_group_id_link_827f6133_uniq UNIQUE (app_group_id, link);


--
-- Name: admin_index_applink admin_index_applink_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_applink
    ADD CONSTRAINT admin_index_applink_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_pkey PRIMARY KEY (id);


--
-- Name: authorizations_applicatie authorizations_applicatie_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_applicatie
    ADD CONSTRAINT authorizations_applicatie_uuid_key UNIQUE (uuid);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_api_root_key UNIQUE (api_root);


--
-- Name: authorizations_authorizationsconfig authorizations_authorizationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_authorizationsconfig
    ADD CONSTRAINT authorizations_authorizationsconfig_pkey PRIMARY KEY (id);


--
-- Name: authorizations_autorisatie authorizations_autorisatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autorisatie_pkey PRIMARY KEY (id);


--
-- Name: axes_accessattempt axes_accessattempt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accessattempt
    ADD CONSTRAINT axes_accessattempt_pkey PRIMARY KEY (id);


--
-- Name: axes_accesslog axes_accesslog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.axes_accesslog
    ADD CONSTRAINT axes_accesslog_pkey PRIMARY KEY (id);


--
-- Name: datamodel_besluittype_resultaattypes datamodel_besluittype_is_besluittype_id_resultaat_634aafe8_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_resultaattypes
    ADD CONSTRAINT datamodel_besluittype_is_besluittype_id_resultaat_634aafe8_uniq UNIQUE (besluittype_id, resultaattype_id);


--
-- Name: datamodel_besluittype_resultaattypes datamodel_besluittype_is_resultaat_van_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_resultaattypes
    ADD CONSTRAINT datamodel_besluittype_is_resultaat_van_pkey PRIMARY KEY (id);


--
-- Name: datamodel_besluittype datamodel_besluittype_maakt_deel_uit_van_id_be_7a1c28e1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype
    ADD CONSTRAINT datamodel_besluittype_maakt_deel_uit_van_id_be_7a1c28e1_uniq UNIQUE (catalogus_id, omschrijving);


--
-- Name: datamodel_besluittype datamodel_besluittype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype
    ADD CONSTRAINT datamodel_besluittype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_besluittype datamodel_besluittype_uuid_927757f0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype
    ADD CONSTRAINT datamodel_besluittype_uuid_927757f0_uniq UNIQUE (uuid);


--
-- Name: datamodel_besluittype_informatieobjecttypes datamodel_besluittype_wo_besluittype_id_informati_c5b65eab_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_informatieobjecttypes
    ADD CONSTRAINT datamodel_besluittype_wo_besluittype_id_informati_c5b65eab_uniq UNIQUE (besluittype_id, informatieobjecttype_id);


--
-- Name: datamodel_besluittype_informatieobjecttypes datamodel_besluittype_wordt_vastgelegd_in_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_informatieobjecttypes
    ADD CONSTRAINT datamodel_besluittype_wordt_vastgelegd_in_pkey PRIMARY KEY (id);


--
-- Name: datamodel_besluittype_zaaktypes datamodel_besluittype_za_besluittype_id_zaaktype__8bd17271_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_zaaktypes
    ADD CONSTRAINT datamodel_besluittype_za_besluittype_id_zaaktype__8bd17271_uniq UNIQUE (besluittype_id, zaaktype_id);


--
-- Name: datamodel_besluittype_zaaktypes datamodel_besluittype_zaaktypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_zaaktypes
    ADD CONSTRAINT datamodel_besluittype_zaaktypes_pkey PRIMARY KEY (id);


--
-- Name: datamodel_broncatalogus datamodel_broncatalogus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_broncatalogus
    ADD CONSTRAINT datamodel_broncatalogus_pkey PRIMARY KEY (id);


--
-- Name: datamodel_bronzaaktype datamodel_bronzaaktype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_bronzaaktype
    ADD CONSTRAINT datamodel_bronzaaktype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_catalogus datamodel_catalogus_domein_rsin_c5daf4a8_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_catalogus
    ADD CONSTRAINT datamodel_catalogus_domein_rsin_c5daf4a8_uniq UNIQUE (domein, rsin);


--
-- Name: datamodel_catalogus datamodel_catalogus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_catalogus
    ADD CONSTRAINT datamodel_catalogus_pkey PRIMARY KEY (id);


--
-- Name: datamodel_catalogus datamodel_catalogus_uuid_965659f9_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_catalogus
    ADD CONSTRAINT datamodel_catalogus_uuid_965659f9_uniq UNIQUE (uuid);


--
-- Name: datamodel_checklistitem datamodel_checklistitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_checklistitem
    ADD CONSTRAINT datamodel_checklistitem_pkey PRIMARY KEY (id);


--
-- Name: datamodel_eigenschap datamodel_eigenschap_is_van_id_eigenschapnaam_00a57a90_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschap
    ADD CONSTRAINT datamodel_eigenschap_is_van_id_eigenschapnaam_00a57a90_uniq UNIQUE (is_van_id, eigenschapnaam);


--
-- Name: datamodel_eigenschap datamodel_eigenschap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschap
    ADD CONSTRAINT datamodel_eigenschap_pkey PRIMARY KEY (id);


--
-- Name: datamodel_eigenschap datamodel_eigenschap_uuid_754351d8_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschap
    ADD CONSTRAINT datamodel_eigenschap_uuid_754351d8_uniq UNIQUE (uuid);


--
-- Name: datamodel_eigenschapreferentie datamodel_eigenschapreferentie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschapreferentie
    ADD CONSTRAINT datamodel_eigenschapreferentie_pkey PRIMARY KEY (id);


--
-- Name: datamodel_eigenschapspecificatie datamodel_eigenschapspecificatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschapspecificatie
    ADD CONSTRAINT datamodel_eigenschapspecificatie_pkey PRIMARY KEY (id);


--
-- Name: datamodel_formulier datamodel_formulier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_formulier
    ADD CONSTRAINT datamodel_formulier_pkey PRIMARY KEY (id);


--
-- Name: datamodel_informatieobjecttype datamodel_informatieobje_maakt_deel_uit_van_id_in_bc7b86ca_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_informatieobjecttype
    ADD CONSTRAINT datamodel_informatieobje_maakt_deel_uit_van_id_in_bc7b86ca_uniq UNIQUE (catalogus_id, omschrijving);


--
-- Name: datamodel_informatieobjecttype datamodel_informatieobjecttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_informatieobjecttype
    ADD CONSTRAINT datamodel_informatieobjecttype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_informatieobjecttype datamodel_informatieobjecttype_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_informatieobjecttype
    ADD CONSTRAINT datamodel_informatieobjecttype_uuid_key UNIQUE (uuid);


--
-- Name: datamodel_informatieobjecttypeomschrijvinggeneriek datamodel_informatieobjecttypeomschrijvinggeneriek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_informatieobjecttypeomschrijvinggeneriek
    ADD CONSTRAINT datamodel_informatieobjecttypeomschrijvinggeneriek_pkey PRIMARY KEY (id);


--
-- Name: datamodel_mogelijkebetrokkene datamodel_mogelijkebetrokkene_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_mogelijkebetrokkene
    ADD CONSTRAINT datamodel_mogelijkebetrokkene_pkey PRIMARY KEY (id);


--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot datamodel_resultaattype__resultaattype_id_zaakinf_f03f8934_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_ziot
    ADD CONSTRAINT datamodel_resultaattype__resultaattype_id_zaakinf_f03f8934_uniq UNIQUE (resultaattype_id, zaakinformatieobjecttype_id);


--
-- Name: datamodel_resultaattype_heeft_verplichte_zot datamodel_resultaattype__resultaattype_id_zaakobj_39a15c34_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_zot
    ADD CONSTRAINT datamodel_resultaattype__resultaattype_id_zaakobj_39a15c34_uniq UNIQUE (resultaattype_id, zaakobjecttype_id);


--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot datamodel_resultaattype_heeft_verplichte_ziot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_ziot
    ADD CONSTRAINT datamodel_resultaattype_heeft_verplichte_ziot_pkey PRIMARY KEY (id);


--
-- Name: datamodel_resultaattype_heeft_verplichte_zot datamodel_resultaattype_heeft_verplichte_zot_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_zot
    ADD CONSTRAINT datamodel_resultaattype_heeft_verplichte_zot_pkey PRIMARY KEY (id);


--
-- Name: datamodel_resultaattype datamodel_resultaattype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype
    ADD CONSTRAINT datamodel_resultaattype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_resultaattype datamodel_resultaattype_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype
    ADD CONSTRAINT datamodel_resultaattype_uuid_key UNIQUE (uuid);


--
-- Name: datamodel_resultaattype datamodel_resultaattype_zaaktype_id_omschrijving_8c52e9ec_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype
    ADD CONSTRAINT datamodel_resultaattype_zaaktype_id_omschrijving_8c52e9ec_uniq UNIQUE (zaaktype_id, omschrijving);


--
-- Name: datamodel_roltype datamodel_roltype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_roltype
    ADD CONSTRAINT datamodel_roltype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_roltype datamodel_roltype_zaaktype_id_omschrijving_3685d302_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_roltype
    ADD CONSTRAINT datamodel_roltype_zaaktype_id_omschrijving_3685d302_uniq UNIQUE (zaaktype_id, omschrijving);


--
-- Name: datamodel_statustype_checklistitem datamodel_statustype_che_statustype_id_checklisti_7ef7e198_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_checklistitem
    ADD CONSTRAINT datamodel_statustype_che_statustype_id_checklisti_7ef7e198_uniq UNIQUE (statustype_id, checklistitem_id);


--
-- Name: datamodel_statustype_checklistitem datamodel_statustype_checklistitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_checklistitem
    ADD CONSTRAINT datamodel_statustype_checklistitem_pkey PRIMARY KEY (id);


--
-- Name: datamodel_statustype datamodel_statustype_is_van_id_statustypevolg_bb0e7cfd_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype
    ADD CONSTRAINT datamodel_statustype_is_van_id_statustypevolg_bb0e7cfd_uniq UNIQUE (zaaktype_id, statustypevolgnummer);


--
-- Name: datamodel_statustype datamodel_statustype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype
    ADD CONSTRAINT datamodel_statustype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_statustype_roltypen datamodel_statustype_rol_statustype_id_roltype_id_0ce4f899_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_roltypen
    ADD CONSTRAINT datamodel_statustype_rol_statustype_id_roltype_id_0ce4f899_uniq UNIQUE (statustype_id, roltype_id);


--
-- Name: datamodel_statustype_roltypen datamodel_statustype_roltypen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_roltypen
    ADD CONSTRAINT datamodel_statustype_roltypen_pkey PRIMARY KEY (id);


--
-- Name: datamodel_statustype datamodel_statustype_uuid_db171655_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype
    ADD CONSTRAINT datamodel_statustype_uuid_db171655_uniq UNIQUE (uuid);


--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime datamodel_zaakinformatie_zaak_informatieobject_ty_0541edac_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttypearchiefregime
    ADD CONSTRAINT datamodel_zaakinformatie_zaak_informatieobject_ty_0541edac_uniq UNIQUE (zaak_informatieobject_type_id, resultaattype_id);


--
-- Name: datamodel_zaakinformatieobjecttype datamodel_zaakinformatie_zaaktype_id_volgnummer_f55c28fe_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttype
    ADD CONSTRAINT datamodel_zaakinformatie_zaaktype_id_volgnummer_f55c28fe_uniq UNIQUE (zaaktype_id, volgnummer);


--
-- Name: datamodel_zaakinformatieobjecttype datamodel_zaakinformatieobjecttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttype
    ADD CONSTRAINT datamodel_zaakinformatieobjecttype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaakinformatieobjecttype datamodel_zaakinformatieobjecttype_uuid_6ebfc02c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttype
    ADD CONSTRAINT datamodel_zaakinformatieobjecttype_uuid_6ebfc02c_uniq UNIQUE (uuid);


--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime datamodel_zaakinformatieobjecttypearchiefregime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttypearchiefregime
    ADD CONSTRAINT datamodel_zaakinformatieobjecttypearchiefregime_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaakobjecttype datamodel_zaakobjecttype_is_relevant_voor_id_obje_d3cf3f89_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobjecttype
    ADD CONSTRAINT datamodel_zaakobjecttype_is_relevant_voor_id_obje_d3cf3f89_uniq UNIQUE (is_relevant_voor_id, objecttype);


--
-- Name: datamodel_zaakobjecttype datamodel_zaakobjecttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobjecttype
    ADD CONSTRAINT datamodel_zaakobjecttype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaaktype_formulier datamodel_zaaktype_formu_zaaktype_id_formulier_id_3ba7dd03_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_formulier
    ADD CONSTRAINT datamodel_zaaktype_formu_zaaktype_id_formulier_id_3ba7dd03_uniq UNIQUE (zaaktype_id, formulier_id);


--
-- Name: datamodel_zaaktype_formulier datamodel_zaaktype_formulier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_formulier
    ADD CONSTRAINT datamodel_zaaktype_formulier_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaaktype_is_deelzaaktype_van datamodel_zaaktype_is_de_from_zaaktype_id_to_zaak_9d936310_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_is_deelzaaktype_van
    ADD CONSTRAINT datamodel_zaaktype_is_de_from_zaaktype_id_to_zaak_9d936310_uniq UNIQUE (from_zaaktype_id, to_zaaktype_id);


--
-- Name: datamodel_zaaktype_is_deelzaaktype_van datamodel_zaaktype_is_deelzaaktype_van_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_is_deelzaaktype_van
    ADD CONSTRAINT datamodel_zaaktype_is_deelzaaktype_van_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaaktype datamodel_zaaktype_maakt_deel_uit_van_id_za_b7f64c5e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype
    ADD CONSTRAINT datamodel_zaaktype_maakt_deel_uit_van_id_za_b7f64c5e_uniq UNIQUE (catalogus_id, zaaktype_identificatie);


--
-- Name: datamodel_zaaktype datamodel_zaaktype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype
    ADD CONSTRAINT datamodel_zaaktype_pkey PRIMARY KEY (id);


--
-- Name: datamodel_zaaktype datamodel_zaaktype_uuid_b0d69a88_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype
    ADD CONSTRAINT datamodel_zaaktype_uuid_b0d69a88_uniq UNIQUE (uuid);


--
-- Name: datamodel_zaaktypenrelatie datamodel_zaaktypenrelat_zaaktype_id_gerelateerd__f19f6be0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktypenrelatie
    ADD CONSTRAINT datamodel_zaaktypenrelat_zaaktype_id_gerelateerd__f19f6be0_uniq UNIQUE (zaaktype_id, gerelateerd_zaaktype);


--
-- Name: datamodel_zaaktypenrelatie datamodel_zaaktypenrelatie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktypenrelatie
    ADD CONSTRAINT datamodel_zaaktypenrelatie_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_api_root_e4030d56_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_api_root_e4030d56_uniq UNIQUE (api_root);


--
-- Name: notifications_notificationsconfig notifications_notificationsconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_notificationsconfig
    ADD CONSTRAINT notifications_notificationsconfig_pkey PRIMARY KEY (id);


--
-- Name: notifications_subscription notifications_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscription_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_api_root_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_api_root_key UNIQUE (api_root);


--
-- Name: vng_api_common_apicredential vng_api_common_apicredential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_apicredential
    ADD CONSTRAINT vng_api_common_apicredential_pkey PRIMARY KEY (id);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_identifier_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_identifier_key UNIQUE (identifier);


--
-- Name: vng_api_common_jwtsecret vng_api_common_jwtsecret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vng_api_common_jwtsecret
    ADD CONSTRAINT vng_api_common_jwtsecret_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: admin_index_appgroup_models_appgroup_id_2bf4a4c3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_index_appgroup_models_appgroup_id_2bf4a4c3 ON public.admin_index_appgroup_models USING btree (appgroup_id);


--
-- Name: admin_index_appgroup_models_contenttypeproxy_id_1e3df183; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_index_appgroup_models_contenttypeproxy_id_1e3df183 ON public.admin_index_appgroup_models USING btree (contenttypeproxy_id);


--
-- Name: admin_index_appgroup_order_4eeb6684; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_index_appgroup_order_4eeb6684 ON public.admin_index_appgroup USING btree ("order");


--
-- Name: admin_index_appgroup_slug_1a396c23_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_index_appgroup_slug_1a396c23_like ON public.admin_index_appgroup USING btree (slug varchar_pattern_ops);


--
-- Name: admin_index_applink_app_group_id_d954f604; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_index_applink_app_group_id_d954f604 ON public.admin_index_applink USING btree (app_group_id);


--
-- Name: admin_index_applink_order_36a54934; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admin_index_applink_order_36a54934 ON public.admin_index_applink USING btree ("order");


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authorizations_authorizationsconfig_api_root_0b54af71_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_authorizationsconfig_api_root_0b54af71_like ON public.authorizations_authorizationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: authorizations_autorisatie_applicatie_id_44348ea1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX authorizations_autorisatie_applicatie_id_44348ea1 ON public.authorizations_autorisatie USING btree (applicatie_id);


--
-- Name: axes_accessattempt_ip_address_10922d9c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_ip_address_10922d9c ON public.axes_accessattempt USING btree (ip_address);


--
-- Name: axes_accessattempt_trusted_0eddf52e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_trusted_0eddf52e ON public.axes_accessattempt USING btree (trusted);


--
-- Name: axes_accessattempt_user_agent_ad89678b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b ON public.axes_accessattempt USING btree (user_agent);


--
-- Name: axes_accessattempt_user_agent_ad89678b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_user_agent_ad89678b_like ON public.axes_accessattempt USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accessattempt_username_3f2d4ca0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0 ON public.axes_accessattempt USING btree (username);


--
-- Name: axes_accessattempt_username_3f2d4ca0_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accessattempt_username_3f2d4ca0_like ON public.axes_accessattempt USING btree (username varchar_pattern_ops);


--
-- Name: axes_accesslog_ip_address_86b417e5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_ip_address_86b417e5 ON public.axes_accesslog USING btree (ip_address);


--
-- Name: axes_accesslog_trusted_496c5681; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_trusted_496c5681 ON public.axes_accesslog USING btree (trusted);


--
-- Name: axes_accesslog_user_agent_0e659004; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004 ON public.axes_accesslog USING btree (user_agent);


--
-- Name: axes_accesslog_user_agent_0e659004_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_user_agent_0e659004_like ON public.axes_accesslog USING btree (user_agent varchar_pattern_ops);


--
-- Name: axes_accesslog_username_df93064b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b ON public.axes_accesslog USING btree (username);


--
-- Name: axes_accesslog_username_df93064b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX axes_accesslog_username_df93064b_like ON public.axes_accesslog USING btree (username varchar_pattern_ops);


--
-- Name: datamodel_besluittype_is_r_resultaattype_id_68b579a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_besluittype_is_r_resultaattype_id_68b579a1 ON public.datamodel_besluittype_resultaattypes USING btree (resultaattype_id);


--
-- Name: datamodel_besluittype_is_resultaat_van_besluittype_id_0183e498; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_besluittype_is_resultaat_van_besluittype_id_0183e498 ON public.datamodel_besluittype_resultaattypes USING btree (besluittype_id);


--
-- Name: datamodel_besluittype_maakt_deel_uit_van_id_42d3c3e6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_besluittype_maakt_deel_uit_van_id_42d3c3e6 ON public.datamodel_besluittype USING btree (catalogus_id);


--
-- Name: datamodel_besluittype_word_besluittype_id_60331224; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_besluittype_word_besluittype_id_60331224 ON public.datamodel_besluittype_informatieobjecttypes USING btree (besluittype_id);


--
-- Name: datamodel_besluittype_word_informatieobjecttype_id_82f787d0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_besluittype_word_informatieobjecttype_id_82f787d0 ON public.datamodel_besluittype_informatieobjecttypes USING btree (informatieobjecttype_id);


--
-- Name: datamodel_besluittype_zaaktypes_besluittype_id_d8fad0a5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_besluittype_zaaktypes_besluittype_id_d8fad0a5 ON public.datamodel_besluittype_zaaktypes USING btree (besluittype_id);


--
-- Name: datamodel_besluittype_zaaktypes_zaaktype_id_cd1d9056; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_besluittype_zaaktypes_zaaktype_id_cd1d9056 ON public.datamodel_besluittype_zaaktypes USING btree (zaaktype_id);


--
-- Name: datamodel_eigenschap_is_van_id_f9df4996; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_eigenschap_is_van_id_f9df4996 ON public.datamodel_eigenschap USING btree (is_van_id);


--
-- Name: datamodel_eigenschap_referentie_naar_eigenschap_id_ca42d6d7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_eigenschap_referentie_naar_eigenschap_id_ca42d6d7 ON public.datamodel_eigenschap USING btree (referentie_naar_eigenschap_id);


--
-- Name: datamodel_eigenschap_specificatie_van_eigenschap_id_d5546e0a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_eigenschap_specificatie_van_eigenschap_id_d5546e0a ON public.datamodel_eigenschap USING btree (specificatie_van_eigenschap_id);


--
-- Name: datamodel_eigenschap_status_type_id_7b5a7256; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_eigenschap_status_type_id_7b5a7256 ON public.datamodel_eigenschap USING btree (status_type_id);


--
-- Name: datamodel_informatieobject_informatieobjecttype_omsch_abd48038; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_informatieobject_informatieobjecttype_omsch_abd48038 ON public.datamodel_informatieobjecttype USING btree (omschrijving_generiek_id);


--
-- Name: datamodel_informatieobjecttype_maakt_deel_uit_van_id_ca8acbff; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_informatieobjecttype_maakt_deel_uit_van_id_ca8acbff ON public.datamodel_informatieobjecttype USING btree (catalogus_id);


--
-- Name: datamodel_mogelijkebetrokkene_roltype_id_7455cc6c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_mogelijkebetrokkene_roltype_id_7455cc6c ON public.datamodel_mogelijkebetrokkene USING btree (roltype_id);


--
-- Name: datamodel_resultaattype_he_resultaattype_id_1c6a4cd9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_resultaattype_he_resultaattype_id_1c6a4cd9 ON public.datamodel_resultaattype_heeft_verplichte_ziot USING btree (resultaattype_id);


--
-- Name: datamodel_resultaattype_he_resultaattype_id_67f8522e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_resultaattype_he_resultaattype_id_67f8522e ON public.datamodel_resultaattype_heeft_verplichte_zot USING btree (resultaattype_id);


--
-- Name: datamodel_resultaattype_he_zaakinformatieobjecttype_i_643fd18b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_resultaattype_he_zaakinformatieobjecttype_i_643fd18b ON public.datamodel_resultaattype_heeft_verplichte_ziot USING btree (zaakinformatieobjecttype_id);


--
-- Name: datamodel_resultaattype_he_zaakobjecttype_id_cc4b977e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_resultaattype_he_zaakobjecttype_id_cc4b977e ON public.datamodel_resultaattype_heeft_verplichte_zot USING btree (zaakobjecttype_id);


--
-- Name: datamodel_resultaattype_heeft_voor_brondatum_archi_e26fd718; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_resultaattype_heeft_voor_brondatum_archi_e26fd718 ON public.datamodel_resultaattype USING btree (heeft_voor_brondatum_archiefprocedure_relevante_id);


--
-- Name: datamodel_resultaattype_is_relevant_voor_id_debb23b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_resultaattype_is_relevant_voor_id_debb23b8 ON public.datamodel_resultaattype USING btree (zaaktype_id);


--
-- Name: datamodel_roltype_is_van_id_f09b4feb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_roltype_is_van_id_f09b4feb ON public.datamodel_roltype USING btree (zaaktype_id);


--
-- Name: datamodel_statustype_checklistitem_checklistitem_id_ae510266; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_statustype_checklistitem_checklistitem_id_ae510266 ON public.datamodel_statustype_checklistitem USING btree (checklistitem_id);


--
-- Name: datamodel_statustype_checklistitem_statustype_id_43ca98f5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_statustype_checklistitem_statustype_id_43ca98f5 ON public.datamodel_statustype_checklistitem USING btree (statustype_id);


--
-- Name: datamodel_statustype_is_van_id_d7f8136a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_statustype_is_van_id_d7f8136a ON public.datamodel_statustype USING btree (zaaktype_id);


--
-- Name: datamodel_statustype_roltypen_roltype_id_f373c336; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_statustype_roltypen_roltype_id_f373c336 ON public.datamodel_statustype_roltypen USING btree (roltype_id);


--
-- Name: datamodel_statustype_roltypen_statustype_id_9c4b2049; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_statustype_roltypen_statustype_id_9c4b2049 ON public.datamodel_statustype_roltypen USING btree (statustype_id);


--
-- Name: datamodel_zaakinformatieob_informatie_object_type_id_28a1966f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakinformatieob_informatie_object_type_id_28a1966f ON public.datamodel_zaakinformatieobjecttype USING btree (informatie_object_type_id);


--
-- Name: datamodel_zaakinformatieob_resultaattype_id_4179cf41; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakinformatieob_resultaattype_id_4179cf41 ON public.datamodel_zaakinformatieobjecttypearchiefregime USING btree (resultaattype_id);


--
-- Name: datamodel_zaakinformatieob_zaak_informatieobject_type_f411d96e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakinformatieob_zaak_informatieobject_type_f411d96e ON public.datamodel_zaakinformatieobjecttypearchiefregime USING btree (zaak_informatieobject_type_id);


--
-- Name: datamodel_zaakinformatieobjecttype_status_type_id_f2a27f1e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakinformatieobjecttype_status_type_id_f2a27f1e ON public.datamodel_zaakinformatieobjecttype USING btree (status_type_id);


--
-- Name: datamodel_zaakinformatieobjecttype_zaaktype_id_d4c2e930; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakinformatieobjecttype_zaaktype_id_d4c2e930 ON public.datamodel_zaakinformatieobjecttype USING btree (zaaktype_id);


--
-- Name: datamodel_zaakobjecttype_is_relevant_voor_id_7c0a6278; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakobjecttype_is_relevant_voor_id_7c0a6278 ON public.datamodel_zaakobjecttype USING btree (is_relevant_voor_id);


--
-- Name: datamodel_zaakobjecttype_status_type_id_8aa0c1fb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaakobjecttype_status_type_id_8aa0c1fb ON public.datamodel_zaakobjecttype USING btree (status_type_id);


--
-- Name: datamodel_zaaktype_broncatalogus_id_87035d6a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaaktype_broncatalogus_id_87035d6a ON public.datamodel_zaaktype USING btree (broncatalogus_id);


--
-- Name: datamodel_zaaktype_bronzaaktype_id_de38bd13; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaaktype_bronzaaktype_id_de38bd13 ON public.datamodel_zaaktype USING btree (bronzaaktype_id);


--
-- Name: datamodel_zaaktype_formulier_formulier_id_f1956fc6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaaktype_formulier_formulier_id_f1956fc6 ON public.datamodel_zaaktype_formulier USING btree (formulier_id);


--
-- Name: datamodel_zaaktype_formulier_zaaktype_id_78080929; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaaktype_formulier_zaaktype_id_78080929 ON public.datamodel_zaaktype_formulier USING btree (zaaktype_id);


--
-- Name: datamodel_zaaktype_is_deel_from_zaaktype_id_7f6fe120; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaaktype_is_deel_from_zaaktype_id_7f6fe120 ON public.datamodel_zaaktype_is_deelzaaktype_van USING btree (from_zaaktype_id);


--
-- Name: datamodel_zaaktype_is_deelzaaktype_van_to_zaaktype_id_2fe006ca; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaaktype_is_deelzaaktype_van_to_zaaktype_id_2fe006ca ON public.datamodel_zaaktype_is_deelzaaktype_van USING btree (to_zaaktype_id);


--
-- Name: datamodel_zaaktype_maakt_deel_uit_van_id_f44e94b1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaaktype_maakt_deel_uit_van_id_f44e94b1 ON public.datamodel_zaaktype USING btree (catalogus_id);


--
-- Name: datamodel_zaaktypenrelatie_zaaktype_van_id_cfc8011b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datamodel_zaaktypenrelatie_zaaktype_van_id_cfc8011b ON public.datamodel_zaaktypenrelatie USING btree (zaaktype_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: notifications_notificationsconfig_api_root_e4030d56_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_notificationsconfig_api_root_e4030d56_like ON public.notifications_notificationsconfig USING btree (api_root varchar_pattern_ops);


--
-- Name: notifications_subscription_config_id_3567b13c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_subscription_config_id_3567b13c ON public.notifications_subscription USING btree (config_id);


--
-- Name: vng_api_common_apicredential_api_root_cb3905ed_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_apicredential_api_root_cb3905ed_like ON public.vng_api_common_apicredential USING btree (api_root varchar_pattern_ops);


--
-- Name: vng_api_common_jwtsecret_identifier_e89b809e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vng_api_common_jwtsecret_identifier_e89b809e_like ON public.vng_api_common_jwtsecret USING btree (identifier varchar_pattern_ops);


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admin_index_appgroup_models admin_index_appgroup_appgroup_id_2bf4a4c3_fk_admin_ind; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_appgroup_models
    ADD CONSTRAINT admin_index_appgroup_appgroup_id_2bf4a4c3_fk_admin_ind FOREIGN KEY (appgroup_id) REFERENCES public.admin_index_appgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admin_index_appgroup_models admin_index_appgroup_contenttypeproxy_id_1e3df183_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_appgroup_models
    ADD CONSTRAINT admin_index_appgroup_contenttypeproxy_id_1e3df183_fk_django_co FOREIGN KEY (contenttypeproxy_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admin_index_applink admin_index_applink_app_group_id_d954f604_fk_admin_ind; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_index_applink
    ADD CONSTRAINT admin_index_applink_app_group_id_d954f604_fk_admin_ind FOREIGN KEY (app_group_id) REFERENCES public.admin_index_appgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authorizations_autorisatie authorizations_autor_applicatie_id_44348ea1_fk_authoriza; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authorizations_autorisatie
    ADD CONSTRAINT authorizations_autor_applicatie_id_44348ea1_fk_authoriza FOREIGN KEY (applicatie_id) REFERENCES public.authorizations_applicatie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_besluittype_informatieobjecttypes datamodel_besluittyp_besluittype_id_47df698d_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_informatieobjecttypes
    ADD CONSTRAINT datamodel_besluittyp_besluittype_id_47df698d_fk_datamodel FOREIGN KEY (besluittype_id) REFERENCES public.datamodel_besluittype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_besluittype_resultaattypes datamodel_besluittyp_besluittype_id_c7bf0744_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_resultaattypes
    ADD CONSTRAINT datamodel_besluittyp_besluittype_id_c7bf0744_fk_datamodel FOREIGN KEY (besluittype_id) REFERENCES public.datamodel_besluittype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_besluittype_zaaktypes datamodel_besluittyp_besluittype_id_d8fad0a5_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_zaaktypes
    ADD CONSTRAINT datamodel_besluittyp_besluittype_id_d8fad0a5_fk_datamodel FOREIGN KEY (besluittype_id) REFERENCES public.datamodel_besluittype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_besluittype datamodel_besluittyp_catalogus_id_c1374f26_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype
    ADD CONSTRAINT datamodel_besluittyp_catalogus_id_c1374f26_fk_datamodel FOREIGN KEY (catalogus_id) REFERENCES public.datamodel_catalogus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_besluittype_informatieobjecttypes datamodel_besluittyp_informatieobjecttype_9ffb3b2b_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_informatieobjecttypes
    ADD CONSTRAINT datamodel_besluittyp_informatieobjecttype_9ffb3b2b_fk_datamodel FOREIGN KEY (informatieobjecttype_id) REFERENCES public.datamodel_informatieobjecttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_besluittype_resultaattypes datamodel_besluittyp_resultaattype_id_27ca0368_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_resultaattypes
    ADD CONSTRAINT datamodel_besluittyp_resultaattype_id_27ca0368_fk_datamodel FOREIGN KEY (resultaattype_id) REFERENCES public.datamodel_resultaattype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_besluittype_zaaktypes datamodel_besluittyp_zaaktype_id_cd1d9056_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_besluittype_zaaktypes
    ADD CONSTRAINT datamodel_besluittyp_zaaktype_id_cd1d9056_fk_datamodel FOREIGN KEY (zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_eigenschap datamodel_eigenschap_is_van_id_f9df4996_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschap
    ADD CONSTRAINT datamodel_eigenschap_is_van_id_f9df4996_fk_datamodel FOREIGN KEY (is_van_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_eigenschap datamodel_eigenschap_referentie_naar_eige_ca42d6d7_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschap
    ADD CONSTRAINT datamodel_eigenschap_referentie_naar_eige_ca42d6d7_fk_datamodel FOREIGN KEY (referentie_naar_eigenschap_id) REFERENCES public.datamodel_eigenschapreferentie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_eigenschap datamodel_eigenschap_specificatie_van_eig_d5546e0a_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschap
    ADD CONSTRAINT datamodel_eigenschap_specificatie_van_eig_d5546e0a_fk_datamodel FOREIGN KEY (specificatie_van_eigenschap_id) REFERENCES public.datamodel_eigenschapspecificatie(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_eigenschap datamodel_eigenschap_status_type_id_7b5a7256_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_eigenschap
    ADD CONSTRAINT datamodel_eigenschap_status_type_id_7b5a7256_fk_datamodel FOREIGN KEY (status_type_id) REFERENCES public.datamodel_statustype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_informatieobjecttype datamodel_informatie_catalogus_id_8fbddc0b_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_informatieobjecttype
    ADD CONSTRAINT datamodel_informatie_catalogus_id_8fbddc0b_fk_datamodel FOREIGN KEY (catalogus_id) REFERENCES public.datamodel_catalogus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_informatieobjecttype datamodel_informatie_omschrijving_generie_27abec64_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_informatieobjecttype
    ADD CONSTRAINT datamodel_informatie_omschrijving_generie_27abec64_fk_datamodel FOREIGN KEY (omschrijving_generiek_id) REFERENCES public.datamodel_informatieobjecttypeomschrijvinggeneriek(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_mogelijkebetrokkene datamodel_mogelijkeb_roltype_id_7455cc6c_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_mogelijkebetrokkene
    ADD CONSTRAINT datamodel_mogelijkeb_roltype_id_7455cc6c_fk_datamodel FOREIGN KEY (roltype_id) REFERENCES public.datamodel_roltype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_resultaattype datamodel_resultaatt_heeft_voor_brondatum_e26fd718_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype
    ADD CONSTRAINT datamodel_resultaatt_heeft_voor_brondatum_e26fd718_fk_datamodel FOREIGN KEY (heeft_voor_brondatum_archiefprocedure_relevante_id) REFERENCES public.datamodel_eigenschap(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot datamodel_resultaatt_resultaattype_id_1c6a4cd9_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_ziot
    ADD CONSTRAINT datamodel_resultaatt_resultaattype_id_1c6a4cd9_fk_datamodel FOREIGN KEY (resultaattype_id) REFERENCES public.datamodel_resultaattype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_resultaattype_heeft_verplichte_zot datamodel_resultaatt_resultaattype_id_67f8522e_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_zot
    ADD CONSTRAINT datamodel_resultaatt_resultaattype_id_67f8522e_fk_datamodel FOREIGN KEY (resultaattype_id) REFERENCES public.datamodel_resultaattype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_resultaattype_heeft_verplichte_ziot datamodel_resultaatt_zaakinformatieobject_643fd18b_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_ziot
    ADD CONSTRAINT datamodel_resultaatt_zaakinformatieobject_643fd18b_fk_datamodel FOREIGN KEY (zaakinformatieobjecttype_id) REFERENCES public.datamodel_zaakinformatieobjecttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_resultaattype_heeft_verplichte_zot datamodel_resultaatt_zaakobjecttype_id_cc4b977e_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype_heeft_verplichte_zot
    ADD CONSTRAINT datamodel_resultaatt_zaakobjecttype_id_cc4b977e_fk_datamodel FOREIGN KEY (zaakobjecttype_id) REFERENCES public.datamodel_zaakobjecttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_resultaattype datamodel_resultaatt_zaaktype_id_c628e5a5_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_resultaattype
    ADD CONSTRAINT datamodel_resultaatt_zaaktype_id_c628e5a5_fk_datamodel FOREIGN KEY (zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_roltype datamodel_roltype_zaaktype_id_5faae113_fk_datamodel_zaaktype_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_roltype
    ADD CONSTRAINT datamodel_roltype_zaaktype_id_5faae113_fk_datamodel_zaaktype_id FOREIGN KEY (zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_statustype_checklistitem datamodel_statustype_checklistitem_id_ae510266_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_checklistitem
    ADD CONSTRAINT datamodel_statustype_checklistitem_id_ae510266_fk_datamodel FOREIGN KEY (checklistitem_id) REFERENCES public.datamodel_checklistitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_statustype_roltypen datamodel_statustype_roltype_id_f373c336_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_roltypen
    ADD CONSTRAINT datamodel_statustype_roltype_id_f373c336_fk_datamodel FOREIGN KEY (roltype_id) REFERENCES public.datamodel_roltype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_statustype_checklistitem datamodel_statustype_statustype_id_43ca98f5_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_checklistitem
    ADD CONSTRAINT datamodel_statustype_statustype_id_43ca98f5_fk_datamodel FOREIGN KEY (statustype_id) REFERENCES public.datamodel_statustype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_statustype_roltypen datamodel_statustype_statustype_id_9c4b2049_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype_roltypen
    ADD CONSTRAINT datamodel_statustype_statustype_id_9c4b2049_fk_datamodel FOREIGN KEY (statustype_id) REFERENCES public.datamodel_statustype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_statustype datamodel_statustype_zaaktype_id_8ef557a6_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_statustype
    ADD CONSTRAINT datamodel_statustype_zaaktype_id_8ef557a6_fk_datamodel FOREIGN KEY (zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakinformatieobjecttype datamodel_zaakinform_informatie_object_ty_28a1966f_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttype
    ADD CONSTRAINT datamodel_zaakinform_informatie_object_ty_28a1966f_fk_datamodel FOREIGN KEY (informatie_object_type_id) REFERENCES public.datamodel_informatieobjecttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime datamodel_zaakinform_resultaattype_id_4179cf41_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttypearchiefregime
    ADD CONSTRAINT datamodel_zaakinform_resultaattype_id_4179cf41_fk_datamodel FOREIGN KEY (resultaattype_id) REFERENCES public.datamodel_resultaattype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakinformatieobjecttype datamodel_zaakinform_status_type_id_f2a27f1e_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttype
    ADD CONSTRAINT datamodel_zaakinform_status_type_id_f2a27f1e_fk_datamodel FOREIGN KEY (status_type_id) REFERENCES public.datamodel_statustype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakinformatieobjecttypearchiefregime datamodel_zaakinform_zaak_informatieobjec_f411d96e_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttypearchiefregime
    ADD CONSTRAINT datamodel_zaakinform_zaak_informatieobjec_f411d96e_fk_datamodel FOREIGN KEY (zaak_informatieobject_type_id) REFERENCES public.datamodel_zaakinformatieobjecttype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakinformatieobjecttype datamodel_zaakinform_zaaktype_id_d4c2e930_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakinformatieobjecttype
    ADD CONSTRAINT datamodel_zaakinform_zaaktype_id_d4c2e930_fk_datamodel FOREIGN KEY (zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakobjecttype datamodel_zaakobject_is_relevant_voor_id_7c0a6278_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobjecttype
    ADD CONSTRAINT datamodel_zaakobject_is_relevant_voor_id_7c0a6278_fk_datamodel FOREIGN KEY (is_relevant_voor_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaakobjecttype datamodel_zaakobject_status_type_id_8aa0c1fb_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaakobjecttype
    ADD CONSTRAINT datamodel_zaakobject_status_type_id_8aa0c1fb_fk_datamodel FOREIGN KEY (status_type_id) REFERENCES public.datamodel_statustype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaaktype datamodel_zaaktype_broncatalogus_id_87035d6a_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype
    ADD CONSTRAINT datamodel_zaaktype_broncatalogus_id_87035d6a_fk_datamodel FOREIGN KEY (broncatalogus_id) REFERENCES public.datamodel_broncatalogus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaaktype datamodel_zaaktype_bronzaaktype_id_de38bd13_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype
    ADD CONSTRAINT datamodel_zaaktype_bronzaaktype_id_de38bd13_fk_datamodel FOREIGN KEY (bronzaaktype_id) REFERENCES public.datamodel_bronzaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaaktype datamodel_zaaktype_catalogus_id_f664a917_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype
    ADD CONSTRAINT datamodel_zaaktype_catalogus_id_f664a917_fk_datamodel FOREIGN KEY (catalogus_id) REFERENCES public.datamodel_catalogus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaaktype_formulier datamodel_zaaktype_f_formulier_id_f1956fc6_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_formulier
    ADD CONSTRAINT datamodel_zaaktype_f_formulier_id_f1956fc6_fk_datamodel FOREIGN KEY (formulier_id) REFERENCES public.datamodel_formulier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaaktype_formulier datamodel_zaaktype_f_zaaktype_id_78080929_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_formulier
    ADD CONSTRAINT datamodel_zaaktype_f_zaaktype_id_78080929_fk_datamodel FOREIGN KEY (zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaaktype_is_deelzaaktype_van datamodel_zaaktype_i_from_zaaktype_id_7f6fe120_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_is_deelzaaktype_van
    ADD CONSTRAINT datamodel_zaaktype_i_from_zaaktype_id_7f6fe120_fk_datamodel FOREIGN KEY (from_zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaaktype_is_deelzaaktype_van datamodel_zaaktype_i_to_zaaktype_id_2fe006ca_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktype_is_deelzaaktype_van
    ADD CONSTRAINT datamodel_zaaktype_i_to_zaaktype_id_2fe006ca_fk_datamodel FOREIGN KEY (to_zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: datamodel_zaaktypenrelatie datamodel_zaaktypenr_zaaktype_id_649993b7_fk_datamodel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datamodel_zaaktypenrelatie
    ADD CONSTRAINT datamodel_zaaktypenr_zaaktype_id_649993b7_fk_datamodel FOREIGN KEY (zaaktype_id) REFERENCES public.datamodel_zaaktype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: notifications_subscription notifications_subscr_config_id_3567b13c_fk_notificat; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications_subscription
    ADD CONSTRAINT notifications_subscr_config_id_3567b13c_fk_notificat FOREIGN KEY (config_id) REFERENCES public.notifications_notificationsconfig(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--
