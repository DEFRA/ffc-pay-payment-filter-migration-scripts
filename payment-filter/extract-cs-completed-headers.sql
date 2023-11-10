
SELECT
	   CONCAT('CS_', H.ID) migrationId,
	   CONCAT('S', RIGHT([XML Out].value('(/Root/Requests/Request/Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 7), COALESCE([XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), S.[Claim Number]), 'V', FORMAT([XML Out].value('(/Root/Requests/Request/Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000')) inboundInvoiceNumber, 
	   5 schemeId,
	   R.request.value('(./Invoice/@InvoiceType)[1]', 'VARCHAR(50)') ledger,
	   'SITI AGRI CS SYS' sourceSystem,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@DeliveryBody)[1]', 'VARCHAR(50)') deliveryBody,
	   CONCAT('S', RIGHT(R.request.value('(/Root/Requests/Request/Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 7), COALESCE(NULLIF(R.request.value('(./Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), ''), S.[Claim Number]), 'V', CASE ISNUMERIC(RIGHT(R.request.value('(./Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 1)) WHEN 1 THEN FORMAT(R.request.value('(./Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000') ELSE FORMAT(R.request.value('(./Invoice/@RequestInvoiceNumber)[1]', 'INT'), '00') END)  invoiceNumber,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@FRN)[1]', 'BIGINT') frn,
	   NULL sbi,
	   COALESCE(COALESCE([XML Out].value('(/Root/Requests/Request/InvoiceLines/InvoiceLine/@AgreementNumber)[1]', 'VARCHAR(50)'), [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)')), S.[Claim Number]) agreementNumber,
	   COALESCE([XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), S.[Claim Number]) contractNumber,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@PaymentPreferenceCurrency)[1]', 'VARCHAR(50)') currency,
	   NULL schedule,
	   FORMAT([XML Out].value('(/Root/Requests/Request/InvoiceLines/InvoiceLine/@DueDate)[1]', 'DATETIME'), 'dd/MM/yyyy') dueDate,
	   CAST(R.request.value('(./Invoice/@TotalAmount)[1]', 'DECIMAL(18, 2)') * 100 AS INT) value,
	   GETDATE() acknowledged,
       [XML Out].value('(/Root/Requests/Request/InvoiceLines/InvoiceLine/@MarketingYear)[1]', 'INT') marketingYear,
	   NULLIF(LOWER(R.request.value('(./InvoiceLines/InvoiceLine/@DebtType)[1]', 'VARCHAR(50)')), '') debtType,
	   NULLIF(R.request.value('(./Invoice/@RecoveryDate)[1]', 'DATETIME'), '') recoveryDate,
	   NULLIF(R.request.value('(./Invoice/@OriginalSettlementDate)[1]', 'DATETIME'), '') originalSettlementDate,
	   NULLIF(R.request.value('(./Invoice/@OriginalInvoiceNumber)[1]', 'VARCHAR(50)'), '') originalInvoiceNumber,
	   NULLIF(R.request.value('(./Invoice/@InvoiceCorrectionReference)[1]', 'VARCHAR(50)'), '') invoiceCorrectionReference,
	   COALESCE(H.[AP Sent to TL], H.[AR Sent to TL]) submitted,
	   R.request.value('(./Invoice/@RequestInvoiceNumber)[1]', 'INT') paymentRequestNumber,
	   0 invalid,
	   0 settledValue,
	   NULL lastSettlement,
	   NULL referenceId,
	   NULL correlationId,
	   CONCAT('SITICS', [XML Out].value('(/Root/Batch/@BatchID)[1]', 'VARCHAR(50)'), '_AP_', FORMAT([XML Out].value('(/Root/Batch/@ExportDate)[1]', 'DATETIME'), 'yyyyMMddHHmmss'), '.dat') batch,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@PaymentType)[1]', 'INT') paymentType,
	   NULL pillar,
	   NULL exchangeRate,
	   NULL eventDate,
	   NULL vendor,
	   NULL trader,
	   NULL claimDate   
  FROM [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgriCS AP Headers] H
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgriCS AP Controls] C
  ON H.[File ID] = C.[File ID]
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Stage].[SitiAgriCS AP Headers] S
  ON H.ID = S.ID
  CROSS APPLY H.[XML In].nodes('/Root/Requests/Request') R(request)
  WHERE [on Hold] = 0
  AND H.[Is Not Valid Flag] = 0
  AND C.[Is Not Valid Flag] = 0
  AND H.[XML In] IS NOT NULL
