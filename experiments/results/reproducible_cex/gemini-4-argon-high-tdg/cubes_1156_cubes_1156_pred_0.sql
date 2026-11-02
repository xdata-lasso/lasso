-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (1, 'LaserJet A', '400x300x200', 600.0, 10.0, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (2, 'LaserJet B', '400x300x200', 600.0, 10.0, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (3, 'LaserJet C', '450x350x250', 600.0, 25.0, 'A3', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (4, 'OfficePro X', '500x400x300', 600.0, 30.0, 'A4', 'WiFi');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (5, 'OfficePro Y', '500x400x300', 600.0, 35.0, 'A3', 'WiFi');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (6, 'PhotoPrint Z', '300x200x150', 1200.0, 5.0, 'Letter', 'USB');
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (1, 'Downtown Tech', 'Flagship', 500.0, 12.0, 1);
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (2, 'Suburb Mart', 'Outlet', 300.0, 8.0, 2);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (1, 'North District', 'Metropolis', 1000000.0, 450.0);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (1, 1);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (1, 3);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (2, 3);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (1, 4);
INSERT INTO store_district (Store_ID, District_ID) VALUES (1, 1);
INSERT INTO store_district (Store_ID, District_ID) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanpages_per_minute_color AS avg_pages_per_minute_color_ FROM (SELECT dpi, interface, AVG(pages_per_minute_color) AS meanpages_per_minute_color FROM product GROUP BY dpi, interface) ORDER BY avg_pages_per_minute_color_;

/*
Gold Result:
(5.0,)
(15.0,)
(32.5,)
*/

-- Prediction Query
SELECT AVG(pages_per_minute_color) FROM product;

/*
Prediction Result:
(19.166666666666668,)
*/