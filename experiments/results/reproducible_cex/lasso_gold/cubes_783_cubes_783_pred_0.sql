-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1059, 'Nicholas Martin', 'hundred', 1060.5, 1061.5, 'expect');
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1064, 'Renee Morales', 'special', 1065.5, 1066.5, 'stand');
INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (1062, 1059, 1064, 'arrive', 'drop');
INSERT INTO "farm_competition" ("competition_id", "host_city_id", "year", "theme", "hosts") VALUES (1067, 1064, 1063, 'wish', 'push');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR, official_name FROM (SELECT LHS.city_id AS city_id, LHS.official_name AS official_name, LHS.status AS status, LHS.area_km_2 AS area_km_2, LHS.population AS population, LHS.census_ranking AS census_ranking, RHS.competition_id AS competition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.hosts AS hosts FROM city AS LHS INNER JOIN farm_competition AS RHS ON (LHS.city_id = RHS.host_city_id)) ORDER BY YEAR, official_name NULLS LAST;

/*
Gold Result:
(1063, 'Renee Morales')
(1064, 'Nicholas Martin')
*/

-- Prediction Query
SELECT T2.Year, T1.Official_Name FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID = T2.Host_city_ID;

/*
Prediction Result:
(1064, 'Nicholas Martin')
(1063, 'Renee Morales')
*/