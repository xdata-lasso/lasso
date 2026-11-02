-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (667467, 'KAM', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (1, 10, 'FRA', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (2, 10, 'ITA', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (3, 20, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (4, 10, 'ESP', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (5, 3, 'NLD', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (6, 40, 'SVK', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (7, 50, 'GER', 'Discount');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (8, 60, 'POL', 'Premium');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (667467, 667467, 'HUN', 'Other');
INSERT INTO products (ProductID, Description) VALUES (4, 'Diesel');
INSERT INTO products (ProductID, Description) VALUES (667467, 'Natural');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-24', '09:30:00', 2, 667467, 3, 4, 10, 300.5);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-24', '10:00:00', 2, 667466, 6, 4, 15, 450.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-24', '11:00:00', 2, 667468, 7, 4, 20, 600.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-24', '12:00:00', 2, NULL, 8, 4, 25, 750.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2012-08-24', '13:00:00', 667467, 111111, 667467, 667467, 30, 900.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (667467, '2012-08-24', '14:00:00', 2, 222222, 1, 4, 35, 1050.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.CardID = '667467';

/*
Gold Result:
('CZE',)
*/

-- Prediction Query
SELECT customers.Currency FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.CardID = 667467;

/*
Prediction Result:
('EUR',)
*/