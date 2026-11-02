-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default1', '201306%'), (0, 'default1', '201306%'), (2, 'default1', 'default2'), (3, '201306%', '201306'), (4, '201306', NULL);
INSERT INTO yearmonth (customerid, date, consumption) VALUES (0, '201306', 214582.17), (0, '201306%', 214582.17), (3, '201306%', 0.0), (2, 'default1', NULL), (1, 'default2', 214583.17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Currency FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201306' AND T1.Consumption = 214582.17;

/*
Gold Result:
('201306%',)
*/

-- Prediction Query
SELECT T1.Currency FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Consumption = 214582.17 AND T2.Date LIKE '201306%';

/*
Prediction Result:
('201306%',)
('201306%',)
*/