-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-10-27', '2013%', 0, 0, 0, -1, 1, 3.0), (-1, '2012-08-24', '2012-08-25', 3, 1, 2, -1, -1, 1.0), (4, '2023-01-01', '2012%', 5, -1, NULL, 3, 0, 633.8), (1, '2023-01-02', '2012%', 3, 1, 4, 1, NULL, 5.0), (2, '2012-08-26', 'default1', -1, 2, 3, 5, 4, 5.0), (3, '2023-01-01', 'default2', 4, -1, NULL, 3, -1, 5.0), (5, '2012-08-25', '2013', -1, 4, 2, 0, 2, 634.8), (6, '2012-08-24', NULL, 5, 4, 4, 0, 5, 0.0), (7, '2012-10-27', '2012%', 5, NULL, 0, 3, 0, 5.0), (8, '2013-10-27', '2012-08-25', 1, 5, 0, 2, 1, NULL), (9, '2012-10-27', NULL, -1, NULL, NULL, 2, 1, -1.0), (10, NULL, '2012%', -1, 0, 4, 3, 4, 1.0), (11, '2023-01-01', 'default1', 0, NULL, 2, 2, 1, NULL), (12, '2013-10-27', NULL, 1, 3, 1, 4, 5, 4.0), (13, '2012-08-25', 'default2', 4, 1, 1, 1, NULL, 635.8), (14, '2012-08-24', 'default2', 0, NULL, -1, -1, 4, 633.8), (15, '2013-10-27', NULL, 2, NULL, 5, NULL, NULL, 3.0), (16, '2023-01-02', '2013', 1, 2, 4, 5, 5, -1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (2, 5, NULL, '2012%'), (-1, 5, 'default2', '2012'), (1, 3, 'default1', 'default2'), (3, 0, '2012', '2012%'), (0, 4, '2013%', '2012%'), (4, 4, 'default2', '2012%'), (5, 2, 'default1', '2013'), (6, 1, 'default1', '2012'), (7, 1, '2012-08-25', '2013'), (8, 2, 'default2', '2012-08-25');
INSERT INTO customers (customerid, segment, currency) VALUES (5, 'default2', 'default2'), (2, '2013%', '2012-08-25'), (0, NULL, 'default1'), (1, 'default1', NULL), (-1, 'default1', '2012%'), (4, '2013', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (-1, 'default1', NULL), (-1, '2012%', 5.0), (2, 'default2', 633.8), (5, '2012', 633.8), (4, '2012-08-25', NULL), (5, 'default2', 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT ((SELECT T2.Consumption FROM yearmonth AS T2 WHERE T2.CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8) AND T2.Date LIKE '2012%') - (SELECT T3.Consumption FROM yearmonth AS T3 WHERE T3.CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8) AND T3.Date LIKE '2013%')) / (SELECT T2.Consumption FROM yearmonth AS T2 WHERE T2.CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8) AND T2.Date LIKE '2012%') AS ConsumptionDecreaseRate;

/*
Prediction Result:
(None,)
*/