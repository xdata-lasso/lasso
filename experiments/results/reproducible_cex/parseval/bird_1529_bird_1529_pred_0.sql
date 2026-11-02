-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (38508, 'uzhs', 'rwbbp6luhvd');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'd21vy9uxj4hw', 'd');

-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (3, -841692980, 'bnp', 'mdpos');

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483648, '2020-12-20', '4h', 38508, -992890117, 1, 1914020640, 1268590800, 378.476082);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-06-28', 'e5u', 38508, 1861536320, 2, 44952191, 1151980946, 83.204633);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483646, '2020-01-23', '9000t5c4ec', 38508, -1683203397, 2, 528680845, -1585009206, 191.847248);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2025-06-20', 'zbuo4nrq', 38508, 418417917, 2, -1031969798, -1106983592, 938.694822);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2025-08-08', 'bbp02eutliqa', 38508, -314162272, 2, 2137741668, -525979501, 668.928822);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2022-07-04', 'o3o9hl72klex', 38508, 1775126557, 1, -74849714, 105869088, 353.163664);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2020-03-04', '2dwyrq', 38508, -1097120355, 1, 244829661, -1362461264, 943.791649);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483641, '2023-03-31', '0b4', 1, 1649269347, 1, -1116181514, 1255852738, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483640, '2021-07-18', 'rkf9vqx5', 1, 1836127587, 1, -1529584866, 1196308825, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483639, '2022-09-24', 'h2gndqwnqcx5', 38508, 580968159, 1, -1245312912, 1575412235, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483638, '2023-01-09', 'tu0', 38508, -1898531797, 1, -1748371085, -1742081330, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483637, '2022-05-01', 'f3dqv0gc', 38508, 1631231566, 1, 172461907, 1606439408, NULL);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483636, '2021-10-23', 'zbilyrkn', 38508, -688098735, 1, 1784916884, 37673509, NULL);

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (38508, '1', 179.378884);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, '1', 328.40866);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Price), SUM(IIF(T3.Date = '201201', T1.Price, 0)) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CustomerID = '38508';

/*
Gold Result:
(1675.431395, 0)
*/

-- Prediction Query
SELECT SUM(amount * price) AS totalamountspent, SUM(CASE WHEN STRFTIME('%Y%m', date) = '201201' THEN amount * price ELSE 0 END) AS january2012amountspent FROM transactions_1k WHERE customerid = 38508;

/*
Prediction Result:
(-2367551288621.801, 0)
*/