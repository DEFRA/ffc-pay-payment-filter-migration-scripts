INSERT INTO "completedPaymentRequests"(
  "paymentRequestId",
  "schemeId",
  ledger,
  "sourceSystem",
  "deliveryBody",
  "invoiceNumber",
  frn,
  sbi,
  "agreementNumber",
  "contractNumber",
  currency,
  schedule,
  "dueDate",
  value,
  acknowledged,
  "marketingYear",
  "debtType",
  "recoveryDate",
  "originalSettlementDate",
  "originalInvoiceNumber",
  "invoiceCorrectionReference",
  submitted,
  "paymentRequestNumber",
  invalid,
  "settledValue",
  "lastSettlement",
  "referenceId",
  "correlationId",
  batch,
  "paymentType",
  pillar,
  "exchangeRate",
  "eventDate",
  vendor,
  trader,
  "claimDate",
  migrated,
  "migrationId")
SELECT
  "paymentRequests"."paymentRequestId",
  "paymentRequests"."schemeId",
  "paymentRequests".ledger,
  "paymentRequests"."sourceSystem",
  "paymentRequests"."deliveryBody",
  "paymentRequests"."invoiceNumber",
  "paymentRequests".frn,
  "paymentRequests".sbi,
  "paymentRequests"."agreementNumber",
  "paymentRequests"."contractNumber",
  "paymentRequests".currency,
  "paymentRequests".schedule,
  "paymentRequests"."dueDate",
  "paymentRequests".value,
  NOW(),
  "paymentRequests"."marketingYear",
  "paymentRequests"."debtType",
  NULL,
  NULL,
  "paymentRequests"."originalInvoiceNumber",
  "paymentRequests"."invoiceCorrectionReference",
  NOW(),
  "paymentRequests"."paymentRequestNumber",
  false,
  0,
  null,
  "paymentRequests"."referenceId",
  "paymentRequests"."correlationId",
  "paymentRequests".batch,
  "paymentRequests"."paymentType",
  "paymentRequests".pillar,
  "paymentRequests"."exchangeRate",
  "paymentRequests"."eventDate",
  "paymentRequests".vendor,
  "paymentRequests".trader,
  "paymentRequests"."claimDate",
  "paymentRequests".migrated,
  "paymentRequests"."migrationId"
FROM "paymentRequests"
LEFT JOIN "completedPaymentRequests"
  ON "completedPaymentRequests"."migrationId" = "paymentRequests"."migrationId"
WHERE "completedPaymentRequests"."migrationId" IS NULL
  AND "paymentRequests"."migrationId" IN ('BPS_218748', 'BPS_228840');

INSERT INTO "completedInvoiceLines"(
  "completedPaymentRequestId",
  "accountCode",
  "fundCode",
  description,
  value,
  "schemeCode",
  convergence,
  "deliveryBody",
  "agreementNumber",
  "marketingYear",
  "stateAid")
SELECT
  "completedPaymentRequests"."completedPaymentRequestId",
  "invoiceLines"."accountCode",
  "invoiceLines"."fundCode",
  "invoiceLines".description,
  "invoiceLines".value,
  "invoiceLines"."schemeCode",
  "invoiceLines".convergence,
  "invoiceLines"."deliveryBody",
  "invoiceLines"."agreementNumber",
  "invoiceLines"."marketingYear",
  "invoiceLines"."stateAid"
FROM "invoiceLines"
INNER JOIN "paymentRequests"
  ON "invoiceLines"."paymentRequestId" = "paymentRequests"."paymentRequestId"
INNER JOIN "completedPaymentRequests"
  ON "paymentRequests"."paymentRequestId" = "completedPaymentRequests"."paymentRequestId"
LEFT JOIN "completedInvoiceLines"
  ON "completedPaymentRequests"."completedPaymentRequestId" = "completedInvoiceLines"."completedPaymentRequestId"
