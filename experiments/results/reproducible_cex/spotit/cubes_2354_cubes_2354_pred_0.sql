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
INSERT INTO COUNTY_PUBLIC_SAFETY VALUES (1, 9, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO COUNTY_PUBLIC_SAFETY VALUES (0, 8, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO CITY VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO CITY VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM county_public_safety ORDER BY police_force DESC, county_public_safety.county_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('8',)
*/

-- Prediction Query
SELECT Name FROM county_public_safety ORDER BY Population DESC, county_public_safety.county_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('8',)
*/