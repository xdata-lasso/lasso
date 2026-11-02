-- Schema DDL
CREATE TABLE "i021" ("ID" INTEGER, "CHARGEID" INTEGER, "CHARGETYPE" TEXT, "SERVICEMONTH" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i021" ("id", "chargeid", "chargetype", "servicemonth") VALUES (1060, 1061, NULL, 'bar');
INSERT INTO "i021" ("id", "chargeid", "chargetype", "servicemonth") VALUES (1062, 1061, 'old', 'finally');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT chargeid, chargetype, maxservicemonth FROM (SELECT chargeid, chargetype, MAX(servicemonth) AS maxservicemonth FROM i021 GROUP BY chargeid, chargetype) ORDER BY chargeid, chargetype NULLS LAST, maxservicemonth NULLS LAST;

/*
Gold Result:
(1061, 'old', 'finally')
(1061, None, 'bar')
*/

-- Prediction Query
SELECT CHARGEID, CHARGETYPE, MAX(SERVICEMONTH) AS "MostRecentServiceMonth" FROM i021 GROUP BY CHARGEID, CHARGETYPE;

/*
Prediction Result:
(1061, None, 'bar')
(1061, 'old', 'finally')
*/