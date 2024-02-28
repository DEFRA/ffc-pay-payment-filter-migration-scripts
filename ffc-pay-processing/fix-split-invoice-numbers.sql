UPDATE "completedPaymentRequests" 
SET "invoiceNumber" = 
    CASE 
        WHEN 
            SUBSTRING("invoiceNumber" FROM 9 FOR 1) ~ '[A-Za-z]' 
            AND 
            SUBSTRING("invoiceNumber" FROM 10 FOR 1) ~ '[A-Za-z]' 
        THEN 
            CONCAT(
                LEFT("invoiceNumber", 8),
                RIGHT("invoiceNumber", LENGTH("invoiceNumber") - 9),
                SUBSTRING("invoiceNumber" FROM 9 FOR 1)
            )
        ELSE 
            "invoiceNumber"
    END
AND "schemeId" = 6
AND SUBSTRING("invoiceNumber" FROM 9 FOR 1) ~ '[A-Za-z]' 
AND SUBSTRING("invoiceNumber" FROM 10 FOR 1) ~ '[A-Za-z]';

UPDATE "completedPaymentRequests" 
SET "invoiceNumber" = 
    CASE 
        WHEN 
            SUBSTRING("invoiceNumber" FROM 9 FOR 1) ~ '[A-Za-z]' 
            AND 
            SUBSTRING("invoiceNumber" FROM 10 FOR 1) ~ '[A-Za-z]' 
        THEN 
            CONCAT(
                LEFT("invoiceNumber", 8),
                RIGHT("invoiceNumber", LENGTH("invoiceNumber") - 9),
                SUBSTRING("invoiceNumber" FROM 9 FOR 1)
            )
        ELSE 
            "invoiceNumber"
    END
AND "schemeId" = 6
AND SUBSTRING("invoiceNumber" FROM 9 FOR 1) ~ '[A-Za-z]' 
AND SUBSTRING("invoiceNumber" FROM 10 FOR 1) ~ '[A-Za-z]';

SELECT "invoiceNumber",
    CASE 
        WHEN 
            SUBSTRING("invoiceNumber" FROM 8 FOR 1) ~ '[A-Za-z]' 
            AND 
            SUBSTRING("invoiceNumber" FROM 9 FOR 1) ~ '[A-Za-z]' 
        THEN 
            CONCAT(
                LEFT("invoiceNumber", 1),
                '0',
                SUBSTRING("invoiceNumber" FROM 2 FOR 6),
                SUBSTRING("invoiceNumber" FROM 9),
                SUBSTRING("invoiceNumber" FROM 8 FOR 1)
            )
        ELSE 
            "invoiceNumber"
    END
FROM "completedPaymentRequests" 
WHERE "schemeId" = 5
AND SUBSTRING("invoiceNumber" FROM 8 FOR 1) ~ '[A-Za-z]' 
AND SUBSTRING("invoiceNumber" FROM 9 FOR 1) ~ '[A-Za-z]';
