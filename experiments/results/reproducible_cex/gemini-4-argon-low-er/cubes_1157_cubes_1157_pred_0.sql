-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (1, 'A', 'City1', 100.0, 10.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (2, 'A', 'City2', 200.0, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name FROM district ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
('A',)
('A',)
*/

-- Prediction Query
SELECT DISTINCT District_name FROM district ORDER BY city_area DESC, District_name NULLS LAST;

/*
Prediction Result:
('A',)
*/