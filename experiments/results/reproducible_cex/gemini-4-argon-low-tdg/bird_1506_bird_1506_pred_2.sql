-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate output preservation (kills DISTINCT / GROUP BY mutants) and ensures products with no transactions or transactions only in non-CZE stations are excluded (kills RIGHT/LEFT JOIN and IN/EXISTS subquery mutants).
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 1, 'CZE', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 1, 'CZE', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 2, 'DEU', 'Premium');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (2, 'Unused Product');
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '12:00:00', 10, 500, 1, 1, 30, 900.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '13:00:00', 20, 501, 2, 1, 20, 600.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '14:00:00', 30, 502, 3, 1, 25, 750.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Country = 'CZE';

/*
Gold Result:
('Diesel',)
('Diesel',)
*/

-- Prediction Query
SELECT DISTINCT "products"."description" FROM "transactions_1k" INNER JOIN "gasstations" ON "transactions_1k"."gasstationid" = "gasstations"."gasstationid" INNER JOIN "products" ON "transactions_1k"."productid" = "products"."productid" WHERE "gasstations"."country" = 'CZE';

/*
Prediction Result:
('Diesel',)
*/