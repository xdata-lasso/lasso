-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests floating-point division (CAST AS REAL), COUNT(CustomerID) vs COUNT(DISTINCT CustomerID),
-- WHERE Segment = 'LAM' filtering, and OUTER JOIN vs INNER JOIN mutations (customer with no yearmonth).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'LAM', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 20.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201203', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Consumption > 46.73, 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (COUNT(DISTINCT y."customerid") * 100.0 / (SELECT COUNT(DISTINCT c."customerid") FROM "customers" AS c WHERE c."segment" = 'LAM')) AS percentage FROM "yearmonth" AS y INNER JOIN "customers" AS c ON y."customerid" = c."customerid" WHERE c."segment" = 'LAM' AND y."consumption" > 46.73;

/*
Prediction Result:
(50.0,)
*/