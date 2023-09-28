
SELECT
	   CONCAT('BPS_', H.ID) migrationId,
	   CASE [XML Out].value('(/Root/Batch/@CreatorID)[1]', 'VARCHAR(50)') WHEN 'FDMR' THEN 7 ELSE 6 END schemeId,
	   [XML Out].value('(/Root/Batch/@CreatorID)[1]', 'VARCHAR(50)') sourceSystem,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@DeliveryBody)[1]', 'VARCHAR(50)') deliveryBody,
	   CONCAT(REPLACE(REPLACE([XML Out].value('(/Root/Requests/Request/Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 'PFSY', 'S'), 'FDMR', 'F'), [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), 'V', FORMAT([XML Out].value('(/Root/Requests/Request/Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000'))  invoiceNumber,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@FRN)[1]', 'BIGINT') frn,
	   NULL sbi,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)') agreementNumber,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)') contractNumber,
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
	   CONCAT('SITI_', [XML Out].value('(/Root/Batch/@BatchID)[1]', 'VARCHAR(50)'), '_AP_', FORMAT([XML Out].value('(/Root/Batch/@ExportDate)[1]', 'DATETIME'), 'yyyyMMddHHmmss'), '.dat') batch,
	   NULL paymentType,
	   NULL pillar,
	   NULL exchangeRate,
	   NULL eventDate,
	   NULL vendor,
	   NULL trader,
	   NULL claimDate,
	   NULL originalInvoiceNumber,
	   NULL invoiceCorrectionReference	   
  FROM [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgri AP Headers] H
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgri AP Controls] C
  ON H.[File ID] = C.[File ID]
  WHERE [on Hold] = 0
  AND H.[Is Not Valid Flag] = 0
  AND C.[Is Not Valid Flag] = 0