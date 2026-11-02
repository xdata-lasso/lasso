-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: products --
INSERT INTO "products" ("productid", "description") VALUES (1, 't2__5f201d');

INSERT INTO "products" ("productid", "description") VALUES (-2147483647, 't2__5f201d');

INSERT INTO "products" ("productid", "description") VALUES (2, 't2__5f201d');

INSERT INTO "products" ("productid", "description") VALUES (3, 'u7');

INSERT INTO "products" ("productid", "description") VALUES (4, NULL);

INSERT INTO "products" ("productid", "description") VALUES (5, 'uzhs');

INSERT INTO "products" ("productid", "description") VALUES (6, NULL);

INSERT INTO "products" ("productid", "description") VALUES (7, 'dposiie5unw');

INSERT INTO "products" ("productid", "description") VALUES (8, NULL);

INSERT INTO "products" ("productid", "description") VALUES (9, 'gce376nium');

INSERT INTO "products" ("productid", "description") VALUES (10, NULL);

INSERT INTO "products" ("productid", "description") VALUES (11, 'bbp02eutliqa');

INSERT INTO "products" ("productid", "description") VALUES (12, NULL);

-- Inserting into table: transactions_1k --
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1, '2025-06-17', '5sw', 1258409369, -1981402255, -890215420, 1, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483647, '2021-02-11', 'u7vfe4hria2y', 1115440883, 1644814318, 1465859724, 3, -1349201381, 737.440743);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (0, '2023-10-03', 'l', -845863578, -1610064545, 429706943, 3, 0, 240.969194);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483645, '2023-01-01', 'dpos', -1576219117, -1823627488, -1209887326, 3, 0, 992.733505);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (-2147483644, '2021-10-25', 'fa9', 1620389964, 546571701, 947159877, 3, -1, 963.351729);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2, '2025-07-01', '4', 374105386, 1274489983, -1683203397, 1, 528680845, 467.07027);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (3, '2025-08-22', 'ium5', 742285925, -747753377, 902887186, 1, -967741825, 680.514642);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (4, '2025-06-17', '5sw', 1258409369, -1981402255, -890215420, 3, 1610062532, 475.173408);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (5, '2023-09-09', 'e4', 1160656988, -992890117, 1914020640, 5, 1268590800, 378.476082);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (6, '2023-01-03', 'wbbp6luhvdlt', -841692980, -1364429300, -1257178728, 7, 1236688122, 986.066566);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (7, '2025-09-21', 'lfa', 1419861592, 700088193, 374105386, 9, 1274489983, 128.76421);

INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (8, '2025-06-20', 'zbuo4nrq', 418417917, -1031969798, -1106983592, 11, 1884179925, 499.570479);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('bbp02eutliqa',)
('t2__5f201d',)
('u7',)
('gce376nium',)
('uzhs',)
*/

-- Prediction Query
SELECT P.Description FROM transactions_1k AS T INNER JOIN products AS P ON T.ProductID = P.ProductID GROUP BY T.ProductID ORDER BY SUM(T.Amount) DESC, P.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('bbp02eutliqa',)
('gce376nium',)
('uzhs',)
('dposiie5unw',)
('t2__5f201d',)
*/