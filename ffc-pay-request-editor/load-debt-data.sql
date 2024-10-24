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
  "v2TempDebtData"."schemeId",
  "v2TempDebtData".frn,
  "v2TempDebtData".reference,
  "v2TempDebtData"."netValue",
  "v2TempDebtData"."debtType",
  TO_CHAR("v2TempDebtData"."recoveryDate", 'YYYY-MM-DD'),
  "v2TempDebtData"."attachedDate",
  "v2TempDebtData"."createdDate",
  "v2TempDebtData"."createdBy",
  "v2TempDebtData"."createdById",
  NOW()
FROM public."v2TempDebtData"
LEFT JOIN public."debtData"
  ON "v2TempDebtData".reference = "debtData".reference
  AND "v2TempDebtData".frn = "debtData".frn
  AND "v2TempDebtData"."schemeId" = "debtData"."schemeId"
  AND "v2TempDebtData"."netValue" = "debtData"."netValue"
WHERE "debtData".reference IS NULL
  AND "v2TempDebtData"."schemeId" != 7;
