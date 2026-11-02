-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface) VALUES (4, NULL, 'default2', 0.0, 1.0, NULL, 'default2'), (0, 'default2', 'default1', 3.0, 4.0, 'default1', 'default2'), (3, 'default2', NULL, 2.0, 1.0, 'default1', NULL), (2, 'default1', 'default1', 1.0, NULL, NULL, 'default2'), (1, NULL, NULL, 1.0, 2.0, 'default1', NULL), (5, 'default2', 'default2', 3.0, NULL, 'default2', 'default2'), (6, NULL, 'default1', 4.0, NULL, 'default2', 'default1'), (7, 'default1', 'default1', NULL, 4.0, NULL, 'default1'), (8, 'default2', NULL, 4.0, 1.0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT max_page_size FROM (SELECT dpi, max_page_size, COUNT(*) AS n FROM product GROUP BY dpi, max_page_size) WHERE (n >= 3) ORDER BY max_page_size;

/*
Gold Result:
*/

-- Prediction Query
SELECT max_page_size FROM product GROUP BY max_page_size HAVING COUNT(*) > 3;

/*
Prediction Result:
('default1',)
*/