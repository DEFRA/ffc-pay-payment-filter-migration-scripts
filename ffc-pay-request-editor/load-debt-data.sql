BEGIN;

INSERT INTO public."debtData"(
  "schemeId",
  frn,
  reference,
  "netValue",
  "debtType",
  "recoveryDate",
  "attachedDate",
  "createdDate",
  "createdBy",
  "createdById",
  migrated)
SELECT
  "tempDebtData"."schemeId",
  "tempDebtData".frn,
  "tempDebtData".reference,
  "tempDebtData"."netValue",
  "tempDebtData"."debtType",
  TO_CHAR("tempDebtData"."recoveryDate", 'YYYY-MM-DD'),
  "tempDebtData"."attachedDate",
  "tempDebtData"."createdDate",
  "tempDebtData"."createdBy",
  "tempDebtData"."createdById",
  NOW()
FROM public."tempDebtData"
LEFT JOIN public."debtData"
  ON "tempDebtData".reference = "debtData".reference
  AND "tempDebtData".frn = "debtData".frn
  AND "tempDebtData"."schemeId" = "debtData"."schemeId"
  AND "tempDebtData"."netValue" = "debtData"."netValue"
WHERE "debtData".reference IS NULL;

COMMIT;
