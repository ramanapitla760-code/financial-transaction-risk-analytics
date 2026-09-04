# Financial Transaction Risk & Analytics Dashboard

A financial transaction analytics project built using **MySQL, SQL, Power Query, and Microsoft Power BI**.

The project analyzes transaction volume, transaction value, currency distribution, hourly behavior, account concentration, IP concentration, and high-value transaction patterns.

> **Important:** The source dataset does not contain a confirmed fraud label such as `fraud_flag`. Therefore, this project identifies **potential risk indicators and transaction patterns** rather than confirming fraudulent transactions.

---

## 📊 Dashboard Preview

### 1. Transaction Overview

Provides a high-level view of transaction activity, including total transactions, transaction value, currency distribution, hourly transaction count, IP activity, and transactions over time.

![Transaction Overview](Transaction%20overview.png)

---

### 2. Transaction Risk Analysis

Focuses on transaction value and potential risk indicators across currencies, hours, accounts, dates, and IP addresses.

![Transaction Risk Analysis](Transaction%20Risk%20Analysis.png)

---

### 3. Transaction Investigation

Provides an investigation-oriented view of high-value transactions, accounts, IP addresses, and transaction-level details.

![Transaction Investigation](Transaction%20Investigation.png)

---

## 🎯 Project Objective

The objective is to build an interactive analytics solution that helps identify:

- High-value transaction patterns
- Unusual transaction-value concentrations
- Currency-level transaction behavior
- Hourly transaction patterns
- Accounts associated with high transaction values
- IP addresses associated with high transaction activity or value
- Individual high-value transactions requiring further investigation

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **MySQL** | Database management and SQL analysis |
| **SQL** | Data validation, exploration, aggregation, and analysis |
| **Power Query** | Data cleaning and transformation |
| **Power BI** | Interactive dashboard and visualization |

---

## 📁 Dataset

**Database:** `fraudanalytics`  
**Main Table:** `fraud_transactions`  
**Approximate Records:** **8,430 transactions**

### Main Fields

- `transactionID`
- `accountID`
- `transactionAmount`
- `transactionCurrencyCode`
- `transactionDate`
- `TransactionDate_Clean`
- `transactionTime`
- `localHour`
- `transactionIPAddress`

---

## 🔄 Project Workflow

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
