-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customerid, segment, currency) VALUES (101, '201202', 'default1'), (99, NULL, '201202'), (0, 'default2', 'default1'), (100, '201202', '201202%'), (-1, 'default2', NULL), (2, NULL, 'default2'), (1, 'default1', 'default1'), (3, 'default2', 'default2'), (4, NULL, 'default1'), (5, '201202%', 'default2');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (-1, 'default1', 529.3), (99, '201202%', 99.0), (101, '201202', 100.0), (1, '201202%', 528.3), (2, 'default2', 2.0), (100, '201202%', 101.0), (5, '201202', 101.0), (3, '201202%', 529.3), (101, '201202%', 1.0), (100, 'default2', 527.3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Consumption > 528.3, 1, 0)) AS REAL) * 100 / COUNT(CustomerID) FROM yearmonth WHERE Date = '201202';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN ym.Consumption > 528.3 THEN 1 END) AS REAL) * 100.0 / COUNT(*) AS percentage_customer_consumption FROM yearmonth AS ym WHERE ym."Date" LIKE '201202%';

/*
Prediction Result:
(14.285714285714286,)
*/