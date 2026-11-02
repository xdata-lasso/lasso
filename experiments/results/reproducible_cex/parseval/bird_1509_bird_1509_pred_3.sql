-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'CZE', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2, 1219478689, 'CZE', 'uzhsrwbbp6lu');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -55602865, 'CZE', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (4, 1219478689, 'CZE', 'uzhsrwbbp6lu');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (5, -1209887326, 't2__4b9fe8', 'klfa9000t');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (6, 1119186446, 't2__4b9fe8', 'rqrofqyp5s');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (7, 274769912, 't2__4b9fe8', 'oo3o9');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (8, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (9, 1, NULL, 'value');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (10, 1, NULL, 'value');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2012-01-01', '9n8c4pgu7v', -1865039888, 1160656988, 1, -992890117, 1914020640, 795.366812);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2012-01-01', 'hvdlttilbnpr', 2087640001, 907682809, 1, 2026480202, -1576219117, 75.403642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2011-12-31', '9n8c4pgu7v', -1865039888, 1160656988, 3, -992890117, 1914020640, 795.366812);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, NULL, 'hvdlttilbnpr', 2087640001, 907682809, 4, 2026480202, -1576219117, 75.403642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2012-01-01', 'c4ecigce', -1585009206, -53231346, 5, -443340271, 757448742, 225.300904);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2011-12-31', 'bbp02eut', -1347802441, 1673584235, 6, -2118135981, 2074205376, 274.580687);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, NULL, 'l7', 1178636309, -1390245819, 7, 1055976837, 1775126557, 482.572691);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2012-01-01', '7zw', 481163439, 2123196517, 8, 364869063, -953437896, 433.533777);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (9, '2011-12-31', 'pyu78d99', -977635379, 1661181156, 9, -1372125820, -2031361952, 884.000446);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (10, NULL, 'p5qi2rkf9v', 556727997, 1178000634, 10, 1836127587, -1529584866, 755.698226);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND STRFTIME('%Y', T1.Date) >= '2012';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) AS TotalTransactions FROM transactions_1k AS T INNER JOIN gasstations AS G ON T.GasStationID = G.GasStationID WHERE G.Country = 'CZE' AND T.Date > '2012-01-01';

/*
Prediction Result:
(0,)
*/