-- Schema DDL
CREATE TABLE "parts" ("pnum" INTEGER, "qoh" INTEGER);

CREATE TABLE "supply" ("pnum" INTEGER, "shipdate" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "parts" ("pnum", "qoh") VALUES (26, 27);
INSERT INTO "parts" ("pnum", "qoh") VALUES (22, 2);
INSERT INTO "supply" ("pnum", "shipdate") VALUES (22, -715);
INSERT INTO "supply" ("pnum", "shipdate") VALUES (NULL, -550);
INSERT INTO "supply" ("pnum", "shipdate") VALUES (22, -388);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.PNUM AS XP FROM PARTS AS X WHERE (X.PNUM, X.QOH) IN (SELECT Y.PNUM, COUNT(Y.SHIPDATE) AS CNT FROM SUPPLY AS Y WHERE Y.SHIPDATE < 10);

/*
Gold Result:
*/

-- Prediction Query
SELECT X.PNUM AS XP FROM PARTS AS X CROSS JOIN (SELECT Y.PNUM AS SUPPNUM, COUNT(Y.SHIPDATE) AS CT FROM SUPPLY AS Y WHERE Y.SHIPDATE < 10 GROUP BY Y.PNUM) AS TEMP WHERE X.QOH = TEMP.CT AND X.PNUM = TEMP.SUPPNUM;

/*
Prediction Result:
(22,)
*/