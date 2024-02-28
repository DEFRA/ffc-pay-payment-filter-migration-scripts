CREATE TABLE IF NOT EXISTS public."tempSettlementData"
(
    "lastSettlement" date,
    "supplierno" bigint,
    "suppliername" character varying(255) COLLATE pg_catalog."default",
    "invoiceNumber" character varying(30) COLLATE pg_catalog."default",
    value integer,
    "documentDate" date,
    "invoiceDate" date,
    "invoiceDueDate" date,
    "schemeCode2" character varying(10) COLLATE pg_catalog."default",
    "marketingYear" integer,
    "deliveryBody" character varying(4) COLLATE pg_catalog."default",
    currency character varying(3) COLLATE pg_catalog."default",
    "invoiceValue" integer,
    "lastHoldReleaseDate" date,
    "fesRef" character varying(10) COLLATE pg_catalog."default",
    "paymentMethod" character varying(30) COLLATE pg_catalog."default"
);
