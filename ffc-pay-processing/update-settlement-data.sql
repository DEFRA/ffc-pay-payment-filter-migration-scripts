UPDATE public."completedPaymentRequests" AS c
    SET "lastSettlement" = t."lastSettlement",
        "settledValue" = t."value" * 100
    FROM public."tempSettlementData" AS t
    WHERE c."invoiceNumber" = t."invoiceNumber"
        AND (c."lastSettlement" IS NULL OR c."lastSettlement" < t."lastSettlement");

UPDATE public."completedPaymentRequests"
    SET "settledValue" = FLOOR("settledValue" /
        CASE
            WHEN "marketingYear" = 2015 THEN 0.73129
            WHEN "marketingYear" = 2016 THEN 0.85228
            WHEN "marketingYear" = 2017 THEN 0.8947
            WHEN "marketingYear" = 2018 THEN 0.89281
            WHEN "marketingYear" = 2019 THEN 0.89092
            WHEN "marketingYear" = 2020 THEN 0.89092
        END)
    WHERE "schemeId" = 6
    AND "marketingYear" IN (2015, 2016, 2017, 2018, 2019, 2020);

UPDATE public."completedPaymentRequests" cpr
    SET "settledValue" = FLOOR(cpr."settledValue" /
        CASE
            WHEN cil."schemeCode" = 10575 THEN 0.73129
            WHEN cil."schemeCode" = 10576 THEN 0.85228
            WHEN cil."schemeCode" = 10577 THEN 0.8947
            WHEN cil."schemeCode" = 10578 THEN 0.89281
            WHEN cil."schemeCode" = 10579 THEN 0.89092
            WHEN cil."schemeCode" = 10580 THEN 0.89092
        END)
    FROM (
        SELECT "completedPaymentRequestId", MIN("schemeCode") AS "schemeCode"
            FROM "completedInvoiceLines"
            GROUP BY "completedPaymentRequestId"
    ) cil
    WHERE cpr."completedPaymentRequestId" = cil."completedPaymentRequestId"
    AND cpr."schemeId" = 6;
