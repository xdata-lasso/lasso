-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions (>= 200000.0 and <= 2000000.0), off-by-one values, and NULL handling in WHERE clause.
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (1, 'District_Low_Out', 'CityA', 199999.9, 100.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (2, 'District_Low_Exact', 'CityB', 200000.0, 200000.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (3, 'District_Mid', 'CityC', 500000.0, 50.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (4, 'District_High_Exact', 'CityD', 2000000.0, 2000000.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (5, 'District_High_Out', 'CityE', 2000000.1, 300.0);
INSERT INTO "district" ("District_ID", "District_name", "Headquartered_City", "City_Population", "City_Area") VALUES (6, 'District_Null_Pop', 'CityF', NULL, 500000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name, city_population FROM district WHERE (city_population >= 200000.0 AND city_population <= 2000000.0) ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
('District_High_Exact', 2000000.0)
('District_Low_Exact', 200000.0)
('District_Mid', 500000.0)
*/

-- Prediction Query
SELECT District_name, City_Population FROM district WHERE City_Population BETWEEN 200000 AND 2000000;

/*
Prediction Result:
('District_Low_Exact', 200000.0)
('District_Mid', 500000.0)
('District_High_Exact', 2000000.0)
*/