-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (27, 'LAM', '20120125');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (13, 'LAM27', 'LAM27');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (15, 27, 'LAM27', 'LAM27');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (14, 27, 'LAM27', 'LAM27');
INSERT INTO "products" ("productid", "description") VALUES (17, 'LAM27');
INSERT INTO "products" ("productid", "description") VALUES (16, 'LAM27');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (19, '1000-01-28', 'LAM27', 27, 27, 27, 27, 27, 27);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (18, '1000-01-28', 'LAM27', 27, 27, 27, 27, 27, 27);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (27, '201201201202', 24);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (27, '201201', 26);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'LAM' AND T2.date BETWEEN 201201 AND 201212 GROUP BY T1.CustomerID ORDER BY SUM(T2.Consumption) ASC, T1.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(27,)
*/

-- Prediction Query
SELECT "customers"."customerid" FROM "customers" INNER JOIN "yearmonth" ON "customers"."customerid" = "yearmonth"."customerid" WHERE "customers"."segment" = 'LAM' AND "yearmonth"."date" BETWEEN '201201' AND '201212' ORDER BY "yearmonth"."consumption" ASC, customers.customerid NULLS LAST, yearmonth.date NULLS LAST, yearmonth.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(27,)
*/