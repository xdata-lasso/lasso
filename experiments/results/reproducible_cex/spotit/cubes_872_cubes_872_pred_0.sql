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
INSERT INTO STORM VALUES (-1, 18, 19, 0, 17, 10);
INSERT INTO STORM VALUES (0, 20, 21, 0, 22, 11);
INSERT INTO REGION VALUES (-1, 49, 4);
INSERT INTO REGION VALUES (0, 51, 6);
INSERT INTO AFFECTED_REGION VALUES (0, -1, 48);
INSERT INTO AFFECTED_REGION VALUES (-1, 0, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, LHS.region_id AS region_id, LHS.region_code AS region_code, LHS.region_name AS region_name, RHS.number_city_affected AS number_city_affected FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, RHS.region_id AS region_id, RHS.region_code AS region_code, RHS.region_name AS region_name FROM storm AS LHS CROSS JOIN region AS RHS) AS LHS INNER JOIN affected_region AS RHS ON (LHS.storm_id = RHS.storm_id AND LHS.region_id = RHS.region_id)) WHERE (number_deaths > 10) ORDER BY region_name;

/*
Gold Result:
('4',)
*/

-- Prediction Query
SELECT T2.region_name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id JOIN storm AS T3 ON T1.storm_id = T3.storm_id WHERE T3.number_deaths >= 10;

/*
Prediction Result:
('4',)
('6',)
*/