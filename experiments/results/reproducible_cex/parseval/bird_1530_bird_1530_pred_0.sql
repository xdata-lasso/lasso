-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("productid", "description") VALUES (1, 't2__005e7b');

INSERT INTO "products" ("productid", "description") VALUES (-2147483647, 't2__005e7b');

INSERT INTO "products" ("productid", "description") VALUES (-1, 't2__005e7b');

INSERT INTO "products" ("productid", "description") VALUES (0, 't2__005e7b');

INSERT INTO "products" ("productid", "description") VALUES (2, 'u7');

INSERT INTO "products" ("productid", "description") VALUES (3, NULL);

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2025-06-17', '5sw', 1258409369, -1981402255, -890215420, 1, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-02-11', 'u7vfe4hria2y', 1115440883, 1644814318, 1465859724, 3, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-1, '2023-10-03', 'l', -845863578, -1610064545, 429706943, 3, 1, 240.969194);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2023-01-01', 'dpos', -1576219117, -1823627488, -1209887326, 1, -1399556171, 741.842896);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2024-07-24', '00t5c4ecigc', 528680845, -1585009206, -53231346, 1, -443340271, 676.357279);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483643, '2022-07-11', 'nrqrofqy', -1106983592, 1884179925, 902551284, 1, 2107872094, 705.580387);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-06-17', '5sw', 1258409369, -1981402255, -890215420, 2, 1610062532, 475.173408);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('t2__005e7b',)
('t2__005e7b',)
('u7',)
(None,)
('t2__005e7b',)
*/

-- Prediction Query
SELECT T1.Description FROM products AS T1 INNER JOIN transactions_1k AS T2 ON T1.ProductID = T2.ProductID GROUP BY T1.Description ORDER BY SUM(T2.Amount) DESC, T1.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('t2__005e7b',)
('u7',)
(None,)
*/