-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (9, '13', NULL, NULL, 1500, NULL);
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (8, '9', '9', 9, 500, '9');
INSERT INTO "farm" ("farm_id", "year", "total_horses", "working_horses", "total_cattle", "oxen", "bulls", "cows", "pigs", "sheep_and_goats") VALUES (10, 9, 9, 9, 9, 9, 9, 9, 9, 9);
INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (11, 9, 9, '9', '9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT official_name FROM city WHERE (population >= 1500.0 OR population < 500.0) ORDER BY official_name, city.city_id NULLS LAST;

/*
Gold Result:
('13',)
*/

-- Prediction Query
SELECT Official_Name FROM city WHERE Population > 1500 OR Population < 500;

/*
Prediction Result:
*/