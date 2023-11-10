BEGIN;

INSERT INTO "outbox"(
	"completedPaymentRequestId")
SELECT "completedPaymentRequests"."completedPaymentRequestId"
FROM "completedPaymentRequests"
LEFT JOIN "outbox"
  ON "completedPaymentRequests"."completedPaymentRequestId" = "outbox"."completedPaymentRequestId"
WHERE "outbox"."completedPaymentRequestId" IS NULL
  AND "completedPaymentRequests"."migrated" IS NOT NULL
  AND "completedPaymentRequests"."submitted" IS NULL;

INSERT INTO "schedule"(
  "paymentRequestId",
  "planned")
SELECT
  "paymentRequests"."paymentRequestId",
  NOW()
FROM "paymentRequests"
LEFT JOIN "schedule"
  ON "paymentRequests"."paymentRequestId" = "schedule"."paymentRequestId"
LEFT JOIN "completedPaymentRequests"
  ON "paymentRequests"."paymentRequestId" = "completedPaymentRequests"."paymentRequestId"
WHERE "schedule"."paymentRequestId" IS NULL
  AND "paymentRequests"."migrated" IS NOT NULL
  AND "completedPaymentRequests"."paymentRequestId" IS NULL;

COMMIT;
