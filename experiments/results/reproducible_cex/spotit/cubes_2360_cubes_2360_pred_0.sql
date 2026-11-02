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
INSERT INTO COUNTY_PUBLIC_SAFETY VALUES (-1, 7, 0, 0, 0, 0, 8, 9, 10);
INSERT INTO COUNTY_PUBLIC_SAFETY VALUES (0, 11, 0, 0, 0, 0, 0, 12, 13);
INSERT INTO CITY VALUES (-1, 0, 18, 90, 19, 20, 21, 22, 23);
INSERT INTO CITY VALUES (0, 0, 24, 90, 25, 26, 27, 28, 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT crime_rate FROM (SELECT LHS.county_id AS county_id, LHS.name AS name, LHS.population AS population, LHS.police_officers AS police_officers, LHS.residents_per_officer AS residents_per_officer, LHS.case_burden AS case_burden, LHS.crime_rate AS crime_rate, LHS.police_force AS police_force, LHS.location AS LOCATION, RHS.city_id AS city_id, RHS.name AS name_other, RHS.white AS white, RHS.black AS black, RHS.amerindian AS amerindian, RHS.asian AS asian, RHS.multiracial AS multiracial, RHS.hispanic AS hispanic FROM county_public_safety AS LHS INNER JOIN (SELECT * FROM city WHERE (white >= 90.0)) AS RHS ON (LHS.county_id = RHS.county_id)) ORDER BY crime_rate;

/*
Gold Result:
(0.0,)
(0.0,)
*/

-- Prediction Query
SELECT T2.Crime_rate FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID = T2.County_ID WHERE T1.White > 90;

/*
Prediction Result:
*/