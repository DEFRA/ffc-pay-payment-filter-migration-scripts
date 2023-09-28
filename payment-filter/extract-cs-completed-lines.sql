
SELECT
	   CONCAT('CS_', H.ID) migrationId,
	   CONCAT('S', RIGHT([XML Out].value('(/Root/Requests/Request/Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 7), COALESCE([XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), S.[Claim Number]), 'V', FORMAT([XML Out].value('(/Root/Requests/Request/Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000'))  inboundInvoiceNumber,
	   CONCAT('S', RIGHT(R.request.value('(./Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 7), COALESCE(NULLIF(R.request.value('(./Invoice/@ClaimNumber)[1]', 'VARCHAR(50)'), ''), S.[Claim Number]), 'V', CASE ISNUMERIC(RIGHT(R.request.value('(./Invoice/@InvoiceNumber)[1]', 'VARCHAR(50)'), 1)) WHEN 1 THEN FORMAT(R.request.value('(./Invoice/@RequestInvoiceNumber)[1]', 'INT'), '000') ELSE FORMAT(R.request.value('(./Invoice/@RequestInvoiceNumber)[1]', 'INT'), '00') END)  invoiceNumber,
	   l.line.value('(@MSDaxAccountCode)[1]', 'VARCHAR(50)') accountCode,
	   l.line.value('(@Fund)[1]', 'VARCHAR(50)') fundCode,
	   l.line.value('(@LineTypeDescription)[1]', 'VARCHAR(50)') description,
	   CAST(l.line.value('(@Value)[1]', 'DECIMAL(18, 2)') * 100 AS INT)  value,
	   l.line.value('(@SchemeCode)[1]', 'VARCHAR(50)') schemeCode,
	   CASE l.line.value('(@Convergence)[1]', 'VARCHAR(50)') WHEN 'Y' THEN 1 ELSE 0 END convergence,
	   l.line.value('(@DeliveryBody)[1]', 'VARCHAR(50)') deliveryBody,
	   l.line.value('(@SchemeCode)[1]', 'VARCHAR(50)') schemeCode,
	   [XML Out].value('(/Root/Requests/Request/Invoice/@ClaimNumber)[1]', 'VARCHAR(50)') agreementNumber,
	   l.line.value('(@MarketingYear)[1]', 'INT') marketingYear,
	   CASE l.line.value('(@MSDaxAccountCode)[1]', 'VARCHAR(50)') WHEN 'SOS228' THEN 1 WHEN 'SOS229' THEN 1 ELSE 0 END stateAid
  FROM [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgriCS AP Headers] H
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Working].[SitiAgriCS AP Controls] C
  ON H.[File ID] = C.[File ID]
  INNER JOIN [RPA.Finance.PaymentFilter.PaymentBatchProcessor (Production)].[Stage].[SitiAgriCS AP Headers] S
  ON H.ID = S.ID
  CROSS APPLY H.[XML In].nodes('/Root/Requests/Request') R(request)
  CROSS APPLY R.request.nodes('./InvoiceLines/InvoiceLine') L(line)
  WHERE [on Hold] = 0
  AND H.[Is Not Valid Flag] = 0
  AND C.[Is Not Valid Flag] = 0