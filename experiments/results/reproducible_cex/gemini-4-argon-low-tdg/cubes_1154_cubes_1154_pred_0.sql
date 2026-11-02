-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (1, 'Alpha', '10x10', 300.0, 10.0, 'A5', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (2, 'Alpha', '12x12', 600.0, 15.0, 'B4', 'WiFi');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (3, 'Beta', '14x14', 1200.0, 20.0, 'A4', 'Ethernet');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (4, 'Beta', '16x16', 1200.0, 25.0, 'A3', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (5, 'Beta', '18x18', 2400.0, 30.0, 'Letter', 'WiFi');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (6, 'Gamma', '20x20', 300.0, 5.0, 'Legal', 'Parallel');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT max_page_size FROM (SELECT LHS.product_id AS product_id, LHS.product AS product, LHS.dimensions AS dimensions, LHS.dpi AS dpi, LHS.pages_per_minute_color AS pages_per_minute_color, LHS.max_page_size AS max_page_size, LHS.interface AS interface FROM product AS LHS INNER JOIN (SELECT product, COUNT(*) AS n FROM product GROUP BY product) AS RHS ON (LHS.product_id = RHS.n AND LHS.product = RHS.product)) ORDER BY max_page_size;

/*
Gold Result:
('A4',)
('B4',)
*/

-- Prediction Query
SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1;

/*
Prediction Result:
('A3',)
*/