-- Schema DDL
CREATE TABLE "months" ("mid" INTEGER, "month" INTEGER);

CREATE TABLE "weekdays" ("did" INTEGER, "day_of_week" INTEGER);

CREATE TABLE "carriers" ("cid" INTEGER, "name" INTEGER);

CREATE TABLE "flights" ("fid" INTEGER, "year" INTEGER, "month_id" INTEGER, "day_of_month" INTEGER, "carrier_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO carriers (cid, name) VALUES (1, 100);
INSERT INTO carriers (cid, name) VALUES (2, 100);
INSERT INTO carriers (cid, name) VALUES (3, 100);
INSERT INTO carriers (cid, name) VALUES (4, 100);
INSERT INTO carriers (cid, name) VALUES (5, 100);
INSERT INTO carriers (cid, name) VALUES (6, 100);
INSERT INTO carriers (cid, name) VALUES (7, 100);
INSERT INTO carriers (cid, name) VALUES (8, 100);
INSERT INTO carriers (cid, name) VALUES (9, 100);
INSERT INTO carriers (cid, name) VALUES (10, 100);
INSERT INTO carriers (cid, name) VALUES (11, 100);
INSERT INTO carriers (cid, name) VALUES (12, 100);
INSERT INTO carriers (cid, name) VALUES (13, 100);
INSERT INTO carriers (cid, name) VALUES (14, 100);
INSERT INTO carriers (cid, name) VALUES (15, 100);
INSERT INTO carriers (cid, name) VALUES (16, 100);
INSERT INTO carriers (cid, name) VALUES (17, 100);
INSERT INTO carriers (cid, name) VALUES (18, 100);
INSERT INTO carriers (cid, name) VALUES (19, 100);
INSERT INTO carriers (cid, name) VALUES (20, 100);
INSERT INTO flights (fid, year, month_id, day_of_month, carrier_id) SELECT NULL, 2020, 1, 1, 1 FROM carriers AS c1, carriers AS c2, carriers AS c3;
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