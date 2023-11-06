CREATE TABLE IF NOT EXISTS public."tempPaymentRequests"
(
    "migrationId" character varying(50) COLLATE pg_catalog."default",
    "schemeId" integer,
    "sourceSystem" character varying(50) COLLATE pg_catalog."default",
    "deliveryBody" character varying(4) COLLATE pg_catalog."default",
    "invoiceNumber" character varying(30) COLLATE pg_catalog."default",
    frn bigint,
    sbi integer,
    "agreementNumber" character varying(50) COLLATE pg_catalog."default",
    "contractNumber" character varying(50) COLLATE pg_catalog."default",
    currency character varying(3) COLLATE pg_catalog."default",
    schedule character varying(3) COLLATE pg_catalog."default",
    "dueDate" character varying(10) COLLATE pg_catalog."default",
    value integer,
    received timestamp without time zone,
    "marketingYear" integer,
    "paymentRequestNumber" integer,
    ledger character varying(2) COLLATE pg_catalog."default",
    "debtType" character varying(3) COLLATE pg_catalog."default",
    "recoveryDate" character varying(10) COLLATE pg_catalog."default",
    "originalSettlementDate" character varying(10) COLLATE pg_catalog."default",
    "referenceId" uuid,
    "correlationId" uuid,
    batch character varying(255) COLLATE pg_catalog."default",
    "paymentType" integer,
    pillar character varying(10) COLLATE pg_catalog."default",
    "exchangeRate" character varying(10) COLLATE pg_catalog."default",
    "eventDate" character varying(10) COLLATE pg_catalog."default",
    vendor character varying(10) COLLATE pg_catalog."default",
    trader character varying(10) COLLATE pg_catalog."default",
    "claimDate" character varying(10) COLLATE pg_catalog."default",
    "originalInvoiceNumber" character varying(30) COLLATE pg_catalog."default",
    "invoiceCorrectionReference" character varying(30) COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public."tempInvoiceLines"
(
    "migrationId" character varying(50) COLLATE pg_catalog."default",
    "invoiceNumber" character varying(30) COLLATE pg_catalog."default",
    "accountCode" character varying(6) COLLATE pg_catalog."default",
    "fundCode" character varying(6) COLLATE pg_catalog."default",
    description character varying(255) COLLATE pg_catalog."default",
    value integer,
    "schemeCode" character varying(10) COLLATE pg_catalog."default",
    convergence boolean DEFAULT false,
    "deliveryBody" character varying(4) COLLATE pg_catalog."default",
    "schemeCode2" character varying(10) COLLATE pg_catalog."default",
    "agreementNumber" character varying(255) COLLATE pg_catalog."default",
    "marketingYear" integer,
    "stateAid" boolean DEFAULT false
);

CREATE TABLE IF NOT EXISTS public."tempCompletedPaymentRequests"
(
    "migrationId" character varying(50) COLLATE pg_catalog."default",
    "inboundInvoiceNumber" character varying(30) COLLATE pg_catalog."default",
    "schemeId" integer,
    ledger character varying(2) COLLATE pg_catalog."default",
    "sourceSystem" character varying(50) COLLATE pg_catalog."default",
    "deliveryBody" character varying(4) COLLATE pg_catalog."default",
    "invoiceNumber" character varying(30) COLLATE pg_catalog."default",
    frn bigint,
    sbi integer,
    "agreementNumber" character varying(50) COLLATE pg_catalog."default",
    "contractNumber" character varying(50) COLLATE pg_catalog."default",
    currency character varying(3) COLLATE pg_catalog."default",
    schedule character varying(3) COLLATE pg_catalog."default",
    "dueDate" character varying(10) COLLATE pg_catalog."default",
    value integer,
    acknowledged timestamp without time zone,
    "marketingYear" integer,
    "debtType" character varying(3) COLLATE pg_catalog."default",
    "recoveryDate" timestamp without time zone,
    "originalSettlementDate" timestamp without time zone,
    "originalInvoiceNumber" character varying(30) COLLATE pg_catalog."default",
    "invoiceCorrectionReference" character varying(30) COLLATE pg_catalog."default",
    submitted timestamp without time zone,
    "paymentRequestNumber" integer,
    invalid boolean,
    "settledValue" integer,
    "lastSettlement" timestamp without time zone,
    "referenceId" uuid,
    "correlationId" uuid,
    batch character varying(255) COLLATE pg_catalog."default",
    "paymentType" integer,
    pillar character varying(10) COLLATE pg_catalog."default",
    "exchangeRate" character varying(10) COLLATE pg_catalog."default",
    "eventDate" character varying(10) COLLATE pg_catalog."default",
    vendor character varying(10) COLLATE pg_catalog."default",
    trader character varying(10) COLLATE pg_catalog."default",
    "claimDate" character varying(10) COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public."tempCompletedInvoiceLines"
(
    "migrationId" character varying(50) COLLATE pg_catalog."default",
    "inboundInvoiceNumber" character varying(30) COLLATE pg_catalog."default",
    "invoiceNumber" character varying(30) COLLATE pg_catalog."default",
    "accountCode" character varying(6) COLLATE pg_catalog."default",
    "fundCode" character varying(6) COLLATE pg_catalog."default",
    description character varying(255) COLLATE pg_catalog."default",
    value integer,
    "schemeCode2" character varying(10) COLLATE pg_catalog."default",
    convergence boolean,
    "deliveryBody" character varying(4) COLLATE pg_catalog."default",
    "schemeCode" character varying(10) COLLATE pg_catalog."default",
    "agreementNumber" character varying(255) COLLATE pg_catalog."default",
    "marketingYear" integer,
    "stateAid" boolean
);

CREATE TABLE IF NOT EXISTS public."tempHoldData"
(
    frn bigint,
    "holdCategoryId" integer,
    added timestamp without time zone,
    closed timestamp without time zone
);
