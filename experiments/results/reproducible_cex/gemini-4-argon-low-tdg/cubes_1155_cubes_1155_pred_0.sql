-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for n >= 3 (n = 2, n = 3, n = 4) and ORDER BY max_page_size.
-- Kills mutants changing >= 3 to > 3, = 3, >= 2, <= 3, or omitting/reversing ORDER BY.
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (1, 'P1', '10x10', 300.0, 10.0, 'B5', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (2, 'P2', '10x10', 300.0, 12.0, 'B5', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (3, 'P3', '10x10', 300.0, 15.0, 'B5', 'WiFi');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (4, 'P4', '20x20', 600.0, 20.0, 'A4', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (5, 'P5', '20x20', 600.0, 20.0, 'A4', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (6, 'P6', '20x20', 600.0, 25.0, 'A4', 'WiFi');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (7, 'P7', '20x20', 600.0, 30.0, 'A4', 'Ethernet');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (8, 'P8', '15x15', 1200.0, 5.0, 'A3', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (9, 'P9', '15x15', 1200.0, 5.0, 'A3', 'USB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT max_page_size FROM (SELECT dpi, max_page_size, COUNT(*) AS n FROM product GROUP BY dpi, max_page_size) WHERE (n >= 3) ORDER BY max_page_size;

/*
Gold Result:
('A4',)
('B5',)
*/

-- Prediction Query
SELECT max_page_size FROM product GROUP BY max_page_size HAVING COUNT(*) > 3;

/*
Prediction Result:
('A4',)
*/