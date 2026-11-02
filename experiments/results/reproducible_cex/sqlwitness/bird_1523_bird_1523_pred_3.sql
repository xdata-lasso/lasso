-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, '2023-01-02', '667467', NULL, 667467, 1, NULL, 667467, 667467.0), (667467, NULL, '667467', NULL, 2, 2, 0, 667468, 667467.0), (0, NULL, '667467', 2, 667467, 667466, 667466, 667467, 0.0), (1, NULL, '667467', 1, 2, 667466, 667467, 667466, 1.0), (667468, '2023-01-01', 'default2', 1, 0, 667466, 667466, 667468, 667467.0), (667466, NULL, 'default1', 0, 0, 667468, 667468, 1, 667467.0), (3, '2023-01-01', 'default2', 2, NULL, 667468, 1, 2, NULL), (4, '2023-01-01', '667467', 667467, NULL, 0, 1, 667467, 0.0), (5, '2023-01-01', NULL, 0, 2, 667467, 0, 2, 667466.0), (6, '2023-01-02', 'default2', 0, 667468, 667468, 0, 1, 667468.0), (7, '2023-01-02', 'default2', NULL, 1, 667466, 667466, 0, 0.0), (8, '2023-01-01', NULL, 0, 667467, 0, 1, NULL, 667468.0), (9, NULL, NULL, 667466, 2, 1, 667468, 667466, 667467.0), (10, '2023-01-02', NULL, 667467, NULL, 667468, 667466, 0, 0.0), (11, '2023-01-01', 'default1', 2, 667467, 1, 0, 667467, 667467.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 667467, NULL, NULL), (667466, 0, 'default2', '667467'), (2, 667467, 'default1', '667467'), (1, 2, 'default1', NULL), (667467, 1, 'default2', 'default1'), (667468, 667468, '667467', 'default1'), (3, NULL, NULL, 'default1'), (4, 667466, NULL, 'default2'), (5, 667467, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('default2',)
('default1',)
(None,)
('default1',)
*/

-- Prediction Query
SELECT g.Country FROM transactions_1k AS t JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE t.CardID = 667467 LIMIT 1;

/*
Prediction Result:
('default2',)
*/