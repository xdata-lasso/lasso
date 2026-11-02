-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (1, 'Pixma', '40x30x15', 4800.0, 10.0, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (2, 'LaserJet', '38x35x25', 1200.0, 25.0, 'Letter', 'WiFi');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (3, 'LaserJet', '38x35x25', 1200.0, 25.0, 'Letter', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (4, 'DeskJet', '42x30x14', 1200.0, 8.0, 'A4', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (5, 'DeskJet', '45x32x16', 2400.0, 12.0, 'Legal', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (6, 'OfficeJet', '50x40x30', 1200.0, 20.0, 'A3', 'Ethernet');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (7, 'OfficeJet', '50x40x30', 1200.0, 20.0, 'A3', 'Ethernet');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (8, 'OfficeJet', '52x42x32', 2400.0, 22.0, 'A3', 'Ethernet');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product FROM (SELECT interface, product, COUNT(*) AS n FROM product GROUP BY interface, product) WHERE (n <= 1) ORDER BY product;

/*
Gold Result:
('LaserJet',)
('LaserJet',)
('Pixma',)
*/

-- Prediction Query
SELECT product FROM product WHERE product <> (SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1);

/*
Prediction Result:
('Pixma',)
('LaserJet',)
('LaserJet',)
('DeskJet',)
('DeskJet',)
('OfficeJet',)
('OfficeJet',)
('OfficeJet',)
*/