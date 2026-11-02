-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (5, 'default2', 'default2', 0.0, 4.0, 'A4', 'A4'), (0, 'default1', NULL, 4.0, 0.0, 'default1', NULL), (4, NULL, 'default2', NULL, 1.0, 'default1', NULL), (1, NULL, NULL, 4.0, NULL, 'default2', 'default1'), (6, 'A4', 'default2', 6.0, NULL, NULL, 'A4'), (2, 'A4', NULL, 1.0, 5.0, 'default2', 'default2'), (3, 'default2', NULL, 1.0, 4.0, 'default2', 'default1'), (7, 'default2', NULL, NULL, NULL, 'default1', NULL), (8, NULL, 'default2', 1.0, 4.0, NULL, 'default1'), (9, 'default2', 'default1', 4.0, 5.0, 'A4', NULL), (10, 'default2', 'A4', NULL, 6.0, 'A4', 'default1'), (11, 'default1', 'A4', 1.0, 0.0, 'A4', NULL), (12, NULL, 'default2', 1.0, 1.0, NULL, 'default1'), (13, 'A4', NULL, 1.0, 5.0, NULL, NULL), (14, 'default1', 'default2', 1.0, 4.0, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product" FROM "product" WHERE ("max_page_size" = 'A4' AND pages_per_minute_color < 5.0) ORDER BY product, product.product_id NULLS LAST;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT product FROM product WHERE max_page_size = 'A4' AND pages_per_minute_color < 5;

/*
Prediction Result:
('default2',)
('default1',)
*/