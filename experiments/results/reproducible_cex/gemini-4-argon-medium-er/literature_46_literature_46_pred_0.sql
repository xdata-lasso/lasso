-- Schema DDL
CREATE TABLE "months" ("mid" INTEGER, "month" INTEGER);

CREATE TABLE "weekdays" ("did" INTEGER, "day_of_week" INTEGER);

CREATE TABLE "carriers" ("cid" INTEGER, "name" INTEGER);

CREATE TABLE "flights" ("fid" INTEGER, "year" INTEGER, "month_id" INTEGER, "day_of_month" INTEGER, "carrier_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO carriers (cid, name) VALUES
(1, 100), (2, 100), (3, 100), (4, 100), (5, 100),
(6, 100), (7, 100), (8, 100), (9, 100), (10, 100),
(11, 100), (12, 100), (13, 100), (14, 100), (15, 100),
(16, 100), (17, 100), (18, 100), (19, 100), (20, 100),
(21, 100), (22, 100), (23, 100), (24, 100), (25, 100),
(26, 100), (27, 100), (28, 100), (29, 100), (30, 100),
(31, 100), (32, 100);
INSERT INTO carriers (cid, name) SELECT cid + 32, name FROM carriers;
INSERT INTO carriers (cid, name) SELECT cid + 64, name FROM carriers;
INSERT INTO carriers (cid, name) SELECT cid + 128, name FROM carriers;
INSERT INTO carriers (cid, name) SELECT cid + 256, name FROM carriers;
INSERT INTO carriers (cid, name) SELECT cid + 512, name FROM carriers;
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id)
SELECT NULL, 2020, 1, 1, cid FROM carriers;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.NAME FROM CARRIERS AS C JOIN FLIGHTS AS F ON C.CID = F.CARRIER_ID GROUP BY C.NAME, F.YEAR, F.MONTH_ID, F.DAY_OF_MONTH HAVING COUNT(F.FID) > 1000;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.NAME FROM CARRIERS AS C JOIN FLIGHTS AS F ON C.CID = F.CARRIER_ID GROUP BY C.NAME, F.DAY_OF_MONTH HAVING COUNT(C.CID) > 1000;

/*
Prediction Result:
(100,)
*/