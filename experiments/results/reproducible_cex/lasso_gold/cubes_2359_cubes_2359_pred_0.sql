-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (0, 'Cindy Anderson', 1063, 1064, 1065, 1066, 1067.5, 'worry', '76311 Gomez Loop Suite 010
Chandlerville, IA 25613');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (150, 'Cindy Anderson', 1069, 1070, 1071, 1072, 1073.5, 'family', '8108 Tanya Terrace
East Richard, NJ 28517');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (20, 'Lauren Daniels', 1075, 1076, 1077, 1078, 1079.5, 'able', 'Unit 4746 Box 8723
DPO AA 29035');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM county_public_safety ORDER BY name, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
('Cindy Anderson',)
('Cindy Anderson',)
('Lauren Daniels',)
*/

-- Prediction Query
SELECT Name FROM county_public_safety ORDER BY Population DESC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
('Lauren Daniels',)
('Cindy Anderson',)
('Cindy Anderson',)
*/