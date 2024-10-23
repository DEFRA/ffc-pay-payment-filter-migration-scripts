// IMPORT CS invoice lines

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
  "v2TempCompletedInvoiceLines"."accountCode",
  "v2TempCompletedInvoiceLines"."fundCode",
  "v2TempCompletedInvoiceLines".description,
  "v2TempCompletedInvoiceLines".value,
  "v2TempCompletedInvoiceLines"."schemeCode",
  "v2TempCompletedInvoiceLines".convergence,
  "v2TempCompletedInvoiceLines"."deliveryBody",
  "v2TempCompletedInvoiceLines"."agreementNumber",
  "v2TempCompletedInvoiceLines"."marketingYear",
  "v2TempCompletedInvoiceLines"."stateAid"
FROM "v2TempCompletedInvoiceLines"
INNER JOIN "completedPaymentRequests"
  ON "v2TempCompletedInvoiceLines"."migrationId" = "completedPaymentRequests"."migrationId"
LEFT JOIN "completedInvoiceLines"
  ON "completedPaymentRequests"."completedPaymentRequestId" = "completedInvoiceLines"."completedPaymentRequestId"
WHERE "completedInvoiceLines"."completedPaymentRequestId" IS NULL
  AND "completedPaymentRequests"."schemeId" = 5
  AND "v2TempCompletedInvoiceLines"."description" NOT LIKE 'N00%';

// IMPORT BPS invoice lines

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
  "v2TempCompletedInvoiceLines"."accountCode",
  "v2TempCompletedInvoiceLines"."fundCode",
  "v2TempCompletedInvoiceLines".description,
  "v2TempCompletedInvoiceLines".value,
  "v2TempCompletedInvoiceLines"."schemeCode",
  "v2TempCompletedInvoiceLines".convergence,
  "v2TempCompletedInvoiceLines"."deliveryBody",
  "v2TempCompletedInvoiceLines"."agreementNumber",
  "v2TempCompletedInvoiceLines"."marketingYear",
  "v2TempCompletedInvoiceLines"."stateAid"
FROM "v2TempCompletedInvoiceLines"
INNER JOIN "completedPaymentRequests"
  ON "v2TempCompletedInvoiceLines"."migrationId" = "completedPaymentRequests"."migrationId"
LEFT JOIN "completedInvoiceLines"
  ON "completedPaymentRequests"."completedPaymentRequestId" = "completedInvoiceLines"."completedPaymentRequestId"
WHERE "completedInvoiceLines"."completedPaymentRequestId" IS NULL
  AND "completedPaymentRequests"."schemeId" = 6
  AND "v2TempCompletedInvoiceLines"."description" NOT LIKE 'N00%';
