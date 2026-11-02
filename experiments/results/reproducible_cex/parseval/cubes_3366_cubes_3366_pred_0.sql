-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: city --
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, 475.173408, 'u7');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483647, 'fe4hri', 'a2ypuzhsrwbb', 749.826493, 503.083789, 'hvdltt');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (2, 'lbn', 'rmdp', 227.766936, 971.82669, 'ie5');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (3, 'nw6klf', 'a9000t5c4eci', 734.586266, 767.720387, 'e');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483644, 'q_2_07fc9d', 'q_2_c6bd4f', 467.07027, 875.837169, 'nium52zbu');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483643, 'q_2_07fc9d', 'q_2_c6bd4f', 225.300904, 760.580899, 'rqrofqyp5s');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT official_name, status FROM (SELECT * FROM (SELECT * FROM (SELECT city_id, official_name, status, area_km_2, MAX(population) OVER () AS population, census_ranking FROM city) ORDER BY status) LIMIT 1);

/*
Gold Result:
('5k5swwqcgs', '9n8')
*/

-- Prediction Query
SELECT Official_Name, Status FROM city ORDER BY Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('lbn', 'rmdp')
*/