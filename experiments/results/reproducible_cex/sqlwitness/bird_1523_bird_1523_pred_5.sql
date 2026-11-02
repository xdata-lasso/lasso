-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (667466, NULL, 'default1', 667468, 1, NULL, NULL, 1, 0.0), (667468, '2023-01-02', NULL, 1, 1, 0, 667467, 1, 1.0), (667467, '2023-01-02', NULL, 667468, 667467, 1, 0, 667468, 0.0), (1, '2023-01-01', NULL, 0, 667467, 0, NULL, NULL, 667467.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 1, '667467', 'default2'), (667468, NULL, '667467', '667467'), (667466, 667466, 'default1', '667467'), (667467, 667468, '667467', '667467'), (0, 1, 'default2', '667467');
INSERT INTO customers (customerid, segment, currency) VALUES (667467, 'default2', 'default2'), (0, 'default1', '667467'), (667468, 'default2', '667467'), (667466, NULL, '667467');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('default2',)
('667467',)
*/

-- Prediction Query
SELECT customers.Currency FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.CardID = 667467;

/*
Prediction Result:
('667467',)
('667467',)
*/