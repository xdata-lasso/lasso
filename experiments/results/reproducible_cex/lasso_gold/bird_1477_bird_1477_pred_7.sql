-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1009, 'since', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1010, 'blue', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1011, 'require', 'EUR');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1012, 'sit', 'EUR');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1009, 'wait', 1015.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1009, 'knowledge', 1018.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 1, 4) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Currency = 'EUR' GROUP BY SUBSTRING(T2.Date, 1, 4) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 1, 4) NULLS LAST LIMIT 1;

/*
Gold Result:
('know',)
*/

-- Prediction Query
SELECT T1.Date FROM yearmonth AS T1 JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' GROUP BY T1."Date" ORDER BY SUM(T1.Consumption) DESC, T1.Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('knowledge',)
*/