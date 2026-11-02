-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT JOIN (unmatched city, competition with NULL Host_city_ID),
-- SELECT ALL vs SELECT DISTINCT (duplicate Year + Official_Name),
-- and basic multi-column ORDER BY (Year ASC, Official_Name ASC).
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (1, 'Beta City', 'Town', 50.5, 10000.0, '10th');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (2, 'Alpha City', 'City', 120.0, 50000.0, '2nd');
INSERT INTO city (City_ID, Official_Name, Status, Area_km_2, Population, Census_Ranking) VALUES (3, 'Unmatched City', 'Village', 10.0, 500.0, '99th');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (10, 1, 2022, 'Harvest', 'Host A');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (20, 2, 2020, 'Spring', 'Host B');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (30, 1, 2020, 'Winter', 'Host C');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (40, 1, 2020, 'Autumn', 'Host D');
INSERT INTO farm_competition (Competition_ID, Host_city_ID, Year, Theme, Hosts) VALUES (50, NULL, 2019, 'Orphan Theme', 'Host E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR, official_name FROM (SELECT LHS.city_id AS city_id, LHS.official_name AS official_name, LHS.status AS status, LHS.area_km_2 AS area_km_2, LHS.population AS population, LHS.census_ranking AS census_ranking, RHS.competition_id AS competition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.hosts AS hosts FROM city AS LHS INNER JOIN farm_competition AS RHS ON (LHS.city_id = RHS.host_city_id)) ORDER BY YEAR, official_name NULLS LAST;

/*
Gold Result:
(2020, 'Alpha City')
(2020, 'Beta City')
(2020, 'Beta City')
(2022, 'Beta City')
*/

-- Prediction Query
SELECT T2.Year, T1.Official_Name FROM city AS T1 JOIN farm_competition AS T2 ON T1.City_ID = T2.Host_city_ID;

/*
Prediction Result:
(2022, 'Beta City')
(2020, 'Alpha City')
(2020, 'Beta City')
(2020, 'Beta City')
*/