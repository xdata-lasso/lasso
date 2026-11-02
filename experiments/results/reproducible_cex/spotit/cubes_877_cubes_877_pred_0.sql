-- Schema DDL
CREATE TABLE "STORM" (
    "STORM_ID" INT,
    "NAME" TEXT,
    "DATES_ACTIVE" TEXT,
    "MAX_SPEED" INT,
    "DAMAGE_MILLIONS_USD" FLOAT,
    "NUMBER_DEATHS" INT,
    PRIMARY KEY ("STORM_ID")
);
CREATE TABLE "REGION" (
    "REGION_ID" INT,
    "REGION_CODE" TEXT,
    "REGION_NAME" TEXT,
    PRIMARY KEY ("REGION_ID")
);
CREATE TABLE "AFFECTED_REGION" (
    "REGION_ID" INT,
    "STORM_ID" INT,
    "NUMBER_CITY_AFFECTED" FLOAT,
    PRIMARY KEY ("REGION_ID", "STORM_ID"),
    FOREIGN KEY ("STORM_ID") REFERENCES "STORM"("STORM_ID"),
    FOREIGN KEY ("REGION_ID") REFERENCES "REGION"("REGION_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STORM VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO STORM VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO REGION VALUES (2, 11, -2);
INSERT INTO REGION VALUES (1, 12, 13);
INSERT INTO AFFECTED_REGION VALUES (1, 0, 17);
INSERT INTO AFFECTED_REGION VALUES (2, 0, 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT region_name FROM (SELECT LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.storm_id AS storm_id FROM region AS LHS INNER JOIN (SELECT storm_id, COUNT(*) AS n FROM affected_region GROUP BY storm_id) AS RHS ON (LHS.region_id = RHS.n)) ORDER BY region_name;

/*
Gold Result:
('-2',)
*/

-- Prediction Query
SELECT T1.region_name FROM region AS T1 JOIN affected_region AS T2 ON T1.region_id = T2.region_id GROUP BY T1.region_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/