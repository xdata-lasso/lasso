-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (1, 'KAM', '5k5swwqcgs');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (-2147483647, 'KAM', 'c4pgu7vfe');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (2, 'KAM', 'ri');

INSERT INTO "customers" ("customerid", "segment", "currency") VALUES (3, 'a2ypuzhsrwbb', 'p6luhvdlttil');

-- Inserting into table: yearmonth --
INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_1', 171.746906);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_2', 557.512061);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_3', 868.436572);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_4', 483.665643);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_5', 818.685402);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_6', 804.971537);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_7', 0.5);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_8', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_9', 22.535764);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_10', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_11', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_12', 600.048938);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_13', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_14', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_15', 240.969194);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_16', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_17', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_18', 267.815776);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_19', 0.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_20', -1.0);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (3, 'date_21', 192.379301);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_22', 607.794538);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_23', 792.223623);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_24', 938.037625);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_25', 921.185044);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_26', 235.059956);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_27', 619.836822);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_28', 286.037632);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_29', 126.856521);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_30', 489.397796);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_31', 933.422701);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_32', 345.718563);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_33', 510.466242);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_34', 768.216462);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_35', 83.204633);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_36', 5.585347);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_37', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_38', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_39', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_40', 871.191565);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_41', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_42', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_43', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_44', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_45', NULL);

INSERT INTO "yearmonth" ("customerid", "date", "consumption") VALUES (1, 'date_46', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CustomerID, SUM(T2.Consumption) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' GROUP BY T2.CustomerID ORDER BY SUM(T2.Consumption) DESC, T2.CustomerID NULLS LAST LIMIT 1;

/*
Gold Result:
(1, 12239.253190999998)
*/

-- Prediction Query
SELECT T1.CustomerID, T2.Consumption FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'KAM' ORDER BY T2.Consumption DESC, T1.customerid NULLS LAST, T2.date NULLS LAST, T2.customerid NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 938.037625)
*/