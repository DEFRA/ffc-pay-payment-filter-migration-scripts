UPDATE public."completedInvoiceLines" AS l
SET "fundCode" = t."fundCode"
FROM (
    SELECT l1."completedPaymentRequestId", t."fundCode"
    FROM public."completedInvoiceLines" AS l1
    JOIN public."completedPaymentRequests" AS c ON c."completedPaymentRequestId" = l1."completedPaymentRequestId"
    JOIN public."tempDualAccounting" AS t ON c."invoiceNumber" = t."invoiceNumber"
) AS t
WHERE l."completedPaymentRequestId" = t."completedPaymentRequestId";
