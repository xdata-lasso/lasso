-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (17, 'LAM', 'CZK');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (19, 17, '20131217', '20131217');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (18, 17, '20131217', '20131217');
INSERT INTO "products" ("productid", "description") VALUES (23, '20131217');
INSERT INTO "products" ("productid", "description") VALUES (22, '20131217');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (21, '1000-01-18', '20131217', 17, 17, 17, 17, 17, 17);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (20, '1000-01-18', '20131217', 17, 17, 17, 17, 17, 17);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (17, 'LAM201302', 0);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (17, '201301', -10656);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'LAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID), CAST(SUM(IIF(T1.Segment = 'KAM', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) - CAST(SUM(IIF(T1.Segment = 'SME', T2.Consumption, 0)) AS REAL) / COUNT(T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Consumption = (SELECT MIN(Consumption) FROM yearmonth) AND T2.Date BETWEEN 201301 AND 201312;

/*
Gold Result:
(10656.0, -10656.0, 0.0)
*/

-- Prediction Query
SELECT (AVG(CASE WHEN Segment = 'SME' THEN Consumption ELSE NULL END) - AVG(CASE WHEN Segment = 'LAM' THEN Consumption ELSE NULL END)) AS Difference_SME_LAM, (AVG(CASE WHEN Segment = 'LAM' THEN Consumption ELSE NULL END) - AVG(CASE WHEN Segment = 'KAM' THEN Consumption ELSE NULL END)) AS Difference_LAM_KAM, (AVG(CASE WHEN Segment = 'KAM' THEN Consumption ELSE NULL END) - AVG(CASE WHEN Segment = 'SME' THEN Consumption ELSE NULL END)) AS Difference_KAM_SME FROM yearmonth INNER JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE "Date" BETWEEN '201301' AND '201312' AND Currency = 'CZK';

/*
Prediction Result:
(None, None, None)
*/