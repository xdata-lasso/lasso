-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (1, 'Grandview', 'Town', 15.5, 5000.0, '100th');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (1, 1, 2020, 'Aliens', 'Zeta Corp');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (2, 1, 2021, 'Harvest', 'Beta Org');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (3, 1, 2022, 'Agriculture', 'Alpha Inc');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (4, 1, 2023, 'Rodeo', 'Beta Org');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (5, 1, 2024, NULL, 'Gamma LLC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "hosts" FROM "farm_competition" WHERE ("theme" <> 'Aliens') ORDER BY hosts, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Beta Org',)
('Beta Org',)
*/

-- Prediction Query
SELECT Hosts FROM farm_competition WHERE Theme <> 'Aliens';

/*
Prediction Result:
('Beta Org',)
('Alpha Inc',)
('Beta Org',)
*/