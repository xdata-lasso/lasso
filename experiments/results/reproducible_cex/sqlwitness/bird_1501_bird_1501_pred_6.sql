-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, '201306', NULL, 1, 1, NULL, NULL, NULL), (0, '2023-01-01', '201306', 1, NULL, NULL, NULL, 0, 1.0), (2, '2023-01-02', NULL, NULL, 1, 1, NULL, 1, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 0, '201306', '201306'), (1, 0, NULL, 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (0, '201306', '201306%'), (1, 'default1', 'default1'), (2, NULL, '201306%'), (3, 'default1', '201306'), (4, '201306%', 'default1'), (5, 'default1', 'default1'), (6, 'default1', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (4, '201306%', 1.0), (0, '201306', 1.0), (0, 'default1', 0.0), (0, '201306%', 0.0), (3, 'default1', 0.0), (1, 'default1', NULL), (0, 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT g.Country FROM yearmonth AS y JOIN gasstations AS g ON y.CustomerID = g.GasStationID WHERE y.Date LIKE '201306%';

/*
Prediction Result:
('201306',)
*/