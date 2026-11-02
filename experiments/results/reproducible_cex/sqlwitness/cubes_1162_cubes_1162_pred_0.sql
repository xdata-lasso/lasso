-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO district (district_id, district_name, headquartered_city, city_population, city_area) VALUES (0, 'default1', 'default2', 1.0, 1.0), (1, 'default1', 'default2', 1.0, NULL), (2, 'Blackville', 'Blackville', 1.0, 1.0);
INSERT INTO store (store_id, store_name, type, area_size, number_of_product_category, ranking) VALUES (1, 'default2', 'default2', 1.0, 0.0, 0), (0, 'default1', 'default1', 0.0, 0.0, 0), (2, 'default1', 'default1', 0.0, 0.0, NULL), (3, NULL, 'default2', 0.0, NULL, NULL), (4, 'Blackville', 'default2', NULL, 1.0, NULL), (5, 'default2', 'default2', NULL, 1.0, NULL), (6, 'Blackville', NULL, 0.0, 0.0, 1), (7, 'default1', 'default2', 1.0, 1.0, NULL);
INSERT INTO store_district (store_id, district_id) VALUES (4, 1), (1, 2), (6, 2), (2, NULL), (0, 0), (7, 2), (3, 1), (5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "headquartered_city" FROM (SELECT "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking", "LHS"."district_id" AS "district_id", "LHS"."district_name" AS "district_name", "LHS"."headquartered_city" AS "headquartered_city", "LHS"."city_population" AS "city_population", "LHS"."city_area" AS "city_area" FROM (SELECT "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking", "RHS"."district_id" AS "district_id", "RHS"."district_name" AS "district_name", "RHS"."headquartered_city" AS "headquartered_city", "RHS"."city_population" AS "city_population", "RHS"."city_area" AS "city_area" FROM "store" AS "LHS" CROSS JOIN "district" AS "RHS") AS "LHS" INNER JOIN "store_district" AS "RHS" ON ("LHS"."store_id" = "RHS"."store_id" AND "LHS"."district_id" = "RHS"."district_id")) WHERE ("store_name" = 'Blackville') ORDER BY headquartered_city, "headquartered_city" NULLS LAST;

/*
Gold Result:
('Blackville',)
('default2',)
*/

-- Prediction Query
SELECT t3.headquartered_city FROM store AS t1 JOIN store_district AS t2 ON t1.store_id = t2.store_id JOIN district AS t3 ON t2.district_id = t3.district_id WHERE t1.store_name = 'Blackville';

/*
Prediction Result:
('default2',)
('Blackville',)
*/