-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'SME', 'USD');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201306', 214582.17);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201306', 214582.17);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '20130601', 214582.17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Currency FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201306' AND T1.Consumption = 214582.17;

/*
Gold Result:
('EUR',)
('EUR',)
*/

-- Prediction Query
SELECT DISTINCT customers.currency FROM customers INNER JOIN yearmonth ON customers.customerid = yearmonth.customerid WHERE SUBSTRING(yearmonth.date, 1, 6) = '201306' AND yearmonth.consumption = 214582.17;

/*
Prediction Result:
('EUR',)
('USD',)
*/