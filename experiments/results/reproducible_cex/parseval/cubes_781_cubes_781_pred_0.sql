-- Schema DDL
CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "Official_Name" TEXT, "Status" TEXT, "Area_km_2" REAL, "Population" REAL, "Census_Ranking" TEXT);

CREATE TABLE "farm" ("Farm_ID" INTEGER PRIMARY KEY, "Year" INTEGER, "Total_Horses" REAL, "Working_Horses" REAL, "Total_Cattle" REAL, "Oxen" REAL, "Bulls" REAL, "Cows" REAL, "Pigs" REAL, "Sheep_and_Goats" REAL);

CREATE TABLE "farm_competition" ("Competition_ID" INTEGER PRIMARY KEY, "Host_city_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Hosts" TEXT, FOREIGN KEY ("Host_city_ID") REFERENCES "city" ("City_ID"));

CREATE TABLE "competition_record" ("Competition_ID" INTEGER, "Farm_ID" INTEGER, "Rank" INTEGER, PRIMARY KEY ("Competition_ID", "Farm_ID"), FOREIGN KEY ("Farm_ID") REFERENCES "farm" ("Farm_ID"), FOREIGN KEY ("Competition_ID") REFERENCES "farm_competition" ("Competition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: city --
INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483648, '5k5swwqcgs', 'cit_4eaa51', 171.746906, 557.512061, '8c4pgu7vfe');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483647, 'hria2ypu', 'cit_4eaa51', 882.963176, 841.297061, 'rwbbp');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483646, 'luhvdltti', 'cit_4eaa51', 182.319045, 998.421621, 'prmd');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (2, 'posiie5unw6k', 'cit_4eaa51', 768.216462, 83.204633, '9');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (3, '00t5c4e', 'cit_4eaa51', 950.466571, 796.740316, 'gce');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483645, '76nium52', 'cit_4eaa51', 816.814398, 396.776796, 'uo4nrqrofqy');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483642, '5s5b', 'G', 22.720462, 990.777211, '02eutliqa11r');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483641, 'ytoo3o9', 'G', 111.926013, 731.301441, '72klex14ji7z');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483640, 'au2dwy', 'A', 278.010437, 433.533777, 'pyu78d99');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483639, 'ljsl0', 'O', 27.036693, 884.000446, 'p5qi2rkf9v');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483638, 'x58pz', 'O', 410.133844, 88.474525, '8jegd21vy9ux');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483637, 'j4hwbdvlph', 'A', 439.200238, 795.815869, 'dqwn');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483636, 'cx5hn', 'O', 41.944398, 242.407667, 'tu0');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483635, 'z', 'O', 521.610309, 654.674676, 'jg');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483634, '8n2f3', 'A', 687.701166, 656.638403, 'qv0gcb98oz');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483633, '3zb', 'O', 138.057338, 728.712934, 'kn6vc');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483632, '6ah', 'O', 418.948509, 532.326819, 'wwlq7');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483631, 'xb72fxa7ryfd', 'A', 276.61064, 399.319982, '16nijjai5dh');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483630, 'ogrgjd8y', 'cit_4eaa51', 763.019095, 308.482994, 'afgogri');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483629, 'tsj3ayxp1q4', 'cit_4eaa51', 457.141778, 410.094566, 'jh3den8');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483628, 'c68x8vacx7', 'cit_4eaa51', 854.793228, 983.924121, '5w1of7');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483627, 'pzo72ctdc', NULL, 803.582738, 695.452114, 'fg62');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483626, '0v', NULL, 492.883123, 691.147113, 'qdjpe1io2');

INSERT INTO "city" ("city_id", "official_name", "status", "area_km_2", "population", "census_ranking") VALUES (-2147483625, '78507cvt', NULL, 145.3181, 789.724834, 'ttg6bnou5zi3');
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
('cit_4eaa51',)
*/