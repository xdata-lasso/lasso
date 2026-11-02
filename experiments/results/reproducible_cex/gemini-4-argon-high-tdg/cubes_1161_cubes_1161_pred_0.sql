-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (1, 'LaserJet', '10x10', 600.0, 20.0, 'A4', 'USB');
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (1, 'Downtown Store', 'Flagship', 500.0, 10.0, 1);
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (2, 'Uptown Store', 'Outlet', 300.0, 5.0, 2);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (1, 'North', 'Alpha', 3.0, 10.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (2, 'South', 'Beta', 2.5, 20.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (3, 'East', 'Gamma', 5.0, 1.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (4, 'West', 'Delta', 5.0, 2.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (5, 'Central', 'Epsilon', 3.5, 8.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (6, 'Suburb', 'Zeta', NULL, 15.0);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (1, 1);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (2, 1);
INSERT INTO store_district (Store_ID, District_ID) VALUES (1, 4);
INSERT INTO store_district (Store_ID, District_ID) VALUES (2, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumcity_population AS sum_city_population_ FROM (SELECT SUM(city_population) AS sumcity_population FROM (SELECT * FROM district WHERE (city_population > 3.0))) ORDER BY sum_city_population_;

/*
Gold Result:
(13.5,)
*/

-- Prediction Query
SELECT SUM(city_population) FROM district ORDER BY city_area DESC, district.district_id NULLS LAST LIMIT 3;

/*
Prediction Result:
(19.0,)
*/