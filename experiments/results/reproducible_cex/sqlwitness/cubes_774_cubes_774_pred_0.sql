-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO city (city_id, official_name, status, area_km_2, population, census_ranking) VALUES (1, 'Aliens', 'Aliens', 1.0, 1.0, 'Aliens'), (0, 'Aliens', 'default1', 0.0, 0.0, 'default1'), (2, NULL, NULL, NULL, 1.0, NULL), (3, NULL, 'Aliens', NULL, 0.0, 'Aliens'), (4, 'Aliens', 'Aliens', NULL, NULL, 'default1'), (5, NULL, 'Aliens', 0.0, 0.0, 'Aliens'), (6, NULL, 'default1', NULL, 1.0, NULL), (7, 'default1', 'default1', 1.0, 1.0, NULL);
INSERT INTO farm_competition (competition_id, host_city_id, year, theme, hosts) VALUES (0, 0, NULL, 'Aliens', 'default1'), (1, 5, NULL, NULL, 'Aliens'), (2, 2, NULL, 'default1', NULL), (3, NULL, 1, NULL, 'default2'), (4, 3, NULL, NULL, 'default1'), (5, 2, 1, 'default2', 'Aliens'), (6, NULL, NULL, 'default2', 'Aliens'), (7, 4, 0, 'default2', 'Aliens'), (8, 3, NULL, 'default2', 'default1'), (9, 4, NULL, 'default1', 'Aliens'), (10, 1, 1, NULL, 'Aliens'), (11, 0, NULL, 'default1', 'default2'), (12, NULL, 0, 'Aliens', NULL), (13, 3, 1, 'Aliens', NULL), (14, 2, 0, 'Aliens', NULL), (15, 3, 1, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "hosts" FROM "farm_competition" WHERE ("theme" <> 'Aliens') ORDER BY hosts, farm_competition.competition_id NULLS LAST;

/*
Gold Result:
(None,)
('Aliens',)
('Aliens',)
('Aliens',)
('Aliens',)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Hosts FROM farm_competition WHERE Theme <> 'Aliens';

/*
Prediction Result:
(None,)
('Aliens',)
('Aliens',)
('Aliens',)
('default1',)
('Aliens',)
('default2',)
('default2',)
*/