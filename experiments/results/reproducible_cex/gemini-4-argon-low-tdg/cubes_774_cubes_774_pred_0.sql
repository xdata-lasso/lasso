-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "city" ("City_ID", "Official_Name", "Status", "Area_km_2", "Population", "Census_Ranking") VALUES (1, 'Metropolis', 'City', 100.5, 50000.0, '1st');
INSERT INTO "farm" ("Farm_ID", "Year", "Total_Horses", "Working_Horses", "Total_Cattle", "Oxen", "Bulls", "Cows", "Pigs", "Sheep_and_Goats") VALUES (1, 2000, 10.0, 5.0, 20.0, 2.0, 3.0, 15.0, 30.0, 40.0);
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (1, 1, 2005, 'Aliens', 'Host_Exact_Match');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (2, 1, 2006, 'aliens', 'Host_Lowercase_Theme');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (3, 1, 2007, 'Aliens ', 'Host_Trailing_Space_Theme');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (4, 1, 2008, NULL, 'Host_Null_Theme');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (5, 1, 2009, 'AAliens', 'Host_Before_Lexicographical');
INSERT INTO "farm_competition" ("Competition_ID", "Host_city_ID", "Year", "Theme", "Hosts") VALUES (6, 1, 2010, 'Zliens', 'Host_After_Lexicographical');
INSERT INTO "competition_record" ("Competition_ID", "Farm_ID", "Rank") VALUES (1, 1, 1);
INSERT INTO "competition_record" ("Competition_ID", "Farm_ID", "Rank") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "hosts" FROM "farm_competition" WHERE ("theme" <> 'Aliens') ORDER BY hosts, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
('Host_After_Lexicographical',)
('Host_Before_Lexicographical',)
('Host_Lowercase_Theme',)
('Host_Trailing_Space_Theme',)
*/

-- Prediction Query
SELECT Hosts FROM farm_competition WHERE Theme <> 'Aliens';

/*
Prediction Result:
('Host_Lowercase_Theme',)
('Host_Trailing_Space_Theme',)
('Host_Before_Lexicographical',)
('Host_After_Lexicographical',)
*/