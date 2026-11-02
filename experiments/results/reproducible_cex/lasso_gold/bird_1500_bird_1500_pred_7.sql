-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1033, 'everything', 'surface');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1042, NULL, NULL);
INSERT INTO "products" ("productid", "description") VALUES (1034, 'Role movie win.');
INSERT INTO "products" ("productid", "description") VALUES (1043, 'Role movie win.');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1035, '1974-05-05', 'human', 1033, 1036, 1037, 1034, 1038, 1039.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1041, '1974-05-05', 'human', 1042, 1036, 1037, 1043, 1038, 1039.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1033, '201309', 1040.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1042, '201309', 1040.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('Role movie win.',)
('Role movie win.',)
*/

-- Prediction Query
SELECT DISTINCT products.description FROM transactions_1k INNER JOIN products ON transactions_1k.productid = products.productid INNER JOIN yearmonth ON transactions_1k.customerid = yearmonth.customerid WHERE yearmonth.date = '201309';

/*
Prediction Result:
('Role movie win.',)
*/