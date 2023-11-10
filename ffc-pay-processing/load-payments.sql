BEGIN;

INSERT INTO "paymentRequests"(
  "schemeId",
  "sourceSystem",
  "deliveryBody",
  "invoiceNumber",
  frn,
  sbi,
  "agreementNumber",
  "contractNumber",
  currency,
  schedule,
  "dueDate",
  value,
  received,
  "marketingYear",
  "paymentRequestNumber",
  ledger,
  "debtType",
  "recoveryDate",
  "originalSettlementDate",
  "referenceId",
  "correlationId",
  batch,
  "paymentType",
  pillar,
  "exchangeRate",
  "eventDate",
  vendor,
  trader,
  "claimDate",
  "originalInvoiceNumber",
  "invoiceCorrectionReference",
  migrated,
  "migrationId")
SELECT
  "tempPaymentRequests"."schemeId",
  "tempPaymentRequests"."sourceSystem",
  "tempPaymentRequests"."deliveryBody",
  "tempPaymentRequests"."invoiceNumber",
  "tempPaymentRequests".frn,
  "tempPaymentRequests".sbi,
  "tempPaymentRequests"."agreementNumber",
  "tempPaymentRequests"."contractNumber",
  "tempPaymentRequests".currency,
  "tempPaymentRequests".schedule,
  "tempPaymentRequests"."dueDate",
  "tempPaymentRequests".value,
  "tempPaymentRequests".received,
  "tempPaymentRequests"."marketingYear",
  "tempPaymentRequests"."paymentRequestNumber",
  "tempPaymentRequests".ledger,
  "tempPaymentRequests"."debtType",
  "tempPaymentRequests"."recoveryDate",
  "tempPaymentRequests"."originalSettlementDate",
  "tempPaymentRequests"."referenceId",
  "tempPaymentRequests"."correlationId",
  "tempPaymentRequests".batch,
  "tempPaymentRequests"."paymentType",
  "tempPaymentRequests".pillar,
  "tempPaymentRequests"."exchangeRate",
  "tempPaymentRequests"."eventDate",
  "tempPaymentRequests".vendor,
  "tempPaymentRequests".trader,
  "tempPaymentRequests"."claimDate",
  "tempPaymentRequests"."originalInvoiceNumber",
  "tempPaymentRequests"."invoiceCorrectionReference",
  NOW(),
  "tempPaymentRequests"."migrationId"
FROM "tempPaymentRequests"
LEFT JOIN "paymentRequests"
  ON "tempPaymentRequests"."migrationId" = "paymentRequests"."migrationId"
WHERE "paymentRequests"."migrationId" IS NULL
  AND "tempPaymentRequests"."marketingYear" IS NOT NULL;

INSERT INTO "invoiceLines"(
  "paymentRequestId",
  "accountCode",
  "fundCode",
  description,
  value,
  "schemeCode",
  convergence,
  "deliveryBody",
  "agreementNumber",
  "marketingYear",
  "stateAid",
  invalid)
SELECT
  "paymentRequests"."paymentRequestId",
  "tempInvoiceLines"."accountCode",
  "tempInvoiceLines"."fundCode",
  "tempInvoiceLines".description,
  "tempInvoiceLines".value,
  "tempInvoiceLines"."schemeCode",
  "tempInvoiceLines".convergence,
  "tempInvoiceLines"."deliveryBody",
  "tempInvoiceLines"."agreementNumber",
  "tempInvoiceLines"."marketingYear",
  "tempInvoiceLines"."stateAid",
  false
FROM "tempInvoiceLines"
INNER JOIN "paymentRequests"
  ON "tempInvoiceLines"."migrationId" = "paymentRequests"."migrationId"
LEFT JOIN "invoiceLines"
  ON "paymentRequests"."paymentRequestId" = "invoiceLines"."paymentRequestId"
WHERE "invoiceLines"."paymentRequestId" IS NULL;

INSERT INTO "completedPaymentRequests"(
  "paymentRequestId",
  "schemeId",
  ledger,
  "sourceSystem",
  "deliveryBody",
  "invoiceNumber",
  frn,
  sbi,
  "agreementNumber",
  "contractNumber",
  currency,
  schedule,
  "dueDate",
  value,
  acknowledged,
  "marketingYear",
  "debtType",
  "recoveryDate",
  "originalSettlementDate",
  "originalInvoiceNumber",
  "invoiceCorrectionReference",
  submitted,
  "paymentRequestNumber",
  invalid,
  "settledValue",
  "lastSettlement",
  "referenceId",
  "correlationId",
  batch,
  "paymentType",
  pillar,
  "exchangeRate",
  "eventDate",
  vendor,
  trader,
  "claimDate",
  migrated,
  "migrationId")
