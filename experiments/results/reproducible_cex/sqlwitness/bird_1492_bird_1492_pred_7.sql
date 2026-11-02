-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', NULL, 0, 99, 99, 2, 0, 0.0), (1, '2023-01-02', 'EUR', 100, 1, 99, 101, 2, 2.0), (100, NULL, 'euro', 1, NULL, 2, 1, 2, 2.0), (2, NULL, 'default1', 99, 101, 99, 99, 100, 101.0);
INSERT INTO customers (customerid, segment, currency) VALUES (100, 'KAM', 'EUR'), (1, 'KAM', 'default1'), (99, 'KAM', 'KAM'), (0, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(Currency = 'EUR') AS REAL) * 100 / COUNT(CustomerID) FROM customers WHERE Segment = 'KAM';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN currency = 'euro' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(*) AS percentageofkamcustomerspayingineuros FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE customers.segment = 'KAM';

/*
Prediction Result:
(0.0,)
*/