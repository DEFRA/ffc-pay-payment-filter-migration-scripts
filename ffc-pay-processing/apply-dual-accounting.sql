UPDATE public."completedInvoiceLines" AS l
  SET "fundCode" = t."fundCode"
FROM public."tempDualAccounting" AS t
INNER JOIN public."completedPaymentRequests" AS c
  ON c."completedPaymentRequestId" = l."completedPaymentRequestId"
WHERE c."invoiceNumber" = t."invoiceNumber"
