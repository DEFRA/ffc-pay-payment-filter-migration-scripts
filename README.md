# FFC Pay Payment Filter data migration scripts
Migration scripts to support migration of Payment Filter data to Payment Hub

## Process
This data migration is part of a wider migration strategy document in [Confluence](https://eaflood.atlassian.net/wiki/spaces/SFI/pages/4518969387/Payment+Filter+Data+Migration)

The following steps should be executed in order to ensure data consistency.

If only Basic Payment Scheme (BPS) or Countryside Stewardship (CS) migration is being run then only need to run the steps under each heading.

> BPS and FDMR must be migrated together due to Payment Filter data structures.  BPS steps include FDMR.

### Disable Payment Filter processing

> To be performed by Enterprise Solutions Team

1. Connect to Production Payment Filter SQL Server with SSMS

TODO: disable inbound, enrichment and load.  Amend BizTalk polling for scheme specifics.

### Disable Payment Filter BizTalk routing

> To be performed by Enterprise Solutions Team

1. Connect to Production BizTalk Server

1. Open BizTalk Server Administration Console

1. Navigate to `BizTalk Server Administration` > `BizTalk Group` > `Applications` > `RPA.Finance.PaymentFilter.PaymentProcessor`

1. Disable all receive locations

1. Confirm all BizTalk processing activity has completed

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

1. Agree SharePoint location

1. Upload all CSV files to SharePoint location


### Verify CSV files

> To be performed by Payments Team

1. Verify all CSV files are present

1. Verify all CSV filenames are correct

1. Verify content of CSV files is correct

### Update Payment Processing

> To be performed by CCoE.  Will need to use `psql` client to upload data due to volume of data.

1. Download all CSV files from SharePoint location to local machine

1. Connect to target FFC Azure PostgreSQL server using client of choice

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
      \copy "tempHolds" FROM '/path/to/holdsData.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

TODO: Add data upload

1. Execute [ffc-pay-processing/delete-temp-tables.sql](ffc-pay-processing/delete-temp-tables.sql)

### Update Request Editor

1. Connect to target FFC Azure PostgreSQL server using client of choice

1. Execute [ffc-pay-request-editor/create-temp-tables.sql](ffc-pay-request-editor/create-temp-tables.sql)

1. Connect to target FFC Azure PostgreSQL server using `psql`
   ```
    psql -h <host> -U <username> -d ffc-pay-processing-<env>
   ```

1. Execute 
    ```
      \copy "tempDebtData" FROM '/path/to/debtData.csv' DELIMITER ',' NULL 'NULL' CSV HEADER;
    ```

TODO: Add data upload

1. Execute [ffc-pay-request-editor/delete-temp-tables.sql](ffc-pay-request-editor/delete-temp-tables.sql)

### Build return file for settlement data

1. Request settlement report from CPAT covering all BPS, CS and FDMR pilot payments

. Clone repository https://github.com/defra/ffc-pay-settlement-to-return-file with:
     ```
     git clone https://github.com/ffc-pay-settlement-to-return-file.git
     ```

1. Create required directories in root of repository with:
    ```
    mkdir -p ./input
    mkdir -p ./output
    ```

1. Copy all CPAT report files to `input` directory

1. Run `npm run start` to run with Node.js or `./scripts/start -b` to run with Docker
   
1. Return file will be output to the `output` directory

### Process return file

50. Navigate to Azure payment blob storage account

51. Upload return file created at `22` to `dax` container in `inbound` virtual directory

52. Within 1 minute, file should be consumed by `ffc-pay-responses` Kubernetes pod and moved to `archive` subdirectory

## Reset databases

In the event the migration needs to be reversed or to support creating a "clean" environment, the following scripts can be run.

- [ffc-pay-processing](ffc-pay-processing/reset.sql)
- [ffc-pay-request-editor](ffc-pay-request-editor/reset.sql)
