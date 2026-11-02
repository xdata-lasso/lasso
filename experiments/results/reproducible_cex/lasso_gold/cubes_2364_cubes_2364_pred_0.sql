-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1201, 'Richard Rodriguez', 1202, 1203, 1204, 1205, 1206.5, 'turn', '37543 Andrew Fields Suite 541
Michaelhaven, MO 89566');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1213, 'Cassandra Estes', 1214, 1215, 1216, 1217, 1218.5, 'evidence', '5698 Paul Ports Apt. 406
New Saraside, TX 94798');
INSERT INTO "city" ("city_id", "county_id", "name", "white", "black", "amerindian", "asian", "multiracial", "hispanic") VALUES (1207, 1201, 'Ms. Teresa Wilson', 1208.5, 11.0, 1209.5, 1210.5, 1211.5, 1213.5);
INSERT INTO "city" ("city_id", "county_id", "name", "white", "black", "amerindian", "asian", "multiracial", "hispanic") VALUES (1219, 1213, 'Nancy Gonzalez', 1209.5, 11.0, 1210.5, 1211.5, 1212.5, 1212.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hispanic FROM city WHERE (black > 10.0) ORDER BY hispanic, city.city_id NULLS LAST;

/*
Gold Result:
(1212.5,)
(1213.5,)
*/

-- Prediction Query
SELECT Hispanic FROM city WHERE Black > 10;

/*
Prediction Result:
(1213.5,)
(1212.5,)
*/