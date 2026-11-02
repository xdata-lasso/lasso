-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-25', NULL, NULL, 0, 1, 0, NULL, NULL), (1, NULL, 'Nafta', NULL, 1, 0, 0, 0, NULL), (2, '2023-01-01', 'default1', NULL, NULL, 1, 1, NULL, NULL), (3, '2023-01-01', 'Nafta', 1, 0, NULL, NULL, 0, 547.4), (4, '2023-01-01', NULL, NULL, 0, 0, 0, 0, 1.0), (5, '2023-01-02', NULL, 1, 1, 1, 1, NULL, 549.4), (6, '2012-08-24', NULL, 0, 0, 1, 0, 1, 1.0), (7, NULL, '2012-08-24', 0, 0, NULL, NULL, 1, 549.4), (8, '2023-01-02', NULL, 0, 0, 1, NULL, 0, 1.0), (9, '2012-08-23', 'default1', NULL, 0, 1, 0, 1, 547.4), (10, '2023-01-01', 'default2', 1, 1, 1, NULL, 0, NULL), (11, NULL, 'Nafta', 0, 1, 1, NULL, NULL, NULL), (12, '2023-01-02', '2012-08-24', NULL, 0, 1, NULL, 0, 549.4), (13, '2023-01-02', NULL, 1, NULL, NULL, 1, 1, NULL), (14, '2012-08-25', 'default2', NULL, 1, 1, NULL, 0, 547.4), (15, '2012-08-23', 'default1', 1, NULL, 0, 0, 1, 549.4), (16, '2023-01-01', 'default2', NULL, 1, NULL, NULL, 0, 548.4), (17, '2023-01-01', '2012-08-24', 0, NULL, 0, NULL, 1, 549.4), (18, '2012-08-24', 'Nafta', 1, NULL, NULL, 0, 1, 549.4), (19, '2023-01-01', 'Nafta', 1, 0, 0, 1, NULL, 547.4), (20, '2023-01-02', 'default1', 0, NULL, 1, 0, NULL, 548.4), (21, '2023-01-01', NULL, 1, 1, NULL, NULL, 1, 0.0), (22, '2012-08-24', 'default2', 0, 1, 1, 1, 0, 547.4), (23, NULL, NULL, 1, 1, NULL, NULL, 1, 547.4), (24, '2012-08-24', NULL, NULL, 0, 0, 1, 1, 548.4), (25, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1.0), (26, '2023-01-02', '2012-08-24', 0, 0, 1, NULL, 0, NULL), (27, '2012-08-25', 'default2', 1, 0, 1, 1, 0, 549.4), (28, '2012-08-24', 'default1', 0, 0, 1, 1, 1, 548.4), (29, NULL, 'default1', 1, 1, 0, 1, 0, NULL), (30, '2012-08-24', NULL, 0, 0, 1, 0, 0, 548.4), (31, '2023-01-01', 'default1', NULL, NULL, NULL, 0, 0, 548.4), (32, '2012-08-24', 'Nafta', 1, 1, 1, 1, 1, 548.4);
INSERT INTO products (productid, description) VALUES (0, 'default1'), (1, '2012-08-24'), (2, NULL), (3, 'default2'), (4, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 0, '2012-08-24', '2012-08-24'), (1, NULL, 'Nafta', 'Nafta'), (2, 0, 'default1', 'default1'), (3, 0, 'default2', 'default2'), (4, NULL, '2012-08-24', 'default2'), (5, NULL, 'Nafta', '2012-08-24'), (6, 1, '2012-08-24', 'default1'), (7, 0, NULL, 'default2'), (8, 1, NULL, 'default1'), (9, 0, NULL, NULL), (10, 0, '2012-08-24', '2012-08-24'), (11, 0, '2012-08-24', NULL), (12, NULL, 'default1', NULL), (13, 0, '2012-08-24', 'default2'), (14, 1, '2012-08-24', 'Nafta'), (15, NULL, 'default1', 'default2'), (16, 1, 'Nafta', 'default1'), (17, 0, 'Nafta', 'Nafta'), (18, 1, 'default2', '2012-08-24'), (19, NULL, 'default1', '2012-08-24'), (20, NULL, NULL, NULL), (21, 1, 'default2', NULL), (22, 1, NULL, 'default2'), (23, NULL, 'default2', 'default1'), (24, 1, NULL, '2012-08-24'), (25, NULL, NULL, NULL), (26, NULL, 'default1', 'default2'), (27, 0, NULL, '2012-08-24'), (28, 1, NULL, 'default2'), (29, 0, 'default2', 'default1'), (30, NULL, 'default2', 'default2'), (31, 0, '2012-08-24', 'Nafta');
INSERT INTO customers (customerid, segment, currency) VALUES (1, 'default1', 'default1'), (0, '2012-08-24', '2012-08-24'), (2, NULL, 'Nafta'), (3, '2012-08-24', 'Nafta'), (4, 'default2', 'default2'), (5, 'default2', 'default2'), (6, 'Nafta', 'default2'), (7, 'default1', 'Nafta'), (8, '2012-08-24', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Price = 548.4;

/*
Gold Result:
('2012-08-24',)
('Nafta',)
('Nafta',)
('Nafta',)
*/

-- Prediction Query
SELECT customers.Currency FROM transactions_1k INNER JOIN products ON transactions_1k.ProductID = products.ProductID INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.Date = '2012-08-24' AND products.Description = 'Nafta' AND transactions_1k.Price = 548.4;

/*
Prediction Result:
*/