-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1001, 'Allison Hill', 'agreement', 1005.5, 1009.5, 'rate');
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1002, 'Noah Rhodes', 'option', 1014.5, 1020.5, 'science');
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1003, 'Angie Henderson', 'decide', 1023.5, 1031.5, 'offer');
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1004, 'Daniel Wagner', 'sense', 1032.5, 1042.5, 'kind');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT official_name, status FROM (SELECT * FROM (SELECT * FROM (SELECT city_id, official_name, status, area_km_2, MAX(population) OVER () AS population, census_ranking FROM city) ORDER BY status) LIMIT 1);

/*
Gold Result:
('Allison Hill', 'agreement')
*/

-- Prediction Query
SELECT Official_Name, Status FROM city ORDER BY Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner', 'sense')
*/