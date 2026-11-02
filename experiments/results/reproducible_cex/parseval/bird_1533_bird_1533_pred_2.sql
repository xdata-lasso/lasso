-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'k9n8c', 'pgu7vfe4');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'siie', 'unw6klfa');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2025-06-17', '5sw', 1, 1258409369, -1981402255, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-05-05', 'ia2yp', 1, -1670923962, 700293388, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2023-11-30', 'b', 1, 1072996612, 13244799, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2023-08-07', 'hvdlttilbnpr', 2, 2087640001, 907682809, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2024-07-24', '00t5c4ecigc', 2, 528680845, -1585009206, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2022-02-24', '52zbuo4nrq', 2, 418417917, -1031969798, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2022-09-19', 's5bbp02e', 1, -751275471, -1347802441, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2022-10-26', '1', 1, 2074205376, 274769912, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2023-05-17', 'oo3o9hl72kl', 1, -305670381, -1525670226, 5, -1, 0.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2025-11-18', 'wau2dwy', 1, -953437896, -1097120355, 1, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2023-09-01', '8d99rljsl', 1, -346339240, 1692174491, 5, -1, -30.0);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2022-12-05', '2rk', 1, -705985602, 537874887, 5, -1, -30.0);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201208', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '201208', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__81bda9', 1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 495.297639);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Price / T1.Amount > 29.00 AND T1.ProductID = 5 AND T2.Date = '201208';

/*
Gold Result:
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT T1.Consumption FROM yearmonth AS T1 INNER JOIN (SELECT DISTINCT CustomerID FROM transactions_1k WHERE ProductID = 5 AND Price / Amount > 29) AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201208';

/*
Prediction Result:
(1.0,)
*/