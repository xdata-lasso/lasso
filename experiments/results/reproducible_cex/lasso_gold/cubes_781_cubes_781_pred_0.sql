-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1, 'Allison Hill', 'dog', 1001.5, 1002.5, 'chair');
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1003, 'Megan Mcclain', 'begin', 1004.5, 1005.5, 'performance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status FROM (SELECT LHS.city_id AS city_id, LHS.official_name AS official_name, LHS.status AS status, LHS.area_km_2 AS area_km_2, LHS.population AS population, LHS.census_ranking AS census_ranking FROM city AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM city) AS RHS ON (LHS.city_id = RHS.n)) ORDER BY status;

/*
Gold Result:
*/

-- Prediction Query
SELECT Status FROM city GROUP BY Status ORDER BY COUNT(*) DESC, Status NULLS LAST LIMIT 1;

/*
Prediction Result:
('begin',)
*/