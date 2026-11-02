-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (1, 'Scanner Pro', '10x12', 600.0, 15.5, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (2, 'LaserJet X', '15x15', 1200.0, 30.0, 'A3', 'Ethernet');
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (10, 'MegaMart', 'Flagship', 500.0, 12.0, 1);
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (20, 'QuickShop', 'Express', 150.0, 4.0, 3);
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (30, 'ValueCenter', 'Outlet', 350.0, 8.0, 2);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (1, 'Zeta Valley', 'Austin', 300000.0, 250.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (2, 'Beta Ridge', 'Denver', 800000.0, 100.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (3, 'Omega Coast', 'Boston', 100000.0, 500.0);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (4, 'Alpha Plains', 'Chicago', 500000.0, 300.0);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (10, 1);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (20, 2);
INSERT INTO store_district (Store_ID, District_ID) VALUES (10, 2);
INSERT INTO store_district (Store_ID, District_ID) VALUES (20, 3);
INSERT INTO store_district (Store_ID, District_ID) VALUES (30, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT district_name FROM district ORDER BY district_name, district.district_id NULLS LAST;

/*
Gold Result:
('Alpha Plains',)
('Beta Ridge',)
('Omega Coast',)
('Zeta Valley',)
*/

-- Prediction Query
SELECT DISTINCT District_name FROM district ORDER BY city_area DESC, District_name NULLS LAST;

/*
Prediction Result:
('Omega Coast',)
('Alpha Plains',)
('Zeta Valley',)
('Beta Ridge',)
*/