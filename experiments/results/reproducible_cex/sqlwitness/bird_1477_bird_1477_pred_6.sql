-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, NULL, '%Y', 3, 0, 0, 3, 4, 3.0), (1, NULL, 'default1', NULL, 2, 1, NULL, NULL, 3.0), (5, NULL, 'default1', 1, 5, 3, 0, 4, 1.0), (3, '2023-01-01', 'EUR', 5, 1, 1, 1, 2, 0.0), (0, '2023-01-01', 'default2', 0, NULL, NULL, 1, NULL, 2.0), (4, '2023-01-01', 'EUR', 3, 4, 2, NULL, 3, 4.0);
INSERT INTO customers (customerid, segment, currency) VALUES (3, 'default1', 'default1'), (0, 'default2', '%Y'), (1, NULL, 'EUR'), (4, 'default2', 'default2'), (2, 'EUR', '%Y');
INSERT INTO yearmonth (customerid, date, consumption) VALUES (1, 'EUR', 3.0), (4, 'default2', 2.0), (1, 'default2', 4.0), (3, 'default2', 2.0), (1, 'default1', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('defa',)
*/

-- Prediction Query
SELECT STRFTIME('%Y', "transactions_1k"."Date") AS year, SUM("transactions_1k"."Amount") AS total_gas_use FROM "transactions_1k" INNER JOIN "customers" ON "transactions_1k"."CustomerID" = "customers"."CustomerID" WHERE "customers"."Currency" = 'EUR' GROUP BY year ORDER BY total_gas_use DESC, year NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, 4)
*/