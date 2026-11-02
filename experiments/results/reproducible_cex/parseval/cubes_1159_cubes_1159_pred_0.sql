-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483648, 'pro_6731a8', '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483647, 'pro_6731a8', 'hria2ypu', 882.963176, 841.297061, 'rwbbp', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483646, 'pro_6731a8', 'luhvdltti', 182.319045, 998.421621, 'prmd', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483645, 'pro_6731a8', 'posiie5unw6k', 768.216462, 83.204633, '9', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483644, 'pro_6731a8', '00t5c4e', 950.466571, 796.740316, 'gce', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483643, 'pro_6731a8', '76nium52', 816.814398, 396.776796, 'uo4nrqrofqy', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483642, 'pro_6731a8', '5s5b', 22.720462, 990.777211, '02eutliqa11r', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483641, 'pro_6731a8', 'ytoo3o9', 111.926013, 731.301441, '72klex14ji7z', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483640, 'pro_6731a8', 'au2dwy', 278.010437, 433.533777, 'pyu78d99', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483639, NULL, 'ljsl0', 27.036693, 884.000446, 'p5qi2rkf9v', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483638, NULL, 'x58pz', 410.133844, 88.474525, '8jegd21vy9ux', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483637, NULL, 'j4hwbdvlph', 439.200238, 795.815869, 'dqwn', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483636, 'pro_6731a8', 'cx5hn', 41.944398, 242.407667, 'tu0', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483635, 'pro_6731a8', 'z', 521.610309, 654.674676, 'jg', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483634, 'pro_6731a8', '8n2f3', 687.701166, 656.638403, 'qv0gcb98oz', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483633, 'pro_6731a8', '3zb', 138.057338, 728.712934, 'kn6vc', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483632, 'pro_6731a8', '6ah', 418.948509, 532.326819, 'wwlq7', 'pro_3eec04');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483631, 'pro_6731a8', 'xb72fxa7ryfd', 276.61064, 399.319982, '16nijjai5dh', 'pro_3eec04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product FROM (SELECT interface, product, COUNT(*) AS n FROM product GROUP BY interface, product) WHERE (n <= 1) ORDER BY product;

/*
Gold Result:
*/

-- Prediction Query
SELECT product FROM product WHERE product <> (SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1);

/*
Prediction Result:
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
('pro_6731a8',)
*/