# FFC Pay Payment Filter data migration scripts
Migration scripts to support migration of Payment Filter data to Payment Hub

## Process
This data migration is part of a wider migration strategy document in [Confluence](https://eaflood.atlassian.net/wiki/spaces/SFI/pages/4518969387/Payment+Filter+Data+Migration)

The following steps should be executed in order to ensure data consistency.

If only Basic Payment Scheme (BPS) or Countryside Stewardship (CS) migration is being run then only need to run the steps under each heading.

> BPS and FDMR must be migrated together due to Payment Filter data structures.  BPS steps include FDMR.

## Pre-requisites

> To be performed by Enterprise Solutions Team & CapGemini Biztalk support

Payment Filter processing has been disabled for schemes to be migrated.  Assurance given that no further payments will be processed for schemes to be migrated.

This will likely involve CapGemini updating BizTalk polling statements in Payment Batch Processor, Settlement Request Editor, Quality Check, Cross Border Payment Engine and Exceptions followed by an agreed period of time to ensure no further payments are processed.

NB, when running these scripts on the Transformation Layer, please ensure that the below Query Options are set within the Results - Grid section:

1. Include column headers when copying or saving the results

1. Quote strings containing list separators when saving .csv results

This is required as failing to apply this means that we are likely to face issues with the import scripts.

### Extract inbound payment requests from Payment Filter

> To be performed by Enterprise Solutions Team

1. Connect to Production Payment Filter SQL Server with SSMS

#### BPS

1. Execute [extract-bps-headers.sql](payment-filter/extract-bps-headers.sql)

1. Save results as CSV with headers with name `bpsHeaders.csv`

1. Execute [extract-bps-lines.sql](payment-filter/extract-bps-lines.sql)

1. Save results as CSV with headers with name `bpsLines.csv`

#### CS

1. Execute [extract-cs-headers.sql](payment-filter/extract-cs-headers.sql)

1. Save results as CSV with headers with name `csHeaders.csv`

1. Execute [extract-cs-lines.sql](payment-filter/extract-cs-lines.sql)

1. Save results as CSV with headers with name `csLines.csv`

### Extract outbound payment requests from Payment Filter

> To be performed by Enterprise Solutions Team

1. Connect to Production Payment Filter SQL Server with SSMS

#### BPS

1. Execute [extract-bps-completed-headers.sql](payment-filter/extract-bps-completed-headers.sql)

1. Save results as CSV with headers with name `bpsCompletedHeaders.csv`

1. Execute [extract-bps-completed-lines.sql](payment-filter/extract-bps-completed-lines.sql)

1. Save results as CSV with headers with name `bpsCompletedLines.csv`

#### CS

1. Execute [extract-cs-completed-headers.sql](payment-filter/extract-cs-completed-headers.sql)

1. Save results as CSV with headers with name `csCompletedHeaders.csv`

1. Execute [extract-cs-completed-lines.sql](payment-filter/extract-cs-completed-lines.sql)

1. Save results as CSV with headers with name `csCompletedLines.csv`

### Extract holds from Payment Filter

> To be performed by Enterprise Solutions Team

1. Connect to Production Payment Filter SQL Server with SSMS

1. Update `WHERE` clause in [extract-holds.sql](payment-filter/extract-holds.sql) if not migrating all schemes.

1. Execute [extract-holds.sql](payment-filter/extract-holds.sql)

1. Save results as CSV with headers with name `holdsData.csv`

### Extract debt data from Payment Filter

> To be performed by Enterprise Solutions Team.  Due to Settlement Request Editor data structure will need to be repeated as is if not migrating all schemes at once.

1. Connect to Production Payment Filter SQL Server with SSMS

1. Execute [extract-debt.sql](payment-filter/extract-debt.sql)

1. Save results as CSV with headers with name `debtData.csv`

### Transfer all CSV files to secure location

> To be performed by Enterprise Solutions Team

1. Agree SharePoint location: [Payment Filter Output](https://defra.sharepoint.com/sites/ea-leg-djw/DDS/Shared%20Documents/Forms/AllItems.aspx?ct=1684927252642&or=Teams%2DHL&ga=1&LOF=1&id=%2Fsites%2Fea%2Dleg%2Ddjw%2FDDS%2FShared%20Documents%2FDDTS%20Development%20Team%2FProjects%2FPayment%20Hub%20Migration%2FOutput%20Files&viewid=5b986c5b%2Df0c1%2D4450%2D8329%2D7e93856a8044&OR=Teams%2DHL&CT=1708952287676&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNDAxMDQxOTEzMCIsIkhhc0ZlZGVyYXRlZFVzZXIiOnRydWV9)

1. Upload all CSV files to SharePoint location


### Verify CSV files

> To be performed by Payments Team & Enterprise Solutions Team

1. Verify all CSV files are present

1. Verify all CSV filenames are correct

1. Verify content of CSV files is correct

1. EST to confirm that the number of payments and invoice lines extracted on Sharepoint matches nunber of lines in the Payment Filter.

### Load Payments

> To be performed by CCoE.  Will need to use `psql` client to upload data due to volume of data.

1. Download all CSV files from SharePoint location to local machine: [Payment Filter Output](https://defra.sharepoint.com/sites/ea-leg-djw/DDS/Shared%20Documents/Forms/AllItems.aspx?ct=1684927252642&or=Teams%2DHL&ga=1&LOF=1&id=%2Fsites%2Fea%2Dleg%2Ddjw%2FDDS%2FShared%20Documents%2FDDTS%20Development%20Team%2FProjects%2FPayment%20Hub%20Migration%2FOutput%20Files&viewid=5b986c5b%2Df0c1%2D4450%2D8329%2D7e93856a8044&OR=Teams%2DHL&CT=1708952287676&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNDAxMDQxOTEzMCIsIkhhc0ZlZGVyYXRlZFVzZXIiOnRydWV9)

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Connect to `ffc-pay-processing-<ENV>` database

1. Execute [ffc-pay-processing/create-temp-tables.sql](ffc-pay-processing/create-temp-tables.sql)

1. Connect to target FFC Azure PostgreSQL server using `psql`.  Enter password when prompted.
   ```
    psql -h <host> -U <username> -d ffc-pay-processing-<env>
   ```

1. Execute 
    ```
      \copy "tempPaymentRequests" FROM '/path/to/bpsHeaders.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute 
    ```
      \copy "tempPaymentRequests" FROM '/path/to/csHeaders.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute
    ```
      \copy "tempInvoiceLines" FROM '/path/to/bpsLines.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute
    ```
      \copy "tempInvoiceLines" FROM '/path/to/csLines.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute
    ```
      \copy "tempCompletedPaymentRequests" FROM '/path/to/bpsCompletedHeaders.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute
    ```
      \copy "tempCompletedPaymentRequests" FROM '/path/to/csCompletedHeaders.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute
    ```
      \copy "tempCompletedInvoiceLines" FROM '/path/to/bpsCompletedLines.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute
    ```
      \copy "tempCompletedInvoiceLines" FROM '/path/to/csCompletedLines.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute
    ```
      \copy "tempHoldData" FROM '/path/to/holdsData.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Connect to `ffc-pay-processing-<ENV>` database

1. Execute [ffc-pay-processing/load-payments.sql](ffc-pay-processing/load-payments.sql)

1. Execute [ffc-pay-processing/fix-anomalies.sql](ffc-pay-processing/fix-anomalies.sql)

### Load debt data

> To be performed by CCoE.  Will need to use `psql` client to upload data due to volume of data.

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Connect to `ffc-pay-request-editor-<ENV>` database

1. Execute [ffc-pay-request-editor/create-temp-tables.sql](ffc-pay-request-editor/create-temp-tables.sql)

1. Connect to target FFC Azure PostgreSQL server using `psql`
   ```
    psql -h <host> -U <username> -d ffc-pay-request-editor-<env>
   ```

1. Execute 
    ```
      \copy "tempDebtData" FROM '/path/to/debtData.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Connect to `ffc-pay-request-editor-<ENV>` database

1. Execute [ffc-pay-request-editor/load-debt-data.sql](ffc-pay-request-editor/load-debt-data.sql)

### Build file for settlement data

> To be performed by Payments Team

1. Request settlement report from CPAT covering all BPS, CS and FDMR payments, uploaded to [Settlement Files](https://defra.sharepoint.com/sites/ea-leg-djw/DDS/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2Fea%2Dleg%2Ddjw%2FDDS%2FShared%20Documents%2FDDTS%20Development%20Team%2FTemporary%20Storage%20%28Files%20older%20than%2012%20months%20will%20be%20deleted%29%2FPayment%5FHub%5FData%5FSharing&p=true&ct=1708956538096&or=Teams%2DHL&ga=1)

1. Convert received settlement reports into a CSV format by removing headers, saving as csv. Reupload CSV copy to above SharePoint, with names `bpsSettlementData.csv`, `fdmrSettlementData.csv` and `csSettlementData.csv`

### Process settlement data

> To be performed by CCoE. Will need to use `psql` client to upload data due to volume of data.

1. Download settlement files `bpsSettlementData.csv`, `fdmrSettlementData.csv` and `csSettlementData.csv` from [Settlement Files](https://defra.sharepoint.com/sites/ea-leg-djw/DDS/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2Fea%2Dleg%2Ddjw%2FDDS%2FShared%20Documents%2FDDTS%20Development%20Team%2FTemporary%20Storage%20%28Files%20older%20than%2012%20months%20will%20be%20deleted%29%2FPayment%5FHub%5FData%5FSharing&p=true&ct=1708956538096&or=Teams%2DHL&ga=1)

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Connect to `ffc-pay-processing-<ENV>` database

1. Execute [ffc-pay-processing/create-temp-settlement-data.sql](ffc-pay-processing/create-temp-settlement-data.sql)

1. Connect to target FFC Azure PostgreSQL server using `psql`
   ```
    psql -h <host> -U <username> -d ffc-pay-processing-<env>
   ```

1. Execute 
    ```
      \copy "tempSettlementData" FROM '/path/to/bpsSettlementData.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute 
    ```
      \copy "tempSettlementData" FROM '/path/to/fdmrSettlementData.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Execute 
    ```
      \copy "tempSettlementData" FROM '/path/to/csSettlementData.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Connect to `ffc-pay-processing-<ENV>` database

1. Execute [ffc-pay-processing/update-settlement-data.sql](ffc-pay-processing/update-settlement-data.sql)

### Confirm settlement data updated

> To be performed by CCoE/Payments Team

1. View tempSettlementData table in `ffc-pay-processing` has as many entries as rows in the CSV files.

### Schedule processing

> To be performed by CCoE.

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Connect to `ffc-pay-processing-<ENV>` database

1. Execute [ffc-pay-processing/load-schedule.sql](ffc-pay-processing/load-schedule.sql)

## Expected outcomes

1. Any BPS, CS or FDMR payment request that had completed payment processing but not sent to the Transformation Layer should be sent from `ffc-pay-processing` to `ffc-pay-submission`.

1. Any BPS, CS or FDMR payment request that had a blocking hold should be blocked by a hold in `ffc-pay-processing`.

1. Any BPS, CS or FDMR payment request that was held in the Settlement Request Editor or Quality Check application should be sent from `ffc-pay-processing` to `ffc-pay-request-editor`.

1. The number of payment requests and invoice lines uploaded to Payment Hub matches the expected amount.

## Reset databases

In the event the migration needs to be reversed, the following scripts can be run.

- [ffc-pay-request-editor](ffc-pay-request-editor/rollback.sql)
- [ffc-pay-processing](ffc-pay-processing/rollback.sql)

> DO NOT run `reset.sql` scripts as these will delete all data from the database.  For local development scenarios only.

## Clean up

> To be optionally performed by CCoE if approval given by Payments Team.  It is likely this will be through a subsequent change once confirmed the migration is complete for the target environment.

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Connect to `ffc-pay-processing-<ENV>` database

1. Execute [ffc-pay-processing/delete-temp-tables.sql](ffc-pay-processing/delete-temp-tables.sql)

1. Connect to `ffc-pay-request-editor-<ENV>` database

1. Execute [ffc-pay-request-editor/delete-temp-tables.sql](ffc-pay-request-editor/delete-temp-tables.sql)
