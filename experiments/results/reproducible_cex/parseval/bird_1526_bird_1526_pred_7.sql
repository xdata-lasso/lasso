-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'ypuzhsrw', 'b');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, -55602865, 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -1833165707, '6nium52zb', 'uo4nrqrofqy');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2012-08-25', 'e4', 1, 1160656988, 3, -992890117, 1914020640, 634.8);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2012-08-25', 'luhvdltti', 1, -1364429300, 3, -1257178728, 1236688122, 634.8);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2012-08-25', 'dpos', 1, -1576219117, 3, -1823627488, -1209887326, 634.8);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2012-08-25', 'klfa9000t', 1, 1408123494, 3, -1964997180, 1149850321, 634.8);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2012-08-25', '5s5b', 1, 2107872094, 1, 882961052, 743312762, 634.8);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-08-25', 'eutliqa11r', 1, 2137741668, 1, -525979501, 1898504886, 634.8);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2012-08-25', 'o3o9hl72klex', 1, 1775126557, 1, -74849714, 105869088, 634.8);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2012-08-25', 'au2dwy', NULL, -953437896, 1, -1097120355, 244829661, 634.8);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2012-08-25', 'jsl', 1, -346339240, 1, 1692174491, -1025564911, 634.8);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'yea_8d38e5', 749.826493);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (T2_2012.Consumption - T2_2013.Consumption) / T2_2012.Consumption AS ConsumptionDecreaseRate FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2_2012 ON T1.CustomerID = T2_2012.CustomerID AND T2_2012.Date LIKE '2012%' INNER JOIN yearmonth AS T2_2013 ON T1.CustomerID = T2_2013.CustomerID AND T2_2013.Date LIKE '2013%' WHERE T1.Amount = 634.8 AND T1.Date = '2012-08-25';

/*
Prediction Result:
*/