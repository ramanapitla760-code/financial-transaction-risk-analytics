# Financial Transaction Risk & Analytics Dashboard

## Project Overview

This project analyzes financial transaction data using **MySQL and Microsoft Power BI**.

The objective is to understand transaction volume, transaction value, currency distribution, hourly behavior, account concentration, IP concentration, and high-value transaction patterns.

The final Power BI dashboard is organized into three analytical stages:

**Transaction Overview → Transaction Risk Analysis → Transaction Investigation**

> **Important:** The final `fraud_transactions` dataset does not contain a confirmed fraud label such as `fraud_flag`. Therefore, this project identifies **potential risk indicators and transaction patterns** rather than confirming whether a transaction is fraudulent.

---

## Business Objective

The dashboard is designed to help an analyst:

- Monitor overall transaction activity
- Understand total and average transaction values
- Identify currencies with high transaction activity
- Analyze transaction behavior by hour
- Identify accounts associated with high transaction values
- Identify IP addresses associated with high transaction activity or value
- Find high-value transactions for further investigation
- Filter transaction-level details by date, currency, and account

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| **MySQL** | Database management, SQL queries, validation, and exploratory analysis |
| **Power Query** | Data cleaning, data-type validation, and transformation |
| **Power BI** | Interactive dashboard, slicers, aggregations, and visualization |
| **SQL** | Data exploration and analytical queries |

---

## Dataset

### Database

`fraudanalytics`

### Main Table

`fraud_transactions`

### Approximate Records

**8,430 transactions**

### Main Fields

| Field | Description |
|---|---|
| `transactionID` | Transaction identifier |
| `accountID` | Account identifier |
| `transactionAmount` | Monetary value of the transaction |
| `transactionCurrencyCode` | Transaction currency |
| `transactionDate` | Original transaction date |
| `TransactionDate_Clean` | Cleaned date used for time analysis |
| `transactionTime` | Transaction time |
| `localHour` | Hour of the transaction, 0–23 |
| `transactionIPAddress` | Transaction IP value |

---

# Project Workflow

```text
MySQL Database
      ↓
Data Inspection & Validation
      ↓
SQL Exploratory Analysis
      ↓
Power Query Cleaning
      ↓
Power BI Data Model
      ↓
Dashboard Development
      ↓
Risk Analysis
      ↓
Transaction Investigation
```

---

# 1. MySQL / SQL Analysis

The SQL stage was used to understand and validate the transaction dataset before building the Power BI dashboard.

### Main SQL activities

- Database and table inspection
- Record-count validation
- Data sampling
- Date-range analysis
- Completeness checks
- Duplicate transaction checks
- Transaction amount statistics
- Currency analysis
- Hourly transaction analysis
- Account analysis
- IP analysis
- High-value transaction identification
- High-value account analysis

### Important SQL concepts used

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

---

## Example SQL Queries

### Total Transactions

```sql
SELECT COUNT(*) AS total_transactions
FROM fraud_transactions;
```

### Total and Average Transaction Amount

```sql
SELECT
    COUNT(*) AS transactions,
    SUM(transactionAmount) AS total_amount,
    AVG(transactionAmount) AS average_amount
FROM fraud_transactions;
```

### Transactions by Currency

```sql
SELECT
    transactionCurrencyCode,
    COUNT(*) AS transactions
FROM fraud_transactions
GROUP BY transactionCurrencyCode
ORDER BY transactions DESC;
```

### Transaction Activity by Hour

```sql
SELECT
    localHour,
    COUNT(*) AS total_transactions,
    AVG(transactionAmount) AS average_amount
FROM fraud_transactions
GROUP BY localHour
ORDER BY average_amount DESC;
```

### Top 10 IP Addresses by Transaction Count

```sql
SELECT
    transactionIPAddress,
    COUNT(*) AS transactions
FROM fraud_transactions
GROUP BY transactionIPAddress
ORDER BY transactions DESC
LIMIT 10;
```

