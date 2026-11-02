-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2031, 2035, 'Mongolia', 'every');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2033, 2040.0, 'Mali', 'democratic');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2034, 2045.0, 'Germany', 'relationship');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2059, 2050.0, 'Vietnam', 'sense');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2032, 2063, 'Oman', 'society');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2060, 2068.0, 'French Southern Territories', 'would');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2061, 2073.0, 'Kuwait', 'baby');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (2062, 2078.0, 'Vanuatu', 'act');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2040, '1973-06-11', 'edge', 2043, 2047, 2031, 2, 2051, 2140.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2041, '1973-06-12', 'individual', 2052.0, 2058.0, 2032, 2, 2068.0, 2074.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2042, '1973-06-13', 'catch', 2061.0, 2069.0, 2033, 2, 2085.0, 2093.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2067, '1973-06-14', 'remain', 2070.0, 2080.0, 2034, 2, 2102.0, 2112.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2039, '1977-10-15', 'low', 2044, 2048, 2032, 2, 2052, 2140.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2068, '1977-10-16', 'pretty', 2080.0, 2086.0, 2060, 2, 2096.0, 2102.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2069, '1977-10-17', 'order', 2089.0, 2097.0, 2061, 2, 2113.0, 2121.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (2070, '1977-10-18', 'black', 2098.0, 2108.0, 2062, 2, 2130.0, 2055.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('Oman',)
*/

-- Prediction Query
SELECT T1.Country FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.ProductID = 2 ORDER BY T2.Price DESC, T1.gasstationid NULLS LAST, T2.transactionid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Mongolia',)
*/