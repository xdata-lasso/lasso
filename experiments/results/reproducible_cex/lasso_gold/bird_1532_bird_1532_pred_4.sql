-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1693, 1725, 'Malaysia', 'mention');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1694, 1702.0, 'Barbados', 'drop');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1695, 1707.0, 'Russian Federation', 'author');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1696, 1712.0, 'Norfolk Island', 'western');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1721, 1697, 'Albania', 'artist');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1722, 1730.0, 'Dominica', 'difficult');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1723, 1735.0, 'Fiji', 'notice');
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (1724, 1740.0, 'Paraguay', 'cause');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1701, '1987-06-13', 'several', 1733, 1737, 1693, 2, 1741, 2802.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1702, '1983-02-10', 'trade', 1714.0, 1720.0, 1694, 2, 1730.0, 2782.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1703, '1983-02-11', 'give', 1723.0, 1731.0, 1695, 2, 1747.0, 2772.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1704, '1983-02-12', 'avoid', 1732.0, 1742.0, 1696, 2, 1764.0, 2762.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1729, '1983-02-09', 'almost', 1705, 1709, 1721, 2, 1713, 2802.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1730, '1987-06-14', 'worry', 1742.0, 1748.0, 1722, 2, 1758.0, 2692.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1731, '1987-06-15', 'us', 1751.0, 1759.0, 1723, 2, 1775.0, 2682.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1732, '1987-06-16', 'own', 1760.0, 1770.0, 1724, 2, 1792.0, 2672.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('Malaysia',)
*/

-- Prediction Query
SELECT DISTINCT gs.country FROM gasstations AS gs INNER JOIN transactions_1k AS t ON gs.gasstationid = t.gasstationid WHERE t.productid = 2 AND t.price = (SELECT MAX(price) FROM transactions_1k WHERE productid = 2);

/*
Prediction Result:
('Malaysia',)
('Albania',)
*/