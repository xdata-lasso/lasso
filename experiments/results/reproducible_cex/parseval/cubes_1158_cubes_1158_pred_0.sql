-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (1, 'pro_d3e14f', '5k5swwqcgs', 171.746906, 5.0, NULL, 'n8c4pgu7v');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (2, 'pro_d3e14f', 'e4', 779.409124, 5.0, NULL, 'hria2ypuzhs');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (3, 'rwbbp6luhvd', 'tti', 182.319045, 998.421621, 'A4', 'prmd');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (4, 'posiie5unw6k', 'fa9', 877.276439, 5.0, 'A4', '00t5c4ecigc');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (5, 'e376nium52', 'zbuo4nrqrof', 586.906897, NULL, 'A4', 'p5s5bbp');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (6, '02eutliqa11r', 'ytoo3o9', 111.926013, 5.0, 'pro_d7a8f6', '72klex14ji7z');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (7, 'au2dwy', 'q13py', 326.912005, 1.0, 'pro_d7a8f6', 'd99rljsl0');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (8, '4', 'p5qi2rk', 811.601922, NULL, 'pro_d7a8f6', '9v');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (9, 'x58pz', 'f8jegd2', 890.091601, 1.0, NULL, 'y9uxj4');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (10, 'wb', 'v', 185.427628, NULL, NULL, 'h2gn');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (11, NULL, 'q', 345.35543, 5.0, NULL, 'cx5hn');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product" FROM "product" WHERE ("max_page_size" = 'A4' OR pages_per_minute_color = 5.0) ORDER BY product, product.product_id NULLS LAST;

/*
Gold Result:
(None,)
('02eutliqa11r',)
('e376nium52',)
('posiie5unw6k',)
('pro_d3e14f',)
('pro_d3e14f',)
('rwbbp6luhvd',)
*/

-- Prediction Query
SELECT product FROM product WHERE max_page_size = 'A4' OR pages_per_minute_color < 5;

/*
Prediction Result:
('rwbbp6luhvd',)
('posiie5unw6k',)
('e376nium52',)
('au2dwy',)
('x58pz',)
*/