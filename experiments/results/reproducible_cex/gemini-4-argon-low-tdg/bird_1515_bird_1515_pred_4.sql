-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests bag semantics (multiplicity): ensures DISTINCT is not erroneously added, and that multiple matching transactions for the same customer or different customers with the same Segment return duplicate rows. Also tests against accidental INNER JOIN with yearmonth.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'Duplicate_Segment', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'Duplicate_Segment', 'CZK');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-23', '21:20:00', 1, 500, 10, 1, 10, 100.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-23', '21:20:00', 1, 501, 11, 2, 20, 200.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-23', '21:20:00', 2, 502, 12, 1, 30, 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.date = '2012-08-23' AND T1.time = '21:20:00';

/*
Gold Result:
('Duplicate_Segment',)
('Duplicate_Segment',)
('Duplicate_Segment',)
*/

-- Prediction Query
SELECT DISTINCT customers.segment FROM customers INNER JOIN transactions_1k ON customers.customerid = transactions_1k.customerid WHERE transactions_1k.date = '2012-08-23' AND transactions_1k.time = '21:20:00';

/*
Prediction Result:
('Duplicate_Segment',)
*/