-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (1, 'Charlie', '40x40', 1200.0, 10.0, 'Letter', 'Wi-Fi');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (2, 'Alpha', '30x20', 600.0, 25.0, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (3, 'Delta', '20x20', 900.0, 30.0, 'Legal', 'Bluetooth');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (4, 'Bravo', '10x10', 300.0, 40.0, 'A3', 'Ethernet');
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (10, 'Main Hub', 'Flagship', 500.0, 12.0, 1);
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (20, 'Corner Shop', 'Retail', 150.0, 4.0, 2);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (100, 'North', 'Metropolis', 1000000.0, 250.0);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (10, 1);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (20, 1);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (10, 2);
INSERT INTO store_district (Store_ID, District_ID) VALUES (10, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product FROM (SELECT product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface, COUNT(*) OVER () AS n FROM product) ORDER BY product;

/*
Gold Result:
('Alpha',)
('Bravo',)
('Charlie',)
('Delta',)
*/

-- Prediction Query
SELECT product FROM product WHERE product <> (SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1);

/*
Prediction Result:
('Charlie',)
('Alpha',)
('Delta',)
('Bravo',)
*/