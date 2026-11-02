-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (27, '20110125', 'CZK');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'CZK27', 'CZK27');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 27, 'CZK27', 'CZK27');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 27, 'CZK27', 'CZK27');
INSERT INTO "products" ("productid", "description") VALUES (17, 'CZK27');
INSERT INTO "products" ("productid", "description") VALUES (16, 'CZK27');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-01-28', 'CZK27', 27, 27, 27, 27, 27, 27);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '1000-01-28', 'CZK27', 27, 27, 27, 27, 27, 27);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (27, 'CZK201102', 24);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (27, '201101', 26);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'CZK' AND T2.Date BETWEEN 201101 AND 201112 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) DESC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(27,)
*/

-- Prediction Query
SELECT "customers"."customerid" FROM "customers" INNER JOIN "yearmonth" ON "customers"."customerid" = "yearmonth"."customerid" WHERE "customers"."currency" = 'CZK' AND "yearmonth"."date" BETWEEN '201101' AND '201112' ORDER BY "yearmonth"."consumption" DESC, customers.customerid NULLS LAST, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(27,)
*/