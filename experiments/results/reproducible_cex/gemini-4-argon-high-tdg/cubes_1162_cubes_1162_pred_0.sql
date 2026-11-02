-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (10, 'Blackville', 'Superstore', 1200.0, 25.0, 1);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (20, 'Blackville', 'Outlet', 450.0, 8.0, 3);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (30, 'Blackville', 'Boutique', 150.0, 3.0, 5);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (40, 'Blackville', 'Department', 800.0, 15.0, 2);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (50, 'OtherStore', 'Superstore', 1000.0, 20.0, 4);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (100, 'Northwest', 'Seattle', 750000.0, 360.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (200, 'Southeast', 'Atlanta', 500000.0, 350.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (300, 'Mountain', 'Denver', 710000.0, 400.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (400, 'Coastal', 'Miami', 460000.0, 140.0);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (10, 100);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (20, 200);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (30, 100);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (40, 300);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (50, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquartered_city" FROM (SELECT "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking", "LHS"."district_id" AS "district_id", "LHS"."district_name" AS "district_name", "LHS"."headquartered_city" AS "headquartered_city", "LHS"."city_population" AS "city_population", "LHS"."city_area" AS "city_area" FROM (SELECT "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking", "RHS"."district_id" AS "district_id", "RHS"."district_name" AS "district_name", "RHS"."headquartered_city" AS "headquartered_city", "RHS"."city_population" AS "city_population", "RHS"."city_area" AS "city_area" FROM "store" AS "LHS" CROSS JOIN "district" AS "RHS") AS "LHS" INNER JOIN "store_district" AS "RHS" ON ("LHS"."store_id" = "RHS"."store_id" AND "LHS"."district_id" = "RHS"."district_id")) WHERE ("store_name" = 'Blackville') ORDER BY headquartered_city, "headquartered_city" NULLS LAST;

/*
Gold Result:
('Atlanta',)
('Denver',)
('Seattle',)
('Seattle',)
*/

-- Prediction Query
SELECT t3.headquartered_city FROM store AS t1 JOIN store_district AS t2 ON t1.store_id = t2.store_id JOIN district AS t3 ON t2.district_id = t3.district_id WHERE t1.store_name = 'Blackville';

/*
Prediction Result:
('Seattle',)
('Atlanta',)
('Seattle',)
('Denver',)
*/