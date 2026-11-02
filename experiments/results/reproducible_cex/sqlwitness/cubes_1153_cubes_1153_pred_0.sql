-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO district (district_id, district_name, headquartered_city, city_population, city_area) VALUES (2000001, 'default2', 'default1', 199999.0, 0.0), (1999999, 'default1', NULL, 200001.0, 0.0), (2000000, 'default2', NULL, 200001.0, 199999.0), (199999, NULL, 'default2', 1999999.0, 199999.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name, city_population FROM district WHERE (city_population >= 200000.0 AND city_population <= 2000000.0) ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
(None, 1999999.0)
('default1', 200001.0)
('default2', 200001.0)
*/

-- Prediction Query
SELECT District_name, City_Population FROM district WHERE City_Population BETWEEN 200000 AND 2000000;

/*
Prediction Result:
(None, 1999999.0)
('default1', 200001.0)
('default2', 200001.0)
*/