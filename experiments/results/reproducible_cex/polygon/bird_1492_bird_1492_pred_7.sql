-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (10, 'KAM', NULL);
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (9, 'KAM', NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (12, -7445725690939838464, 'KAM', 'KAM');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (11, -7445725690939838464, 'KAM', 'KAM');
INSERT INTO "products" ("productid", "description") VALUES (14, 'KAM');
INSERT INTO "products" ("productid", "description") VALUES (13, 'KAM');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (16, '0001-01-01', 'KAM', -7445725690939838464, -7445725690939838464, -7445725690939838464, -7445725690939838464, -7445725690939838464, -7445725690939838464);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (15, '0001-01-01', 'KAM', -7445725690939838464, -7445725690939838464, -7445725690939838464, -7445725690939838464, -7445725690939838464, -7445725690939838464);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, 'KAM18', -7445725690939838464);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (10, 'EUR17', -7445725690939838464);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(Currency = 'EUR') AS REAL) * 100 / COUNT(CustomerID) FROM customers WHERE Segment = 'KAM';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT CASE WHEN Currency = 'EUR' THEN CustomerID END) AS REAL) * 100.0) / COUNT(DISTINCT CustomerID) AS PercentageOfKAMInEUR FROM customers WHERE Segment = 'KAM';

/*
Prediction Result:
(0.0,)
*/