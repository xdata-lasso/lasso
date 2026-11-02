-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SegmentA', 'USD');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SegmentB', 'USD');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID) VALUES (1, '2023-01-01', '12:00:00', 1);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID) VALUES (2, '2023-01-01', '08:00:00', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Segment FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID ORDER BY Date ASC, T1.transactionid NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Gold Result:
('SegmentA',)
*/

-- Prediction Query
SELECT "customers"."segment" FROM "customers" INNER JOIN "transactions_1k" ON "customers"."customerid" = "transactions_1k"."customerid" ORDER BY "transactions_1k"."date", "transactions_1k"."time", customers.customerid NULLS LAST, transactions_1k.transactionid NULLS LAST LIMIT 1;

/*
Prediction Result:
('SegmentB',)
*/