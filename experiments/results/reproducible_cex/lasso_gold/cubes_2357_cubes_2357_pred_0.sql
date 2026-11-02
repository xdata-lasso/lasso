-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (100, 'Brenda Snyder PhD', 99, 1054, 1055, 1056, 1053, 'traditional', '691 James Mountain
Tashatown, TX 94967');
INSERT INTO "city" ("city_id", "county_id", "name", "white", "black", "amerindian", "asian", "multiracial", "hispanic") VALUES (1057, 100, 'Stephen Potter', 1058.5, 1059.5, 1060.5, 1061.5, 1062.5, 1063.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name FROM (SELECT * FROM (SELECT LHS.county_id AS county_id, LHS.name AS name, LHS.population AS population, LHS.police_officers AS police_officers, LHS.residents_per_officer AS residents_per_officer, LHS.case_burden AS case_burden, LHS.crime_rate AS crime_rate, LHS.police_force AS police_force, LHS.location AS LOCATION, RHS.city_id AS city_id, RHS.county_id AS county_id_other, RHS.name AS name_other, RHS.white AS white, RHS.black AS black, RHS.amerindian AS amerindian, RHS.asian AS asian, RHS.multiracial AS multiracial, RHS.hispanic AS hispanic FROM county_public_safety AS LHS CROSS JOIN city AS RHS) WHERE (county_id = county_id_other)) WHERE (county_id = 100 OR crime_rate < 100.0) ORDER BY name;

/*
Gold Result:
('Stephen Potter',)
*/

-- Prediction Query
SELECT name FROM city WHERE county_id IN (SELECT county_id FROM county_public_safety WHERE Crime_rate < 100);

/*
Prediction Result:
*/