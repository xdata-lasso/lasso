-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (1, 'CityA', 'A', 100.0, 1000.0, '1st');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (2, 'CityB', 'B', 200.0, 5000.0, '2nd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT official_name, status FROM (SELECT * FROM (SELECT * FROM (SELECT city_id, official_name, status, area_km_2, MAX(population) OVER () AS population, census_ranking FROM city) ORDER BY status) LIMIT 1);

/*
Gold Result:
('CityA', 'A')
*/

-- Prediction Query
SELECT Official_Name, Status FROM city ORDER BY Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('CityB', 'B')
*/