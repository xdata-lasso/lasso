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
INSERT INTO COUNTY_PUBLIC_SAFETY VALUES (100, 0, 0, 0, 0, 0, 100, 12, 13);
INSERT INTO COUNTY_PUBLIC_SAFETY VALUES (101, 21, 0, 0, 0, 0, 100, 22, 23);
INSERT INTO CITY VALUES (0, 100, 14, 15, 16, 17, 18, 19, 20);
INSERT INTO CITY VALUES (1, 101, 24, 25, 26, 27, 28, 29, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name FROM (SELECT * FROM (SELECT LHS.county_id AS county_id, LHS.name AS name, LHS.population AS population, LHS.police_officers AS police_officers, LHS.residents_per_officer AS residents_per_officer, LHS.case_burden AS case_burden, LHS.crime_rate AS crime_rate, LHS.police_force AS police_force, LHS.location AS LOCATION, RHS.city_id AS city_id, RHS.county_id AS county_id_other, RHS.name AS name_other, RHS.white AS white, RHS.black AS black, RHS.amerindian AS amerindian, RHS.asian AS asian, RHS.multiracial AS multiracial, RHS.hispanic AS hispanic FROM county_public_safety AS LHS CROSS JOIN city AS RHS) WHERE (county_id = county_id_other)) WHERE (county_id = 100 OR crime_rate < 100.0) ORDER BY name;

/*
Gold Result:
('14',)
*/

-- Prediction Query
SELECT name FROM city WHERE county_id IN (SELECT county_id FROM county_public_safety WHERE Crime_rate < 100);

/*
Prediction Result:
*/