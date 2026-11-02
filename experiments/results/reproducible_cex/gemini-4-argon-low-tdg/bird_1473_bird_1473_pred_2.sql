-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 10.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '120130', 5000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '2013', 30.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '2012013', 8000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.Consumption) / 12 FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME';

/*
Gold Result:
(1.6666666666666667,)
*/

-- Prediction Query
SELECT AVG("yearmonth"."consumption") / 12 FROM "yearmonth" INNER JOIN "customers" ON "yearmonth"."customerid" = "customers"."customerid" WHERE "customers"."segment" = 'SME' AND "yearmonth"."date" BETWEEN '201301' AND '201312';

/*
Prediction Result:
(0.8333333333333334,)
*/