### Top 10 Accounts by Total Transaction Amount

```sql
SELECT
    accountID,
    SUM(transactionAmount) AS total_amount
FROM fraud_transactions
GROUP BY accountID
ORDER BY total_amount DESC
LIMIT 10;
```

### High-Value Transactions

```sql
SELECT
    transactionID,
    accountID,
    transactionAmount
FROM fraud_transactions
WHERE transactionAmount > 100000
ORDER BY transactionAmount DESC;
```

The complete SQL query set is included in the project documentation PDF.

---

# 2. Data Cleaning & Preparation

The dataset was checked before creating the final dashboard.

### Date Cleaning

A cleaned date field named:

`TransactionDate_Clean`

was used for reliable time-based analysis in Power BI.

### Device Field

`transactionDeviceId` was investigated during data-quality checks.

The field contained only `NA` as its distinct value, so it was removed from the final analytical model rather than being used as a misleading dimension.

### Dataset Separation

A separate Excel profiling dataset containing additional fraud-related fields was not combined with the final transaction dataset. This prevented mixing different datasets and producing misleading results.

### IP Values

The IP field was analyzed as provided by the source data. The values were not assumed to be conventional dotted IPv4 addresses.

---

# 3. Power BI Dashboard

The final dashboard contains three pages.

---

## Page 1 — Transaction Overview

### Purpose

Provides a high-level understanding of the transaction dataset.

### KPI Cards

- **Average Transaction Amount:** 10.19K
- **Total Transactions:** 8.43K
- **Total Transaction Amount:** 85.86M

### Filters

- Date
- Currency

### Visuals

1. **Top 10 Transaction Currencies by Count**
2. **Transaction Count by Hour**
3. **Top 10 IP Addresses by Transaction Count**
4. **Transactions Over Time**

### Business Questions

- How many transactions are present?
- What is the total transaction value?
- Which currencies have the highest transaction activity?
- Which hours have the most transactions?
- Which IP addresses have high transaction activity?
- How does transaction activity change over time?

---

## Page 2 — Transaction Risk Analysis

### Purpose

Focuses on transaction value rather than only transaction frequency.

### Filters

- Currency
- Date

### Visuals

1. **Average Transaction Amount by Currency**
2. **Average Transaction Amount by Hour**
3. **Top 10 Accounts by Avg. Transaction Amount**
4. **Average Transaction Amount Over Time**
5. **Top 10 IP Addresses by Avg. Transaction Amount**

### Business Questions

- Which currencies have higher average transaction values?
- Which hours show higher-value transactions?
- Which accounts have the highest average transaction amounts?
- Which IP addresses are associated with higher average transaction values?
- Are there dates with unusual average transaction amounts?

---

## Page 3 — Transaction Investigation

### Purpose

Provides an investigation-oriented view for examining high-value transaction activity.

### Filters

- Currency
- Account
- Transaction Date

### Visuals

1. **Top 10 Highest-Value Transactions**
2. **Top 10 Accounts by Total Transaction Amount**
3. **Top 10 IP Addresses by Transaction Amount**
4. **Transaction Details Table**

### Transaction Details Table

The table contains:

- `transactionID`
- `accountID`
- `TransactionDate_Clean`
- `transactionTime`
- `transactionAmount`
- `transactionCurrencyCode`
- `transactionIPAddress`
- `localHour`

The transaction table is sorted from **highest to lowest transaction amount**.

---

# Analytical Design

Different aggregations were deliberately used for different business questions.

| Analysis | Aggregation | Reason |
|---|---|---|
| Transaction activity | `COUNT` | Measures transaction frequency |
| Total transaction value | `SUM` | Measures total monetary exposure |
| Average transaction value | `AVG` | Identifies higher-value behavior |
| Top accounts by total value | `SUM` | Finds accounts with greatest total exposure |
| Top accounts by average value | `AVG` | Finds accounts with higher typical transaction values |
| Top IPs by count | `COUNT` | Finds IPs with high activity |
| Top IPs by amount | `SUM` / `AVG` | Finds IPs associated with high-value activity |

