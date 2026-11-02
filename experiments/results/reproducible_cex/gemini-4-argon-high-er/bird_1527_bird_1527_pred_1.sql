-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO gasstations (GasStationID) VALUES (1);
INSERT INTO gasstations (GasStationID) VALUES (2);
INSERT INTO transactions_1k (TransactionID, GasStationID, Amount, Price) VALUES (1, 1, 1, 10.0);
INSERT INTO transactions_1k (TransactionID, GasStationID, Amount, Price) VALUES (2, 2, 5, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT GasStationID FROM transactions_1k GROUP BY GasStationID ORDER BY SUM(Price) DESC, GasStationID NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT gs.GasStationID FROM gasstations AS gs INNER JOIN transactions_1k AS t ON gs.GasStationID = t.GasStationID GROUP BY gs.GasStationID ORDER BY SUM(t.Amount * t.Price) DESC, gs.GasStationID NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/