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
WHERE "invoiceLines"."paymentRequestId" IS NULL
  AND "tempInvoiceLines"."description" NOT LIKE 'N00%';