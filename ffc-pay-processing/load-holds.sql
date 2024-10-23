INSERT INTO holds(
  frn,
  "holdCategoryId",
  added,
  migrated)
SELECT
  "v2TempHoldData".frn,
  "v2TempHoldData"."holdCategoryId",
  "v2TempHoldData".added,
  NOW()
FROM "v2TempHoldData"
LEFT JOIN (
  SELECT
    frn,
    "holdCategoryId"
  FROM holds
  WHERE closed IS NULL
) "currentHolds"
  ON "v2TempHoldData".frn = "currentHolds".frn
  AND "v2TempHoldData"."holdCategoryId" = "currentHolds"."holdCategoryId"
JOIN "holdCategories"
  ON "v2TempHoldData"."holdCategoryId" = "holdCategories"."holdCategoryId"
WHERE "currentHolds".frn IS NULL
  AND "holdCategories"."schemeId" != 7;
