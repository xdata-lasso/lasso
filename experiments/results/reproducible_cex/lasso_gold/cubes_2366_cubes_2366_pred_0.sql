-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1149, 'Derek Anderson', 1150, 1151, 1152, 1153, 1154.5, 'step', '8723 Robinson Centers Apt. 500
Shawhaven, GA 07956');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1162, 'William Baker', 1163, 1164, 1165, 1166, 1167.5, 'call', 'USNS Riley
FPO AE 81684');
INSERT INTO "city" ("city_id", "county_id", "name", "white", "black", "amerindian", "asian", "multiracial", "hispanic") VALUES (1155, 1149, 'Dean Santiago', 1156.5, 1157.5, 1158.5, 1159.5, 1160.5, 1161.5);
INSERT INTO "city" ("city_id", "county_id", "name", "white", "black", "amerindian", "asian", "multiracial", "hispanic") VALUES (1168, 1162, 'Angela Lopez', 1157.5, 1158.5, 1159.5, 1160.5, 1161.5, 1162.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.city_id AS city_id, LHS.county_id AS county_id, LHS.name AS name, LHS.white AS white, LHS.black AS black, LHS.amerindian AS amerindian, LHS.asian AS asian, LHS.multiracial AS multiracial, LHS.hispanic AS hispanic, RHS.name AS name_other, RHS.population AS population, RHS.police_officers AS police_officers, RHS.residents_per_officer AS residents_per_officer, RHS.case_burden AS case_burden, RHS.crime_rate AS crime_rate, RHS.police_force AS police_force, RHS.location AS LOCATION FROM city AS LHS INNER JOIN county_public_safety AS RHS ON (LHS.county_id = RHS.county_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Angela Lopez', 'William Baker')
('Dean Santiago', 'Derek Anderson')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID = T2.County_ID;

/*
Prediction Result:
('Dean Santiago', 'Derek Anderson')
('Angela Lopez', 'William Baker')
*/