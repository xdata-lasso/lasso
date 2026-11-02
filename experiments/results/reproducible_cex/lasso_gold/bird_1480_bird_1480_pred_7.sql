-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1213, 'SME', 'structure');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1214, 'SME', 'response');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1215, 'SME', 'knowledge');
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1216, 'SME', 'pick');
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1213, '2013 ', 1217.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1214, '2013 ', 1224.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1215, '2013 ', 1231.5);
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1216, '2013 ', 1238.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 5, 2) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME' GROUP BY SUBSTRING(T2.Date, 5, 2) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 5, 2) NULLS LAST LIMIT 1;

/*
Gold Result:
(' ',)
*/

-- Prediction Query
SELECT SUBSTRING(yearmonth.date, 5, 2) AS month, SUM(yearmonth.consumption) AS total_consumption FROM customers INNER JOIN yearmonth ON customers.customerid = yearmonth.customerid WHERE yearmonth.date BETWEEN '201301' AND '201312' AND customers.segment = 'SME' GROUP BY month ORDER BY total_consumption DESC, month NULLS LAST LIMIT 1;

/*
Prediction Result:
*/