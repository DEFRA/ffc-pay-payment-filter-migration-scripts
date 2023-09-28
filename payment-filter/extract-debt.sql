/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	6 schemeId,
	D.FRN frn,
	COALESCE(D.ClaimReference, P.ClaimReference) reference,
	COALESCE(D.ClaimValue, P.ClaimValue) netValue,
	LOWER(D.DebtType) debtType,
	D.RecoveryDate recoveryDate,
	NULL attachedDate,
	D.Created createdDate,
	D.[User] createdBy,
	D.[User] createdById
  FROM [RPA.Finance.SettlementRequestEditor (Production)].[ADC].[DataCapture] D
  LEFT JOIN [RPA.Finance.SettlementRequestEditor (Production)].PR.PaymentRequests P
  ON D.PaymentRequestId = P.PaymentRequestId
  WHERE COALESCE(D.ClaimReference, P.ClaimReference) IS NOT NULL
  AND COALESCE(D.ClaimReference, P.ClaimReference) LIKE 'C%'
UNION
SELECT 
	5 schemeId,
	D.FRN frn,
	REPLACE(COALESCE(D.ClaimReference, P.ClaimReference), 'C', 'A') reference,
	COALESCE(D.ClaimValue, P.ClaimValue) netValue,
	LOWER(D.DebtType) debtType,
	D.RecoveryDate recoveryDate,
	NULL attachedDate,
	D.Created createdDate,
	D.[User] createdBy,
	D.[User] createdById
  FROM [RPA.Finance.SettlementRequestEditor (Production)].[ADC].[DataCapture] D
  LEFT JOIN [RPA.Finance.SettlementRequestEditor (Production)].PR.PaymentRequests P
  ON D.PaymentRequestId = P.PaymentRequestId
  WHERE COALESCE(D.ClaimReference, P.ClaimReference) IS NOT NULL
  AND COALESCE(D.ClaimReference, P.ClaimReference) LIKE 'C%'
