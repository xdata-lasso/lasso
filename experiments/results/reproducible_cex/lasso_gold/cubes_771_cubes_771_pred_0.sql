-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1012, 'Jonathan Johnson', 'decide', 1013.5, 1014.5, 'sense');
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1017, 'Connie Lawrence', 'table', 1018.5, 1019.5, 'true');
INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (1015, 1012, 1016, 'sure', 'science');
INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (1020, 1017, 1017, 'rate', 'song');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM farm_competition ORDER BY theme, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
('rate',)
('sure',)
*/

-- Prediction Query
SELECT Theme FROM farm_competition ORDER BY YEAR ASC, farm_competition.competition_id NULLS LAST;

/*
Prediction Result:
('sure',)
('rate',)
*/