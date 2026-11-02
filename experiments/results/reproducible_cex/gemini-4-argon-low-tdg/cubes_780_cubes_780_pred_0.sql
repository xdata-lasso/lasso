-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality filtering, NULL handling in Status and Census_Ranking, duplicates (SELECT vs SELECT DISTINCT), and string vs numeric sorting on Census_Ranking.
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (1, 'Metropolis', 'City', 500.5, 1000000.0, '10 of 100');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (2, 'Smallville', 'Village', 50.0, 5000.0, '99 of 100');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (3, 'Gotham', 'Town', 300.0, 500000.0, '2 of 100');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (4, 'Star City', 'City', 400.0, 600000.0, '2 of 100');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (5, 'Ghost Town', NULL, 10.0, 0.0, '100 of 100');
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (6, 'Unranked City', 'City', 200.0, 150000.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "census_ranking" FROM "city" WHERE ("status" <> 'Village') ORDER BY census_ranking, city.city_id NULLS LAST;

/*
Gold Result:
(None,)
('10 of 100',)
('2 of 100',)
('2 of 100',)
*/

-- Prediction Query
SELECT Census_Ranking FROM city WHERE Status <> 'Village';

/*
Prediction Result:
('10 of 100',)
('2 of 100',)
('2 of 100',)
(None,)
*/