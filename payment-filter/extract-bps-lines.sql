
SELECT
	   CONCAT('BPS_', H.ID) migrationId,
	   CONCAT(REPLACE(REPLACE([XML Out].value('(/Root/Requests/Request/Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 'PFSY', 'S'), 'FDMR', 'F'), [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), 'V', FORMAT([XML Out].value('(/Root/Requests/Request/Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000'))  invoiceNumber,
	   NULL accountCode,
	   l.line.value('(@Fund)[1]', 'VARCHAR(50)') fundCode,
	   l.line.value('(@LineTypeDescription)[1]', 'VARCHAR(50)') description,
	   CAST(l.line.value('(@Value)[1]', 'DECIMAL(18, 2)') * 100 AS INT)  value,
	   l.line.value('(@SchemeCode)[1]', 'VARCHAR(50)') schemeCode,
	   0 convergence,
	   l.line.value('(@DeliveryBody)[1]', 'VARCHAR(50)') deliveryBody,
	   l.line.value('(@SchemeCode)[1]', 'VARCHAR(50)') schemeCode,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)') agreementNumber,
	   l.line.value('(@MarketingYear)[1]', 'INT') marketingYear,
	   0 stateAid
  FROM [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgri AP Headers] H
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgri AP Controls] C
  ON H.[File ID] = C.[File ID]
  CROSS APPLY H.[XML Out].nodes('/Root/Requests/Request/InvoiceLines/InvoiceLine') L(line)
  WHERE [on Hold] = 0
  AND H.[Is Not Valid Flag] = 0
  AND C.[Is Not Valid Flag] = 0