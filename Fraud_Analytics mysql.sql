create database FraudAnalytics;
USE FraudAnalytics;
USE FraudAnalytics;

CREATE TABLE transactions (
    transactionID VARCHAR(50),
    accountID VARCHAR(50),
    transactionAmount DECIMAL(15,2),
    transactionCurrencyCode VARCHAR(10),
    transactionDate DATE,
    transactionTime TIME,
    localHour INT,
    transactionDeviceId VARCHAR(100),
    transactionIPaddress VARCHAR(50)
);
show tables;
DESCRIBE transactions;
COMMIT;
SELECT COUNT(*) AS total_rows
FROM fraud_transactions;
DESCRIBE fraud_transactions;
SELECT *
FROM fraud_transactions
LIMIT 10;
SELECT
    MIN(transactionDate) AS first_date,
    MAX(transactionDate) AS last_date
FROM fraud_transactions;

SELECT COUNT(*) AS total_transactions
FROM fraud_transactions;

SELECT
    COUNT(*) AS total_rows,
    COUNT(transactionID) AS transaction_ids,
    COUNT(accountID) AS account_ids,
    COUNT(transactionAmount) AS amounts,
    COUNT(transactionDeviceId) AS devices,
    COUNT(transactionIPaddress) AS ip_addresses
FROM fraud_transactions;

SELECT
    transactionID,
    COUNT(*) AS count
FROM fraud_transactions
GROUP BY transactionID
HAVING COUNT(*) > 1;

SELECT
    MIN(transactionAmount) AS minimum_amount,
    MAX(transactionAmount) AS maximum_amount,
    AVG(transactionAmount) AS average_amount
FROM fraud_transactions;


##Find suspicious high-value transaction
SELECT
    transactionID,
    accountID,
    transactionAmount
FROM fraud_transactions
WHERE transactionAmount > 100000
ORDER BY transactionAmount DESC;


##Analyze transactions by hour
SELECT
    localHour,
    COUNT(*) AS total_transactions,
    AVG(transactionAmount) AS average_amount
FROM fraud_transactions
GROUP BY localHour
ORDER BY average_amount DESC;


## Account Activity
SELECT accountID, COUNT(*) AS transactions
FROM fraud_transactions
GROUP BY accountID
ORDER BY transactions DESC
LIMIT 10;


##Check high-value transactions by account
SELECT
    accountID,
    SUM(transactionAmount) AS total_amount
FROM fraud_transactions
GROUP BY accountID
ORDER BY total_amount DESC
LIMIT 10;



##Accounts with very high total transaction amount
SELECT accountID, SUM(transactionAmount) AS total_amount
FROM fraud_transactions
GROUP BY accountID
HAVING SUM(transactionAmount) > 1000000;



 ##High-value transactions by hour
SELECT localHour, COUNT(*) AS transactions
FROM fraud_transactions
WHERE transactionAmount > 100000
GROUP BY localHour
ORDER BY transactions DESC;



 ##Transactions by currency
SELECT transactionCurrencyCode, COUNT(*) AS transactions
FROM fraud_transactions
GROUP BY transactionCurrencyCode
ORDER BY transactions DESC;



##Transactions by device
SELECT transactionDeviceId, COUNT(*) AS transactions
FROM fraud_transactions
GROUP BY transactionDeviceId
ORDER BY transactions DESC;



 ##Transactions by IP address
SELECT transactionIPaddress, COUNT(*) AS transactions
FROM fraud_transactions
GROUP BY transactionIPaddress
ORDER BY transactions DESC
LIMIT 10;



##Final transaction summary
SELECT
    COUNT(*) AS transactions,
    SUM(transactionAmount) AS total_amount,
    AVG(transactionAmount) AS average_amount
FROM fraud_transactions;

