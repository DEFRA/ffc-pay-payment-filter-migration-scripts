CREATE TABLE IF NOT EXISTS public."tempDebtData"
(
    "schemeId" smallint,
    frn bigint,
    reference character varying(50) COLLATE pg_catalog."default",
    "netValue" numeric,
    "debtType" character varying(3) COLLATE pg_catalog."default",
    "recoveryDate" timestamp without time zone,
    "attachedDate" timestamp without time zone,
    "createdDate" timestamp without time zone,
    "createdBy" character varying(50) COLLATE pg_catalog."default",
    "createdById" character varying(255) COLLATE pg_catalog."default"
)
