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
  "paymentRequests"."schemeId",
  "paymentRequests".ledger,
  "paymentRequests"."sourceSystem",
  "paymentRequests"."deliveryBody",
  "paymentRequests"."invoiceNumber",
  "paymentRequests".frn,
  "paymentRequests".sbi,
  "paymentRequests"."agreementNumber",
  "paymentRequests"."contractNumber",
  "paymentRequests".currency,
  "paymentRequests".schedule,
  "paymentRequests"."dueDate",
  "paymentRequests".value,
  NOW(),
  "paymentRequests"."marketingYear",
  "paymentRequests"."debtType",
  NULL,
  NULL,
  "paymentRequests"."originalInvoiceNumber",
  "paymentRequests"."invoiceCorrectionReference",
  NOW(),
  "paymentRequests"."paymentRequestNumber",
  false,
  0,
  null,
  "paymentRequests"."referenceId",
  "paymentRequests"."correlationId",
  "paymentRequests".batch,
  "paymentRequests"."paymentType",
  "paymentRequests".pillar,
  "paymentRequests"."exchangeRate",
  "paymentRequests"."eventDate",
  "paymentRequests".vendor,
  "paymentRequests".trader,
  "paymentRequests"."claimDate",
  "paymentRequests".migrated,
  "paymentRequests"."migrationId"
FROM "paymentRequests"
LEFT JOIN "completedPaymentRequests"
  ON "completedPaymentRequests"."migrationId" = "paymentRequests"."migrationId"
WHERE "completedPaymentRequests"."migrationId" IS NULL
  AND "paymentRequests"."migrationId" IN ('BPS_218748', 'BPS_228840');

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
  "invoiceLines"."accountCode",
  "invoiceLines"."fundCode",
  "invoiceLines".description,
  "invoiceLines".value,
  "invoiceLines"."schemeCode",
  "invoiceLines".convergence,
  "invoiceLines"."deliveryBody",
  "invoiceLines"."agreementNumber",
  "invoiceLines"."marketingYear",
  "invoiceLines"."stateAid"
FROM "invoiceLines"
INNER JOIN "paymentRequests"
  ON "invoiceLines"."paymentRequestId" = "paymentRequests"."paymentRequestId"
INNER JOIN "completedPaymentRequests"
  ON "paymentRequests"."paymentRequestId" = "completedPaymentRequests"."paymentRequestId"
LEFT JOIN "completedInvoiceLines"
  ON "completedPaymentRequests"."completedPaymentRequestId" = "completedInvoiceLines"."completedPaymentRequestId"
WHERE "completedInvoiceLines"."completedPaymentRequestId" IS NULL
  AND "invoiceLines"."description" NOT LIKE 'N00%'
  AND "paymentRequests"."migrationId" IN ('BPS_218748', 'BPS_228840');

UPDATE "invoiceLines"
SET "description" = 'X01 - Reduction arising from Progressive Reduction Bnd 1'
WHERE "description" = 'X01 - Reduction arising from Progressive Reduction';

UPDATE "invoiceLines"
SET "description" = 'X02 - Reduction arising from Progressive Reduction Bnd 2'
WHERE "description" = 'X02 - Reduction arising from Progressive Reduction';

UPDATE "invoiceLines"
SET "description" = 'X03 - Reduction arising from Progressive Reduction Bnd 3'
WHERE "description" = 'X03 - Reduction arising from Progressive Reduction';

UPDATE "invoiceLines"
SET "description" = 'X04 - Reduction arising from Progressive Reduction Bnd 4'
WHERE "description" = 'X04 - Reduction arising from Progressive Reduction';

UPDATE "completedInvoiceLines"
SET "description" = 'X01 - Reduction arising from Progressive Reduction Bnd 1'
WHERE "description" = 'X01 - Reduction arising from Progressive Reduction';

UPDATE "completedInvoiceLines"
SET "description" = 'X02 - Reduction arising from Progressive Reduction Bnd 2'
WHERE "description" = 'X02 - Reduction arising from Progressive Reduction';

UPDATE "completedInvoiceLines"
SET "description" = 'X03 - Reduction arising from Progressive Reduction Bnd 3'
WHERE "description" = 'X03 - Reduction arising from Progressive Reduction';

UPDATE "completedInvoiceLines"
SET "description" = 'X04 - Reduction arising from Progressive Reduction Bnd 4'
WHERE "description" = 'X04 - Reduction arising from Progressive Reduction';