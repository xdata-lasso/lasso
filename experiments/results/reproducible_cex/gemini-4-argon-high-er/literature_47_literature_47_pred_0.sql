-- Schema DDL
CREATE TABLE "months" ("mid" INTEGER, "month" INTEGER);

CREATE TABLE "weekdays" ("did" INTEGER, "day_of_week" INTEGER);

CREATE TABLE "carriers" ("cid" INTEGER, "name" INTEGER);

CREATE TABLE "flights" ("fid" INTEGER, "year" INTEGER, "month_id" INTEGER, "day_of_month" INTEGER, "carrier_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO months (mid, month) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO carriers (cid, name) VALUES (1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (1, 1, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (2, 2, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (3, 3, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (4, 4, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (5, 5, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (6, 6, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (7, 7, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (8, 8, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (9, 9, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (10, 10, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (11, 11, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (12, 12, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (13, 13, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (14, 14, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (15, 15, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (16, 16, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (17, 17, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (18, 18, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (19, 19, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (20, 20, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (21, 21, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (22, 22, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (23, 23, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (24, 24, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (25, 25, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (26, 26, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (27, 27, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (28, 28, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (29, 29, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (30, 30, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (31, 31, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (32, 32, 1, 1, 1);
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