
SELECT
	   CONCAT('BPS_', H.ID) migrationId,
	   CONCAT(REPLACE(REPLACE([XML Out].value('(/Root/Requests/Request/Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 'PFSY', 'S'), 'FDMR', 'F'), [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), 'V', FORMAT([XML Out].value('(/Root/Requests/Request/Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000'))  inboundInvoiceNumber, 
	   CASE [XML Out].value('(/Root/Batch/@CreatorID)[1]', 'VARCHAR(50)') WHEN 'FDMR' THEN 7 ELSE 6 END schemeId,
	   R.request.value('(./Invoice/@InvoiceType)[1]', 'VARCHAR(50)') ledger,
	   [XML Out].value('(/Root/Batch/@CreatorID)[1]', 'VARCHAR(50)') sourceSystem,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@DeliveryBody)[1]', 'VARCHAR(50)') deliveryBody,
	   CONCAT(REPLACE(REPLACE(R.request.value('(./Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 'PFSY', 'S'), 'FDMR', 'F'), R.request.value('(./Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), 'V', CASE ISNUMERIC(RIGHT(R.request.value('(./Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 1)) WHEN 1 THEN FORMAT(R.request.value('(./Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000') ELSE FORMAT(R.request.value('(./Invoice/@RequestInvoiceNumber)[1]', 'INT'), '00') END)  invoiceNumber,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@FRN)[1]', 'BIGINT') frn,
	   NULL sbi,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)') agreementNumber,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)') contractNumber,
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
	   CONCAT('SITI_', [XML Out].value('(/Root/Batch/@BatchID)[1]', 'VARCHAR(50)'), '_AP_', FORMAT([XML Out].value('(/Root/Batch/@ExportDate)[1]', 'DATETIME'), 'yyyyMMddHHmmss'), '.dat') batch,
	   NULL paymentType,
	   NULL pillar,
	   NULL exchangeRate,
	   NULL eventDate,
	   NULL vendor,
	   NULL trader,
	   NULL claimDate   
  FROM [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgri AP Headers] H
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgri AP Controls] C
  ON H.[File ID] = C.[File ID]
  CROSS APPLY H.[XML In].nodes('/Root/Requests/Request') R(request)
  WHERE [on Hold] = 0
  AND H.[Is Not Valid Flag] = 0
  AND C.[Is Not Valid Flag] = 0
  AND H.[XML In] IS NOT NULL