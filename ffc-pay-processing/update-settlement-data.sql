UPDATE public."tempSettlementData"
SET "invoiceNumber" = 'S0549328A1004567V001'
WHERE "invoiceNumber" = 'S0549328A#######V001';

UPDATE public."tempSettlementData"
SET "invoiceNumber" = 'S0549327A1003804V001'
WHERE "invoiceNumber" = 'S0549327A#######V001';

UPDATE public."completedPaymentRequests" AS c
    SET "lastSettlement" = t."lastSettlement",
        "settledValue" = t."value" * 100
    FROM public."tempSettlementData" AS t
    WHERE c."invoiceNumber" = t."invoiceNumber"
        AND (c."lastSettlement" IS NULL OR c."lastSettlement" < t."lastSettlement");

UPDATE public."completedPaymentRequests"
    SET "settledValue" = "value"
    WHERE "schemeId" IN (6, 7)
    AND "marketingYear" IN (2015, 2016, 2017, 2018, 2019, 2020)
    AND "settledValue" IS NOT NULL
    AND "settledValue" != 0;
