-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1138, 'Khanewal District', 'East Nathaniel', 1139.5, 1140.5);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (1145, 'Khanewal District', 'New Mariotown', 1146.5, 1147.5);
INSERT INTO "store" ("store_id", "store_name", "type", "area_size", "number_of_product_category", "ranking") VALUES (1141, 'Troy Nielsen', 'surface', 1142.5, 1143.5, 1144);
INSERT INTO "store" ("store_id", "store_name", "type", "area_size", "number_of_product_category", "ranking") VALUES (1148, 'Anthony Humphrey', 'why', 1143.5, 1144.5, 1145);
INSERT INTO "store_district" ("store_id", "district_id") VALUES (1141, 1138);
INSERT INTO "store_district" ("store_id", "district_id") VALUES (1148, 1145);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "store_name" FROM (SELECT "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking", "LHS"."district_id" AS "district_id", "LHS"."district_name" AS "district_name", "LHS"."headquartered_city" AS "headquartered_city", "LHS"."city_population" AS "city_population", "LHS"."city_area" AS "city_area" FROM (SELECT "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking", "RHS"."district_id" AS "district_id", "RHS"."district_name" AS "district_name", "RHS"."headquartered_city" AS "headquartered_city", "RHS"."city_population" AS "city_population", "RHS"."city_area" AS "city_area" FROM "store" AS "LHS" CROSS JOIN "district" AS "RHS") AS "LHS" INNER JOIN "store_district" AS "RHS" ON ("LHS"."store_id" = "RHS"."store_id" AND "LHS"."district_id" = "RHS"."district_id")) WHERE ("district_name" = 'Khanewal District') ORDER BY store_name, "store_name" NULLS LAST;

/*
Gold Result:
('Anthony Humphrey',)
('Troy Nielsen',)
*/

-- Prediction Query
SELECT t1.store_name FROM store AS t1 JOIN store_district AS t2 ON t1.store_id = t2.store_id JOIN district AS t3 ON t2.district_id = t3.district_id WHERE t3.district_name = 'Khanewal District';

/*
Prediction Result:
('Troy Nielsen',)
('Anthony Humphrey',)
*/