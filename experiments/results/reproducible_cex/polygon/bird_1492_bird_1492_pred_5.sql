-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (12, 'KAM', 'KAM21');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (41, 'EUR22', NULL);
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 41, 'euro41', 'euro41');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (13, 41, 'euro41', 'euro41');
INSERT INTO "products" ("productid", "description") VALUES (16, 'euro41');
INSERT INTO "products" ("productid", "description") VALUES (15, 'euro41');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, NULL, NULL, 41, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (17, '1000-02-12', NULL, 41, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (41, 'euro20', 41);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (41, 'EUR19', 41);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(Currency = 'EUR') AS REAL) * 100 / COUNT(CustomerID) FROM customers WHERE Segment = 'KAM';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN currency = 'euro' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(*) AS percentageofkamcustomerspayingineuros FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE customers.segment = 'KAM';

/*
Prediction Result:
(None,)
*/