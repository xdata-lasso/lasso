-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', NULL, 0, NULL, 1, 1, NULL, NULL), (1, '2023-01-02', NULL, 0, 0, NULL, NULL, 1, NULL), (2, '2023-01-02', 'default1', 1, 1, 1, 0, 0, 1.0), (3, '2023-01-01', 'default2', 0, 0, 1, 0, NULL, NULL), (4, NULL, 'default2', NULL, NULL, 0, NULL, NULL, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, '201306', 'default2'), (1, 0, 'default2', '201306'), (2, NULL, 'default1', 'default2'), (3, 1, '201306%', 'default1'), (4, 0, NULL, '201306%'), (5, NULL, '201306%', '201306%'), (6, 1, NULL, NULL);
INSERT INTO customers (customerid, segment, currency) VALUES (0, '201306%', '201306%'), (1, '201306%', NULL), (2, 'default2', '201306'), (3, 'default2', 'default2'), (4, NULL, NULL), (5, '201306', '201306'), (6, 'default2', 'default1'), (7, NULL, 'default2'), (8, '201306%', NULL), (9, 'default1', '201306'), (10, '201306', 'default1');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (2, '201306', 1.0), (0, '201306%', NULL), (3, '201306', NULL), (8, '201306%', NULL), (6, '201306', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN yearmonth AS T3 ON T1.CustomerID = T3.CustomerID WHERE T3.Date = '201306';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T3.Country FROM yearmonth AS T1 JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID JOIN gasstations AS T3 ON T2.GasStationID = T3.GasStationID WHERE T1."Date" LIKE '201306%';

/*
Prediction Result:
('default2',)
*/