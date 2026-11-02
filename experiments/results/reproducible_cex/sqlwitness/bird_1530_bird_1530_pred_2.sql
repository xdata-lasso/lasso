-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (6, NULL, NULL, 1, 6, 6, 1, 6, NULL), (1, NULL, NULL, 4, 0, 4, 6, 4, 5.0), (5, NULL, 'default1', 6, 6, 0, 4, 5, NULL), (0, '2023-01-01', 'default2', 0, 6, 6, NULL, 6, 4.0), (4, '2023-01-02', 'default2', 0, 4, 1, 1, 6, 6.0), (2, '2023-01-01', 'default2', 5, NULL, 6, 4, 4, NULL);
INSERT INTO products (productid, description) VALUES (0, 'default1'), (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT "products"."description" FROM "products" INNER JOIN "transactions_1k" ON "products"."productid" = "transactions_1k"."productid" GROUP BY "products"."description" ORDER BY SUM("transactions_1k"."amount") DESC, "products"."description" NULLS LAST LIMIT 5;

/*
Prediction Result:
(None,)
*/