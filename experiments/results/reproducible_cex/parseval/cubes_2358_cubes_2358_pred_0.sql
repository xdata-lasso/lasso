-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: county_public_safety --
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (2, '5k5swwqcgs', 247012447, -1980249628, -734455130, 1744686505, 483.665643, 'cou_a82150', 'West');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (3, 'hria2ypuzhs', 700293388, 906324270, 1908028688, 2122220075, 749.826493, 'cou_a82150', 'West');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (4, 'luhvdltti', -1364429300, -1257178728, 1236688122, 2087640001, 666.330692, 'p', 'cou_7c964f');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (5, '5k5swwqcgs', 247012447, -1980249628, -734455130, 1744686505, 483.665643, 'hria2ypuzhs', 'East');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (6, '5k5swwqcgs', 247012447, -1980249628, -734455130, 1744686505, 483.665643, 'hria2ypuzhs', NULL);

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (7, 'rwbbp6luhvd', -1377057208, -841692980, -1364429300, -1257178728, 787.938887, 'dpos', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "police_force" FROM "county_public_safety" WHERE ("location" <> 'East' AND "location" = 'West') ORDER BY police_force, "police_force" NULLS LAST;

/*
Gold Result:
('cou_a82150',)
*/

-- Prediction Query
SELECT Police_force FROM county_public_safety WHERE LOCATION = 'East' INTERSECT SELECT Police_force FROM county_public_safety WHERE LOCATION = 'West';

/*
Prediction Result:
*/