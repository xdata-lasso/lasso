-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (1, NULL, 'default2'), (0, 'default2', 'default1'), (2, NULL, 'default1'), (3, NULL, NULL), (4, 'default1', NULL), (5, NULL, '201306'), (6, 'default2', '%201306%'), (7, 'default1', '%201306%'), (8, 'default2', '%201306%'), (9, '%201306%', '201306'), (10, 'default2', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, '201306', 1.0), (0, 'default1', 214581.17), (5, 'default2', 214582.17), (1, 'default2', 1.0), (3, '201306', 214583.17), (6, '%201306%', 214582.17), (1, '%201306%', NULL), (10, '201306', 214581.17), (5, '201306', 214583.17), (10, 'default1', 214582.17), (4, 'default2', 214581.17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Currency FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '201306' AND T1.Consumption = 214582.17;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Currency FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Consumption = 214582.17 AND T1.Date LIKE '%201306%';

/*
Prediction Result:
('%201306%',)
*/