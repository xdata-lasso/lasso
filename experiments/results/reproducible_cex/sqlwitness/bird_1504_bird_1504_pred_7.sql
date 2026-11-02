-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2001-12-20', NULL, NULL, 0, NULL, NULL, 1, 1.0), (1, '2001-12-20', 'default1', 1, NULL, 0, 0, 1, 0.0), (2, '2001-12-20', 'default1', 1, 0, 0, NULL, 0, NULL), (3, '2001-12-20', '201201', 1, 0, 0, 1, 0, 0.0), (4, '2023-01-02', 'default2', 0, 0, 1, NULL, 0, NULL), (5, NULL, NULL, 0, NULL, 1, NULL, NULL, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (1, '2012-01%', NULL), (0, 'default1', 'default1'), (2, 'default1', 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, '201201', 0.0), (2, '201201', 1.0), (2, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(Amount) FROM transactions_1k WHERE Date LIKE '2012-01%';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Date LIKE '201201';

/*
Prediction Result:
(0.0,)
*/