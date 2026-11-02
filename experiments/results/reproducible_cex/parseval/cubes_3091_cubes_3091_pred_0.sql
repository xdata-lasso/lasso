-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: catalog_structure --
INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (1, -2147483648, 'cat_32a601');

-- Inserting into table: catalogs --
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483648, 'cat_f063e6', 'cat_c1feab', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: catalog_contents --
INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1, 1, 1, 1, 1, 'cat_0a955c', 'cat_5e062f', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_9b3043', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483647, 1, 1, 1, 1, 'cat_cd033b', 'cat_aa23e4', 1.0, 1.0, 1.0, 'cat_7b0a0b', 'cat_f98437', 'cat_9b3043', 'cat_2d94a3');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (2, 1, -664303813, -1022641847, -1726781632, 'cat_aecbf5', 'cat_a977e5', 171.746906, 557.512061, 868.436572, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (3, 1, -106629402, 1871297066, 809183447, 'cat_aecbf5', 'cat_a977e5', 520.784135, 86.520366, 65.761562, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (4, 1, -992890117, 1914020640, 1268590800, 'cat_aecbf5', 'cat_a977e5', 378.476082, 783.93201, 718.397869, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (5, 1, 1644814318, 1465859724, -1349201381, 'cat_aecbf5', 'cat_a977e5', 737.440743, 334.878198, 55.194297, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (6, 1, -841692980, -1364429300, -1257178728, 'cat_aecbf5', 'cat_a977e5', 787.938887, 986.066566, 666.330692, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (7, 1, -1137908826, -918961358, -1602639011, 'cat_aecbf5', 'cat_a977e5', 489.397796, 933.422701, 345.718563, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (8, 1, 1151980946, 1620389964, 546571701, 'cat_aecbf5', 'cat_a977e5', 801.414196, 890.762259, 720.527846, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (9, 1, 1408123494, -1964997180, 1149850321, 'cat_aecbf5', 'cat_a977e5', 44.682291, 73.182847, 517.275698, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (10, 1, 1313172851, -761141909, 283598170, 'cat_aecbf5', 'cat_a977e5', 452.706544, 672.826911, 21.917736, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (11, 1, -1179823637, 1119186446, 781505063, 'cat_aecbf5', 'cat_a977e5', 597.420508, 220.906948, 82.05602, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (12, 1, -472966518, -921187550, -2070843029, 'cat_aecbf5', 'cat_a977e5', 797.364011, 236.803246, 415.205312, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (13, 1, -1822992503, -868774469, -1068298341, 'cat_aecbf5', 'cat_a977e5', 427.383654, 426.853398, 997.73177, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (14, 1, -188151580, 226938182, 90119032, 'cat_aecbf5', 'cat_a977e5', 958.92567, 164.991544, 74.250383, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (15, 1, 1775126557, -74849714, 105869088, 'cat_aecbf5', 'cat_a977e5', 353.163664, 15.406045, 712.264292, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name_other AS catalog_entry_name FROM (SELECT catalog_level_number AS catalog_entry_id, catalog_level_number, parent_entry_id, previous_entry_id, next_entry_id, catalog_entry_name, product_stock_number, price_in_dollars, price_in_euros, price_in_pounds, capacity, LENGTH, height, width, catalog_level_number_other, parent_entry_id_other, previous_entry_id_other, next_entry_id_other, catalog_entry_name_other, product_stock_number_other, price_in_dollars_other, price_in_euros_other, price_in_pounds_other, capacity_other, length_other, width_other FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.catalog_level_number AS catalog_level_number_other, RHS.parent_entry_id AS parent_entry_id_other, RHS.previous_entry_id AS previous_entry_id_other, RHS.next_entry_id AS next_entry_id_other, RHS.catalog_entry_name AS catalog_entry_name_other, RHS.product_stock_number AS product_stock_number_other, RHS.price_in_dollars AS price_in_dollars_other, RHS.price_in_euros AS price_in_euros_other, RHS.price_in_pounds AS price_in_pounds_other, RHS.capacity AS capacity_other, RHS.length AS length_other, RHS.width AS width_other FROM catalog_contents AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.catalog_level_number = RHS.catalog_entry_id AND LHS.capacity = RHS.height))) ORDER BY catalog_entry_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY capacity ASC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('cat_aecbf5',)
*/