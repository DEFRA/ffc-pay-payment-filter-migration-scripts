BEGIN;

DELETE FROM "invoiceLines"
USING "paymentRequests"
WHERE "invoiceLines"."paymentRequestId" = "paymentRequests"."paymentRequestId"
  AND "paymentRequests"."schemeId" IN (5, 6, 7);

DELETE FROM "paymentRequests"
WHERE "schemeId" IN (5, 6, 7);

DELETE FROM "debtData"
WHERE "migrated" IS NOT NULL;

COMMIT;
