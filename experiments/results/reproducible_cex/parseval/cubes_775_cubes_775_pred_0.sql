-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: city --
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (1, 'cit_de88f5', '5k5swwqcgs', 171.746906, 0.0, 'n8c4pgu7v');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (2, 'cit_de88f5', 'e4', 779.409124, 0.0, 'hria2ypuzhs');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (3, 'rwbbp6luhvd', 'tti', 182.319045, 1500.0, 'nprmdposii');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (4, '5k5swwqcgs', '9n8', 874.871895, 500.0, 'pgu7vfe4');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (5, 'hria2ypuzhs', 'rwbbp6luhvd', 179.378884, NULL, 'ilbnp');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (6, 'mdpos', 'ie5', 327.753528, NULL, 'w6kl');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (7, 'a9', '00t5c4e', 950.466571, NULL, 'i');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (8, 'gce376nium52', 'zbuo4nrqrof', 586.906897, NULL, 'p5s5bbp');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (9, '02eutliqa11r', 'ytoo3o9', 111.926013, NULL, '72klex14ji7z');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (10, 'au2dwy', 'q13py', 326.912005, NULL, 'd99rljsl0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT official_name FROM city WHERE (population >= 1500.0 OR population < 500.0) ORDER BY official_name, city.city_id NULLS LAST;

/*
Gold Result:
('cit_de88f5',)
('cit_de88f5',)
('rwbbp6luhvd',)
*/

-- Prediction Query
SELECT Official_Name FROM city WHERE Population > 1500 OR Population < 500;

/*
Prediction Result:
('cit_de88f5',)
('cit_de88f5',)
*/