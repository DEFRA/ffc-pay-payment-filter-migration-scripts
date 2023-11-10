BEGIN;

DELETE FROM "outbox"
USING "completedPaymentRequests"
WHERE "outbox"."completedPaymentRequestId" = "completedPaymentRequests"."completedPaymentRequestId"
AND "completedPaymentRequests"."migrated" IS NOT NULL;

DELETE FROM "schedule"
USING "paymentRequests"
WHERE "schedule"."paymentRequestId" = "paymentRequests"."paymentRequestId"
AND "paymentRequests"."migrated" IS NOT NULL;

DELETE FROM "completedInvoiceLines" WHERE "migrated" IS NOT NULL;
DELETE FROM "completedPaymentRequests" WHERE "migrated" IS NOT NULL;
DELETE FROM "invoiceLines" WHERE "migrated" IS NOT NULL;
DELETE FROM "paymentRequests" WHERE "migrated" IS NOT NULL;
DELETE FROM "holds" WHERE "migrated" IS NOT NULL;

COMMIT;
