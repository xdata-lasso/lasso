-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-01', '667467', 667467, 1, 667467, 1, 667466, NULL), (667468, '2023-01-01', 'default2', 667466, 1, 1, 0, 667467, 667468.0), (667467, '2023-01-01', 'default2', 0, 667467, 667466, 667468, 667468, 0.0), (0, '2023-01-01', 'default1', 667468, 667468, 1, 0, 667468, 667467.0), (667466, NULL, NULL, 667468, 667467, 1, 667467, 1, NULL), (2, '2023-01-01', 'default2', 0, 667467, NULL, 1, 667468, 0.0), (3, '2023-01-02', '667467', 0, 0, 1, 667467, 667466, NULL), (4, '2023-01-02', 'default1', 0, NULL, 667466, 667467, 1, 667467.0), (5, '2023-01-01', 'default1', 0, 0, NULL, 667466, NULL, 667466.0), (6, NULL, '667467', 0, 667467, 667466, 1, 667466, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (667466, 667467, NULL, NULL), (667468, 1, '667467', 'default2'), (0, 1, 'default2', 'default1'), (667467, 667466, '667467', 'default1'), (1, 1, 'default2', '667467'), (2, 667468, 'default2', NULL), (3, 0, '667467', '667467'), (4, 667467, 'default2', 'default2'), (5, 0, '667467', NULL), (6, 1, 'default1', 'default2'), (7, 1, '667467', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
(None,)
('default2',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT "gasstations"."country" FROM "transactions_1k" INNER JOIN "gasstations" ON "transactions_1k"."gasstationid" = "gasstations"."gasstationid" WHERE "transactions_1k"."cardid" = 667467;

/*
Prediction Result:
(None,)
('default2',)
*/