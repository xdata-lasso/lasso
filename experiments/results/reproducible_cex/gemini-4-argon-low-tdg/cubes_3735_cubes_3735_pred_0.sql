-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty 'district' table while other tables are populated.
-- Catches: Regular aggregate `SELECT SUM(city_population) FROM district` (which returns 1 row with NULL)
-- vs Window function `SELECT DISTINCT SUM(...) OVER () FROM district` (which returns 0 rows on an empty table).
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (1, 'Printer X', '20x20', 600.0, 20.0, 'A3', 'WiFi');
INSERT INTO "store" ("Store_ID", "Store_Name", "Type", "Area_size", "Number_of_product_category", "Ranking") VALUES (1, 'Super Store', 'Wholesale', 1200.0, 15.0, 2);
INSERT INTO "store_product" ("Store_ID", "Product_ID") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM(city_population) OVER () AS sum_city_population_ FROM district ORDER BY sum_city_population_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(city_population) FROM district ORDER BY city_area DESC, district.district_id NULLS LAST LIMIT 3;

/*
Prediction Result:
(None,)
*/