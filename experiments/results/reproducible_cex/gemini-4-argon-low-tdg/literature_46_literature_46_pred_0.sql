-- Schema DDL
CREATE TABLE "months" ("mid" INTEGER, "month" INTEGER);

CREATE TABLE "weekdays" ("did" INTEGER, "day_of_week" INTEGER);

CREATE TABLE "carriers" ("cid" INTEGER, "name" INTEGER);

CREATE TABLE "flights" ("fid" INTEGER, "year" INTEGER, "month_id" INTEGER, "day_of_month" INTEGER, "carrier_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO carriers (cid, name) VALUES (1, 500);
INSERT INTO carriers (cid, name) VALUES (2, 600);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id)
WITH RECURSIVE cnt(x) AS (
SELECT 1
UNION ALL
SELECT x + 1 FROM cnt WHERE x < 1000
)
SELECT x, 2022, 5, 10, 1 FROM cnt;
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (NULL, 2022, 5, 10, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (9999, 2022, 5, 11, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id)
WITH RECURSIVE cnt(x) AS (
SELECT 1001
UNION ALL
SELECT x + 1 FROM cnt WHERE x < 2001
)
SELECT x, 2022, 5, 10, 2 FROM cnt;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.NAME FROM CARRIERS AS C JOIN FLIGHTS AS F ON C.CID = F.CARRIER_ID GROUP BY C.NAME, F.YEAR, F.MONTH_ID, F.DAY_OF_MONTH HAVING COUNT(F.FID) > 1000;

/*
Gold Result:
(600,)
*/

-- Prediction Query
SELECT C.NAME FROM CARRIERS AS C JOIN FLIGHTS AS F ON C.CID = F.CARRIER_ID GROUP BY C.NAME, F.DAY_OF_MONTH HAVING COUNT(C.CID) > 1000;

/*
Prediction Result:
(500,)
(600,)
*/