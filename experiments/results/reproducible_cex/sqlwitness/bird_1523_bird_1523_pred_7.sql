-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, 'default2', 0, 0, 0, 667468, 1, 667467.0), (667468, NULL, 'default2', NULL, 667467, 1, 1, 667466, 1.0), (667467, NULL, '667467', NULL, 667467, 0, 667466, NULL, 0.0), (0, '2023-01-02', 'default2', 667468, 667467, 1, 0, 667468, 667468.0), (667466, '2023-01-02', '667467', 667467, 1, NULL, NULL, 1, 0.0), (2, NULL, 'default1', NULL, 667468, 667467, 667468, 0, 667466.0), (3, NULL, 'default2', 667468, 667467, 667467, 667468, 667466, NULL), (4, NULL, 'default1', NULL, 0, NULL, 667467, NULL, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, '667467', '667467'), (667466, 667468, 'default2', 'default1'), (667467, 1, NULL, 'default2'), (0, 667468, 'default1', NULL), (667468, 667468, 'default1', 'default1'), (2, 667467, NULL, NULL), (3, 667466, '667467', NULL), (4, 667466, 'default1', NULL), (5, 0, NULL, NULL), (6, 667466, '667467', NULL), (7, 667467, NULL, 'default2');
INSERT INTO customers (customerid, segment, currency) VALUES (1, NULL, 'default2'), (0, 'default1', NULL), (667466, '667467', 'default2'), (667468, 'default2', 'default2'), (667467, NULL, NULL), (2, NULL, 'default1'), (3, 'default1', '667467');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('667467',)
(None,)
('default1',)
('667467',)
*/

-- Prediction Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN customers AS T3 ON T1.CustomerID = T3.CustomerID WHERE T1.CardID = 667467;

/*
Prediction Result:
('667467',)
(None,)
*/