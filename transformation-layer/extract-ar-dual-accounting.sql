SELECT DISTINCT
  Claim AS "invoiceNumber",
  Fund AS "fundCode"
FROM [Transformation Layer (Production)].[Load].[DAX AR]
WHERE Fund IN ('DOM00', 'DOM00', 'DOM01', 'DRD05', 'DRD00', 'DRD01')
  AND [Source System] IN ('SITIAgri', 'SITICS')
