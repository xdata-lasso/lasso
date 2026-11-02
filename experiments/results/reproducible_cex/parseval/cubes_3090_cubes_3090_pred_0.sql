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
INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483648, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1, 1, 1, 1, 1, 'lhs_0dca33', 'lhs_2755cd', 1.0, 1.0, 1.0, 'lhs_571892', 'lhs_3390b8', 'lhs_dbff29', 'lhs_c33427');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483646, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483645, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483644, 1, 1, 1, 1, 'cat_cd033b', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_7b0a0b', 'cat_f98437', 'cat_d2d167', 'cat_2d94a3');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483643, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483642, 1, 1, 1, 1, 'rhs_8f26b7', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_a69095', 'rhs_a7459c', 'rhs_d3653e', 'rhs_478622');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483641, 1, NULL, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483640, 1, NULL, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483639, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', NULL, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483638, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', NULL, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483637, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, NULL, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483636, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, NULL, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483635, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', NULL, 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483634, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', NULL, 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483633, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, NULL, 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483632, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, NULL, 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483631, 1, 1, 1, 1, NULL, 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483630, 1, 1, 1, 1, NULL, 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483629, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, NULL, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483628, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, NULL, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483627, 1, 1, 1, 1, 'cat_0a955c', NULL, 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483626, 1, 1, 1, 1, 'rhs_e401c9', NULL, 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483625, 1, 1, NULL, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483624, 1, 1, NULL, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483623, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', NULL, 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483622, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', NULL, 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483621, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', NULL);

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483620, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', NULL);

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483619, 1, 1, 1, 1, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483618, 1, 1, 1, 1, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483617, 1, 1, 1, NULL, 'cat_0a955c', 'cat_a977e5', 1.0, 1.0, 1.0, 'cat_ce2807', 'cat_cb666f', 'cat_8908b3', 'cat_d39f52');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483616, 1, 1, 1, NULL, 'rhs_e401c9', 'cat_a977e5', 1.0, 1.0, 1.0, 'rhs_b12976', 'rhs_940833', 'rhs_1e539d', 'rhs_40030f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.catalog_level_number AS catalog_level_number_other, RHS.parent_entry_id AS parent_entry_id_other, RHS.previous_entry_id AS previous_entry_id_other, RHS.next_entry_id AS next_entry_id_other, RHS.catalog_entry_name AS catalog_entry_name_other, RHS.price_in_dollars AS price_in_dollars_other, RHS.price_in_euros AS price_in_euros_other, RHS.price_in_pounds AS price_in_pounds_other, RHS.capacity AS capacity_other, RHS.length AS length_other, RHS.height AS height_other, RHS.width AS width_other FROM catalog_contents AS LHS INNER JOIN catalog_contents AS RHS ON (LHS.previous_entry_id = RHS.catalog_entry_id AND LHS.product_stock_number = RHS.product_stock_number)) ORDER BY catalog_entry_name;

/*
Gold Result:
('lhs_0dca33',)
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY price_in_dollars DESC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('cat_0a955c',)
*/