-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gasstations --
INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483648, -55602865, 'Slovakia', 'swwqcgsk');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483647, 1610062532, 'Slovakia', 'pgu7vfe4');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483646, 1160656988, 'gas_20f34c', 'ia2yp');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483645, -1670923962, 'Slovakia', 'rwbbp6luhvd');

INSERT INTO "gasstations" ("gasstationid", "chainid", "country", "segment") VALUES (-2147483644, -1377057208, 'Slovakia', 'ilbnp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(Segment = 'Premium', 1, 0)) AS REAL) * 100 / COUNT(GasStationID) FROM gasstations WHERE Country = 'SVK';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CASE WHEN COUNT(*) = 0 THEN 0 ELSE CAST(SUM(IIF(segment = 'Premium', 1, 0)) AS REAL) * 100 / COUNT(*) END AS premium_percentage FROM gasstations WHERE country = 'Slovakia';

/*
Prediction Result:
(0.0,)
*/