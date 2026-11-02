-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (1, 'Z_Printer', '10x10', 300.0, 2.0, 'A4', 'USB');
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (2, 'A_Printer', '10x10', 300.0, 2.0, 'A4', 'USB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product" FROM "product" WHERE ("max_page_size" = 'A4' AND pages_per_minute_color < 5.0) ORDER BY product, product.product_id NULLS LAST;

/*
Gold Result:
('A_Printer',)
('Z_Printer',)
*/

-- Prediction Query
SELECT product FROM product WHERE max_page_size = 'A4' AND pages_per_minute_color < 5;

/*
Prediction Result:
('Z_Printer',)
('A_Printer',)
*/