-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate preservation (SELECT vs SELECT DISTINCT) and 1-to-N join multiplicity.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10, 'KAM', 'CZK');
INSERT INTO products (ProductID, Description) VALUES (5, 'Diesel');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201208', 555.55);
-- Two distinct transactions for the same customer meeting all criteria; should output 555.55 twice.
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (101, '2012-08-01', '08:00:00', 10, 111, 200, 5, 1, 30.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (102, '2012-08-02', '09:00:00', 10, 111, 200, 5, 2, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Price / T1.Amount > 29.00 AND T1.ProductID = 5 AND T2.Date = '201208';

/*
Gold Result:
(555.55,)
(555.55,)
*/

-- Prediction Query
SELECT T1.Consumption FROM yearmonth AS T1 INNER JOIN (SELECT DISTINCT CustomerID FROM transactions_1k WHERE ProductID = 5 AND Price / Amount > 29) AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201208';

/*
Prediction Result:
(555.55,)
*/