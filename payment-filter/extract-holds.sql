/****** Script for SelectTopNRows command from SSMS  ******/
CREATE TABLE #PHMigrationHoldCategories (
  holdCategoryId INT,
  schemeId INT,
  name VARCHAR(255),
  reasonId UNIQUEIDENTIFIER
)

INSERT INTO #PHMigrationHoldCategories
VALUES


(56,5,'DAX rejection',NULL),
(57,5,'Awaiting debt enrichment',NULL),
(58,5,'Ex-gratia',NULL),
(59,5,'Hardship case',NULL),
(60,5,'Non-payable',NULL),
(61,5,'Withdrawal',NULL),
(62,5,'Manual payment','5EB43F02-7317-444F-8782-FE7401B1718E'),
(63,5,'Bridging payments',NULL),
(64,5,'Other admin',NULL),
(65,5,'Bank account anomaly','E979E2AD-B3DB-413A-AE64-FBF1A092AE37'),
(66,5,'Recovery',NULL),
(67,5,'Top up',NULL),
(68,5,'Manual ledger hold',NULL),
(70,5,'Delta Validation Check','53737712-343D-44C2-BA74-887780FC0791'),
(71,5,'AI Marketing Year Error','97AD0DAF-33EB-4091-B19F-656A90186507'),
(72,5,'2016 Interim','0E90D0BA-B3C5-4A87-837C-E6400732D24B'),
(73,5,'2017 Bridging Payment','6C3E89BB-A54F-4F9F-B6C6-5D66DC015732'),
(74,5,'2017 Hardship','4897A2CF-DF11-4D34-BA04-38BE6EDBD777'),
(75,5,'2018 Bridging Payment','F1B82631-4446-4659-9EAC-7C8F42DF6310'),
(76,5,'2019 Bridging Payment','3327E7F4-003F-4904-9F2A-5B44C36686E5'),
(76,5,'2019 Bridging Payment', 'EA23917D-8010-4066-B50E-9661CE346FC8'),
(77,5,'Advance Tick','29690663-5AD3-4F2F-8560-B0F57587A4DC'),
(78,5,'Capital Payments','6CE6976D-0C34-4060-BF4D-147F7BD20076'),
(79,5,'Capital Recoveries','93978360-D8F7-4124-AB28-9ED3655D0FB7'),
(80,5,'Claim affected by INC0553223','C8D0512D-9259-497B-8DA2-9132838B1665'),
(81,5,'FSP','8DF4606D-8B19-47CB-8D58-3BCE0A075AD4'),
(82,5,'Treasury','BBA800C9-41E0-4FF1-84D1-8FBB8C85B208'),
(83,6,'Bank account anomaly','D6C9B947-7A00-4352-BAF8-9A60FCF80577'),
(84,6,'DAX rejection',NULL),
(85,6,'Awaiting debt enrichment',NULL),
(86,6,'Recovery',NULL),
(87,6,'Top up',NULL),
(88,6,'BACS Recalls XC only','3D86B910-BFDD-46CC-9004-D4F021028A2D'),
(89,6,'Delta Validation Check','03311820-0EB8-4077-A64B-126F393EDD94'),
(90,6,'3YP','6CCBB6FB-0625-42D3-9C75-7FF39D38F1BA'),
(91,6,'Ex-gratia','625D06C1-F125-4A17-9A99-C059DF8C3324'),
(92,6,'Bridging Payments','17CA4D0E-E698-48D9-9D11-CD5CBE6E530A'),
(93,6,'Commons Manual','15555D69-19D9-4F0C-80A0-53BB800D3AA1'),
(94,6,'Cross Border D2P','6BD14389-0E76-418A-A51C-6833F9F9D333'),
(95,6,'Cross Border E2P','BACB2568-70D6-4232-8CF8-1DB579D76C77'),
(96,6,'FRNs With Debts','8E3D826D-AEA6-459B-A6E4-F688DEFD7A0A'),
(97,6,'Greyed Out Lines','811C2357-5FF1-49FF-90BB-AA4322D20E1D'),
(98,6,'Hardship Case','B4476A07-00A7-4C2E-91A9-28A0806482F3'),
(99,6,'Incorrect Currency Preference','A1D9715A-3EB5-4F0D-BDEE-EFCBA049987E'),
(100,6,'Manual Payments - June','B28772F1-B886-4D08-88BB-0666314047C8'),
(101,6,'NF Commons Manual','FEE4702F-AB2A-42D9-809F-B289A531018D'),
(102,6,'Non-Declaration Penalties','57A9B7F2-30E2-4BE5-AEBC-61B89980D1D7'),
(103,6,'Non-Payable','74B30B4C-71B4-4A95-A528-551FF5C6C39F'),
(104,6,'Payment Hold 2016','9B6A213B-6E98-459C-BC95-9602BEAACC40'),
(105,6,'QA','6BCA074F-2C25-4F59-8230-3B0C22AAF858'),
(106,6,'RPA Land Bank','92114969-1D53-471F-986A-E70AD80FDC51'),
(107,6,'Unregistered Customer','0906FCEC-405D-46FF-9710-108F4594A8CA'),
(108,6,'Withdrawal','DF162EDF-4CD3-487B-BFE3-02B8FF15D2AB'),
(109,6,'Xcomp Obstruction','4FF439FF-8612-4986-A7BA-BFEE67646ABC'),
(110,7,'Bank account anomaly','00CCD2FA-B545-4CF1-A55C-3A52AF07E28B'),
(111,7,'DAX rejection',NULL),
(112,7,'Awaiting debt enrichment',NULL),
(113,7,'Recovery',NULL),
(114,7,'Top up',NULL),
(115,7,'Incorrect Currency Preference - FDM','6FFFF5E3-609B-42DE-BA74-AAF1EE6BB6BB'),
(116,6,'Manual ledger hold',NULL),
(117,7,'Manual ledger hold',NULL)

SELECT
      [frn],
	  P.holdCategoryId holdCategoryId,
	  GETDATE() added,
	  NULL removed
  FROM [RPA.Finance.ExceptionCases (Production)].[EL].[ExceptionsList] E
  INNER JOIN [RPA.Finance.ExceptionCases (Production)].[EL].Reasons R
  ON E.reason_id = R.id
  INNER JOIN [RPA.Finance.ExceptionCases (Production)].[EL].Creators C
  ON R.creator_id = C.id
  INNER JOIN #PHMigrationHoldCategories P
  ON R.id = P.reasonId
  WHERE removed = 0
  -- AND P.schemeId IN (5,6,7) -- if not migrating all schemes at same time

DROP TABLE #PHMigrationHoldCategories