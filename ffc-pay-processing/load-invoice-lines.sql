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
  "v2TempInvoiceLines"."accountCode",
  "v2TempInvoiceLines"."fundCode",
  "v2TempInvoiceLines".description,
  "v2TempInvoiceLines".value,
  "v2TempInvoiceLines"."schemeCode",
  "v2TempInvoiceLines".convergence,
  "v2TempInvoiceLines"."deliveryBody",
  "v2TempInvoiceLines"."agreementNumber",
  "v2TempInvoiceLines"."marketingYear",
  "v2TempInvoiceLines"."stateAid",
  false
FROM "v2TempInvoiceLines"
INNER JOIN "paymentRequests"
  ON "v2TempInvoiceLines"."migrationId" = "paymentRequests"."migrationId"
LEFT JOIN "invoiceLines"
  ON "paymentRequests"."paymentRequestId" = "invoiceLines"."paymentRequestId"
WHERE "invoiceLines"."paymentRequestId" IS NULL
  AND "v2TempInvoiceLines"."description" NOT LIKE 'N00%'
  AND "paymentRequests"."schemeId" != 7;