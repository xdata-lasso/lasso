-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: city --
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1, 'cit_f9d012', 'cit_c288d5', 1.0, 1.0, 'cit_25c2d8');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483647, 'cit_b8282d', 'cit_a6f1ac', 1.0, 1.0, 'cit_819c88');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-1, '5k5swwqcgs', '9n8', 7719.0, 874.871895, 'pgu7vfe4');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (0, 'hria2ypuzhs', 'rwbbp6luhvd', 0.0, 179.378884, 'ilbnp');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483644, 'q_1_1d8284', 'q_1_efee67', 787.938887, 986.066566, 'dposiie5unw');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483643, 'q_1_1d8284', 'q_1_efee67', 992.733505, 162.04354, 'fa9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT official_name, status FROM (SELECT * FROM (SELECT * FROM city ORDER BY area_km_2 DESC, city.city_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('5k5swwqcgs', '9n8')
*/

-- Prediction Query
SELECT Official_Name, Status FROM city ORDER BY Population DESC, city.city_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_1_1d8284', 'q_1_efee67')
*/