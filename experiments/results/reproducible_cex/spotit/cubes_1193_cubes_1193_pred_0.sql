-- Schema DDL
CREATE TABLE "CAPTAIN" (
    "CAPTAIN_ID" INT,
    "SHIP_ID" INT,
    "NAME" TEXT,
    "AGE" TEXT,
    "CLASS" TEXT,
    "RANK" TEXT,
    PRIMARY KEY ("CAPTAIN_ID"),
    FOREIGN KEY ("SHIP_ID") REFERENCES "SHIP"("SHIP_ID")
);
CREATE TABLE "SHIP" (
    "SHIP_ID" INT,
    "NAME" TEXT,
    "TYPE" TEXT,
    "BUILT_YEAR" FLOAT,
    "CLASS" TEXT,
    "FLAG" TEXT,
    PRIMARY KEY ("SHIP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CAPTAIN VALUES (1, 2, 0, 0, 0, 0);
INSERT INTO CAPTAIN VALUES (0, 3, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (2, 11, 12, 13, 14, 0);
INSERT INTO SHIP VALUES (3, NULL, NULL, 13, 14, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT flag FROM (SELECT LHS.ship_id AS ship_id, LHS.name AS name, LHS.type AS TYPE, LHS.built_year AS built_year, LHS.class AS CLASS, LHS.flag AS flag, RHS.built_year AS built_year_other FROM ship AS LHS INNER JOIN (SELECT built_year, CLASS, COUNT(*) AS n FROM ship GROUP BY built_year, CLASS) AS RHS ON (LHS.ship_id = RHS.n AND LHS.class = RHS.class)) ORDER BY flag;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT flag FROM ship GROUP BY flag ORDER BY COUNT(*) DESC, flag NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/