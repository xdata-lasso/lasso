-- Schema DDL
CREATE TABLE "months" ("mid" INTEGER, "month" INTEGER);

CREATE TABLE "weekdays" ("did" INTEGER, "day_of_week" INTEGER);

CREATE TABLE "carriers" ("cid" INTEGER, "name" INTEGER);

CREATE TABLE "flights" ("fid" INTEGER, "year" INTEGER, "month_id" INTEGER, "day_of_month" INTEGER, "carrier_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
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
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (1, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (2, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (3, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (4, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (5, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (6, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (7, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (8, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (9, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (10, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (11, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (12, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (13, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (14, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (15, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (16, 2000, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (17, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (18, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (19, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (20, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (21, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (22, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (23, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (24, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (25, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (26, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (27, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (28, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (29, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (30, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (31, 2001, 1, 1, 1);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) VALUES (32, 2001, 1, 1, 1);
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
(1,)
*/