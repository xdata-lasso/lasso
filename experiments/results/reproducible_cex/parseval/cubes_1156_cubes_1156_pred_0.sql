-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483648, '5k5swwqcgs', '9n8', 1.0, 874.871895, 'pgu7vfe4', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483647, 'hria2ypuzhs', 'rwbbp6luhvd', 1.0, 179.378884, 'ilbnp', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483646, 'mdpos', 'ie5', 1.0, 327.753528, 'w6kl', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483645, 'a9', '00t5c4e', 1.0, 950.466571, 'i', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483644, 'gce376nium52', 'zbuo4nrqrof', 1.0, 586.906897, 'p5s5bbp', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483643, '02eutliqa11r', 'ytoo3o9', 1.0, 111.926013, '72klex14ji7z', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483642, 'au2dwy', 'q13py', 326.912005, 798.947629, '9', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483641, 'rljsl0b4y', 'p5qi2rkf9v', 1.0, NULL, 'x58pz', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483640, 'f8jegd2', 'vy9uxj4', 1.0, NULL, 'wb', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483639, 'v', 'ph2', 1.0, NULL, 'nd', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483638, 'wnqcx', '5hncprjtu0d', NULL, 395.809081, 'fjgq8n2f3', 'dqv0gcb98ozk');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483637, 'zbilyrkn', '6vck6ah0f8js', NULL, NULL, 'wlq7xb', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483636, '72fxa7ryfd', 'z16ni', NULL, NULL, 'jai', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483635, 'dh5ogrgj', '8', NULL, NULL, 'yzt1afgogrit', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483634, 'sj3ayxp1q430', 'jh3den8', 1.0, NULL, 'c68x8vacx7', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483633, 'f', '5w1of7', 1.0, NULL, 'pzo72ctdc', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483632, 'mfg62', '0v', 1.0, NULL, 'q8qdjpe1', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483631, 'o22', '8507cvtjp', 1.0, NULL, 'ttg6bnou5zi3', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483630, 'c4bfkfoac', '0', 1.0, NULL, '7z2zezjo7wg', 'pro_964a1b');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483629, 'd5ysxc', 'r0oz', 1.0, NULL, 'dgj5i', 'pro_964a1b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanpages_per_minute_color AS avg_pages_per_minute_color_ FROM (SELECT dpi, interface, AVG(pages_per_minute_color) AS meanpages_per_minute_color FROM product GROUP BY dpi, interface) ORDER BY avg_pages_per_minute_color_;

/*
Gold Result:
(None,)
(None,)
(395.809081,)
(505.21729799999997,)
(798.947629,)
*/

-- Prediction Query
SELECT AVG(pages_per_minute_color) FROM product;

/*
Prediction Result:
(528.25756225,)
*/