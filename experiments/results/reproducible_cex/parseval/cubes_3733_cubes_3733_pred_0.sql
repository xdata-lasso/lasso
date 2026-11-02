-- Schema DDL
CREATE TABLE "product" ("product_id" INTEGER PRIMARY KEY, "product" TEXT, "dimensions" TEXT, "dpi" REAL, "pages_per_minute_color" REAL, "max_page_size" TEXT, "interface" TEXT);

CREATE TABLE "store" ("Store_ID" INTEGER PRIMARY KEY, "Store_Name" TEXT, "Type" TEXT, "Area_size" REAL, "Number_of_product_category" REAL, "Ranking" INTEGER);

CREATE TABLE "district" ("District_ID" INTEGER PRIMARY KEY, "District_name" TEXT, "Headquartered_City" TEXT, "City_Population" REAL, "City_Area" REAL);

CREATE TABLE "store_product" ("Store_ID" INTEGER, "Product_ID" INTEGER, PRIMARY KEY ("Store_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "product" ("Product_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

CREATE TABLE "store_district" ("Store_ID" INTEGER PRIMARY KEY, "District_ID" INTEGER, FOREIGN KEY ("District_ID") REFERENCES "district" ("District_ID"), FOREIGN KEY ("Store_ID") REFERENCES "store" ("Store_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (2, 'pro_365dbc', '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe', 'hria2ypu');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (3, 'pro_365dbc', 'hsrwbbp', 503.083789, 320.851235, 'vd', 'tti');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483648, 'bnp', 'mdpos', 133.007885, 75.403642, 'pro_0581fe', 'nw6klf');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483645, 'a9000t5c4eci', 'gce376nium52', 816.814398, 396.776796, 'pro_0581fe', 'uo4nrqrofqy');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483644, '5s5b', 'p', 705.580387, 673.065986, 'pro_0581fe', 'eutliqa11r');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483643, 'pro_365dbc', 'ytoo3o9', 111.926013, 731.301441, '72klex14ji7z', 'au2dwy');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483642, 'q13py', '78d99r', 182.777264, 943.791649, '1', 'l0b4y');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483641, 'p5qi2rkf9v', 'x58pz', 410.133844, 88.474525, 'C', '8jegd21vy9ux');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483640, 'pro_365dbc', 'j4hwbdvlph', 439.200238, 795.815869, 'dqwn', 'cx5hn');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483639, 'p', 'jtu0d', 395.809081, 552.472052, '9', 'fjgq8n2f3d');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483638, 'qv0gcb98ozk', 'zbilyrkn', 692.775559, 339.789525, '!', '6ah');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483637, 'pro_365dbc', 'f8jswwl', 260.513699, 969.559316, 'xb72fxa7ryfd', 'z16ni');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483636, 'jai', 'dh5ogrgj', 54.980195, 958.424773, 'C', 'yzt1afgogrit');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483635, 'sj3ayxp1q430', 'jh3den8', 596.764785, 46.611179, 'A', '68x8vacx7afu');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483634, 'pro_365dbc', 'w1of77pz', 224.624401, 985.639995, '2ctdctmfg', '2g0v5q8qd');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483633, 'jpe1io22785', '7cvtjpt', 605.666938, 107.390057, 'pro_0581fe', 'n');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483632, 'u5zi', '6c4bfkfo', 12.330671, 774.96573, 'pro_0581fe', 'd');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483631, '7z2zezj', '7wgx', 50.798088, 486.564401, 'pro_0581fe', 'xcmr0');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483630, NULL, 'ztdg', 145.027285, 495.31632, 'lq5lnpim', 'k58qs27p');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483629, NULL, 'r94gth2m', 925.474843, 211.248782, 'pro_0581fe', 'ajjla3okv8');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483628, NULL, 'uttmu2ne578', 944.379011, 86.586744, 'pro_0581fe', 'yz7zzb');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483627, NULL, '8y', 335.639672, 743.007715, 'pro_0581fe', '42q7sx58b4');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483626, 'pro_365dbc', 'pmaus3auvmkr', 641.973572, 49.701386, NULL, 'wzw5chn9mo70');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483625, 'a9n0jxfo', 'ws', 900.422166, 55.294573, NULL, '2zob');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483624, '0', '0k32o', 57.929422, 38.169466, NULL, '5am');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483623, 'sorlwyngc1', 'j', 821.485286, 549.267866, NULL, 'rhizgk1yoey');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483622, 'pro_365dbc', 'o6l0hdt6fu', 254.178165, 388.909559, 'uzkb521gwnl', 's');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483621, 'elboeowii', 'z5nxih6', 946.669761, 441.511648, 'pro_0581fe', 'xlyotow9');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483620, 'aawg', '6aqb0tbin', 58.176945, 466.613431, 'pro_0581fe', 'ajz9t');

INSERT INTO "product" ("product_id", "product", "dimensions", "dpi", "pages_per_minute_color", "max_page_size", "interface") VALUES (-2147483619, '8', '5wcg', 314.953709, 30.758515, 'pro_0581fe', '3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product FROM (SELECT product_id, product, dimensions, dpi, pages_per_minute_color, max_page_size, interface, COUNT(*) OVER () AS n FROM product) ORDER BY product;

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
('0',)
('5s5b',)
('7z2zezj',)
('8',)
('a9000t5c4eci',)
('a9n0jxfo',)
('aawg',)
('bnp',)
('elboeowii',)
('jai',)
('jpe1io22785',)
('p',)
('p5qi2rkf9v',)
('pro_365dbc',)
('pro_365dbc',)
('pro_365dbc',)
('pro_365dbc',)
('pro_365dbc',)
('pro_365dbc',)
('pro_365dbc',)
('pro_365dbc',)
('q13py',)
('qv0gcb98ozk',)
('sj3ayxp1q430',)
('sorlwyngc1',)
('u5zi',)
*/

-- Prediction Query
SELECT product FROM product WHERE product <> (SELECT max_page_size FROM product GROUP BY max_page_size ORDER BY COUNT(*) DESC, max_page_size NULLS LAST LIMIT 1);

/*
Prediction Result:
('bnp',)
('a9000t5c4eci',)
('5s5b',)
('pro_365dbc',)
('q13py',)
('p5qi2rkf9v',)
('pro_365dbc',)
('p',)
('qv0gcb98ozk',)
('pro_365dbc',)
('jai',)
('sj3ayxp1q430',)
('pro_365dbc',)
('jpe1io22785',)
('u5zi',)
('7z2zezj',)
('pro_365dbc',)
('a9n0jxfo',)
('0',)
('sorlwyngc1',)
('pro_365dbc',)
('elboeowii',)
('aawg',)
('8',)
('pro_365dbc',)
('pro_365dbc',)
*/