-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("productid", "description") VALUES (1, 't2__64553b');

INSERT INTO "products" ("productid", "description") VALUES (2, 't2__64553b');

INSERT INTO "products" ("productid", "description") VALUES (-2147483647, 't2__64553b');

INSERT INTO "products" ("productid", "description") VALUES (-1, 't2__64553b');

INSERT INTO "products" ("productid", "description") VALUES (3, NULL);

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2025-06-17', '5sw', 1258409369, -1981402255, -890215420, 1, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-02-11', 'u7vfe4hria2y', 1115440883, 1644814318, 1465859724, 3, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-1, '2023-10-03', 'l', -845863578, -1610064545, 429706943, 3, 1, 240.969194);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (0, '2023-01-01', 'dpos', -1576219117, -1823627488, -1209887326, 3, 1, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2021-10-25', 'fa9', 1620389964, 546571701, 947159877, 1, 1990080517, 827.854302);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2020-06-05', '4ecigce376n', 1313172851, -761141909, 283598170, 1, 742285925, 21.917736);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483642, '2023-08-27', '4nrq', 418417917, -1031969798, -1106983592, 1, 1884179925, 499.570479);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-06-17', '5sw', 1258409369, -1981402255, -890215420, 3, 1610062532, 475.173408);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('t2__64553b',)
('t2__64553b',)
('t2__64553b',)
(None,)
('t2__64553b',)
*/

-- Prediction Query
SELECT "products"."description" FROM "products" INNER JOIN "transactions_1k" ON "products"."productid" = "transactions_1k"."productid" GROUP BY "products"."description" ORDER BY SUM("transactions_1k"."amount") DESC, "products"."description" NULLS LAST LIMIT 5;

/*
Prediction Result:
('t2__64553b',)
(None,)
*/