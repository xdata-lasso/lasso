-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (0, 'Rachel Mitchell', 1075, 1076, 1077, 1078, 1079.5, 'same', 'USCGC Moore
FPO AA 29035');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (150, 'Lauren Daniels', 1081, 1082, 1083, 1078, 1085.5, 'small', '788 Brian Pass
Port Jacobland, TX 31329');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (20, 'Todd Hudson', 1087, 1088, 1089, 1079, 1091.5, 'particular', '9985 Harris Stravenue
Johnfurt, DC 88540');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT case_burden FROM county_public_safety ORDER BY case_burden, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
(1078,)
(1078,)
(1079,)
*/

-- Prediction Query
SELECT Case_burden FROM county_public_safety ORDER BY Population DESC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
(1079,)
(1078,)
(1078,)
*/