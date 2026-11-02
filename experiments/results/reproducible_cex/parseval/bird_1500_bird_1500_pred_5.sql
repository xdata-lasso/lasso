-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, '8c4p', 'u7');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'lfa', '9000t5c4ec');

-- Inserting into table: products --
INSERT INTO "products" ("productid", "description") VALUES (1, 't3__31af6f');

INSERT INTO "products" ("productid", "description") VALUES (-2147483647, 't3__31af6f');

INSERT INTO "products" ("productid", "description") VALUES (2, 't3__31af6f');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2025-06-17', '5sw', 1, 1258409369, -1981402255, 1, -890215420, 572.766956);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2020-09-26', 'hria2ypu', 1, 1644814318, 1465859724, 1, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2023-10-03', 'l', 1, -845863578, -1610064545, 3, 429706943, 240.969194);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2023-01-01', 'dpos', 2, -1576219117, -1823627488, 1, -1209887326, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2021-03-18', 'e', 1, -1585009206, -53231346, 3, -443340271, 676.357279);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2022-07-11', 'nrqrofqy', 2, -1106983592, 1884179925, 1, 902551284, 22.720462);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2022-08-27', '02eutliqa11r', 1, 2137741668, -525979501, 3, 1898504886, 937.856955);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2022-08-06', 'o9hl72kl', 2, -305670381, -1525670226, 1, -453362185, 612.02959);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2023-07-07', '2dwyrq13pyu7', 1, 244829661, -1362461264, 3, -904834265, 419.361606);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-04-09', 'p5qi2rk', 1, -705985602, 537874887, 1, -461695645, 694.765963);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2021-08-12', 'gd', 1, -283454505, 233994589, 1, 1442655647, 479.592965);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2023-12-18', 'd', 1, -736979194, 2103044118, 1, -1642259219, 109.083092);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '201309', 328.996339);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, '201309', 128.76421);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 't2__faea53', 802.414724);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 58.749749);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Date = '201309';

/*
Gold Result:
('t3__31af6f',)
('t3__31af6f',)
('t3__31af6f',)
('t3__31af6f',)
('t3__31af6f',)
*/

-- Prediction Query
SELECT DISTINCT products.description FROM transactions_1k INNER JOIN products ON transactions_1k.productid = products.productid INNER JOIN yearmonth ON transactions_1k.customerid = yearmonth.customerid WHERE yearmonth.date = '201309';

/*
Prediction Result:
('t3__31af6f',)
*/