-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (1, 'Exact Lower Bound', 'Metro A', 200000.0, 150.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (2, 'Just Below Lower', 'Metro B', 199999.9, 150.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (3, 'Just Above Lower', 'Metro C', 200000.1, 150.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (4, 'Exact Upper Bound', 'Metro D', 2000000.0, 500.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (5, 'Just Above Upper', 'Metro E', 2000000.1, 500.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (6, 'Just Below Upper', 'Metro F', 1999999.9, 500.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (7, 'Order Of Magnitude Low', 'Metro G', 20000.0, 50.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (8, 'Mid Low Range', 'Metro H', 50000.0, 80.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (9, 'Mid Valid Range', 'Metro I', 750000.0, 300.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (10, 'Mid High Range', 'Metro J', 5000000.0, 900.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (11, 'Order Of Magnitude High', 'Metro K', 20000000.0, 1200.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (12, 'Null Population', 'Metro L', NULL, 400.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name, city_population FROM district WHERE (city_population >= 200000.0 AND city_population <= 2000000.0) ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
('Exact Lower Bound', 200000.0)
('Exact Upper Bound', 2000000.0)
('Just Above Lower', 200000.1)
('Just Below Upper', 1999999.9)
('Mid Valid Range', 750000.0)
*/

-- Prediction Query
SELECT District_name, City_Population FROM district WHERE City_Population BETWEEN 200000 AND 2000000;

/*
Prediction Result:
('Exact Lower Bound', 200000.0)
('Just Above Lower', 200000.1)
('Exact Upper Bound', 2000000.0)
('Just Below Upper', 1999999.9)
('Mid Valid Range', 750000.0)
*/