
SELECT
	   CONCAT('CS_', H.ID) migrationId,
	   5 schemeId,
	   'SITI AGRI CS SYS' sourceSystem,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@DeliveryBody)[1]', 'VARCHAR(50)') deliveryBody,
	   CONCAT('S', RIGHT([XML Out].value('(/Root/Requests/Request/Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 7), COALESCE([XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), S.[Claim Number]), 'V', FORMAT([XML Out].value('(/Root/Requests/Request/Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000'))  invoiceNumber,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@FRN)[1]', 'BIGINT') frn,
	   NULL sbi,
	   COALESCE(COALESCE([XML Out].value('(/Root/Requests/Request/InvoiceLines/InvoiceLine/@AgreementNumber)[1]', 'VARCHAR(50)'), [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)')), S.[Claim Number]) agreementNumber,
	   COALESCE([XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), S.[Claim Number]) contractNumber,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@PaymentPreferenceCurrency)[1]', 'VARCHAR(50)') currency,
	   NULL schedule,
	   FORMAT([XML Out].value('(/Root/Requests/Request/InvoiceLines/InvoiceLine/@DueDate)[1]', 'DATETIME'), 'dd/MM/yyyy') dueDate,
	   CAST([XML Out].value('(/Root/Requests/Request/Invoice/@TotalAmount)[1]', 'DECIMAL(18, 2)') * 100 AS INT) value,
	   GETDATE() received,
	   [XML Out].value('(/Root/Requests/Request/InvoiceLines/InvoiceLine/@MarketingYear)[1]', 'INT') marketingYear,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@RequestInvoiceNumber)[1]', 'INT') paymentRequestNumber,
	   'AP' ledger,
	   NULL debtType,
	   NULL recoveryDate,
	   NULL originalSettlementDate,
	   NEWID() referenceId,
	   NEWID() correlationId,
	   CONCAT('SITICS', [XML Out].value('(/Root/Batch/@BatchID)[1]', 'VARCHAR(50)'), '_AP_', FORMAT([XML Out].value('(/Root/Batch/@ExportDate)[1]', 'DATETIME'), 'yyyyMMddHHmmss'), '.dat') batch,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@PaymentType)[1]', 'INT') paymentType,
	   NULL pillar,
	   NULL exchangeRate,
	   NULL eventDate,
	   NULL vendor,
	   NULL trader,
	   NULL claimDate,
	   NULL originalInvoiceNumber,
	   NULL invoiceCorrectionReference	   
  FROM [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgriCS AP Headers] H
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgriCS AP Controls] C
  ON H.[File ID] = C.[File ID]
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Stage].[SitiAgriCS AP Headers] S
  ON H.ID = S.ID
  WHERE [on Hold] = 0
  AND H.[Is Not Valid Flag] = 0
  AND C.[Is Not Valid Flag] = 0