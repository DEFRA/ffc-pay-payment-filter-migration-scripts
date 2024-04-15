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

UPDATE public."paymentRequests"
SET "contractNumber" = 'A1013885'
WHERE "migrationId" = 'CS_46288';

UPDATE public."completedPaymentRequests"
SET "contractNumber" = 'A1013885'
WHERE "migrationId" = 'CS_46288';

UPDATE public."invoiceLines"
SET "agreementNumber" = 'A1013885'
FROM public."paymentRequests" pr
WHERE pr."migrationId" = 'CS_46288'
AND "invoiceLines"."paymentRequestId" = pr."paymentRequestId";

UPDATE public."completedInvoiceLines"
SET "agreementNumber" = 'A1013885'
FROM public."completedPaymentRequests" pr
WHERE pr."migrationId" = 'CS_46288'
AND "completedInvoiceLines"."completedPaymentRequestId" = pr."completedPaymentRequestId";

UPDATE public."paymentRequests"
SET "contractNumber" = 'A1004567'
WHERE "migrationId" = 'CS_44522';

UPDATE public."completedPaymentRequests"
SET "contractNumber" = 'A1004567'
WHERE "migrationId" = 'CS_44522';

UPDATE public."invoiceLines"
SET "agreementNumber" = 'A1004567'
FROM public."paymentRequests" pr
WHERE pr."migrationId" = 'CS_44522'
AND "invoiceLines"."paymentRequestId" = pr."paymentRequestId";

UPDATE public."completedInvoiceLines"
SET "agreementNumber" = 'A1004567'
FROM public."completedPaymentRequests" pr
WHERE pr."migrationId" = 'CS_44522'
AND "completedInvoiceLines"."completedPaymentRequestId" = pr."completedPaymentRequestId";

UPDATE public."paymentRequests"
SET "contractNumber" = 'A1003804'
WHERE "migrationId" = 'CS_44521';

UPDATE public."completedPaymentRequests"
SET "contractNumber" = 'A1003804'
WHERE "migrationId" = 'CS_44521';

UPDATE public."invoiceLines"
SET "agreementNumber" = 'A1003804'
FROM public."paymentRequests" pr
WHERE pr."migrationId" = 'CS_44521'
AND "invoiceLines"."paymentRequestId" = pr."paymentRequestId";

UPDATE public."completedInvoiceLines"
SET "agreementNumber" = 'A1003804'
FROM public."completedPaymentRequests" pr
WHERE pr."migrationId" = 'CS_44521'
AND "completedInvoiceLines"."completedPaymentRequestId" = pr."completedPaymentRequestId";

UPDATE public."paymentRequests"
SET "contractNumber" = 'A1011859'
WHERE "migrationId" = 'CS_46287';

UPDATE public."completedPaymentRequests"
SET "contractNumber" = 'A1011859'
WHERE "migrationId" = 'CS_46287';

UPDATE public."invoiceLines"
SET "agreementNumber" = 'A1011859'
FROM public."paymentRequests" pr
WHERE pr."migrationId" = 'CS_46287'
AND "invoiceLines"."paymentRequestId" = pr."paymentRequestId";

UPDATE public."completedInvoiceLines"
SET "agreementNumber" = 'A1011859'
FROM public."completedPaymentRequests" pr
WHERE pr."migrationId" = 'CS_46287'
AND "completedInvoiceLines"."completedPaymentRequestId" = pr."completedPaymentRequestId";

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

UPDATE public."invoiceLines"
SET description = 'P11 - Reduction arising from Financial Discipline Budget'
WHERE description LIKE 'P11 - Reduction arising from Financial Discipline%';

UPDATE public."completedInvoiceLines"
SET description = 'P11 - Reduction arising from Financial Discipline Budget'
WHERE description LIKE 'P11 - Reduction arising from Financial Discipline%';
