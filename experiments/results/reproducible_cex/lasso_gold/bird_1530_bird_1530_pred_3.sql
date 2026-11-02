-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "products" ("productid", "description") VALUES (1001, 'Agent every development say.');
INSERT INTO "products" ("productid", "description") VALUES (1002, 'Beautiful instead ahead despite measure ago current.');
INSERT INTO "products" ("productid", "description") VALUES (1003, 'Information last everything thank serve civil institution.');
INSERT INTO "products" ("productid", "description") VALUES (1004, 'Choice whatever from behavior benefit.');
INSERT INTO "products" ("productid", "description") VALUES (1005, 'Page southern role movie win her.');
INSERT INTO "products" ("productid", "description") VALUES (1006, 'Fall pick those gun court attorney product.');
INSERT INTO "products" ("productid", "description") VALUES (1007, 'World talk term herself law.');
INSERT INTO "products" ("productid", "description") VALUES (1008, 'Class great prove reduce raise author.');
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1009, '1970-01-01', 'prove', 1017, 1025, 1033, 1001, 1041, 1049.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1010, '1970-01-02', 'Congress', 1026.0, 1036.0, 1046.0, 1002, 1058.0, 1068.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1011, '1970-01-03', 'none', 1035.0, 1047.0, 1059.0, 1003, 1075.0, 1087.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1012, '1970-01-04', 'shoulder', 1044.0, 1058.0, 1072.0, 1004, 1092.0, 1106.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1013, '1970-01-05', 'election', 1053.0, 1069.0, 1085.0, 1005, 1109.0, 1125.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1014, '1970-01-06', 'common', 1062.0, 1080.0, 1098.0, 1006, 1126.0, 1144.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1015, '1970-01-07', 'maintain', 1071.0, 1091.0, 1111.0, 1007, 1143.0, 1163.5);
INSERT INTO "transactions_1k" ("transactionid", "date", "time", "customerid", "cardid", "gasstationid", "productid", "amount", "price") VALUES (1016, '1970-01-08', 'hundred', 1080.0, 1102.0, 1124.0, 1008, 1160.0, 1182.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('Class great prove reduce raise author.',)
('World talk term herself law.',)
('Fall pick those gun court attorney product.',)
('Page southern role movie win her.',)
('Choice whatever from behavior benefit.',)
*/

-- Prediction Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID GROUP BY T2.Description ORDER BY COUNT(T2.Description) DESC, T2.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('Agent every development say.',)
('Beautiful instead ahead despite measure ago current.',)
('Choice whatever from behavior benefit.',)
('Class great prove reduce raise author.',)
('Fall pick those gun court attorney product.',)
*/