WHERE "completedInvoiceLines"."completedPaymentRequestId" IS NULL
  AND "invoiceLines"."description" NOT LIKE 'N00%'
  AND "paymentRequests"."migrationId" IN ('BPS_218748', 'BPS_228840');

UPDATE "invoiceLines"
SET "description" = 'X01 - Reduction arising from Progressive Reduction Bnd 1'
WHERE "description" = 'X01 - Reduction arising from Progressive Reduction';

UPDATE "invoiceLines"
SET "description" = 'X02 - Reduction arising from Progressive Reduction Bnd 2'
WHERE "description" = 'X02 - Reduction arising from Progressive Reduction';

UPDATE "invoiceLines"
SET "description" = 'X03 - Reduction arising from Progressive Reduction Bnd 3'
WHERE "description" = 'X03 - Reduction arising from Progressive Reduction';

UPDATE "invoiceLines"
SET "description" = 'X04 - Reduction arising from Progressive Reduction Bnd 4'
WHERE "description" = 'X04 - Reduction arising from Progressive Reduction';

UPDATE "completedInvoiceLines"
SET "description" = 'X01 - Reduction arising from Progressive Reduction Bnd 1'
WHERE "description" = 'X01 - Reduction arising from Progressive Reduction';

UPDATE "completedInvoiceLines"
SET "description" = 'X02 - Reduction arising from Progressive Reduction Bnd 2'
WHERE "description" = 'X02 - Reduction arising from Progressive Reduction';

UPDATE "completedInvoiceLines"
SET "description" = 'X03 - Reduction arising from Progressive Reduction Bnd 3'
WHERE "description" = 'X03 - Reduction arising from Progressive Reduction';

UPDATE "completedInvoiceLines"
SET "description" = 'X04 - Reduction arising from Progressive Reduction Bnd 4'
WHERE "description" = 'X04 - Reduction arising from Progressive Reduction';

UPDATE public."paymentRequests" pr
SET "agreementNumber" = 
    CASE 
        WHEN pr."agreementNumber" = 'A#######' THEN
            CASE pr."frn"
                WHEN '1101933828' THEN 'A1013885'
                WHEN '1102285404' THEN 'A1004567'
                WHEN '1102528803' THEN 'A1003804'
                WHEN '1104853825' THEN 'A1011859'
                ELSE pr."agreementNumber"
            END
        ELSE pr."agreementNumber"
    END;

UPDATE public."paymentRequests" pr
SET "contractNumber" = 
    CASE 
        WHEN pr."contractNumber" = 'A#######' THEN
            CASE pr."frn"
                WHEN '1101933828' THEN 'A1013885'
                WHEN '1102285404' THEN 'A1004567'
                WHEN '1102528803' THEN 'A1003804'
                WHEN '1104853825' THEN 'A1011859'
                ELSE pr."contractNumber"
            END
        ELSE pr."contractNumber"
    END;

UPDATE public."completedPaymentRequests" pr
SET "agreementNumber" = 
    CASE 
        WHEN pr."agreementNumber" = 'A#######' THEN
            CASE pr."frn"
                WHEN '1101933828' THEN 'A1013885'
                WHEN '1102285404' THEN 'A1004567'
                WHEN '1102528803' THEN 'A1003804'
                WHEN '1104853825' THEN 'A1011859'
                ELSE pr."agreementNumber"
            END
        ELSE pr."agreementNumber"
    END;

UPDATE public."completedPaymentRequests" pr
SET "contractNumber" = 
    CASE 
        WHEN pr."contractNumber" = 'A#######' THEN
            CASE pr."frn"
                WHEN '1101933828' THEN 'A1013885'
                WHEN '1102285404' THEN 'A1004567'
                WHEN '1102528803' THEN 'A1003804'
                WHEN '1104853825' THEN 'A1011859'
                ELSE pr."contractNumber"
            END
        ELSE pr."contractNumber"
    END;

