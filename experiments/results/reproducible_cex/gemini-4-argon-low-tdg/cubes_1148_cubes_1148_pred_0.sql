-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (1, 'Printer A', '10x10', 600.0, 20.0, 'A4', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (2, 'Printer B', '12x12', 1200.0, 30.0, 'A3', 'WiFi');
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (1, 'Zeta Store', 'Mall', 500.0, 10.0, 1);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (2, 'Alpha Store', 'Shop', 100.0, 5.0, 3);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (3, 'Alpha Store', 'Supermarket', 300.0, 8.0, 2);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (4, NULL, 'Boutique', 150.0, 3.0, 4);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (5, 'Beta Store', 'Outlet', 250.0, 6.0, 5);
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (6, 'Unlinked Store', 'Kiosk', 50.0, 1.0, 6);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (10, 'Khanewal District', 'Khanewal', 200000.0, 500.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (20, 'Multan District', 'Khanewal District', 500000.0, 1000.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (30, 'Lahore District', 'Lahore', 1000000.0, 2000.0);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (1, 10);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (2, 10);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (3, 10);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (4, 10);
INSERT INTO "store_district" ("Store_ID", "District_ID") VALUES (5, 20);
INSERT INTO "store_product" ("Store_ID", "Product_ID") VALUES (1, 1);
INSERT INTO "store_product" ("Store_ID", "Product_ID") VALUES (1, 2);
INSERT INTO "store_product" ("Store_ID", "Product_ID") VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "store_name" FROM (SELECT "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking", "LHS"."district_id" AS "district_id", "LHS"."district_name" AS "district_name", "LHS"."headquartered_city" AS "headquartered_city", "LHS"."city_population" AS "city_population", "LHS"."city_area" AS "city_area" FROM (SELECT "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking", "RHS"."district_id" AS "district_id", "RHS"."district_name" AS "district_name", "RHS"."headquartered_city" AS "headquartered_city", "RHS"."city_population" AS "city_population", "RHS"."city_area" AS "city_area" FROM "store" AS "LHS" CROSS JOIN "district" AS "RHS") AS "LHS" INNER JOIN "store_district" AS "RHS" ON ("LHS"."store_id" = "RHS"."store_id" AND "LHS"."district_id" = "RHS"."district_id")) WHERE ("district_name" = 'Khanewal District') ORDER BY store_name, "store_name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Store',)
('Alpha Store',)
('Zeta Store',)
*/

-- Prediction Query
SELECT t1.store_name FROM store AS t1 JOIN store_district AS t2 ON t1.store_id = t2.store_id JOIN district AS t3 ON t2.district_id = t3.district_id WHERE t3.district_name = 'Khanewal District';

/*
Prediction Result:
('Zeta Store',)
('Alpha Store',)
('Alpha Store',)
(None,)
*/