-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Area_km_2 DESC vs Population DESC, City_ID ASC/DESC, and kills spurious inner joins with farm_competition.
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (1, 'SmallAreaBigPop', 'Town', 100.5, 900000.0, '1 of 10');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (2, 'MaxAreaNoComp', 'Metropolis', 950.2, 50000.0, '5 of 10');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (3, 'MidAreaWithComp', 'Village', 500.0, 250000.0, '3 of 10');
INSERT INTO "farm" ("Farm_ID", "Year", "Total_Horses", "Working_Horses", "Total_Cattle", "Oxen", "Bulls", "Cows", "Pigs", "Sheep_and_Goats") VALUES (1, 2020, 10.0, 5.0, 20.0, 2.0, 1.0, 17.0, 30.0, 40.0);
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (1, 3, 2020, 'Harvest', 'Country');
INSERT INTO "competition_record" ("Competition_ID", "Farm_ID", "Rank") VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT official_name, status FROM (SELECT * FROM (SELECT * FROM city ORDER BY area_km_2 DESC, city.city_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('MaxAreaNoComp', 'Metropolis')
*/

-- Prediction Query
SELECT Official_Name, Status FROM city ORDER BY Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('SmallAreaBigPop', 'Town')
*/