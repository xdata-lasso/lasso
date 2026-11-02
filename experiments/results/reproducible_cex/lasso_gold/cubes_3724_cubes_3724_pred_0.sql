-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1056, 'Nathan Cortez', 'East Nathaniel', NULL, 1062.5);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1057, 'Pamela Romero', 'New Stephanie', NULL, 1073.5);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1058, 'Mario Skinner', 'New Mariotown', NULL, 1084.5);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1065, 'Jack Galloway', 'Port Amandaberg', NULL, 1071.5);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1066, 'Cynthia Allen', 'Lake Thomas', NULL, 1082.5);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1067, 'Angela Dennis', 'West Allison', NULL, 1093.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT district_name FROM (SELECT LHS.district_id AS district_id, LHS.district_name AS district_name, LHS.headquartered_city AS headquartered_city, LHS.city_population AS city_population, LHS.city_area AS city_area, LHS.maxcity_population AS maxcity_population, RHS.district_id AS district_id_other, RHS.district_name AS district_name_other, RHS.headquartered_city AS headquartered_city_other, RHS.city_population AS city_population_other, RHS.city_area AS city_area_other, RHS.maxcity_population AS maxcity_population_other FROM (SELECT district_id, district_name, headquartered_city, city_population, city_area, MAX(city_population) OVER () AS maxcity_population FROM district) AS LHS CROSS JOIN (SELECT district_id, district_name, headquartered_city, city_population, city_area, MAX(city_population) OVER () AS maxcity_population FROM district) AS RHS) WHERE (city_population >= maxcity_population AND city_population <= maxcity_population_other) ORDER BY district_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT district_name FROM district ORDER BY city_population DESC, district.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Nathan Cortez',)
*/