-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (10, 'Metro', 'CityA', 500000.0, 150.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (20, 'Metro', 'CityB', 500000.0, 250.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (5, 'Metro', 'CityC', 800000.0, 350.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (15, 'Alpha', 'Zeta', 1200000.0, 450.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (25, NULL, 'Omega', 900000.0, 550.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name, city_population FROM district WHERE (city_population >= 200000.0 AND city_population <= 2000000.0) ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
(None, 900000.0)
('Alpha', 1200000.0)
('Metro', 800000.0)
('Metro', 500000.0)
('Metro', 500000.0)
*/

-- Prediction Query
SELECT District_name, City_Population FROM district WHERE City_Population BETWEEN 200000 AND 2000000;

/*
Prediction Result:
('Metro', 800000.0)
('Metro', 500000.0)
('Alpha', 1200000.0)
('Metro', 500000.0)
(None, 900000.0)
*/