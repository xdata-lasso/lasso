-- Schema DDL
CREATE TABLE "i021" ("ID" INTEGER, "CHARGEID" INTEGER, "CHARGETYPE" TEXT, "SERVICEMONTH" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i021" ("ID", "CHARGEID", "CHARGETYPE", "SERVICEMONTH") VALUES (1, 1, 'A', '2023-01');
INSERT INTO "i021" ("ID", "CHARGEID", "CHARGETYPE", "SERVICEMONTH") VALUES (2, 1, NULL, '2023-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT chargeid, chargetype, maxservicemonth FROM (SELECT chargeid, chargetype, MAX(servicemonth) AS maxservicemonth FROM i021 GROUP BY chargeid, chargetype) ORDER BY chargeid, chargetype NULLS LAST, maxservicemonth NULLS LAST;

/*
Gold Result:
(1, 'A', '2023-01')
(1, None, '2023-01')
*/

-- Prediction Query
SELECT CHARGEID, CHARGETYPE, MAX(SERVICEMONTH) AS "MostRecentServiceMonth" FROM i021 GROUP BY CHARGEID, CHARGETYPE;

/*
Prediction Result:
(1, None, '2023-01')
(1, 'A', '2023-01')
*/