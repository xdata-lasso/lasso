-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for city_area (10.0) and city_population (100000.0), as well as AND vs OR logic.
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (1, 'Dist_A_Both_True', 'City_A', 50000.0, 20.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (2, 'Dist_B_Area_Boundary_True', 'City_B', 200000.0, 10.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (3, 'Dist_C_Pop_Boundary_True', 'City_C', 100000.0, 5.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (4, 'Dist_D_Both_Boundary_False', 'City_D', 100000.1, 9.9);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (5, 'Dist_E_Area_True_Pop_False', 'City_E', 150000.0, 10.1);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (6, 'Dist_F_Area_False_Pop_True', 'City_F', 99999.9, 9.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name FROM district WHERE (city_area >= 10.0 OR city_population <= 100000.0) ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
('Dist_A_Both_True',)
('Dist_B_Area_Boundary_True',)
('Dist_C_Pop_Boundary_True',)
('Dist_E_Area_True_Pop_False',)
('Dist_F_Area_False_Pop_True',)
*/

-- Prediction Query
SELECT district_name FROM district WHERE city_area > 10 OR City_Population > 100000;

/*
Prediction Result:
('Dist_A_Both_True',)
('Dist_B_Area_Boundary_True',)
('Dist_D_Both_Boundary_False',)
('Dist_E_Area_True_Pop_False',)
*/