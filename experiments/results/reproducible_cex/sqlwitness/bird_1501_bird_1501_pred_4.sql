-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-02', 'default1', NULL, 0, 0, NULL, NULL, 1.0), (0, '2023-01-02', '201306', 0, NULL, 1, 0, 1, 1.0), (2, '2023-01-01', '201306%', 1, 0, NULL, 0, 0, 0.0), (3, '2023-01-02', NULL, NULL, 1, NULL, NULL, NULL, 1.0), (4, '2023-01-01', 'default2', 1, NULL, 0, 1, NULL, 1.0), (5, NULL, '201306%', 1, 0, NULL, 0, NULL, 1.0), (6, '2023-01-02', '201306%', 0, 0, 1, NULL, 0, 1.0), (7, '2023-01-01', '201306', 1, NULL, 0, 0, 0, 1.0), (8, '2023-01-01', '201306', NULL, 1, NULL, NULL, 0, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, '201306%', '201306%'), (1, 1, '201306', '201306%'), (2, NULL, NULL, NULL), (3, NULL, 'default1', NULL), (4, NULL, 'default1', 'default1'), (5, 1, NULL, '201306');
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default2', 'default2'), (0, '201306', '201306'), (2, '201306', '201306'), (3, 'default2', '201306'), (4, '201306', 'default1'), (5, '201306', 'default1'), (6, NULL, '201306%'), (7, 'default1', '201306%');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (7, 'default2', 1.0), (1, '201306', NULL), (0, 'default1', 1.0), (5, 'default2', 1.0), (7, 'default1', 1.0), (2, '201306%', 0.0), (6, 'default1', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
('201306%',)
('201306%',)
*/

-- Prediction Query
SELECT DISTINCT g.Country FROM gasstations AS g JOIN transactions_1k AS t ON g.GasStationID = t.GasStationID JOIN yearmonth AS y ON t.CustomerID = y.CustomerID WHERE y.Date LIKE '201306%';

/*
Prediction Result:
('201306%',)
*/