SELECT
  "paymentRequests"."paymentRequestId",
  "tempCompletedPaymentRequests"."schemeId",
  "tempCompletedPaymentRequests".ledger,
  "tempCompletedPaymentRequests"."sourceSystem",
  "tempCompletedPaymentRequests"."deliveryBody",
  "tempCompletedPaymentRequests"."invoiceNumber",
  "tempCompletedPaymentRequests".frn,
  "tempCompletedPaymentRequests".sbi,
  "tempCompletedPaymentRequests"."agreementNumber",
  "tempCompletedPaymentRequests"."contractNumber",
  "tempCompletedPaymentRequests".currency,
  "tempCompletedPaymentRequests".schedule,
  "tempCompletedPaymentRequests"."dueDate",
  "tempCompletedPaymentRequests".value,
  "tempCompletedPaymentRequests".acknowledged,
  "tempCompletedPaymentRequests"."marketingYear",
  "tempCompletedPaymentRequests"."debtType",
  TO_CHAR("tempCompletedPaymentRequests"."recoveryDate",
  'DD/MM/YYYY') AS "recoveryDate",
  TO_CHAR("tempCompletedPaymentRequests"."originalSettlementDate",
  'DD/MM/YYYY') AS "originalSettlementDate",
  "tempCompletedPaymentRequests"."originalInvoiceNumber",
  "tempCompletedPaymentRequests"."invoiceCorrectionReference",
  "tempCompletedPaymentRequests".submitted,
  "tempCompletedPaymentRequests"."paymentRequestNumber",
  "tempCompletedPaymentRequests".invalid,
  "tempCompletedPaymentRequests"."settledValue",
  "tempCompletedPaymentRequests"."lastSettlement",
  "tempCompletedPaymentRequests"."referenceId",
  "tempCompletedPaymentRequests"."correlationId",
  "tempCompletedPaymentRequests".batch,
  "tempCompletedPaymentRequests"."paymentType",
  "tempCompletedPaymentRequests".pillar,
  "tempCompletedPaymentRequests"."exchangeRate",
  "tempCompletedPaymentRequests"."eventDate",
  "tempCompletedPaymentRequests".vendor,
  "tempCompletedPaymentRequests".trader,
  "tempCompletedPaymentRequests"."claimDate",
  "paymentRequests".migrated,
  "paymentRequests"."migrationId"
FROM "tempCompletedPaymentRequests"
LEFT JOIN "completedPaymentRequests"
  ON "tempCompletedPaymentRequests"."migrationId" = "completedPaymentRequests"."migrationId"
INNER JOIN "paymentRequests"
  ON "tempCompletedPaymentRequests"."migrationId" = "paymentRequests"."migrationId"
WHERE "completedPaymentRequests"."migrationId" IS NULL;

INSERT INTO "completedInvoiceLines"(
  "completedPaymentRequestId",
  "accountCode",
  "fundCode",
  description,
  value,
  "schemeCode",
  convergence,
  "deliveryBody",
  "agreementNumber",
  "marketingYear",
  "stateAid")
SELECT
  "completedPaymentRequests"."completedPaymentRequestId",
  "tempCompletedInvoiceLines"."accountCode",
  "tempCompletedInvoiceLines"."fundCode",
  "tempCompletedInvoiceLines".description,
  "tempCompletedInvoiceLines".value,
  "tempCompletedInvoiceLines"."schemeCode",
  "tempCompletedInvoiceLines".convergence,
  "tempCompletedInvoiceLines"."deliveryBody",
  "tempCompletedInvoiceLines"."agreementNumber",
  "tempCompletedInvoiceLines"."marketingYear",
  "tempCompletedInvoiceLines"."stateAid"
FROM "tempCompletedInvoiceLines"
INNER JOIN "completedPaymentRequests"
  ON "tempCompletedInvoiceLines"."migrationId" = "completedPaymentRequests"."migrationId"
LEFT JOIN "completedInvoiceLines"
  ON "completedPaymentRequests"."completedPaymentRequestId" = "completedInvoiceLines"."completedPaymentRequestId"
WHERE "completedInvoiceLines"."completedPaymentRequestId" IS NULL;

INSERT INTO holds(
  frn,
  "holdCategoryId",
  added,
  migrated)
SELECT
  "tempHoldData".frn,
  "tempHoldData"."holdCategoryId",
  "tempHoldData".added,
  NOW()
FROM "tempHoldData"
LEFT JOIN (
  SELECT
    frn,
    "holdCategoryId"
  FROM holds
  WHERE closed IS NULL
) "currentHolds"
  ON "tempHoldData".frn = "currentHolds".frn
  AND "tempHoldData"."holdCategoryId" = "currentHolds"."holdCategoryId"
WHERE "currentHolds".frn IS NULL;

COMMIT;
