-- Schema DDL
CREATE TABLE "months" ("mid" INTEGER, "month" INTEGER);

CREATE TABLE "weekdays" ("did" INTEGER, "day_of_week" INTEGER);

CREATE TABLE "carriers" ("cid" INTEGER, "name" INTEGER);

CREATE TABLE "flights" ("fid" INTEGER, "year" INTEGER, "month_id" INTEGER, "day_of_month" INTEGER, "carrier_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO carriers (cid, name) VALUES (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1), (1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1), (1, 2020, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1), (1, 2020, 2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.NAME FROM CARRIERS AS C JOIN FLIGHTS AS F ON C.CID = F.CARRIER_ID GROUP BY C.CID, C.NAME, F.YEAR, F.MONTH_ID, F.DAY_OF_MONTH HAVING COUNT(F.FID) > 1000;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.NAME FROM CARRIERS AS C JOIN FLIGHTS AS F ON C.CID = F.CARRIER_ID GROUP BY C.NAME, F.DAY_OF_MONTH HAVING COUNT(F.FID) > 1000;

/*
Prediction Result:
(1,)
*/