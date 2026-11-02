-- Schema DDL
CREATE TABLE "ROLLER_COASTER" (
    "ROLLER_COASTER_ID" INT,
    "COUNTRY_ID" INT,
    "NAME" TEXT,
    "PARK" TEXT,
    "LENGTH" FLOAT,
    "HEIGHT" FLOAT,
    "SPEED" TEXT,
    "OPENED" TEXT,
    "STATUS" TEXT,
    PRIMARY KEY ("ROLLER_COASTER_ID"),
    FOREIGN KEY ("COUNTRY_ID") REFERENCES "COUNTRY"("COUNTRY_ID")
);
CREATE TABLE "COUNTRY" (
    "COUNTRY_ID" INT,
    "NAME" TEXT,
    "POPULATION" INT,
    "AREA" INT,
    "LANGUAGES" TEXT,
    PRIMARY KEY ("COUNTRY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ROLLER_COASTER VALUES (0, 0, 30, 26, 3000, 31, 32, 33, 27);
INSERT INTO ROLLER_COASTER VALUES (-1, 1, 10, 14, 0, 11, 12, 13, 15);
INSERT INTO COUNTRY VALUES (1, 16, 0, 0, 17);
INSERT INTO COUNTRY VALUES (0, 18, 0, 0, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count___ FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.park AS park, RHS.status AS status, RHS.n_distinct AS n_distinct FROM country AS LHS CROSS JOIN (SELECT park, status, COUNT(DISTINCT country_id) AS n_distinct FROM roller_coaster GROUP BY park, status) AS RHS) WHERE (n_distinct >= 3000 OR n_distinct <> country_id) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM country WHERE NOT country_id IN (SELECT country_id FROM roller_coaster WHERE LENGTH > 3000);

/*
Prediction Result:
(2,)
*/