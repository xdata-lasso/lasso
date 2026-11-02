-- Schema DDL
CREATE TABLE "COUNTY_PUBLIC_SAFETY" (
    "COUNTY_ID" INT,
    "NAME" TEXT,
    "POPULATION" INT,
    "POLICE_OFFICERS" INT,
    "RESIDENTS_PER_OFFICER" INT,
    "CASE_BURDEN" INT,
    "CRIME_RATE" FLOAT,
    "POLICE_FORCE" TEXT,
    "LOCATION" TEXT,
    PRIMARY KEY ("COUNTY_ID")
);
CREATE TABLE "CITY" (
    "CITY_ID" INT,
    "COUNTY_ID" INT,
    "NAME" TEXT,
    "WHITE" FLOAT,
    "BLACK" FLOAT,
    "AMERINDIAN" FLOAT,
    "ASIAN" FLOAT,
    "MULTIRACIAL" FLOAT,
    "HISPANIC" FLOAT,
    PRIMARY KEY ("CITY_ID"),
    FOREIGN KEY ("COUNTY_ID") REFERENCES "COUNTY_PUBLIC_SAFETY"("COUNTY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COUNTY_PUBLIC_SAFETY VALUES (2, 12, 0, 0, 0, 0, 13, 14, 1);
INSERT INTO COUNTY_PUBLIC_SAFETY VALUES (1, NULL, NULL, 0, 0, 0, 8, NULL, 0);
INSERT INTO CITY VALUES (1, 2, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO CITY VALUES (0, 2, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.county_id AS county_id, LHS.name AS name, LHS.population AS population, LHS.police_officers AS police_officers, LHS.residents_per_officer AS residents_per_officer, LHS.case_burden AS case_burden, LHS.crime_rate AS crime_rate, LHS.police_force AS police_force, LHS.location AS LOCATION FROM county_public_safety AS LHS INNER JOIN (SELECT police_officers, COUNT(*) AS n FROM county_public_safety GROUP BY police_officers) AS RHS ON (LHS.county_id = RHS.n AND LHS.police_officers = RHS.police_officers)) ORDER BY LOCATION;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT LOCATION FROM county_public_safety GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/