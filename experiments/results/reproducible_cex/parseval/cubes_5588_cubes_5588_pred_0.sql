-- Schema DDL
CREATE TABLE "Attribute_Definitions" ("attribute_id" INTEGER PRIMARY KEY, "attribute_name" TEXT(30), "attribute_data_type" TEXT(10));

CREATE TABLE "Catalogs" ("catalog_id" INTEGER PRIMARY KEY, "catalog_name" TEXT(50), "catalog_publisher" TEXT(80), "date_of_publication" DATETIME, "date_of_latest_revision" DATETIME);

CREATE TABLE "Catalog_Structure" ("catalog_level_number" INTEGER PRIMARY KEY, "catalog_id" INTEGER, "catalog_level_name" TEXT(50), FOREIGN KEY ("catalog_id") REFERENCES "Catalogs" ("catalog_id"));

CREATE TABLE "Catalog_Contents" ("catalog_entry_id" INTEGER PRIMARY KEY, "catalog_level_number" INTEGER, "parent_entry_id" INTEGER, "previous_entry_id" INTEGER, "next_entry_id" INTEGER, "catalog_entry_name" TEXT(80), "product_stock_number" TEXT(50), "price_in_dollars" REAL, "price_in_euros" REAL, "price_in_pounds" REAL, "capacity" TEXT(20), "length" TEXT(20), "height" TEXT(20), "width" TEXT(20), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"));

CREATE TABLE "Catalog_Contents_Additional_Attributes" ("catalog_level_number" INTEGER, "catalog_entry_id" INTEGER, "attribute_id" INTEGER, "attribute_value" TEXT(255), FOREIGN KEY ("catalog_level_number") REFERENCES "Catalog_Structure" ("catalog_level_number"), FOREIGN KEY ("catalog_entry_id") REFERENCES "Catalog_Contents" ("catalog_entry_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: catalog_structure --
INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (-2147483648, -2147483648, 'cat_32a601');

INSERT INTO "catalog_structure" ("catalog_level_number", "catalog_id", "catalog_level_name") VALUES (1, -2147483648, 'cat_32a601');

-- Inserting into table: catalogs --
INSERT INTO "catalogs" ("catalog_id", "catalog_name", "catalog_publisher", "date_of_publication", "date_of_latest_revision") VALUES (-2147483648, 'cat_f063e6', 'cat_c1feab', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: catalog_contents --
INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483648, -2147483648, -55602865, -59984348, 1, 'cat_aecbf5', 'cat_a977e5', 345.329712, 1.0, 833.684115, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483647, -2147483648, -1981402255, -890215420, 1, 'cat_aecbf5', 'cat_a977e5', 572.766956, 1.0, 206.939346, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483646, -2147483648, -106629402, 1871297066, 1, 'cat_aecbf5', 'cat_a977e5', 688.4027, 1.0, 520.784135, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (1, 1, 1, 1, 1, 'lhs_33f36c', 'lhs_21814e', 1.0, 1.0, 1.0, 'lhs_3bea26', 'lhs_11a9fb', 'lhs_41bcad', 'lhs_b3198b');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483644, -2147483648, -1633151678, -252690330, 1, 'cat_aecbf5', 'cat_a977e5', 797.015047, 1.0, 241.913711, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483643, 1, 1644814318, 1465859724, 1, 'cat_aecbf5', 'cat_a977e5', 294.861575, 1.0, 268.234631, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483642, 1, 1908028688, 2122220075, 1, 'cat_aecbf5', 'cat_a977e5', 749.826493, 1.0, 503.083789, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483641, 1, 1019800248, -1910425938, -845863578, 'cat_aecbf5', 'cat_a977e5', 125.12763, 22.535764, 600.048938, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', NULL);

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483640, -2147483648, 1236688122, 2087640001, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 666.330692, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', NULL);

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483639, -2147483648, -1137908826, -918961358, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 126.856521, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', NULL);

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483638, 1, -1209887326, -1399556171, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 741.842896, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', NULL);

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483637, 1, 546571701, 947159877, 1990080517, 'cat_aecbf5', 'cat_a977e5', 827.854302, 983.124993, 828.555322, NULL, 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483636, -2147483648, 700088193, 374105386, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 950.466571, NULL, 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483635, -2147483648, -1683203397, 528680845, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 467.07027, NULL, 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483634, -2147483648, 1313172851, -761141909, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 779.28645, NULL, 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483633, 1, 742285925, -747753377, 902887186, 'cat_aecbf5', 'cat_a977e5', 979.158161, 250.982945, 274.680042, 'cat_5602f9', 'cat_c1680e', NULL, 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483632, -2147483648, 373262291, -472966518, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 488.977171, 'cat_5602f9', 'cat_c1680e', NULL, 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483631, 1, 902551284, 2107872094, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 705.580387, 'cat_5602f9', 'cat_c1680e', NULL, 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483630, 1, -1822992503, -868774469, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 138.017996, 'cat_5602f9', 'cat_c1680e', NULL, 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483629, 1, -2118135981, 2074205376, 274769912, 'cat_aecbf5', 'cat_a977e5', 300.875654, 737.540744, 223.509572, 'cat_5602f9', NULL, 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483628, -2147483648, 1644911394, -1666765085, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 731.301441, 'cat_5602f9', NULL, 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483627, 1, -1438850342, -305670381, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 144.777217, 'cat_5602f9', NULL, 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483626, 1, -2081315180, 1909986641, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 845.831524, 'cat_5602f9', NULL, 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483625, 1, -953437896, -1097120355, 244829661, 'cat_aecbf5', 'cat_a977e5', 182.777264, NULL, 943.791649, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483624, 1, -1372125820, -2031361952, 1, 'cat_aecbf5', 'cat_a977e5', NULL, NULL, 884.000446, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483623, -2147483648, -1025564911, -227162283, 1, 'cat_aecbf5', 'cat_a977e5', NULL, NULL, 164.583726, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483622, -2147483648, 222415430, 556727997, 1, 'cat_aecbf5', 'cat_a977e5', NULL, NULL, 860.770887, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483621, 1, 1836127587, -1529584866, 1196308825, 'cat_aecbf5', 'cat_a977e5', NULL, 712.084197, 452.27611, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483620, 1, -688509700, -792092619, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 585.18838, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483619, -2147483648, -87647544, -629784617, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 50.647649, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483618, -2147483648, 2103044118, -1642259219, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 109.083092, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483617, -2147483648, 1968874827, -664193365, -1070063173, 'cat_aecbf5', 'cat_a977e5', 629.317167, 668.309685, NULL, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483616, -2147483648, -1245312912, 1575412235, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, NULL, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483615, 1, -1509264256, -792947627, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, NULL, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483614, -2147483648, 401805964, -1485777725, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, NULL, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483613, 1, 894242932, -211209314, NULL, 'cat_aecbf5', 'cat_a977e5', 456.127515, 52.895335, 632.477228, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483612, 1, -688216274, 331812443, NULL, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 790.551139, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483611, -2147483648, 1631231566, 172461907, NULL, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 874.028321, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483610, -2147483648, -155284187, 1686459626, NULL, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 138.057338, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483609, 1, 638024588, -688098735, 1784916884, NULL, 'cat_a977e5', 508.771546, 591.134092, 694.345982, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483608, 1, -1520489792, -658391922, 1, NULL, 'cat_a977e5', NULL, 1.0, 176.824244, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483607, 1, -541746689, 1294666887, 1, NULL, 'cat_a977e5', NULL, 1.0, 379.883722, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483606, -2147483648, 564390026, -1259474148, 1, NULL, 'cat_a977e5', NULL, 1.0, 968.276986, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483605, -2147483648, NULL, -2115841792, 1746373317, 'cat_aecbf5', 'cat_a977e5', 62.386264, 816.712865, 488.601669, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483604, -2147483648, NULL, 1449284300, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 272.414976, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483603, -2147483648, NULL, -458359144, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 639.801051, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483602, -2147483648, NULL, -1794176801, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 221.842983, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483601, 1, 710458518, 678047687, -1478134144, 'cat_aecbf5', 'cat_a977e5', 15.432127, 385.461721, 239.245131, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483600, 1, 1792827279, 804529642, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 457.141778, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483599, 1, 1923912467, 518609210, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 123.184903, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483598, 1, 1476361420, 195720193, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 897.348977, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483597, -2147483648, 2035306060, NULL, 1523825314, 'cat_aecbf5', 'cat_a977e5', 983.924121, 313.653498, 489.044661, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483596, 1, 765724008, NULL, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 528.552305, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483595, -2147483648, -435350511, NULL, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 689.065203, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483594, 1, -1957268147, NULL, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 51.002063, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483593, 1, -1284905200, 7929158, -1744557630, 'cat_aecbf5', NULL, 935.463334, 492.883123, 691.147113, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483592, 1, -1488156735, -1858644047, 1, 'cat_aecbf5', NULL, NULL, 1.0, 140.053935, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483591, -2147483648, -241848752, 2004147439, 1, 'cat_aecbf5', NULL, NULL, 1.0, 338.933701, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483590, -2147483648, -847293924, -2033879835, 1, 'cat_aecbf5', NULL, NULL, 1.0, 918.655561, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483589, 1, -29242208, 1691780814, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 464.719657, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483588, -2147483648, 1722106924, -2072838897, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 166.297151, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483587, -2147483648, 1923659053, -1950324754, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 992.626961, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483586, 1, -253138337, 641521863, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 147.932394, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483585, -2147483648, -604098478, 1248858185, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 50.798088, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (-2147483584, 1, -526612570, -546516406, 1, 'cat_aecbf5', 'cat_a977e5', NULL, 1.0, 187.71278, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (2, 1, 983324983, 1269522000, 853709925, 'cat_aecbf5', 'cat_a977e5', 297.258735, 104.37745, 703.796681, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');

INSERT INTO "catalog_contents" ("catalog_entry_id", "catalog_level_number", "parent_entry_id", "previous_entry_id", "next_entry_id", "catalog_entry_name", "product_stock_number", "price_in_dollars", "price_in_euros", "price_in_pounds", "capacity", "length", "height", "width") VALUES (3, -2147483648, -176606723, -15162884, 1339733032, 'cat_aecbf5', 'cat_a977e5', 236.262879, 137.487391, 487.138399, 'cat_5602f9', 'cat_c1680e', 'cat_9b3043', 'cat_9d29d0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT catalog_entry_name FROM (SELECT LHS.catalog_entry_id AS catalog_entry_id, LHS.catalog_level_number AS catalog_level_number, LHS.parent_entry_id AS parent_entry_id, LHS.previous_entry_id AS previous_entry_id, LHS.next_entry_id AS next_entry_id, LHS.catalog_entry_name AS catalog_entry_name, LHS.product_stock_number AS product_stock_number, LHS.price_in_dollars AS price_in_dollars, LHS.price_in_euros AS price_in_euros, LHS.price_in_pounds AS price_in_pounds, LHS.capacity AS capacity, LHS.length AS LENGTH, LHS.height AS height, LHS.width AS width, RHS.price_in_euros AS price_in_euros_other FROM catalog_contents AS LHS INNER JOIN (SELECT next_entry_id, price_in_euros, MAX(price_in_dollars) AS price_in_dollars FROM catalog_contents GROUP BY next_entry_id, price_in_euros) AS RHS ON (LHS.catalog_entry_id = RHS.next_entry_id AND LHS.price_in_dollars = RHS.price_in_dollars)) ORDER BY catalog_entry_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT catalog_entry_name FROM catalog_contents ORDER BY price_in_dollars DESC, catalog_contents.catalog_entry_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('cat_aecbf5',)
*/