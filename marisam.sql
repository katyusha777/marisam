--
-- PostgreSQL database dump
--

-- Dumped from database version 13.14
-- Dumped by pg_dump version 13.14

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
-- Name: action_events; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.action_events (
    id uuid NOT NULL,
    batch_id character(36) NOT NULL,
    user_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    actionable_id uuid,
    actionable_type character varying(255),
    target_id uuid,
    target_type character varying(255),
    model_type character varying(255) NOT NULL,
    model_id uuid,
    fields text NOT NULL,
    status character varying(25) DEFAULT 'running'::character varying NOT NULL,
    exception text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    original text,
    changes text
);


ALTER TABLE public.action_events OWNER TO katyusha;

--
-- Name: annual_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annual_reports (
    id uuid NOT NULL,
    title character varying,
    file character varying,
    image character varying
);


ALTER TABLE public.annual_reports OWNER TO postgres;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.articles (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    image text NOT NULL,
    body text NOT NULL,
    category_id uuid,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.articles OWNER TO katyusha;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.categories (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.categories OWNER TO katyusha;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO katyusha;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: katyusha
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO katyusha;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: katyusha
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: faqs; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.faqs (
    id uuid NOT NULL,
    question character varying(255) NOT NULL,
    answer text NOT NULL,
    type character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.faqs OWNER TO katyusha;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO katyusha;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: katyusha
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO katyusha;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: katyusha
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: nova_field_attachments; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.nova_field_attachments (
    id integer NOT NULL,
    attachable_id uuid NOT NULL,
    attachable_type character varying(255) NOT NULL,
    attachment character varying(255) NOT NULL,
    disk character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.nova_field_attachments OWNER TO katyusha;

--
-- Name: nova_field_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: katyusha
--

CREATE SEQUENCE public.nova_field_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nova_field_attachments_id_seq OWNER TO katyusha;

--
-- Name: nova_field_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: katyusha
--

ALTER SEQUENCE public.nova_field_attachments_id_seq OWNED BY public.nova_field_attachments.id;


--
-- Name: nova_notifications; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.nova_notifications (
    id uuid NOT NULL,
    type character varying(255) NOT NULL,
    notifiable_id uuid NOT NULL,
    notifiable_type character varying(255) NOT NULL,
    data text NOT NULL,
    read_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.nova_notifications OWNER TO katyusha;

--
-- Name: nova_pending_field_attachments; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.nova_pending_field_attachments (
    id integer NOT NULL,
    draft_id character varying(255) NOT NULL,
    attachment character varying(255) NOT NULL,
    disk character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.nova_pending_field_attachments OWNER TO katyusha;

--
-- Name: nova_pending_field_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: katyusha
--

CREATE SEQUENCE public.nova_pending_field_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nova_pending_field_attachments_id_seq OWNER TO katyusha;

--
-- Name: nova_pending_field_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: katyusha
--

ALTER SEQUENCE public.nova_pending_field_attachments_id_seq OWNED BY public.nova_pending_field_attachments.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.pages (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    header_image character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    body text NOT NULL,
    parent_id uuid,
    blocks json,
    is_frontpage boolean DEFAULT false NOT NULL,
    is_cta_page boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.pages OWNER TO katyusha;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO katyusha;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO katyusha;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: katyusha
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO katyusha;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: katyusha
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: quotes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotes (
    id uuid NOT NULL,
    text text NOT NULL,
    author_name character varying(255) NOT NULL,
    author_image character varying(255),
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.quotes OWNER TO postgres;

--
-- Name: timelines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timelines (
    year integer,
    title character varying,
    text text,
    image character varying,
    id uuid NOT NULL
);


ALTER TABLE public.timelines OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: katyusha
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO katyusha;

--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: nova_field_attachments id; Type: DEFAULT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.nova_field_attachments ALTER COLUMN id SET DEFAULT nextval('public.nova_field_attachments_id_seq'::regclass);


--
-- Name: nova_pending_field_attachments id; Type: DEFAULT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.nova_pending_field_attachments ALTER COLUMN id SET DEFAULT nextval('public.nova_pending_field_attachments_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Data for Name: action_events; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.action_events (id, batch_id, user_id, name, actionable_id, actionable_type, target_id, target_type, model_type, model_id, fields, status, exception, created_at, updated_at, original, changes) FROM stdin;
\.


--
-- Data for Name: annual_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annual_reports (id, title, file, image) FROM stdin;
915841f6-232b-492a-b154-042c887f1cd8	Fire to The Prisons	vUtGLDmGRN5h019NNXB32eVJ0DqgXDJsg4fsCxUR.pdf	OGhBkKZSCbQr0jtjAkx7twuf8PXpPBB9aI4ZF1RS.png
c6ca4e98-90fe-4304-a592-58282e3d33e7	Fire to The Prisons #3	s7WhMpMXLwQ43qTwn26mLXErEVpcJ4hBBb3iLkdI.pdf	xbiKMaPXm5fgVR117r7OrFgA1B4mMwQfTJgDXgmx.png
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.articles (id, title, slug, image, body, category_id, created_at, updated_at) FROM stdin;
9866e4dd-3b2f-4249-b8e2-ebbaf23ca0e4	Ending Mass Incarceration: Social Interventions That Work	ending-mass-incarceration	Y68GNXAdRTvOrHpwLlMFGYFqjx7ko6FPHaXhXUSh.jpg	**Ending Mass Incarceration: Social Interventions That Work**\r\n\r\n### Outline\r\n\r\n1. **Introduction**\r\n   - Overview of Mass Incarceration in America\r\n   - Importance of Addressing Mass Incarceration\r\n\r\n2. **Historical Context**\r\n   - The War on Drugs and its Impact\r\n   - Racial Disparities in Incarceration Rates\r\n\r\n3. **The Human Cost of Mass Incarceration**\r\n   - Stories of Political Prisoners\r\n   - Psychological and Social Impact on Prisoners and Families\r\n\r\n4. **Failed Policies and Practices**\r\n   - Mandatory Minimum Sentencing\r\n   - Three Strikes Law\r\n\r\n5. **Successful Social Interventions**\r\n   - Community-Based Alternatives\r\n   - Restorative Justice Programs\r\n\r\n6. **Education and Rehabilitation Programs**\r\n   - Educational Opportunities in Prisons\r\n   - Vocational Training and Job Placement\r\n\r\n7. **Mental Health and Substance Abuse Treatment**\r\n   - Access to Mental Health Services\r\n   - Substance Abuse Programs\r\n\r\n8. **Reentry Support**\r\n   - Transitional Housing\r\n   - Employment Support and Job Training\r\n\r\n9. **Policy Reforms**\r\n   - Sentencing Reform\r\n   - Decriminalization of Minor Offenses\r\n\r\n10. **Community Involvement**\r\n    - Grassroots Movements\r\n    - Support Networks for Ex-Prisoners\r\n\r\n11. **The Role of Technology**\r\n    - Electronic Monitoring as an Alternative\r\n    - Data-Driven Approaches to Reduce Recidivism\r\n\r\n12. **Case Studies of Successful Interventions**\r\n    - Examples from Various States\r\n    - International Comparisons\r\n\r\n13. **Challenges and Barriers**\r\n    - Resistance from Political and Law Enforcement Entities\r\n    - Funding and Resource Allocation\r\n\r\n14. **Future Directions**\r\n    - Innovative Approaches and Pilot Programs\r\n    - The Importance of Ongoing Advocacy and Education\r\n\r\n15. **Conclusion**\r\n    - Recap of Key Points\r\n    - The Path Forward to Ending Mass Incarceration\r\n\r\n16. **FAQs**\r\n    - Why is mass incarceration a significant issue in America?\r\n    - What are the main reasons behind the high incarceration rates?\r\n    - How can community-based alternatives reduce incarceration?\r\n    - What role does education play in reducing recidivism?\r\n    - What are some successful examples of reentry programs?\r\n\r\n---\r\n\r\n### **Ending Mass Incarceration: Social Interventions That Work**\r\n\r\n#### **Introduction**\r\n\r\nMass incarceration in America is a pressing issue that has profound social, economic, and moral implications. The U.S. has the highest incarceration rate in the world, with over 2 million people currently behind bars. This article explores the social interventions that can effectively address and reduce mass incarceration, offering hope for a more just and equitable society.\r\n\r\n#### **Historical Context**\r\n\r\nTo understand the current state of mass incarceration, it's essential to look back at the policies and practices that have led us here. The War on Drugs, initiated in the 1980s, significantly increased incarceration rates, particularly among African American communities. Harsh sentencing laws, including mandatory minimums and the Three Strikes Law, have disproportionately affected people of color, exacerbating racial disparities in the prison system.\r\n\r\n#### **The Human Cost of Mass Incarceration**\r\n\r\nThe human cost of mass incarceration is immense. Political prisoners, individuals imprisoned for their beliefs or activism, suffer greatly. Families are torn apart, and the psychological toll on prisoners can be devastating. Take, for example, the story of Angela Davis, a renowned political activist who was incarcerated in the 1970s. Her imprisonment highlighted the broader issues of racial and political injustice within the American legal system.\r\n\r\n#### **Failed Policies and Practices**\r\n\r\nMany of the policies designed to deter crime have failed, instead contributing to overcrowded prisons and prolonged sentences for non-violent offenders. Mandatory minimum sentencing laws remove judicial discretion, often leading to excessively harsh punishments. Similarly, the Three Strikes Law, which mandates life sentences for third-time offenders, regardless of the severity of the crime, has resulted in unjust and disproportionate penalties.\r\n\r\n#### **Successful Social Interventions**\r\n\r\nCommunity-based alternatives to incarceration have shown promising results. Programs that keep individuals in their communities while providing support and supervision can reduce recidivism and promote rehabilitation. Restorative justice programs, which focus on repairing harm and involving all stakeholders in the process, offer a more humane and effective approach to justice.\r\n\r\n#### **Education and Rehabilitation Programs**\r\n\r\nEducation is a powerful tool in reducing recidivism. Providing prisoners with access to educational opportunities, from GED programs to college courses, helps them gain the skills needed for successful reentry into society. Vocational training and job placement services further enhance their prospects, reducing the likelihood of reoffending.\r\n\r\n#### **Mental Health and Substance Abuse Treatment**\r\n\r\nMany incarcerated individuals suffer from mental health issues and substance abuse disorders. Effective interventions must include access to mental health services and comprehensive substance abuse programs. Treating these underlying issues can significantly decrease the rates of reoffending and improve overall outcomes for individuals and their communities.\r\n\r\n#### **Reentry Support**\r\n\r\nSuccessful reentry into society requires robust support systems. Transitional housing provides a stable environment for individuals as they reintegrate. Employment support and job training programs are crucial in helping ex-prisoners secure meaningful employment, which is a critical factor in preventing recidivism.\r\n\r\n#### **Policy Reforms**\r\n\r\nPolicy reforms are essential to address the root causes of mass incarceration. Sentencing reform, including the reduction or elimination of mandatory minimums, can ensure more proportionate and fair sentencing. Decriminalizing minor offenses, such as drug possession, can significantly reduce the prison population.\r\n\r\n#### **Community Involvement**\r\n\r\nGrassroots movements and community involvement are vital in the fight against mass incarceration. Organizations and support networks for ex-prisoners provide essential services and advocacy, helping to create a more supportive environment for reintegration. Community engagement also fosters a greater understanding of the issues and drives systemic change.\r\n\r\n#### **The Role of Technology**\r\n\r\nTechnology offers new ways to address mass incarceration. Electronic monitoring can serve as an alternative to incarceration for non-violent offenders, allowing them to remain in their communities under supervision. Data-driven approaches can help identify trends and inform policies aimed at reducing recidivism.\r\n\r\n#### **Case Studies of Successful Interventions**\r\n\r\nSeveral states have implemented successful interventions that can serve as models for broader reform. For	88944181-9e52-4333-969f-c81ff88f42ea	2024-06-20 10:48:53	2024-06-20 12:07:10
9bf52e75-7e85-4e59-8e7c-a7286274f68b	Effective Alternatives To Youth Incarceration	effective-alternatives	VDsZTmRTUxf8CFYSCI3CSytNFCxWBqY9ErwPP24o.jpg	**Effective Alternatives To Youth Incarceration**\r\n\r\n### Outline\r\n\r\n1. **Introduction**\r\n   - Overview of Youth Incarceration Issues\r\n   - Importance of Finding Alternatives\r\n\r\n2. **Community-Based Programs**\r\n   - Mentorship and Counseling\r\n   - Community Service Initiatives\r\n\r\n3. **Educational and Vocational Training**\r\n   - School-Based Interventions\r\n   - Job Training Programs\r\n\r\n4. **Restorative Justice**\r\n   - Principles of Restorative Justice\r\n   - Successful Case Examples\r\n\r\n5. **Mental Health and Substance Abuse Treatment**\r\n   - Access to Therapy and Counseling\r\n   - Substance Abuse Programs\r\n\r\n6. **Family and Social Support Systems**\r\n   - Role of Family in Rehabilitation\r\n   - Community Support Networks\r\n\r\n7. **Policy Recommendations**\r\n   - Legislative Reforms\r\n   - Funding and Resource Allocation\r\n\r\n8. **Conclusion**\r\n   - Summary of Key Points\r\n   - The Path Forward\r\n\r\n---\r\n\r\n### **Effective Alternatives To Youth Incarceration**\r\n\r\n#### **Introduction**\r\n\r\nYouth incarceration presents significant social and developmental challenges. Locking up young people often leads to more harm than good, perpetuating a cycle of criminal behavior and lost potential. Instead, focusing on effective alternatives can provide a more supportive and constructive path for these youths.\r\n\r\n#### **Community-Based Programs**\r\n\r\nCommunity-based programs offer personalized support through mentorship and counseling, helping at-risk youths navigate their challenges. Programs that involve community service initiatives not only hold young people accountable but also foster a sense of responsibility and community engagement.\r\n\r\n#### **Educational and Vocational Training**\r\n\r\nSchool-based interventions are crucial in preventing youth delinquency. By keeping youths engaged in education, we reduce their likelihood of reoffending. Vocational training programs equip them with job skills, enhancing their employability and providing a clear path to a stable future.\r\n\r\n#### **Restorative Justice**\r\n\r\nRestorative justice focuses on repairing harm rather than punishment. It involves the offender, the victim, and the community in the healing process. Successful examples include mediation and conflict resolution programs that emphasize accountability and reconciliation.\r\n\r\n#### **Mental Health and Substance Abuse Treatment**\r\n\r\nMany youths in the criminal justice system struggle with mental health issues and substance abuse. Providing access to therapy, counseling, and comprehensive substance abuse programs addresses these underlying problems, reducing the risk of reoffending.\r\n\r\n#### **Family and Social Support Systems**\r\n\r\nFamily plays a vital role in the rehabilitation of young offenders. Strengthening family ties and providing social support networks help youths feel connected and supported, which is essential for their emotional and psychological well-being.\r\n\r\n#### **Policy Recommendations**\r\n\r\nEffective alternatives require supportive legislation and adequate funding. Reforms should focus on reducing reliance on incarceration, promoting community-based interventions, and ensuring that resources are allocated to support these programs adequately.\r\n\r\n#### **Conclusion**\r\n\r\nBy implementing community-based programs, educational and vocational training, restorative justice, mental health and substance abuse treatment, and strengthening family support systems, we can offer more effective alternatives to youth incarceration. These approaches not only benefit the youths but also contribute to a healthier, more just society.	7264c025-346b-4c2f-ab98-9807da030e1c	2024-06-20 10:48:41	2024-06-20 12:09:33
237875c1-63f4-442c-bdf0-cfb3e795388a	Beyond Bars: A Path Forward From 50 Years Of Mass Incarceration In The United States	beyond-bars	CMmUG4JuMxrk5yo6c6gTWeyzEfLNCaPSFZhZbSrN.jpg	**Beyond Bars: A Path Forward From 50 Years Of Mass Incarceration In The United States**\r\n\r\n### Outline\r\n\r\n1. **Introduction**\r\n   - Brief Overview of Mass Incarceration\r\n   - Need for Change\r\n\r\n2. **Historical Overview**\r\n   - Key Policies and Their Impact\r\n\r\n3. **Consequences of Mass Incarceration**\r\n   - Social and Economic Costs\r\n\r\n4. **Successful Alternatives**\r\n   - Community Programs\r\n   - Rehabilitation Efforts\r\n\r\n5. **Policy Recommendations**\r\n   - Sentencing Reforms\r\n   - Support Systems\r\n\r\n6. **Conclusion**\r\n   - Summary and Call to Action\r\n\r\n---\r\n\r\n### **Beyond Bars: A Path Forward From 50 Years Of Mass Incarceration In The United States**\r\n\r\n#### **Introduction**\r\n\r\nMass incarceration in the United States, a result of tough-on-crime policies over the past 50 years, has created deep social and economic issues. It's time for a change.\r\n\r\n#### **Historical Overview**\r\n\r\nPolicies like the War on Drugs and mandatory minimum sentencing have led to an explosion in the prison population, disproportionately affecting minorities.\r\n\r\n#### **Consequences of Mass Incarceration**\r\n\r\nThe human and economic costs are staggering: broken families, community disintegration, and a massive financial burden on taxpayers.\r\n\r\n#### **Successful Alternatives**\r\n\r\nCommunity-based programs and rehabilitation efforts show promise. These alternatives focus on education, job training, and mental health support, reducing recidivism.\r\n\r\n#### **Policy Recommendations**\r\n\r\nReforming sentencing laws and investing in support systems are crucial steps. Emphasizing rehabilitation over punishment can lead to more just and effective outcomes.\r\n\r\n#### **Conclusion**\r\n\r\nAddressing mass incarceration requires comprehensive policy changes and community support. By focusing on rehabilitation and reform, we can pave the way for a more equitable future.	793b7b5b-b6c5-437a-83ac-0f3009cc5334	2024-06-20 10:48:20	2024-06-20 12:10:19
6f66a759-cb25-4fc4-b815-512b70df98d7	Effective Alternatives To Youth Incarceration	effective-alternatives-to-youth-incarceration	6SoFmIoDM7azlKArAQWORycX7wGEEJHZTqDWou3A.jpg	**Effective Alternatives To Youth Incarceration**\r\n\r\n### Outline\r\n\r\n1. **Introduction**\r\n   - Overview of Youth Incarceration Issues\r\n   - Importance of Finding Alternatives\r\n\r\n2. **Community-Based Programs**\r\n   - Mentorship and Counseling\r\n   - Community Service Initiatives\r\n\r\n3. **Educational and Vocational Training**\r\n   - School-Based Interventions\r\n   - Job Training Programs\r\n\r\n4. **Restorative Justice**\r\n   - Principles of Restorative Justice\r\n   - Successful Case Examples\r\n\r\n5. **Mental Health and Substance Abuse Treatment**\r\n   - Access to Therapy and Counseling\r\n   - Substance Abuse Programs\r\n\r\n6. **Family and Social Support Systems**\r\n   - Role of Family in Rehabilitation\r\n   - Community Support Networks\r\n\r\n7. **Policy Recommendations**\r\n   - Legislative Reforms\r\n   - Funding and Resource Allocation\r\n\r\n8. **Conclusion**\r\n   - Summary of Key Points\r\n   - The Path Forward\r\n\r\n---\r\n\r\n### **Effective Alternatives To Youth Incarceration**\r\n\r\n#### **Introduction**\r\n\r\nYouth incarceration presents significant social and developmental challenges. Locking up young people often leads to more harm than good, perpetuating a cycle of criminal behavior and lost potential. Instead, focusing on effective alternatives can provide a more supportive and constructive path for these youths.\r\n\r\n#### **Community-Based Programs**\r\n\r\nCommunity-based programs offer personalized support through mentorship and counseling, helping at-risk youths navigate their challenges. Programs that involve community service initiatives not only hold young people accountable but also foster a sense of responsibility and community engagement.\r\n\r\n#### **Educational and Vocational Training**\r\n\r\nSchool-based interventions are crucial in preventing youth delinquency. By keeping youths engaged in education, we reduce their likelihood of reoffending. Vocational training programs equip them with job skills, enhancing their employability and providing a clear path to a stable future.\r\n\r\n#### **Restorative Justice**\r\n\r\nRestorative justice focuses on repairing harm rather than punishment. It involves the offender, the victim, and the community in the healing process. Successful examples include mediation and conflict resolution programs that emphasize accountability and reconciliation.\r\n\r\n#### **Mental Health and Substance Abuse Treatment**\r\n\r\nMany youths in the criminal justice system struggle with mental health issues and substance abuse. Providing access to therapy, counseling, and comprehensive substance abuse programs addresses these underlying problems, reducing the risk of reoffending.\r\n\r\n#### **Family and Social Support Systems**\r\n\r\nFamily plays a vital role in the rehabilitation of young offenders. Strengthening family ties and providing social support networks help youths feel connected and supported, which is essential for their emotional and psychological well-being.\r\n\r\n#### **Policy Recommendations**\r\n\r\nEffective alternatives require supportive legislation and adequate funding. Reforms should focus on reducing reliance on incarceration, promoting community-based interventions, and ensuring that resources are allocated to support these programs adequately.\r\n\r\n#### **Conclusion**\r\n\r\nBy implementing community-based programs, educational and vocational training, restorative justice, mental health and substance abuse treatment, and strengthening family support systems, we can offer more effective alternatives to youth incarceration. These approaches not only benefit the youths but also contribute to a healthier, more just society.	7264c025-346b-4c2f-ab98-9807da030e1c	2024-07-31 17:46:22	2024-07-31 17:46:22
5d2d0d93-87de-498e-b2bc-5755ab3f3541	Ending Mass Incarceration: Social Interventions That Work	ending-mass-incarceration-social-interventions-that-work	mhWKsSBaMY93Z5h60rwSnGsMolZyJSj83spMNaFR.jpg	**Ending Mass Incarceration: Social Interventions That Work**\r\n\r\n### Outline\r\n\r\n1. **Introduction**\r\n   - Overview of Mass Incarceration in America\r\n   - Importance of Addressing Mass Incarceration\r\n\r\n2. **Historical Context**\r\n   - The War on Drugs and its Impact\r\n   - Racial Disparities in Incarceration Rates\r\n\r\n3. **The Human Cost of Mass Incarceration**\r\n   - Stories of Political Prisoners\r\n   - Psychological and Social Impact on Prisoners and Families\r\n\r\n4. **Failed Policies and Practices**\r\n   - Mandatory Minimum Sentencing\r\n   - Three Strikes Law\r\n\r\n5. **Successful Social Interventions**\r\n   - Community-Based Alternatives\r\n   - Restorative Justice Programs\r\n\r\n6. **Education and Rehabilitation Programs**\r\n   - Educational Opportunities in Prisons\r\n   - Vocational Training and Job Placement\r\n\r\n7. **Mental Health and Substance Abuse Treatment**\r\n   - Access to Mental Health Services\r\n   - Substance Abuse Programs\r\n\r\n8. **Reentry Support**\r\n   - Transitional Housing\r\n   - Employment Support and Job Training\r\n\r\n9. **Policy Reforms**\r\n   - Sentencing Reform\r\n   - Decriminalization of Minor Offenses\r\n\r\n10. **Community Involvement**\r\n    - Grassroots Movements\r\n    - Support Networks for Ex-Prisoners\r\n\r\n11. **The Role of Technology**\r\n    - Electronic Monitoring as an Alternative\r\n    - Data-Driven Approaches to Reduce Recidivism\r\n\r\n12. **Case Studies of Successful Interventions**\r\n    - Examples from Various States\r\n    - International Comparisons\r\n\r\n13. **Challenges and Barriers**\r\n    - Resistance from Political and Law Enforcement Entities\r\n    - Funding and Resource Allocation\r\n\r\n14. **Future Directions**\r\n    - Innovative Approaches and Pilot Programs\r\n    - The Importance of Ongoing Advocacy and Education\r\n\r\n15. **Conclusion**\r\n    - Recap of Key Points\r\n    - The Path Forward to Ending Mass Incarceration\r\n\r\n16. **FAQs**\r\n    - Why is mass incarceration a significant issue in America?\r\n    - What are the main reasons behind the high incarceration rates?\r\n    - How can community-based alternatives reduce incarceration?\r\n    - What role does education play in reducing recidivism?\r\n    - What are some successful examples of reentry programs?\r\n\r\n---\r\n\r\n### **Ending Mass Incarceration: Social Interventions That Work**\r\n\r\n#### **Introduction**\r\n\r\nMass incarceration in America is a pressing issue that has profound social, economic, and moral implications. The U.S. has the highest incarceration rate in the world, with over 2 million people currently behind bars. This article explores the social interventions that can effectively address and reduce mass incarceration, offering hope for a more just and equitable society.\r\n\r\n#### **Historical Context**\r\n\r\nTo understand the current state of mass incarceration, it's essential to look back at the policies and practices that have led us here. The War on Drugs, initiated in the 1980s, significantly increased incarceration rates, particularly among African American communities. Harsh sentencing laws, including mandatory minimums and the Three Strikes Law, have disproportionately affected people of color, exacerbating racial disparities in the prison system.\r\n\r\n#### **The Human Cost of Mass Incarceration**\r\n\r\nThe human cost of mass incarceration is immense. Political prisoners, individuals imprisoned for their beliefs or activism, suffer greatly. Families are torn apart, and the psychological toll on prisoners can be devastating. Take, for example, the story of Angela Davis, a renowned political activist who was incarcerated in the 1970s. Her imprisonment highlighted the broader issues of racial and political injustice within the American legal system.\r\n\r\n#### **Failed Policies and Practices**\r\n\r\nMany of the policies designed to deter crime have failed, instead contributing to overcrowded prisons and prolonged sentences for non-violent offenders. Mandatory minimum sentencing laws remove judicial discretion, often leading to excessively harsh punishments. Similarly, the Three Strikes Law, which mandates life sentences for third-time offenders, regardless of the severity of the crime, has resulted in unjust and disproportionate penalties.\r\n\r\n#### **Successful Social Interventions**\r\n\r\nCommunity-based alternatives to incarceration have shown promising results. Programs that keep individuals in their communities while providing support and supervision can reduce recidivism and promote rehabilitation. Restorative justice programs, which focus on repairing harm and involving all stakeholders in the process, offer a more humane and effective approach to justice.\r\n\r\n#### **Education and Rehabilitation Programs**\r\n\r\nEducation is a powerful tool in reducing recidivism. Providing prisoners with access to educational opportunities, from GED programs to college courses, helps them gain the skills needed for successful reentry into society. Vocational training and job placement services further enhance their prospects, reducing the likelihood of reoffending.\r\n\r\n#### **Mental Health and Substance Abuse Treatment**\r\n\r\nMany incarcerated individuals suffer from mental health issues and substance abuse disorders. Effective interventions must include access to mental health services and comprehensive substance abuse programs. Treating these underlying issues can significantly decrease the rates of reoffending and improve overall outcomes for individuals and their communities.\r\n\r\n#### **Reentry Support**\r\n\r\nSuccessful reentry into society requires robust support systems. Transitional housing provides a stable environment for individuals as they reintegrate. Employment support and job training programs are crucial in helping ex-prisoners secure meaningful employment, which is a critical factor in preventing recidivism.\r\n\r\n#### **Policy Reforms**\r\n\r\nPolicy reforms are essential to address the root causes of mass incarceration. Sentencing reform, including the reduction or elimination of mandatory minimums, can ensure more proportionate and fair sentencing. Decriminalizing minor offenses, such as drug possession, can significantly reduce the prison population.\r\n\r\n#### **Community Involvement**\r\n\r\nGrassroots movements and community involvement are vital in the fight against mass incarceration. Organizations and support networks for ex-prisoners provide essential services and advocacy, helping to create a more supportive environment for reintegration. Community engagement also fosters a greater understanding of the issues and drives systemic change.\r\n\r\n#### **The Role of Technology**\r\n\r\nTechnology offers new ways to address mass incarceration. Electronic monitoring can serve as an alternative to incarceration for non-violent offenders, allowing them to remain in their communities under supervision. Data-driven approaches can help identify trends and inform policies aimed at reducing recidivism.\r\n\r\n#### **Case Studies of Successful Interventions**\r\n\r\nSeveral states have implemented successful interventions that can serve as models for broader reform. For	88944181-9e52-4333-969f-c81ff88f42ea	2024-07-31 17:46:41	2024-07-31 17:46:41
b9313b93-fd7a-412d-bbb1-a0ce5ccb7495	Beyond Bars: A Path Forward From 50 Years Of Mass Incarceration In The United States	beyond-bars-a-path-forward-from-50-years-of-mass-incarceration-in-the-united-states	PWFEPbFbmdJS6Vl7PAXMuJVzgzjbVpMaZPf5regM.jpg	**Beyond Bars: A Path Forward From 50 Years Of Mass Incarceration In The United States**\r\n\r\n### Outline\r\n\r\n1. **Introduction**\r\n   - Brief Overview of Mass Incarceration\r\n   - Need for Change\r\n\r\n2. **Historical Overview**\r\n   - Key Policies and Their Impact\r\n\r\n3. **Consequences of Mass Incarceration**\r\n   - Social and Economic Costs\r\n\r\n4. **Successful Alternatives**\r\n   - Community Programs\r\n   - Rehabilitation Efforts\r\n\r\n5. **Policy Recommendations**\r\n   - Sentencing Reforms\r\n   - Support Systems\r\n\r\n6. **Conclusion**\r\n   - Summary and Call to Action\r\n\r\n---\r\n\r\n### **Beyond Bars: A Path Forward From 50 Years Of Mass Incarceration In The United States**\r\n\r\n#### **Introduction**\r\n\r\nMass incarceration in the United States, a result of tough-on-crime policies over the past 50 years, has created deep social and economic issues. It's time for a change.\r\n\r\n#### **Historical Overview**\r\n\r\nPolicies like the War on Drugs and mandatory minimum sentencing have led to an explosion in the prison population, disproportionately affecting minorities.\r\n\r\n#### **Consequences of Mass Incarceration**\r\n\r\nThe human and economic costs are staggering: broken families, community disintegration, and a massive financial burden on taxpayers.\r\n\r\n#### **Successful Alternatives**\r\n\r\nCommunity-based programs and rehabilitation efforts show promise. These alternatives focus on education, job training, and mental health support, reducing recidivism.\r\n\r\n#### **Policy Recommendations**\r\n\r\nReforming sentencing laws and investing in support systems are crucial steps. Emphasizing rehabilitation over punishment can lead to more just and effective outcomes.\r\n\r\n#### **Conclusion**\r\n\r\nAddressing mass incarceration requires comprehensive policy changes and community support. By focusing on rehabilitation and reform, we can pave the way for a more equitable future.	793b7b5b-b6c5-437a-83ac-0f3009cc5334	2024-07-31 17:47:02	2024-07-31 17:47:02
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.categories (id, title, slug, created_at, updated_at) FROM stdin;
793b7b5b-b6c5-437a-83ac-0f3009cc5334	Publications	publications	2024-06-20 10:44:54	2024-06-20 10:44:54
7264c025-346b-4c2f-ab98-9807da030e1c	Report	report	2024-06-20 10:44:58	2024-06-20 10:44:58
88944181-9e52-4333-969f-c81ff88f42ea	Policy Brief	policy-brief	2024-06-20 10:45:06	2024-06-20 10:45:06
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: faqs; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.faqs (id, question, answer, type, created_at, updated_at) FROM stdin;
c35e6493-8a3b-477b-8fbc-f8ceb851607f	Why is Writing Letters to Political Prisoners Important?	Our fellow citizens languishing in the Russian prisons or detention centers in the occupied Crimea are increasingly facing problems with their psychological health.\r\n\r\nThey are psychologically and physically abused by the prison administrations and their cellmates on account of their nationality and political views. A number of political prisoners have serious illnesses and disabilities. They are not provided with proper medical care even after being tortured.\r\n\r\nPreviously, we shared with you information on the deaths of Dzhemil Gafarov and Konstantin Shiring. Prison sentences meted out by Russian courts to elderly Ukrainians and Crimean Tatars tend to be too long; hence, they run the risk of not making it out alive.\r\n\r\nA letter is a sign that a political prisoner is remembered and cared for. It sends a signal not only to your addressee but also to the prison administration. Your letter will have a human rights effect, too. For the prison administrations, this is an important message that a political prisoner is still in the public eye and that their human rights cannot be violated. And if they are, human rights activists and journalists will immediately report it.	map	2024-08-19 18:56:57	2024-08-19 20:05:46
18dd3bc0-4d7f-4a75-8973-2acadad0050a	What Should You Write About in Your Letter?	Begin your letter by providing some information about yourself: where you work or study and what you do in your free time. Write about what motivated you to reach out to this particular person. If you have read any interesting facts about the political prisoner or you share some common interests with them, you can write about that, too. Do not write anonymously. If you don't want to reveal your real identity, you should choose an alias. Political prisoners get a lot of letters and they may not remember getting one from you when they read your next letter.\r\n\r\nYou can write about whatever you feel like sharing. For example, what's happening around you and in the world, about movies, books, travel, nature, or work. You can share some emotional/funny stories or your impressions of them. When you are in prison, everything is gray and monotonous; hence, prisoners need to get some vivid images and feelings.\r\n\r\nAsk questions. This will provide your penpal with an opportunity to express their thoughts, feelings, and views or to speak out on certain issues. Many political prisoners are educated people and they will definitely have some interesting information to share with you.\r\n\r\nYou can send them news articles, stories, or excerpts from someone's memoirs. You can even share posts written by some famous people (except for ones that will definitely get censored, such as posts of Ukrainian politicians). It'll also be nice for the political prisoners to receive postcards from places far away.\r\n\r\nYou can share news or interviews with interesting people, provide tips on improving health indoors, cite poems, or tell short stories. Your children can draw pictures, too.\r\n\r\nYou can send educational materials, such as drawing or board game instructions, math problems, tests, etc. It would also be a good idea to congratulate a political prisoner on his or her birthdayі.\r\n\r\nMake sure your handwriting is legible: use a nice pen and white paper. Indicate the date of writing and number the letters (if there’s more than one of them). That will help your penpal keep your correspondence in chronological order.\r\n\r\nIf you send emails, the history of your correspondence will always be ‘at your fingertips’. If you use postal mail, you should make brief copies of your letters or take pictures of them. Postal letters arrive at long intervals, so you may forget what you wrote about in your previous ones. And you will definitely get confused if you correspond with several political prisoners.\r\n\r\nIf you are not in Ukraine, you can also send board games, such as chess or checkers. However, you need to make sure that the pieces are made of plastic and have no magnets inside. Please, keep in mind that Russian prison guards disallow card games and backgammon.\r\n\r\nFurthermore, it is possible to send pens and pencils to Kremlin prisoners, but only in black or blue colors. Colored pencils, erasers, and pencil sharpeners are prohibited. It is also permitted to send A4 paper to the prisoners, however, it must be folded as Russian prisons only allow small envelopes, not A4 format.\r\n \r\nIf you have not decided to whom exactly to write a letter, but you still want to support political prisoners, you can not indicate a specific addressee, since political prisoners (especially in places of deprivation of liberty in Crimea) are often held together by several people in one cell, so they will be able to read your letter together.	map	2024-08-19 20:15:13	2024-08-19 20:15:13
3fb6cb0a-b12a-43eb-8e67-2965528331a7	What Letters Get Screened by Prison Censors?	All your letters and images will be checked by a censor before being passed on to your addressee. The censor may redact or remove the information in your letter. If they don't like something in it, your letter may end up not reaching the intended recipient at all. Hence, you should follow these rules:\r\n\r\nWrite in Russian: If the censor does not understand something, your letter will not reach the addressee.\r\n\r\nKeep your letters politically neutral.\r\n\r\nRefrain from asking questions about criminal cases (sometimes, it can do damage).\r\n\r\nDo not write anything that could compromise you or the recipient.\r\n\r\nDo not use ciphers, obscure symbols, or abbreviations.\r\n\r\nDo not use obscenities, insults, erotic or pornographic descriptions.\r\n\r\nDo not call for escape and other illegal actions (even jokingly), nor write disparagingly about the prison administration or personnel handling the political prisoner’s case (this will primarily damage you).\r\n\r\nPlease, keep in mind that censors in some correctional facilities disallow poems and cross out names in the letters.	map	2024-08-19 20:15:38	2024-08-19 20:15:38
71aec585-2d33-4e23-a833-2f385d7a59aa	Are There Any Restrictions on Letter Formats and Length?	There are no restrictions on the amount of text in letters or their format. You can even send a folded A2 size paper and it should be accepted.\r\n\r\nTo save money, you can make your own envelope using an A4 size paper (instructions are available on the Internet). You need to glue it well and then put some stamps on it.\r\n\r\nIf the detainee is transferred to another pre-trial detention center or prison camp prior to receiving the letter, your letter should be sent back within three days after receipt.\r\n\r\nLetters to political prisoners may not be delivered on purpose. In this case, you can file a complaint with the prison camp administration.	map	2024-08-19 20:15:50	2024-08-19 20:15:50
ca87f211-b9ed-413f-b56e-53f07eadd0ce	FAQ page test	FAQ page test	faq	2024-09-02 23:33:28	2024-09-02 23:33:28
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.migrations (id, migration, batch) FROM stdin;
14	2014_10_12_000000_create_users_table	1
15	2014_10_12_100000_create_password_reset_tokens_table	1
16	2018_01_01_000000_create_action_events_table	1
17	2019_02_08_105647_create_blocks_contents_tables	1
18	2019_05_10_000000_add_fields_to_action_events_table	1
19	2019_08_19_000000_create_failed_jobs_table	1
20	2019_12_14_000001_create_personal_access_tokens_table	1
21	2021_08_25_193039_create_nova_notifications_table	1
22	2021_11_12_153947_remove_blocks_contents_tables	1
23	2022_04_26_000000_add_fields_to_nova_notifications_table	1
24	2022_12_19_000000_create_field_attachments_table	1
25	2024_03_30_185628_create_categories_table	1
26	2024_03_30_185721_create_articles_table	1
27	2024_03_30_190048_create_pages_table	1
28	2024_08_19_165446_create_faqs_table	2
29	2024_07_07_000000_create_quotes_table	2
\.


--
-- Data for Name: nova_field_attachments; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.nova_field_attachments (id, attachable_id, attachable_type, attachment, disk, url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: nova_notifications; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.nova_notifications (id, type, notifiable_id, notifiable_type, data, read_at, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: nova_pending_field_attachments; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.nova_pending_field_attachments (id, draft_id, attachment, disk, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.pages (id, title, header_image, slug, body, parent_id, blocks, is_frontpage, is_cta_page, created_at, updated_at) FROM stdin;
0f1dffcc-50b0-4181-84ac-2bf1328a1b1d	Board of Directors	2yJ1IZjBGvAki9U1wV5uYIyeY5aMdhfRSVdULsEM.jpg	board-of-directors	The National Political Prisoner Coalition is governed by a diverse and dedicated Board of Directors, comprising individuals with extensive experience in human rights advocacy, legal affairs, and public policy. Our board members bring a wealth of knowledge and a shared commitment to justice and equality.\r\n\r\n- **Jane Doe, Chairperson**: A renowned human rights lawyer with over 20 years of experience.\r\n- **John Smith, Vice Chairperson**: A former political prisoner and activist.\r\n- **Dr. Emily Johnson**: A sociologist specializing in mass incarceration and racial justice.\r\n- **Michael Lee**: A community organizer and policy advocate.\r\n- **Sara Ahmed**: An expert in international human rights law.\r\n\r\nOur Board of Directors plays a crucial role in guiding NPPC's strategic direction and ensuring that our mission is fulfilled with integrity and impact.	84ef0de1-9ab9-4e5f-bef6-79629f4e9eeb	\N	f	f	2024-06-20 12:40:57	2024-06-20 12:40:57
2e1efe5d-9c37-4af7-aece-a48dd52f103e	Staff	4W5Dpeub1ZTLqAyhK8NLad2az8c3yciCUGPxdgrm.jpg	staff	The NPPC team is composed of passionate professionals dedicated to advocating for political prisoners and advancing human rights. Our staff includes legal experts, researchers, communications specialists, and community organizers who work tirelessly to support our mission.\r\n\r\n- **Executive Director**: Alex Martinez\r\n- **Legal Director**: Dr. Laura Green\r\n- **Communications Manager**: Priya Patel\r\n- **Community Outreach Coordinator**: Marcus Thompson\r\n- **Research Analyst**: Mei Wong\r\n\r\nOur team collaborates with a wide network of volunteers and partner organizations to maximize our reach and effectiveness in advocating for those unjustly imprisoned for their political beliefs.	84ef0de1-9ab9-4e5f-bef6-79629f4e9eeb	\N	f	f	2024-06-20 13:08:02	2024-06-20 13:08:02
a6b42512-fa2c-4e8c-8869-00bedca89146	Partners	19ByJnCBtUGLg0w85s3BpplCYUDV6kfVt6vbK6Am.jpg	partners	The NPPC partners with a range of organizations and advocacy groups to strengthen our efforts and broaden our impact. Our partners include:\r\n\r\n- **Amnesty International**: Collaborating on global human rights campaigns.\r\n- **Human Rights Watch**: Joint research and advocacy initiatives.\r\n- **Prison Policy Initiative**: Providing data and analysis on mass incarceration.\r\n- **Freedom House**: Supporting international advocacy for political prisoners.\r\n- **ACLU**: Legal assistance and policy advocacy.\r\n\r\nThrough these partnerships, we are able to leverage resources, share expertise, and amplify our collective voice to better support political prisoners and advocate for systemic change.	84ef0de1-9ab9-4e5f-bef6-79629f4e9eeb	\N	f	f	2024-06-20 13:08:19	2024-06-20 13:08:19
25c0c833-5e55-46be-934b-1a4cfb2d6e1c	Careers & Internships	1uQMtNS0jqZqKM0txLKDZgYSs8qzuFyqucsFGG2Q.jpg	careers-internships	At NPPC, we are always looking for passionate individuals to join our team and contribute to our mission. We offer a range of career and internship opportunities in various fields, including legal advocacy, research, communications, and community outreach.\r\n\r\n**Current Openings:**\r\n- **Legal Intern**: Assist with case research and legal documentation.\r\n- **Communications Specialist**: Develop and implement media campaigns.\r\n- **Research Assistant**: Conduct data analysis and report writing.\r\n- **Outreach Coordinator**: Engage with communities and support local advocacy efforts.\r\n\r\nTo apply or learn more about our career and internship opportunities, please visit our [Careers page](https://nppc.org/careers).	84ef0de1-9ab9-4e5f-bef6-79629f4e9eeb	\N	f	f	2024-06-20 13:08:37	2024-06-20 13:08:37
2071c050-1c49-4361-a334-eb8e3726778c	FAQ	eBRmlJSrhfQhchk2Gcp3RptGNuvzrj0XpeTPhw6o.jpg	faq	**Q: What is the National Political Prisoner Coalition?**\r\nA: NPPC is an organization dedicated to advocating for the rights and release of political prisoners in the United States.\r\n\r\n**Q: Who are considered political prisoners?**\r\nA: Political prisoners are individuals imprisoned for their political beliefs, actions, or affiliations, particularly those challenging systemic injustices.\r\n\r\n**Q: How can I get involved with NPPC?**\r\nA: You can get involved by volunteering, donating, participating in our events, or joining our advocacy campaigns. Visit our [Get Involved page](https://nppc.org/get-involved) for more information.\r\n\r\n**Q: Does NPPC provide legal assistance?**\r\nA: Yes, we offer legal support to political prisoners and their families through our network of legal experts and partner organizations.\r\n\r\n**Q: How can I support the families of political prisoners?**\r\nA: You can support families by donating to our relief fund, volunteering for community support programs, or advocating for policy changes that benefit political prisoners and their families.	84ef0de1-9ab9-4e5f-bef6-79629f4e9eeb	\N	f	f	2024-06-20 13:08:51	2024-06-20 13:08:51
5d4916cf-2aa4-4076-ba28-c5652d4a73d5	Get Involved	cH4fniL9pOLrL2kq1IoxeMRdad9wkZ5HETm6ZsmN.jpg	get-involved	Join us in the fight for justice and the rights of political prisoners. Your involvement can make a significant impact. Here are some ways you can get involved:\r\n\r\n- **Volunteer**: Offer your time and skills to support our campaigns and events.\r\n- **Donate**: Contributions help fund legal assistance, advocacy efforts, and support for families of political prisoners.\r\n- **Advocate**: Raise awareness by sharing our message on social media, contacting your representatives, and participating in public demonstrations.\r\n- **Attend Events**: Participate in our events to learn more and show your support.\r\n- **Stay Informed**: Subscribe to our newsletter for the latest updates and action alerts.\r\n\r\nVisit our [Get Involved page](https://nppc.org/get-involved) to learn more.	\N	\N	f	f	2024-06-20 13:10:42	2024-06-20 13:10:42
cb4bc317-1f39-4151-b4c3-dec1775f3573	Birthdates	WVwruamNjD8YQASVQ0rgkICQSJ8exnReYU587S5e.jpg	birthdates	Commemorate the birthdays of political prisoners by sending messages of solidarity and support. Recognizing their birthdays is a meaningful way to show that they are not forgotten.\r\n\r\n- **June 12**: John Doe, Activist and Advocate\r\n- **August 24**: Jane Smith, Environmental Activist\r\n- **October 10**: Mark Johnson, Civil Rights Leader\r\n\r\nYour messages can provide encouragement and hope to those enduring imprisonment. To participate, check our [Birthdates page](https://nppc.org/birthdates) for more information.	5d4916cf-2aa4-4076-ba28-c5652d4a73d5	\N	f	f	2024-06-20 13:11:03	2024-06-20 13:11:03
389d50e9-ed3b-4364-8443-e5d40e6a9914	Prisoner Outreach	1wB99kPWNgAdmPVSUJxJTmWW2SFhtcpOZ8jue1Wi.jpg	prisoner-outreach	Our Prisoner Outreach program connects volunteers with political prisoners through letters and visits. Your support can make a huge difference in their lives.\r\n\r\n- **Write Letters**: Send letters of support to political prisoners.\r\n- **Visit Prisoners**: Participate in visitation programs to provide personal support.\r\n- **Care Packages**: Help assemble and send care packages to prisoners and their families.\r\n\r\nGet involved in our outreach efforts by visiting our [Prisoner Outreach page](https://nppc.org/prisoner-outreach).	5d4916cf-2aa4-4076-ba28-c5652d4a73d5	\N	f	f	2024-06-20 13:11:47	2024-06-20 13:11:47
7faa039c-bf9e-4fd0-9d04-47ef02177002	Learn More	zJjMgANXxmP9M6fRpW4GKwLqqYZyCJzVOb1NteWx.jpg	learn-more	Expand your understanding of the issues surrounding political prisoners in the United States. Our resources provide in-depth information on various topics, including:\r\n\r\n- **Political Prisoner Profiles**: Detailed biographies and case histories of current political prisoners.\r\n- **Legal Framework**: Information on the laws and policies that impact political prisoners.\r\n- **Advocacy and Action**: Guides on how you can advocate for the rights of political prisoners.\r\n\r\nVisit our [Learn More page](https://nppc.org/learn-more) for comprehensive resources and information.	\N	\N	f	f	2024-06-20 13:12:32	2024-06-20 13:12:32
d8c9ab74-ee40-477e-ae3d-1a714b15c638	Annual Report	vyNInL74Dj6mqIvGfBXnxiLitTNXYcgnBcMwlvta.jpg	annual-report	Our Annual Report provides a comprehensive overview of the National Political Prisoner Coalition's activities, achievements, and financial performance over the past year. Highlights include:\r\n\r\n- **Campaign Successes**: Major milestones and victories in our advocacy efforts.\r\n- **Financial Summary**: Detailed financial statements and funding sources.\r\n- **Future Goals**: Our strategic objectives and plans for the coming year.\r\n\r\nDownload the full report from our [Annual Report page](https://nppc.org/annual-report).	7faa039c-bf9e-4fd0-9d04-47ef02177002	\N	f	f	2024-06-20 13:13:12	2024-06-20 13:13:12
df45bf85-3503-4dda-8bef-c9c83b0773e4	History	ctfHb5klt0lFNmEgW8QTdflx5xvMt5TGE6ulBRpr.jpg	history	The National Political Prisoner Coalition has a rich history of advocacy and activism. Key moments include:\r\n\r\n- **Founding**: Established in 1995 by a group of former political prisoners and human rights activists.\r\n- **Major Campaigns**: Successful campaigns for the release of high-profile political prisoners and policy changes.\r\n- **Growth and Impact**: Expansion of our programs and partnerships to support a wider range of political prisoners and their families.\r\n\r\nLearn more about our journey and milestones on our [History page](https://nppc.org/history).	7faa039c-bf9e-4fd0-9d04-47ef02177002	\N	f	f	2024-06-20 13:13:41	2024-06-20 13:13:41
84ef0de1-9ab9-4e5f-bef6-79629f4e9eeb	About	GJTBb1u2QScdTpPuV8u1ScT80BXMVW08nFfdqW0Y.jpg	about-us	Hello there!	\N	\N	f	f	2024-06-20 12:35:28	2024-07-08 17:46:53
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: quotes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotes (id, text, author_name, author_image, created_at, updated_at) FROM stdin;
4681a4f5-6c88-42eb-bea7-6e964ee4ab80	When a man is denied the right to live the life he believes in, he has no choice but to become an outlaw.	Nelson Mandela	jjZVxjE9evL5FSudM7eHr0gbuQlwqcCN5ShpRfAv.webp	2024-07-07 10:14:09	2024-07-07 10:14:09
b3c4c83b-4048-4b1e-8965-98386b27630c	The struggle for justice doesn't end with the imprisonment of those who fight for it; it only intensifies.	Angela Davis	f63w3qFkHKutiRInYTO3qORHZP1WFVJFPSlHaQze.webp	2024-07-07 10:15:30	2024-07-07 10:15:30
ff3382ac-a107-4b68-8cc2-ec4341d14d7a	I have been in jail four times. I am not afraid of being in jail again.	Civil Rights Leader, Congressman John Lewis	IQjdbeoIllcM7ncHRzs5wP9CoS6SDtF2uqyyyIUr.png	2024-07-07 16:26:29	2024-07-07 16:26:29
e8712508-6177-440e-9b7f-ec6709bd82c5	The history of American politics is littered with instances of government officials abusing their power to imprison individuals for their beliefs or associations	Edward Snowden	O3rzQMlsfHaAX1ENwzElPHcgVrRoNdslxEIAuNhl.jpg	2024-07-07 16:29:33	2024-07-07 16:29:33
302c95b0-4135-4ed2-af91-54a8bedc60c8	We still have hundreds of people that I would categorize as political prisoners. Maybe even thousands, depending on how you categorize them.	Andrew Young Former United States Ambassador to the United Nations	X8vqFOkKfZkDlwpsWrtgYURD11nFZoQ877ueO99K.jpg	2024-07-07 16:32:43	2024-07-07 16:32:43
bc5475f2-6ace-4f8e-9116-b244a4613fd0	The most certain way to ensure that you are doing nothing to help a political prisoner is to stay silent about their plight.	Desmond Tutu	1lndQWNagWXEaaEKmtmzA4nLTXYCnu3SqxxE2Tw9.png	2024-07-07 16:29:58	2024-07-07 16:36:38
050bd3c7-6759-47f1-b1d3-11ba0d0a592d	Political prisoners are not forgotten heroes; they are our conscience in chains.	Vaclav Havel	md80SSxqNC5o1rjF0gXaGHqX8VWq2xJvnVAdKn3R.png	2024-07-07 16:27:04	2024-07-07 16:37:23
1df8c298-6032-4991-af66-a1af20c6bfb7	Prison bars cannot contain the truth; they only serve to amplify it."	Martin Luther King Jr.	OCgE2BPzJqptFQZMoHSXVPZSQnPO3dtK18whqOlC.png	2024-07-07 16:30:18	2024-07-07 16:38:11
\.


--
-- Data for Name: timelines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timelines (year, title, text, image, id) FROM stdin;
1700	Sedition act	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin tortor enim, faucibus semper tincidunt vel, pretium ut purus. Pellentesque egestas quis lectus at sollicitudin. Nunc libero leo, tristique et diam at, aliquam fringilla est. Pellentesque tincidunt dictum justo, sed commodo leo luctus sit amet. Cras ultricies at tellus ut pharetra. Proin placerat quis mi in suscipit. Vestibulum vitae tortor tristique, dapibus velit nec, consequat massa.	qoTCTsGy7XqoARhhtVNoDSIDxHq1JwqhIWcmNBFJ.jpg	a6acb39e-9482-422d-84cf-24f0aa1475d5
1783	Abolition Movement	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin tortor enim, faucibus semper tincidunt vel, pretium ut purus. Pellentesque egestas quis lectus at sollicitudin. Nunc libero leo, tristique et diam at, aliquam fringilla est. Pellentesque tincidunt dictum justo, sed commodo leo luctus sit amet. Cras ultricies at tellus ut pharetra. Proin placerat quis mi in suscipit. Vestibulum vitae tortor tristique, dapibus velit nec, consequat massa.	MrcHMUp1rusMepwblitLi11DUicYiiESIkkiw5KL.jpg	1336f116-cf6b-41c7-b317-746bbb7c132d
1861	Civil War	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin tortor enim, faucibus semper tincidunt vel, pretium ut purus. Pellentesque egestas quis lectus at sollicitudin. Nunc libero leo, tristique et diam at, aliquam fringilla est. Pellentesque tincidunt dictum justo, sed commodo leo luctus sit amet. Cras ultricies at tellus ut pharetra. Proin placerat quis mi in suscipit. Vestibulum vitae tortor tristique, dapibus velit nec, consequat massa.	Y9RW8jzQRBsBhmMA20RnBeAbQdPxj8MGZuTtrgVX.jpg	d8695686-51de-4b5f-9dd6-99a9395973ad
1904	Suffragism	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin tortor enim, faucibus semper tincidunt vel, pretium ut purus. Pellentesque egestas quis lectus at sollicitudin. Nunc libero leo, tristique et diam at, aliquam fringilla est. Pellentesque tincidunt dictum justo, sed commodo leo luctus sit amet. Cras ultricies at tellus ut pharetra. Proin placerat quis mi in suscipit. Vestibulum vitae tortor tristique, dapibus velit nec, consequat massa.	8KVrb9oEbUtjkhmvqKrMGQPOmCF5KwJphKdbRg5k.jpg	baaabc7f-7a79-433e-9074-64eaa312f811
1914	World War I	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin tortor enim, faucibus semper tincidunt vel, pretium ut purus. Pellentesque egestas quis lectus at sollicitudin. Nunc libero leo, tristique et diam at, aliquam fringilla est. Pellentesque tincidunt dictum justo, sed commodo leo luctus sit amet. Cras ultricies at tellus ut pharetra. Proin placerat quis mi in suscipit. Vestibulum vitae tortor tristique, dapibus velit nec, consequat massa.	70mjPlnS9IN356PEBTdEmutu30cghJLLRzuX3gDs.jpg	71022444-a908-4bc9-9382-3e51a4f5cbfb
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: katyusha
--

COPY public.users (id, is_admin, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
35e79ad0-1071-4e8e-9d9e-dd75074abfaa	f	Katyusha	patrickdeamorim@icloud.com	\N	$2y$12$esWighQNQfCHjosr7Vbx6.P7XTx.zG5esqp6NcnGqBBZfRb981T3S	fugKpaMBP5sNSw1QGKipUBmTKUyct4Nq5OeWCOwm4mlzpTAgrvJwzSwPK79B	2024-06-20 10:44:07	2024-06-20 10:44:07
8d695fae-4c5e-49b7-ae0f-d47883aa9eab	f	Marisam	marisam@nationalpoliticalprisonercoalition.org	\N	$2y$12$ttUA/dVvDyY9O6UvIqzDAOTSQgrC4kAIE4aRpplsFKrAL/hvQ7g0e	\N	2024-06-20 13:51:11	2024-06-20 13:51:11
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: katyusha
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: katyusha
--

SELECT pg_catalog.setval('public.migrations_id_seq', 29, true);


--
-- Name: nova_field_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: katyusha
--

SELECT pg_catalog.setval('public.nova_field_attachments_id_seq', 1, false);


--
-- Name: nova_pending_field_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: katyusha
--

SELECT pg_catalog.setval('public.nova_pending_field_attachments_id_seq', 1, false);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: katyusha
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: action_events action_events_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.action_events
    ADD CONSTRAINT action_events_pkey PRIMARY KEY (id);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: articles articles_slug_unique; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_slug_unique UNIQUE (slug);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_unique; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_unique UNIQUE (slug);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: faqs faqs_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: nova_field_attachments nova_field_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.nova_field_attachments
    ADD CONSTRAINT nova_field_attachments_pkey PRIMARY KEY (id);


--
-- Name: nova_notifications nova_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.nova_notifications
    ADD CONSTRAINT nova_notifications_pkey PRIMARY KEY (id);


--
-- Name: nova_pending_field_attachments nova_pending_field_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.nova_pending_field_attachments
    ADD CONSTRAINT nova_pending_field_attachments_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: pages pages_slug_unique; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_slug_unique UNIQUE (slug);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: quotes quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotes
    ADD CONSTRAINT quotes_pkey PRIMARY KEY (id);


--
-- Name: annual_reports table_name_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_reports
    ADD CONSTRAINT table_name_pk PRIMARY KEY (id);


--
-- Name: timelines timelines_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timelines
    ADD CONSTRAINT timelines_pk PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: action_events_batch_id_model_type_model_id_index; Type: INDEX; Schema: public; Owner: katyusha
--

CREATE INDEX action_events_batch_id_model_type_model_id_index ON public.action_events USING btree (batch_id, model_type, model_id);


--
-- Name: action_events_user_id_index; Type: INDEX; Schema: public; Owner: katyusha
--

CREATE INDEX action_events_user_id_index ON public.action_events USING btree (user_id);


--
-- Name: nova_field_attachments_url_index; Type: INDEX; Schema: public; Owner: katyusha
--

CREATE INDEX nova_field_attachments_url_index ON public.nova_field_attachments USING btree (url);


--
-- Name: nova_pending_field_attachments_draft_id_index; Type: INDEX; Schema: public; Owner: katyusha
--

CREATE INDEX nova_pending_field_attachments_draft_id_index ON public.nova_pending_field_attachments USING btree (draft_id);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: katyusha
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: articles articles_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: katyusha
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

