BEGIN;

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

DELETE FROM "completedPaymentRequests" WHERE "migrationId" IS NOT NULL;

DELETE FROM "invoiceLines"
USING "paymentRequests"
WHERE "invoiceLines"."paymentRequestId" = "paymentRequests"."paymentRequestId"
AND "paymentRequests"."migrationId" IS NOT NULL;

DELETE FROM "paymentRequests" WHERE "migratedId" IS NOT NULL;

DELETE FROM "holds" WHERE "migrationId" IS NOT NULL;

COMMIT;
