-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (12, '26', '16', 18, 20, '22', '24');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (11, '26', '17', 19, 21, '23', '25');
INSERT INTO "store" ("store_id", "store_name", "type", "area_size", "number_of_product_category", "ranking") VALUES (14, '26', '26', 26, 26, 26);
INSERT INTO "store" ("store_id", "store_name", "type", "area_size", "number_of_product_category", "ranking") VALUES (13, '26', '26', 26, 26, 26);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (15, '26', '26', 26, 26);
INSERT INTO "store_product" ("store_id", "product_id") VALUES (13, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product FROM (SELECT product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface, COUNT(*) OVER () AS n FROM product) ORDER BY product;

/*
Gold Result:
('26',)
('26',)
*/

-- Prediction Query
SELECT product FROM product WHERE product <> (SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1);

/*
Prediction Result:
('26',)
('26',)
*/