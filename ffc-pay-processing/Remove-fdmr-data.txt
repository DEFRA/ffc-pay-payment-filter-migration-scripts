DELETE FROM "completedInvoiceLines"
USING "completedPaymentRequests"
WHERE "completedInvoiceLines"."completedPaymentRequestId" = "completedPaymentRequests"."completedPaymentRequestId"
AND "completedPaymentRequests"."schemeId" = 7;

DELETE FROM "completedPaymentRequests"
WHERE "schemeId" = 7;

DELETE FROM "invoiceLines"
USING "paymentRequests"
WHERE "invoiceLines"."paymentRequestId" = "paymentRequests"."paymentRequestId"
AND "paymentRequests"."schemeId" = 7;

DELETE FROM "paymentRequests"
WHERE "schemeId" = 7;