-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic aggregation vs single-row filtering, boundary conditions (30000), and date filtering across multiple rows per customer.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'EUR');
-- Customer 1: Two rows in 2012 summing to 25000 (< 30000), plus a 2013 row that would push the sum over 30000 if date filter is missing/wrong.
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201', 15000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202', 10000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 10000.0);
-- Customer 2: Two rows in 2012, each < 30000, but summing to 35000 (>= 30000). Catches WHERE Consumption < 30000 instead of HAVING SUM(Consumption) < 30000, or MAX/AVG instead of SUM.
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201', 18000.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201202', 17000.0);
-- Customer 3: Exact boundary 30000. Catches <= 30000 instead of < 30000.
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201205', 30000.0);
-- Customer 4: Wrong segment ('SME'), valid 2012 consumption < 30000. Catches missing/wrong Segment filter.
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (4, '201201', 5000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM (SELECT T2.CustomerID FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND SUBSTRING(T2.Date, 1, 4) = '2012' GROUP BY T2.CustomerID HAVING SUM(T2.Consumption) < 30000) AS t1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.CustomerID) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' AND T2.Consumption < 30000 AND SUBSTRING(T2.Date, 1, 4) = '2012';

/*
Prediction Result:
(2,)
*/