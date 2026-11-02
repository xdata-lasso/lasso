-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483648, '5k5swwqcgs', '9n8', 1.0, 874.871895, 'pro_b949ad', 'pgu7vfe4');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483647, 'hria2ypuzhs', 'rwbbp6luhvd', 1.0, 179.378884, 'pro_b949ad', 'ilbnp');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483646, 'mdpos', 'ie5', 1.0, 327.753528, 'pro_b949ad', 'w6kl');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483645, 'a9', '00t5c4e', 1.0, 950.466571, 'pro_b949ad', 'i');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483644, 'gce376nium52', 'zbuo4nrqrof', 1.0, 586.906897, 'pro_b949ad', 'p5s5bbp');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483643, '02eutliqa11r', 'ytoo3o9', 1.0, 111.926013, 'pro_b949ad', '72klex14ji7z');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483642, 'au2dwy', 'q13py', 1.0, 326.912005, 'pro_b949ad', 'd99rljsl0');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483641, '4', 'p5qi2rk', 1.0, 811.601922, 'pro_b949ad', '9v');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483640, 'x58pz', 'f8jegd2', 1.0, 890.091601, 'pro_b949ad', 'y9uxj4');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483639, 'wb', 'v', 1.0, 185.427628, NULL, 'h2gn');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483638, 'q', 'nqcx5h', 1.0, 210.05299, NULL, 'rjtu');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483637, 'dz79fjg', '8n2f3', 1.0, 687.701166, NULL, 'qv0gcb98ozk');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483636, 'zbilyrkn', '6vck6ah0f8js', NULL, 346.706184, 'pro_b949ad', 'q7x');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483635, '7', '2fxa7ryfdrz', NULL, 753.351134, 'pro_b949ad', '6nijjai');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483634, 'dh5ogrgj', '8', NULL, 740.059813, 'pro_b949ad', 'zt1afgo');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483633, 'ri', 'tsj3ayxp1q4', 1.0, 457.141778, 'pro_b949ad', '1jh3den');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483632, 'c68x8vacx', 'afu5w1of7', 1.0, 517.927187, 'pro_b949ad', 'o72ctdc');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483631, 'mfg62', '0v', 1.0, 492.883123, 'pro_b949ad', 'q8qdjpe1io22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT max_page_size FROM (SELECT dpi, max_page_size, COUNT(*) AS n FROM product GROUP BY dpi, max_page_size) WHERE (n >= 3) ORDER BY max_page_size;

/*
Gold Result:
(None,)
('pro_b949ad',)
('pro_b949ad',)
*/

-- Prediction Query
SELECT max_page_size FROM product GROUP BY max_page_size HAVING COUNT(*) > 3;

/*
Prediction Result:
('pro_b949ad',)
*/