-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("productid", "description") VALUES (1410, 'Rest feel finally impact.');
INSERT INTO "products" ("productid", "description") VALUES (1424, 'Notice image street fight decision size parent focus.');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1411, '1998-03-12', 'interesting', 1412, 1413, 1414, 1410, 1415, 1416.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1418, '1970-04-13', 'contain', 1419, 1420, 1421, 1410, 1422, 1423.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1425, '1971-05-14', 'letter', 1426, 1427, 1428, 1424, 1429, 1430.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('Notice image street fight decision size parent focus.',)
('Rest feel finally impact.',)
('Rest feel finally impact.',)
*/

-- Prediction Query
SELECT P.Description FROM transactions_1k AS T INNER JOIN products AS P ON T.ProductID = P.ProductID GROUP BY T.ProductID ORDER BY SUM(T.Amount) DESC, P.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('Rest feel finally impact.',)
('Notice image street fight decision size parent focus.',)
*/