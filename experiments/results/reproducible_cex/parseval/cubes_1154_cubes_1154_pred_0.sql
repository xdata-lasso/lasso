-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483648, 'pro_727995', '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483647, 'pro_727995', 'hsrwbbp', 503.083789, 320.851235, 'vd', 'tti');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483646, 'pro_727995', 'bnp', 787.938887, 986.066566, 'dposiie5unw', 'klfa9000t');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (1, 'lhs_18a7f8', 'lhs_6a622b', 1.0, 1.0, 'lhs_ac8615', 'lhs_3734ab');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483644, 'pro_727995', 'c4ecigce', 467.07027, 875.837169, 'nium52zbu', '4nrq');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483643, 'pro_727995', 'rofqyp5s5b', 22.720462, 990.777211, '02eutliqa11r', 'ytoo3o9');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483642, 'pro_727995', 'l7', 443.457804, 774.422647, 'ex1', 'ji7zwau2');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483641, 'pro_727995', 'dwyrq13pyu78', NULL, 49.538289, 'rljsl0b4y', 'p5qi2rkf9v');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483640, 'pro_727995', 'x58pz', NULL, 410.133844, '8j', 'gd');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483639, 'pro_727995', '1vy9uxj4', NULL, 124.573829, 'd', 'lph2gn');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483638, 'pro_727995', 'q', 345.35543, 250.856497, NULL, 'x5hncprjtu0');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483637, 'pro_727995', 'z', 521.610309, 654.674676, NULL, 'jg');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483636, 'pro_727995', '8n2f3', 687.701166, 656.638403, NULL, 'qv0gcb98oz');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483635, 'pro_727995', '3zb', 138.057338, NULL, 'yrkn6vck6ah0', '8j');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483634, 'pro_727995', 'wwlq7', 786.074668, NULL, 'xb72fxa7ryfd', 'z16ni');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483633, 'pro_727995', 'jai', 906.609226, NULL, 'h', 'ogrgjd8y');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483632, 'pro_727995', 't1afgog', 279.731401, 630.468925, 'sj3ay', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483631, 'pro_727995', 'p1q430', 947.945777, 571.595144, 'jh3den8c68', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483630, 'pro_727995', '8vacx7', 854.793228, 983.924121, '5w1of7', NULL);

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483629, 'pro_727995', NULL, 517.927187, 398.637058, '72ctdctmfg62', '0v');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483628, 'pro_727995', NULL, 492.883123, 691.147113, 'qdjpe1io2', '78507cvt');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483627, 'pro_727995', NULL, 145.3181, 789.724834, 'ttg6bnou5zi3', 'c4bfkfoac');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483626, NULL, '0', 668.776683, 517.925079, 'zezjo7wg', 'd5ysxc');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483625, NULL, 'r0oz', 297.258735, 104.37745, '5i3lq5lnpim5', '58q');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483624, NULL, 's27p2r94gth2', 193.695314, 770.686956, 'ajjla3okv8u', 'tmu2n');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT max_page_size FROM (SELECT LHS.product_id AS product_id, LHS.product AS product, LHS.dimensions AS dimensions, LHS.dpi AS dpi, LHS.pages_per_minute_color AS pages_per_minute_color, LHS.max_page_size AS max_page_size, LHS.interface AS interface FROM product AS LHS INNER JOIN (SELECT product, COUNT(*) AS n FROM product GROUP BY product) AS RHS ON (LHS.product_id = RHS.n AND LHS.product = RHS.product)) ORDER BY max_page_size;

/*
Gold Result:
('lhs_ac8615',)
*/

-- Prediction Query
SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/