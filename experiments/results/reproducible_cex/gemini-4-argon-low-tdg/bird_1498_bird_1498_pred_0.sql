-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, SUM vs AVG/MAX/MIN/COUNT, GROUP BY month vs no GROUP BY, ORDER BY DESC vs ASC, LIMIT 1, and year filtering ('2012' vs '2011'/'2013').
-- Also tests SUBSTRING(Date, 5, 2) vs SUBSTRING(Date, 1, 6) or Date by using extra suffix characters.
-- Also tests SUM(DISTINCT Consumption) by using identical consumption values (25.0) in the winning month.
-- Also includes a customer with no yearmonth records and a NULL consumption to test INNER vs LEFT JOIN and NULL handling.
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'LAM', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (4, 'SME', 'CZK');
-- Month '01' in 2012: 3 rows (two with identical Consumption 25.0, one with NULL).
-- SUM = 50.0, SUM(DISTINCT) = 25.0, AVG = 25.0, MAX = 25.0, COUNT = 2 or 3.
-- Notice different suffixes ('A', 'B') to kill GROUP BY Date instead of SUBSTRING(Date, 5, 2).
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201201A', 25.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201201B', 25.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '201201A', NULL);
-- Month '02' in 2012: 1 row with Consumption 40.0.
-- SUM = 40.0, MAX = 40.0, AVG = 40.0.
-- Ensures Month '01' wins on SUM (50.0 > 40.0), while Month '02' would win on MAX or AVG (40.0 > 25.0) or if Month '01' used DISTINCT (40.0 > 25.0) or grouped by exact Date (40.0 > 25.0).
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201202A', 40.0);
-- Month '03' in 2012: 1 row with small Consumption 10.0 (tests ORDER BY ASC vs DESC).
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201203A', 10.0);
-- Other years (2011, 2013) with huge Consumption to kill missing/wrong year filter (e.g., != '2012', >= '2012', <= '2012', or LIKE '%2012%').
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201101A', 500.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (2, '201301A', 600.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (3, '992012A', 700.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(Consumption) FROM yearmonth WHERE SUBSTRING(Date, 1, 4) = '2012' GROUP BY SUBSTRING(Date, 5, 2) ORDER BY SUM(Consumption) DESC LIMIT 1;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT MAX(Consumption) FROM yearmonth WHERE SUBSTRING(Date, 1, 4) = '2012';

/*
Prediction Result:
(40.0,)
*/