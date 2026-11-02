-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '12:00:00', 1, 100, 10, 1, 10, 634.8);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201207', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201208', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201303', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(0.75,)
*/

-- Prediction Query
SELECT (y2012."Consumption" - y2013."Consumption") / y2012."Consumption" AS consumption_decrease_rate FROM (SELECT "CustomerID", "Consumption" FROM "yearmonth" WHERE "Date" = '201207') AS y2012 INNER JOIN (SELECT "CustomerID", "Consumption" FROM "yearmonth" WHERE "Date" = '201303') AS y2013 ON y2012."CustomerID" = y2013."CustomerID" WHERE y2012."CustomerID" = (SELECT "CustomerID" FROM "transactions_1k" WHERE "Date" = '2012-08-25' AND "Price" = 634.8 LIMIT 1);

/*
Prediction Result:
(0.5,)
*/