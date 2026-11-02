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
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (5, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (6, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (7, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (8, 'KAM', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value for money');
INSERT INTO products (ProductID, Description) VALUES (20, 'Diesel');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 450.75);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 210.00);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201', 315.50);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201201', 120.25);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (5, '201201', 890.00);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (6, '201202', 540.10);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (7, '201112', 670.80);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (8, '201208', 999.90);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '10:15:00', 1, 101, 10, 20, 5, 124.05);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '11:20:00', 2, 102, 10, 20, 5, 124.00);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-24', '12:30:00', 3, 103, 10, 20, 5, 124.06);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-23', '14:00:00', 4, 104, 10, 20, 5, 124.05);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2012-08-25', '15:45:00', 5, 105, 10, 20, 5, 124.05);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (6, '2012-08-24', '16:10:00', 6, 106, 10, 20, 5, 124.05);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (7, '2012-08-24', '17:05:00', 7, 107, 10, 20, 5, 124.05);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (8, '2012-08-24', '18:00:00', 8, 108, 10, 20, 5, 124.05);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.CustomerID, T2.Date, T2.Consumption FROM transactions_1k AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-24' AND T1.Price = 124.05 AND T2.Date = '201201';

/*
Gold Result:
(1, '201201', 450.75)
*/

-- Prediction Query
SELECT SUM(y.Consumption) AS TotalExpense, y.Date AS Date, t.Amount AS Expense FROM transactions_1k AS t INNER JOIN yearmonth AS y ON t.CustomerID = y.CustomerID WHERE t.Amount = 124.05 AND t.Date = '2012-08-24' AND y."Date" LIKE '2012-01-%';

/*
Prediction Result:
(None, None, None)
*/