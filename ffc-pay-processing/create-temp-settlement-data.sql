CREATE TABLE IF NOT EXISTS public."v2TempSettlementData"
(
    "lastSettlement" timestamp without time zone,
    "supplierno" bigint,
    "suppliername" character varying(255) COLLATE pg_catalog."default",
    "invoiceNumber" character varying(30) COLLATE pg_catalog."default",
    value numeric,
    "documentDate" character varying(10) COLLATE pg_catalog."default",
    "invoiceDate" timestamp without time zone,
    "invoiceDueDate" timestamp without time zone,
    "schemeCode2" character varying(10) COLLATE pg_catalog."default",
    "marketingYear" integer,
    "deliveryBody" character varying(4) COLLATE pg_catalog."default",
    currency character varying(3) COLLATE pg_catalog."default",
    "invoiceValue" numeric,
    "lastHoldReleaseDate" character varying(10) COLLATE pg_catalog."default",
    "fesRef" character varying(10) COLLATE pg_catalog."default",
    "paymentMethod" character varying(30) COLLATE pg_catalog."default"
);
