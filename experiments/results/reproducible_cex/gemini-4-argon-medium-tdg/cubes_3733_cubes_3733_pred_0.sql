-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out of insertion order), duplicate product names (kills DISTINCT / GROUP BY), and columns having different ordering directions than 'product'.
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (1, 'Zebra Printer', '10x10', 100.0, 5.0, 'A5', 'USB');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (2, 'Alpha Scanner', '30x30', 600.0, 20.0, 'A3', 'Wi-Fi');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (3, 'Beta Copier', '20x20', 300.0, 10.0, 'A4', 'Ethernet');
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (4, 'Alpha Scanner', '15x15', 1200.0, 15.0, 'Letter', 'Bluetooth');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product FROM (SELECT product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface, COUNT(*) OVER () AS n FROM product) ORDER BY product;

/*
Gold Result:
('Alpha Scanner',)
('Alpha Scanner',)
('Beta Copier',)
('Zebra Printer',)
*/

-- Prediction Query
SELECT product FROM product WHERE product <> (SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1);

/*
Prediction Result:
('Zebra Printer',)
('Alpha Scanner',)
('Beta Copier',)
('Alpha Scanner',)
*/