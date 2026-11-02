-- Schema DDL
CREATE TABLE "parts" ("pnum" INTEGER, "qoh" INTEGER);

CREATE TABLE "supply" ("pnum" INTEGER, "shipdate" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, boundary condition on shipdate (< 10 vs <= 10), and distinct vs non-distinct pnum in supply (kills GROUP BY Y.PNUM mutants).
INSERT INTO parts (pnum, qoh) VALUES (1, 1);
INSERT INTO parts (pnum, qoh) VALUES (2, 1);
INSERT INTO parts (pnum, qoh) VALUES (3, 2);
INSERT INTO supply (pnum, shipdate) VALUES (1, 9);
INSERT INTO supply (pnum, shipdate) VALUES (2, 5);
INSERT INTO supply (pnum, shipdate) VALUES (3, 10);
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
(1,)
(2,)
*/