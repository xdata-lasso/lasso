-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO city (city_id, official_name, status, area_km_2, population, census_ranking) VALUES (0, NULL, 'Village', NULL, NULL, NULL), (1, NULL, 'Village', 1.0, NULL, 'default1'), (2, 'default1', 'Village', NULL, 0.0, 'default1'), (3, 'Village', 'default2', NULL, 0.0, 'default2'), (4, 'default2', 'Village', 0.0, 0.0, 'default1'), (5, 'default2', NULL, 1.0, 1.0, 'Village'), (6, NULL, 'Village', NULL, 0.0, 'Village'), (7, 'default2', 'default1', NULL, 1.0, NULL), (8, 'default1', 'Village', 1.0, 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "census_ranking" FROM "city" WHERE ("status" <> 'Village') ORDER BY census_ranking, city.city_id NULLS LAST;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT Census_Ranking FROM city WHERE Status <> 'Village';

/*
Prediction Result:
('default2',)
(None,)
*/