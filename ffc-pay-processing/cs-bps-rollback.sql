DELETE FROM "outbox"
USING "completedPaymentRequests"
WHERE "outbox"."completedPaymentRequestId" = "completedPaymentRequests"."completedPaymentRequestId"
AND "completedPaymentRequests"."migrationId" IS NOT NULL;

DELETE FROM "schedule"
USING "paymentRequests"
WHERE "schedule"."paymentRequestId" = "paymentRequests"."paymentRequestId"
AND "paymentRequests"."migrationId" IS NOT NULL;

DELETE FROM "completedInvoiceLines"
USING "completedPaymentRequests"
WHERE "completedInvoiceLines"."completedPaymentRequestId" = "completedPaymentRequests"."completedPaymentRequestId"
AND "completedPaymentRequests"."migrationId" IS NOT NULL;

DELETE FROM "completedPaymentRequests"
WHERE "migrationId" IS NOT NULL
AND "schemeId" = 5;

DELETE FROM "completedPaymentRequests"
WHERE "migrationId" IS NOT NULL
AND "schemeId" = 6;

DELETE FROM "completedPaymentRequests"
WHERE "migrationId" IS NOT NULL
AND "schemeId" = 7;

DELETE FROM "invoiceLines"
USING "paymentRequests"
WHERE "invoiceLines"."paymentRequestId" = "paymentRequests"."paymentRequestId"
AND "paymentRequests"."migrationId" IS NOT NULL;

DELETE FROM "paymentRequests"
WHERE "migrationId" IS NOT NULL
AND "schemeId" = 5;

DELETE FROM "paymentRequests"
WHERE "migrationId" IS NOT NULL
AND "schemeId" = 6;

DELETE FROM "paymentRequests"
WHERE "migrationId" IS NOT NULL
AND "schemeId" = 7;

DELETE FROM "holds" WHERE "migrationId" IS NOT NULL;