-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (5, '2013-10-27', '2012', 2, -1, 0, 3, -1, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT (T2_2012.Consumption - T2_2013.Consumption) / T2_2012.Consumption AS ConsumptionDecreaseRate FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2_2012 ON T1.CustomerID = T2_2012.CustomerID AND T2_2012.Date LIKE '2012%' INNER JOIN yearmonth AS T2_2013 ON T1.CustomerID = T2_2013.CustomerID AND T2_2013.Date LIKE '2013%' WHERE T1.Amount = 634.8 AND T1.Date = '2012-08-25';

/*
Prediction Result:
*/