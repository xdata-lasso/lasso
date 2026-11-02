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
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (101, 1, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (102, 2, 'CZE', 'Premium');
INSERT INTO products (ProductID, Description) VALUES (1, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (2, 'Natural 95');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '10:15:00', 1, 501, 101, 1, 15, 634.8);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '11:20:00', 2, 502, 101, 1, 634, 500.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-26', '09:00:00', 3, 503, 102, 2, 20, 634.8);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 100.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201206', 300.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 50.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201305', 30.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201311', 20.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201401', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 1000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201301', 900.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 200.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201301', 180.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) - SUM(IIF(SUBSTRING(Date, 1, 4) = '2013', Consumption, 0)) AS REAL) / SUM(IIF(SUBSTRING(Date, 1, 4) = '2012', Consumption, 0)) FROM yearmonth WHERE CustomerID = (SELECT T1.CustomerID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' AND T1.Price = 634.8);

/*
Gold Result:
(0.75,)
*/

-- Prediction Query
SELECT CAST((SUM(CASE WHEN ym."Date" LIKE '2012%' THEN ym.Consumption ELSE 0 END) - SUM(CASE WHEN ym."Date" LIKE '2013%' THEN ym.Consumption ELSE 0 END)) AS REAL) / SUM(CASE WHEN ym."Date" LIKE '2012%' THEN ym.Consumption ELSE 0 END) AS ConsumptionDecreaseRate FROM yearmonth AS ym INNER JOIN transactions_1k AS t ON ym.CustomerID = t.CustomerID WHERE t."Date" = '2012-08-25' AND ym."Date" LIKE '2012%' AND ym."Date" LIKE '2013%';

/*
Prediction Result:
(None,)
*/