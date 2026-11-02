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
INSERT INTO STORM VALUES (0, 13, NULL, 0, 15, 1);
INSERT INTO STORM VALUES (1, 16, 17, 0, 18, 1);
INSERT INTO REGION VALUES (1, 119, -1);
INSERT INTO REGION VALUES (-1, 120, 121);
INSERT INTO AFFECTED_REGION VALUES (1, 1, 110);
INSERT INTO AFFECTED_REGION VALUES (-1, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region_name FROM (SELECT LHS.region_id AS region_id, LHS.storm_id AS storm_id, LHS.number_city_affected AS number_city_affected, RHS.storm_id AS storm_id_other, RHS.name AS name, RHS.dates_active AS dates_active, RHS.max_speed AS max_speed, RHS.damage_millions_usd AS damage_millions_usd, RHS.region_code AS region_code, RHS.region_name AS region_name FROM affected_region AS LHS INNER JOIN (SELECT storm_id, name, dates_active, max_speed, damage_millions_usd, number_deaths, region_code, region_name, number_deaths AS region_id FROM (SELECT LHS.storm_id AS storm_id, LHS.name AS name, LHS.dates_active AS dates_active, LHS.max_speed AS max_speed, LHS.damage_millions_usd AS damage_millions_usd, LHS.number_deaths AS number_deaths, RHS.region_code AS region_code, RHS.region_name AS region_name FROM storm AS LHS INNER JOIN region AS RHS ON (LHS.number_deaths = RHS.region_id))) AS RHS ON (LHS.storm_id = RHS.number_deaths AND LHS.region_id = RHS.region_id)) ORDER BY region_name;

/*
Gold Result:
('-1',)
('-1',)
*/

-- Prediction Query
SELECT T2.region_name FROM affected_region AS T1 JOIN region AS T2 ON T1.region_id = T2.region_id JOIN storm AS T3 ON T1.storm_id = T3.storm_id ORDER BY T3.Number_Deaths DESC, T1.region_id NULLS LAST, T1.storm_id NULLS LAST, T2.region_id NULLS LAST, T3.storm_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('121',)
*/