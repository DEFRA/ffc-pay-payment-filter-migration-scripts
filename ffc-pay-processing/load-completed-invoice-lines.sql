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
WHERE "completedInvoiceLines"."completedPaymentRequestId" IS NULL
  AND "tempCompletedInvoiceLines"."description" NOT LIKE 'N00%';