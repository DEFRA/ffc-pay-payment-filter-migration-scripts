UPDATE "completedPaymentRequests" AS c
    SET "lastSettlement" = t."lastSettlement",
        "settledValue" = t."value" * 100
    FROM "tempSettlementData" AS t
    WHERE c."invoiceNumber" = t."invoiceNumber"
        AND (c."lastSettlement" IS NULL OR c."lastSettlement" < t."lastSettlement")