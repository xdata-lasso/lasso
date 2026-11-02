-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, NULL, 'default1'), (0, 'default2', '201306'), (2, '201306', NULL), (3, 'default2', '201306%'), (4, '201306', '201306%'), (5, 'default2', NULL), (6, 'default1', 'default1'), (7, 'default2', 'default1'), (8, '201306', '201306%'), (9, '201306%', '201306%'), (10, '201306%', 'default2'), (11, 'default1', '201306'), (12, 'default1', 'default1'), (13, '201306', '201306%'), (14, NULL, '201306%'), (15, '201306%', '201306%'), (16, 'default2', '201306%'), (17, 'default1', '201306');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (4, '201306', 214583.17), (3, 'default2', 0.0), (4, 'default1', 214581.17), (16, '201306', 0.0), (10, 'default2', 214581.17), (17, '201306%', 1.0), (8, '201306%', 214582.17), (11, 'default2', NULL), (10, '201306', 0.0), (10, '201306%', 214582.17), (5, '201306%', 0.0), (1, '201306', 214583.17), (1, 'default1', 214582.17), (1, '201306%', 1.0), (0, 'default2', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Currency FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201306' AND T1.Consumption = 214582.17;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.Currency FROM customers AS c JOIN yearmonth AS ym ON c.CustomerID = ym.CustomerID WHERE ym.Consumption = 214582.17 AND ym.Date LIKE '201306%';

/*
Prediction Result:
('201306%',)
('default2',)
*/