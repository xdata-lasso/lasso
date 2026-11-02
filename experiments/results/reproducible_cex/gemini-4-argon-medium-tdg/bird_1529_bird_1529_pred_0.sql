-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (38508, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10001, 'KAM', 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 2, 'SVK', 'Premium');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (38508, '201201', 150.5);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (38508, '201202', 200.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10001, '201201', 300.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-01-15', '10:00:00', 38508, 101, 10, 1, 5, 25.5);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-01-16', '11:00:00', 38508, 101, 10, 2, 10, 50.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-01-17', '12:00:00', 10001, 102, 20, 1, 20, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Price), SUM(IIF(T3.Date = '201201', T1.Price, 0)) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CustomerID = '38508';

/*
Gold Result:
(151.0, 75.5)
*/

-- Prediction Query
SELECT SUM(T1."amount") AS total_spent_gas_stations, SUM(T2."consumption") AS total_spent_january_2012 FROM "transactions_1k" AS T1 LEFT JOIN "yearmonth" AS T2 ON T1."customerid" = T2."customerid" WHERE T1."customerid" = 38508 AND NOT T1."gasstationid" IS NULL AND T2."date" = '201201';

/*
Prediction Result:
(15, 301.0)
*/