-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (9, '17', '17', 17, 17, '17', '17');
INSERT INTO "store" ("store_id", "store_name", "type", "area_size", "number_of_product_category", "ranking") VALUES (11, '17', '17', 17, 17, 17);
INSERT INTO "store" ("store_id", "store_name", "type", "area_size", "number_of_product_category", "ranking") VALUES (10, '17', '17', 17, 17, 17);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (13, NULL, '14', 100001, -635);
INSERT INTO "district" ("district_id", "district_name", "headquartered_city", "city_population", "city_area") VALUES (12, NULL, '15', 142, 853);
INSERT INTO "store_product" ("store_id", "product_id") VALUES (11, 9);
INSERT INTO "store_product" ("store_id", "product_id") VALUES (10, 9);
INSERT INTO "store_district" ("store_id", "district_id") VALUES (11, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name FROM district WHERE (city_area >= 10.0 OR city_population <= 100000.0) ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT district_name FROM district WHERE city_area > 10 OR City_Population > 100000;

/*
Prediction Result:
(None,)
(None,)
*/