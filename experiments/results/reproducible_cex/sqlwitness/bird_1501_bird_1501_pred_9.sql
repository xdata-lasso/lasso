-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-01', '201306', 0, NULL, 0, 0, 0, 0.0), (1, '2013-06-27', 'default1', 0, 1, 0, NULL, 1, 1.0), (2, '2023-01-02', NULL, NULL, 0, 1, 0, 0, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, '%Y-%m', '%Y-%m'), (0, 0, '%Y-%m', 'default1'), (2, 0, NULL, 'default1'), (3, 0, 'default1', '201306'), (4, NULL, '201306', '201306'), (5, 0, NULL, 'default2'), (6, NULL, '%Y-%m', 'default2'), (7, NULL, NULL, '201306'), (8, 1, '%Y-%m', NULL), (9, 0, 'default1', '%Y-%m');
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default2', '2013-06'), (0, NULL, '%Y-%m'), (2, '2013-06', NULL), (3, '%Y-%m', '201306'), (4, 'default2', 'default1'), (5, 'default1', '2013-06'), (6, '%Y-%m', 'default2'), (7, '201306', NULL), (8, NULL, 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (0, '2013-06', 0.0), (1, '%Y-%m', 1.0), (2, 'default2', NULL), (1, 'default1', 0.0), (1, '201306', 1.0), (3, 'default1', NULL), (5, '201306', 1.0), (3, '2013-06', NULL), (7, '201306', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.Country FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE NOT T2.Date IS NULL AND STRFTIME('%Y-%m', T2.Date) = '2013-06';

/*
Prediction Result:
('%Y-%m',)
*/