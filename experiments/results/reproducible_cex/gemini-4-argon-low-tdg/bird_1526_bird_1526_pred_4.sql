-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value');
INSERT INTO products (ProductID, Description) VALUES (100, 'Diesel');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '12:00:00', 1, 10, 10, 100, 30, 634.8);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '12:05:00', 2, 20, 99, 100, 30, 634.8);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-26', '12:10:00', 3, 30, 10, 100, 30, 634.8);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-25', '12:15:00', 4, 40, 10, 100, 30, 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 300.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 150.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201302', 150.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201401', 900.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 1000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201301', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 2000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201301', 200.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201201', 4000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201301', 400.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(0.625,)
*/

-- Prediction Query
SELECT CAST((y2012.Consumption - y2013.Consumption) AS REAL) / CAST(y2012.Consumption AS REAL) AS decrease_rate FROM yearmonth AS y2012 JOIN yearmonth AS y2013 ON y2012.CustomerID = y2013.CustomerID WHERE y2012.Date LIKE '2012%' AND y2013.Date LIKE '2013%' AND y2012.CustomerID = (SELECT CustomerID FROM transactions_1k WHERE Amount = 634.8 AND Date = '2012-08-25') LIMIT 1;

/*
Prediction Result:
*/