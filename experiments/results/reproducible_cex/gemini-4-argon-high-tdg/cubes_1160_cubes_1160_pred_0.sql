-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (1, 'LaserJet Pro', '10x10', 600.0, 4.9, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (2, 'DeskJet Basic', 'A4', 3.0, 3.0, 'A4', 'Wi-Fi');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (3, 'OfficeJet Exact5', '12x12', 4.0, 5.0, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (4, 'Pixma Fast', '15x15', 2.0, 6.5, 'A4', 'Ethernet');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (5, 'EcoTank Wide', 'A4', 1200.0, 2.5, 'A3', 'A4');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (6, 'DeskJet Basic', '8x8', 300.0, 1.5, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (7, 'WorkForce Ultra', '20x20', 600.0, 8.0, 'B5', 'Wi-Fi');
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (1, 'Downtown Tech', 'Flagship', 500.0, 10.0, 1);
INSERT INTO store (Store_ID, Store_Name, Type, Area_size, Number_of_product_category, Ranking) VALUES (2, 'Mall Express', 'Kiosk', 120.0, 4.0, 2);
INSERT INTO district (District_ID, District_name, Headquartered_City, City_Population, City_Area) VALUES (1, 'Central', 'Metropolis', 1000000.0, 250.0);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (1, 1);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (2, 1);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (1, 4);
INSERT INTO store_product (Store_ID, Product_ID) VALUES (2, 5);
INSERT INTO store_district (Store_ID, District_ID) VALUES (1, 1);
INSERT INTO store_district (Store_ID, District_ID) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product" FROM "product" WHERE ("max_page_size" = 'A4' AND pages_per_minute_color < 5.0) ORDER BY product, product.product_id NULLS LAST;

/*
Gold Result:
('DeskJet Basic',)
('DeskJet Basic',)
('LaserJet Pro',)
*/

-- Prediction Query
SELECT product FROM product WHERE max_page_size = 'A4' AND pages_per_minute_color < 5;

/*
Prediction Result:
('LaserJet Pro',)
('DeskJet Basic',)
('DeskJet Basic',)
*/