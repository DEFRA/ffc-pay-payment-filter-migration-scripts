INSERT INTO holds(
  frn,
  "holdCategoryId",
  added,
  migrated)
SELECT
  "tempHoldData".frn,
  "tempHoldData"."holdCategoryId",
  "tempHoldData".added,
  NOW()
FROM "tempHoldData"
LEFT JOIN (
  SELECT
    frn,
    "holdCategoryId"
  FROM holds
  WHERE closed IS NULL
) "currentHolds"
  ON "tempHoldData".frn = "currentHolds".frn
  AND "tempHoldData"."holdCategoryId" = "currentHolds"."holdCategoryId"
JOIN "holdCategories"
  ON "tempHoldData"."holdCategoryId" = "holdCategories"."holdCategoryId"
WHERE "currentHolds".frn IS NULL
  AND "holdCategories"."schemeId" != 7;
