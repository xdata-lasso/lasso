-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("City_ID", "Official_Name") VALUES (1, 'CityA');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (1, 1, 2020, 'B_Theme', 'Host1');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (2, 1, 2021, 'A_Theme', 'Host2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM farm_competition ORDER BY theme, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
('A_Theme',)
('B_Theme',)
*/

-- Prediction Query
SELECT Theme FROM farm_competition ORDER BY YEAR ASC, farm_competition.competition_id NULLS LAST;

/*
Prediction Result:
('B_Theme',)
('A_Theme',)
*/