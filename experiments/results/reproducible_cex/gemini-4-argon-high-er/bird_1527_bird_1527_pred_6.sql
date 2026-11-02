-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 1, 'CZE', 'Value');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 1, 'CZE', 'Value');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2020-01-01', '10:00:00', 1, 1, 1, 1, 10, 100.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2020-01-01', '11:00:00', 1, 1, 2, 1, 100, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT GasStationID FROM transactions_1k GROUP BY GasStationID ORDER BY SUM(Price) DESC, GasStationID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT gst.GasStationID FROM transactions_1k AS t INNER JOIN gasstations AS gst ON t.GasStationID = gst.GasStationID GROUP BY t.GasStationID ORDER BY SUM(t.Amount) DESC, gst.GasStationID NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/