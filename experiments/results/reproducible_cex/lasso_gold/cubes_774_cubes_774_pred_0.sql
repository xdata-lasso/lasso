-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1057, 'Mark Ferguson', 'election', 1058.5, 1059.5, 'common');
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1062, 'Timothy Watts', 'discuss', 1063.5, 1064.5, 'reveal');
INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (1060, 1057, 1061, 'maintain', 'special');
INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (1065, 1062, 1062, 'garden', 'hundred');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "hosts" FROM "farm_competition" WHERE ("theme" <> 'Aliens') ORDER BY hosts, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
('hundred',)
('special',)
*/

-- Prediction Query
SELECT Hosts FROM farm_competition WHERE Theme <> 'Aliens';

/*
Prediction Result:
('special',)
('hundred',)
*/