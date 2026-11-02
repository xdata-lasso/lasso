-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: store --
INSERT INTO "store" ("store_id", "store_name", "type", "area_size", "number_of_product_category", "ranking") VALUES (1, 'rhs_80774b', 'rhs_fc57ad', 1.0, 1.0, 1);

-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (1, 'lhs_275d2d', 'lhs_786e39', 1.0, 1.0, 'lhs_cd3fad', 'lhs_39587c');

-- Inserting into table: store_product --
INSERT INTO "store_product" ("store_id", "product_id") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "product" FROM (SELECT "LHS"."product_id" AS "product_id", "LHS"."product" AS "product", "LHS"."dimensions" AS "dimensions", "LHS"."dpi" AS "dpi", "LHS"."pages_per_minute_color" AS "pages_per_minute_color", "LHS"."max_page_size" AS "max_page_size", "LHS"."interface" AS "interface", "LHS"."store_id" AS "store_id", "LHS"."store_name" AS "store_name", "LHS"."type" AS "type", "LHS"."area_size" AS "area_size", "LHS"."number_of_product_category" AS "number_of_product_category", "LHS"."ranking" AS "ranking" FROM (SELECT "LHS"."product_id" AS "product_id", "LHS"."product" AS "product", "LHS"."dimensions" AS "dimensions", "LHS"."dpi" AS "dpi", "LHS"."pages_per_minute_color" AS "pages_per_minute_color", "LHS"."max_page_size" AS "max_page_size", "LHS"."interface" AS "interface", "RHS"."store_id" AS "store_id", "RHS"."store_name" AS "store_name", "RHS"."type" AS "type", "RHS"."area_size" AS "area_size", "RHS"."number_of_product_category" AS "number_of_product_category", "RHS"."ranking" AS "ranking" FROM "product" AS "LHS" CROSS JOIN "store" AS "RHS") AS "LHS" INNER JOIN "store_product" AS "RHS" ON ("LHS"."product_id" = "RHS"."product_id" AND "LHS"."store_id" = "RHS"."store_id")) WHERE ("store_name" <> 'Miramichi') ORDER BY product, "product" NULLS LAST;

/*
Gold Result:
('lhs_275d2d',)
*/

-- Prediction Query
SELECT t1.product FROM product AS t1 JOIN store_product AS t2 ON t1.product_id = t2.product_id JOIN store AS t3 ON t2.store_id = t3.store_id WHERE t3.store_name = 'Miramichi';

/*
Prediction Result:
*/