-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (54839, '2012-08-24', '2012-08-24', 54840, 0, 1, 54839, 0, 548.4);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 54839, '2012-08-24', '2012-08-24'), (54840, 0, NULL, NULL), (54841, 54840, 'default2', '2012-08-24'), (54839, NULL, 'default2', 'default1'), (1, 54841, '2012-08-24', 'default2'), (2, 54841, '2012-08-24', 'default1');
INSERT INTO customers (customerid, segment, currency) VALUES (54839, 'default2', 'default1'), (1, 'default1', '2012-08-24'), (0, 'default2', '2012-08-24'), (54840, 'default1', 'default1'), (54841, NULL, 'default2'), (2, NULL, '2012-08-24'), (3, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('2012-08-24',)
*/

-- Prediction Query
SELECT T1.Currency FROM customers AS T1 INNER JOIN transactions_1k AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Amount = 54840 AND T2.Date = '2012-08-24';

/*
Prediction Result:
*/