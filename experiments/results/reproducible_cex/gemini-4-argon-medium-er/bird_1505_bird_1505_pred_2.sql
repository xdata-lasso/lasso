-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '202001', 1500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '202002', 1500.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM yearmonth AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T2.Currency = 'EUR' AND T1.Consumption > 1000.00;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "customers"."customerid") FROM "customers" INNER JOIN "yearmonth" ON "customers"."customerid" = "yearmonth"."customerid" WHERE "customers"."currency" = 'EUR' AND "yearmonth"."consumption" > 1000;

/*
Prediction Result:
(1,)
*/