-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, NULL, '2012%', NULL, 3, 4, NULL, 0, 5.0), (1, '2013-10-27', 'default2', NULL, -1, -1, 0, 5, -1.0), (-1, '2013-10-27', '2013%', -1, 3, NULL, 4, 0, 633.8), (0, '2012-08-26', '2013', 0, NULL, -1, 5, 2, 2.0), (4, '2012-08-26', '2012%', 5, 3, 2, 4, 1, 4.0), (5, '2013-10-27', NULL, 2, 3, 0, 4, NULL, 4.0), (3, '2013-10-27', 'default1', NULL, 0, 0, 5, 3, 5.0), (6, '2012-08-26', NULL, -1, 5, 3, NULL, 2, 4.0), (7, '2012-08-24', '2012%', 4, 2, 3, 2, -1, 635.8), (8, '2023-01-02', NULL, -1, 5, 2, 2, NULL, 0.0), (9, '2012-10-27', NULL, 1, -1, -1, 4, NULL, 635.8), (10, '2012-08-25', '2012', 1, 5, 1, -1, -1, 0.0), (11, '2012-08-26', '2012', 2, 3, 3, 2, -1, 633.8), (12, '2012-10-27', 'default1', 4, -1, -1, 5, NULL, NULL), (13, '2012-08-25', '2012-08-25', 2, 1, 0, 0, 3, 634.8), (14, NULL, 'default1', NULL, 2, -1, NULL, 2, 0.0), (15, NULL, '2012%', 4, 2, 4, NULL, 1, NULL), (16, '2012-10-27', '2012%', 2, 5, 4, 3, 3, 634.8);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (5, 2, '2013%', '2013'), (0, 4, '2012%', NULL), (2, 5, 'default1', 'default1'), (4, -1, '2012%', '2012%'), (1, NULL, '2012%', '2012%'), (-1, NULL, '2012%', 'default1'), (3, 3, '2012-08-25', '2013%'), (6, -1, 'default2', '2012%'), (7, 3, '2013', '2012%'), (8, 0, '2012', 'default1'), (9, 5, '2012%', 'default1'), (10, -1, 'default2', '2013%'), (11, 4, '2012%', '2012'), (12, -1, NULL, '2013'), (13, 3, 'default2', 'default1'), (14, 1, '2013', 'default1'), (15, 0, NULL, '2013'), (16, NULL, '2013', 'default2'), (17, 4, '2012', '2013'), (18, 1, 'default2', '2012-08-25');
INSERT INTO customers (customerid, segment, currency) VALUES (4, '2012-08-25', 'default2'), (1, '2012%', 'default2'), (5, '2012%', NULL), (3, '2012-08-25', NULL), (2, NULL, '2012-08-25'), (0, '2012-08-25', '2012-08-25'), (-1, '2012', 'default2'), (6, '2012', NULL), (7, 'default2', 'default2'), (8, 'default1', 'default1'), (9, 'default2', '2012%'), (10, NULL, 'default2'), (11, NULL, '2012%'), (12, 'default1', 'default1'), (13, '2013%', NULL), (14, '2012', '2012'), (15, '2013', '2012'), (16, '2012-08-25', '2012%'), (17, 'default2', '2012-08-25'), (18, '2013', 'default2'), (19, '2013', '2012%'), (20, '2012%', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (-1, '2012', 635.8), (-1, 'default2', 635.8), (3, '2012%', 635.8), (-1, '2013', 635.8), (12, '2013%', 1.0), (2, '2012-08-25', 634.8), (2, '2012', 634.8), (2, 'default1', -1.0), (4, '2012', 635.8), (8, 'default2', 635.8), (1, '2012', 0.0), (0, '2012%', 3.0), (8, 'default1', 634.8), (0, '2013%', -1.0), (19, '2013', 5.0), (14, '2012-08-25', 635.8), (3, '2012', 2.0), (4, '2013%', 3.0), (8, '2013%', 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT CAST((SUM(CASE WHEN ym."Date" LIKE '2012%' THEN ym.Consumption ELSE 0 END) - SUM(CASE WHEN ym."Date" LIKE '2013%' THEN ym.Consumption ELSE 0 END)) AS REAL) / SUM(CASE WHEN ym."Date" LIKE '2012%' THEN ym.Consumption ELSE 0 END) AS ConsumptionDecreaseRate FROM yearmonth AS ym INNER JOIN transactions_1k AS t ON ym.CustomerID = t.CustomerID WHERE t."Date" = '2012-08-25' AND ym."Date" LIKE '2012%' AND ym."Date" LIKE '2013%';

/*
Prediction Result:
(None,)
*/