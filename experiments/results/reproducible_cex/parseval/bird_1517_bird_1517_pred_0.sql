-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 't2__ac7d4f', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 't2__ac7d4f', 'puzhsrw');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 't2__ac7d4f', 'b');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-1, 't2__ac7d4f', 'p');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2021-12-04', '9n8c4pgu7v', 1, -1865039888, 1160656988, -992890117, 1914020640, 795.366812);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2022-08-24', 'luhvdltti', 1, -1364429300, -1257178728, 1236688122, 2087640001, 666.330692);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-1, '1969-12-31', 'siie', 3, -45536098, 1861536320, 44952191, 1151980946, 83.204633);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (0, '1970-01-01', '9', 3, 1620389964, 546571701, 947159877, 1990080517, 827.854302);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2020-06-05', '4ecigce376n', 1, 1313172851, -761141909, 283598170, 742285925, 21.917736);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2023-08-27', '4nrq', 1, 418417917, -1031969798, -1106983592, 1884179925, 499.570479);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2020-03-14', 'p', 1, 882961052, 743312762, -1822992503, -868774469, 138.017996);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-06-17', '5sw', 3, 1258409369, -1981402255, -890215420, 1610062532, 475.173408);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Segment FROM customers ORDER BY CustomerID ASC LIMIT 1;

/*
Prediction Result:
('t2__ac7d4f',)
*/