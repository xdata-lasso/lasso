-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests SUM(Price) vs MAX(Price), AVG(Price), COUNT(*), SUM(Amount), SUM(Price * Amount), and Date filtering.
-- Customer 1: Two transactions on '2012-08-25', SUM(Price) = 120.0, MAX(Price) = 60.0, AVG(Price) = 60.0, SUM(Amount) = 2.
-- Customer 2: One transaction on '2012-08-25', SUM(Price) = 100.0, MAX(Price) = 100.0, AVG(Price) = 100.0, SUM(Amount) = 10.
-- Customer 3: Three transactions on '2012-08-25', SUM(Price) = 90.0, COUNT(*) = 3.
-- Customer 4: Huge transaction on a different date '2012-08-24', SUM(Price) = 500.0.
-- Gold Query returns CustomerID = 1.
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '10:00:00', 1, 101, 1, 1, 1, 60.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '11:00:00', 1, 101, 1, 1, 1, 60.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '12:00:00', 2, 102, 1, 1, 10, 100.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-25', '13:00:00', 3, 103, 1, 1, 5, 30.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2012-08-25', '14:00:00', 3, 103, 1, 1, 5, 30.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (6, '2012-08-25', '15:00:00', 3, 103, 1, 1, 5, 30.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (7, '2012-08-24', '16:00:00', 4, 104, 1, 1, 50, 500.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (8, '2012-08-26', '17:00:00', 2, 102, 1, 1, 50, 500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' GROUP BY CustomerID ORDER BY SUM(Price) DESC, CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT "transactions_1k"."CustomerID" FROM "transactions_1k" WHERE "transactions_1k"."Date" = '2012-08-25' GROUP BY "transactions_1k"."CustomerID" ORDER BY SUM("transactions_1k"."Amount" * "transactions_1k"."Price") DESC, "transactions_1k"."CustomerID" NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/