This prevents using the same metric for every visual when the business question is different.

---

# Key Business Insights

The dashboard can be used to identify:

### 1. Currency Concentration

Transaction activity is concentrated in a small number of currencies.

### 2. Hourly Patterns

Transaction frequency and average transaction value vary across the 24-hour period.

### 3. Account Concentration

Some accounts are associated with significantly higher transaction values than others.

### 4. IP Concentration

Certain IP values are associated with high transaction counts or high transaction amounts.

### 5. High-Value Transactions

A small number of transactions can have substantially larger monetary values than the typical transaction.

### 6. Time-Based Spikes

Transaction activity and transaction amounts can show spikes on particular dates, which may deserve further review.

> These patterns are **risk indicators**, not evidence of confirmed fraud.

---

# Data Limitations

The final transaction dataset has important limitations.

- No confirmed `fraud_flag` is available.
- No `fraud_reason` field is available.
- No merchant category is available.
- No transaction type is available.
- No reliable geographic field is available.
- The device identifier was not useful because it contained only `NA`.
- IP values are represented according to the source dataset.

Therefore, the project should not be described as a machine-learning fraud detection model or a system that confirms fraudulent transactions.

---

# Future Enhancements

The project can be extended by adding:

1. A validated fraud label
2. Merchant category
3. Transaction type
4. Customer profile information
5. Geographic information
6. Validated device identifiers
7. Device-change behavior
8. Historical customer behavior
9. Machine-learning fraud-risk scoring
10. Automated alerts for high-risk transactions

With a validated fraud label, supervised machine-learning models could be developed and evaluated using metrics such as:

- Precision
- Recall
- F1-score
- ROC-AUC
- Confusion Matrix

---

# Project Outcome

The final solution provides an interactive Power BI dashboard that allows users to move from:

**Overall Transaction Activity**

to

**High-Value Risk Patterns**

to

**Transaction-Level Investigation**

The project demonstrates practical skills in:

- SQL
- Data validation
- Data cleaning
- Power Query
- Power BI
- Data visualization
- Aggregation
- Filtering
- Business analysis
- Dashboard design
- Risk-oriented transaction analysis

---

# Interview Explanation

## 30-Second Version

> “I built a financial transaction analytics dashboard using MySQL and Power BI. I first inspected and validated the transaction data using SQL, then cleaned the data in Power Query and developed a three-page Power BI dashboard. The first page provides an overall transaction overview, the second analyzes higher-value risk patterns across currencies, hours, accounts and IPs, and the third supports transaction-level investigation. Since the source data did not contain a confirmed fraud label, I positioned the project as transaction risk and investigation analytics rather than a fraud-classification model.”

---

# Resume Description

**Financial Transaction Risk & Analytics Dashboard | MySQL, SQL, Power BI**

Built an interactive Power BI dashboard using MySQL transaction data to analyze transaction volume, monetary value, currency and hourly patterns, account/IP concentration, high-value transactions, and transaction-level investigation.

---

# Recommended Project Title

**Financial Transaction Risk & Analytics Dashboard using SQL and Power BI**

---

# Project Structure

```text
Financial-Transaction-Risk-Analytics/
│
├── SQL/
│   └── transaction_analysis.sql
│
├── PowerBI/
│   └── Financial_Transaction_Risk_Analytics.pbix
│
├── Documentation/
│   └── Financial_Transaction_Risk_Analytics_Project_Documentation.pdf
│
├── README.md
│
└── Screenshots/
    ├── transaction_overview.png
    ├── transaction_risk_analysis.png
    └── transaction_investigation.png
```

---

## Final Note

This project demonstrates an end-to-end analytics workflow:

**MySQL → SQL Analysis → Data Cleaning → Power BI → Risk Analysis → Investigation**

The emphasis is on producing an accurate, explainable and interview-ready analytics solution rather than overstating the available data.