UPDATE public."invoiceLines" il
SET "agreementNumber" = 
    CASE 
        WHEN "agreementNumber" = 'A#######' THEN
            CASE 
                WHEN EXISTS (SELECT 1 FROM public."paymentRequests" pr WHERE il."paymentRequestId" = pr."paymentRequestId" AND pr.frn = 1101933828) THEN 'A1013885'
                WHEN EXISTS (SELECT 1 FROM public."paymentRequests" pr WHERE il."paymentRequestId" = pr."paymentRequestId" AND pr.frn = 1102285404) THEN 'A1004567'
                WHEN EXISTS (SELECT 1 FROM public."paymentRequests" pr WHERE il."paymentRequestId" = pr."paymentRequestId" AND pr.frn = 1102528803) THEN 'A1003804'
                WHEN EXISTS (SELECT 1 FROM public."paymentRequests" pr WHERE il."paymentRequestId" = pr."paymentRequestId" AND pr.frn = 1104853825) THEN 'A1011859'
                ELSE "agreementNumber"
            END
        ELSE "agreementNumber"
    END;

UPDATE public."completedInvoiceLines" il
SET "agreementNumber" = 
    CASE 
        WHEN "agreementNumber" = 'A#######' THEN
            CASE 
                WHEN EXISTS (SELECT 1 FROM public."completedPaymentRequests" pr WHERE il."completedPaymentRequestId" = pr."completedPaymentRequestId" AND pr.frn = 1101933828) THEN 'A1013885'
                WHEN EXISTS (SELECT 1 FROM public."completedPaymentRequests" pr WHERE il."completedPaymentRequestId" = pr."completedPaymentRequestId" AND pr.frn = 1102285404) THEN 'A1004567'
                WHEN EXISTS (SELECT 1 FROM public."completedPaymentRequests" pr WHERE il."completedPaymentRequestId" = pr."completedPaymentRequestId" AND pr.frn = 1102528803) THEN 'A1003804'
                WHEN EXISTS (SELECT 1 FROM public."completedPaymentRequests" pr WHERE il."completedPaymentRequestId" = pr."completedPaymentRequestId" AND pr.frn = 1104853825) THEN 'A1011859'
                ELSE "agreementNumber"
            END
        ELSE "agreementNumber"
    END;

UPDATE public."paymentRequests" AS pr
SET "agreementNumber" = CONCAT('A0', SUBSTRING(pr."agreementNumber", 2))
WHERE pr."schemeId" = 5
AND pr."agreementNumber" ~ '^A[0-9]{6}$';

UPDATE public."paymentRequests" AS pr
SET "contractNumber" = CONCAT('A0', SUBSTRING(pr."contractNumber", 2))
WHERE pr."schemeId" = 5
AND pr."contractNumber" ~ '^A[0-9]{6}$';


UPDATE public."completedPaymentRequests" AS cpr
SET "agreementNumber" = CONCAT('A0', SUBSTRING(cpr."agreementNumber", 2))
WHERE cpr."schemeId" = 5
AND cpr."agreementNumber" ~ '^A[0-9]{6}$';

UPDATE public."completedPaymentRequests" AS cpr
SET "contractNumber" = CONCAT('A0', SUBSTRING(cpr."contractNumber", 2))
WHERE cpr."schemeId" = 5
AND cpr."contractNumber" ~ '^A[0-9]{6}$';

UPDATE public."invoiceLines" AS il
SET "agreementNumber" = CONCAT('A0', SUBSTRING(il."agreementNumber", 2))
FROM public."paymentRequests" AS pr
WHERE pr."schemeId" = 5
AND il."paymentRequestId" = pr."paymentRequestId"
AND il."agreementNumber" ~ '^A[0-9]{6}$';

UPDATE public."completedInvoiceLines" AS cil
SET "agreementNumber" = CONCAT('A0', SUBSTRING(cil."agreementNumber", 2))
FROM public."completedPaymentRequests" AS pr
WHERE pr."schemeId" = 5
AND cil."completedPaymentRequestId" = pr."completedPaymentRequestId"
AND cil."agreementNumber" ~ '^A[0-9]{6}$';
