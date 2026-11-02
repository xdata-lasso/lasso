-- Schema DDL
CREATE TABLE "Ref_Feature_Types" ("feature_type_code" TEXT(20) PRIMARY KEY, "feature_type_name" TEXT(80));

CREATE TABLE "Ref_Property_Types" ("property_type_code" TEXT(20) PRIMARY KEY, "property_type_description" TEXT(80));

CREATE TABLE "Other_Available_Features" ("feature_id" INTEGER PRIMARY KEY, "feature_type_code" TEXT(20), "feature_name" TEXT(80), "feature_description" TEXT(80), FOREIGN KEY ("feature_type_code") REFERENCES "Ref_Feature_Types" ("feature_type_code"));

CREATE TABLE "Properties" ("property_id" INTEGER PRIMARY KEY, "property_type_code" TEXT(20), "date_on_market" DATETIME, "date_sold" DATETIME, "property_name" TEXT(80), "property_address" TEXT(255), "room_count" INTEGER, "vendor_requested_price" REAL(19, 4), "buyer_offered_price" REAL(19, 4), "agreed_selling_price" REAL(19, 4), "apt_feature_1" TEXT(255), "apt_feature_2" TEXT(255), "apt_feature_3" TEXT(255), "fld_feature_1" TEXT(255), "fld_feature_2" TEXT(255), "fld_feature_3" TEXT(255), "hse_feature_1" TEXT(255), "hse_feature_2" TEXT(255), "hse_feature_3" TEXT(255), "oth_feature_1" TEXT(255), "oth_feature_2" TEXT(255), "oth_feature_3" TEXT(255), "shp_feature_1" TEXT(255), "shp_feature_2" TEXT(255), "shp_feature_3" TEXT(255), "other_property_details" TEXT(255), FOREIGN KEY ("property_type_code") REFERENCES "Ref_Property_Types" ("property_type_code"));

CREATE TABLE "Other_Property_Features" ("property_id" INTEGER, "feature_id" INTEGER, "property_feature_description" TEXT(80), FOREIGN KEY ("property_id") REFERENCES "Properties" ("property_id"), FOREIGN KEY ("feature_id") REFERENCES "Other_Available_Features" ("feature_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: ref_property_types --
INSERT INTO "ref_property_types" ("property_type_code", "property_type_description") VALUES ('House', 'ref_f077ea');

INSERT INTO "ref_property_types" ("property_type_code", "property_type_description") VALUES ('pro_2940bc', 'ref_f077ea');

-- Inserting into table: properties --
INSERT INTO "properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (1, 'House', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'pro_11dd51', 'pro_a9c94f', 1, 1.0, 1.0, 1.0, 'pro_79d466', 'pro_0c5f78', 'pro_6b79f1', 'pro_dd2c0e', 'pro_2b9992', 'pro_9a2d54', 'pro_61bed7', 'pro_764f55', 'pro_2aecbc', 'pro_c8d6a0', 'pro_dfd3d3', 'pro_a37645', 'pro_a1d03f', 'pro_a05503', 'pro_1797bb', 'pro_1aff2b');

INSERT INTO "properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (-2147483647, 'House', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'pro_83178c', 'pro_f460cb', 1, 1.0, 1.0, 1.0, 'pro_d66418', 'pro_4ac629', 'pro_29104a', 'pro_a23560', 'pro_8152de', 'pro_135460', 'pro_234dc6', 'pro_7555f2', 'pro_e97970', 'pro_5229cf', 'pro_802794', 'pro_f7e330', 'pro_1b6631', 'pro_138bbe', 'pro_2bf51e', 'pro_dbf06f');

INSERT INTO "properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (-2147483646, 'House', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00', 'q_0_3a2f2d', 'pro_ef4f89', -55602865, 0.0003, 0.0003, 0.0003, 'pro_34dc5c', 'pro_701d46', 'pro_1d430d', 'pro_8128bf', 'pro_4335a0', 'pro_b88987', 'pro_686275', 'pro_10be99', 'pro_5990b7', 'pro_436578', 'pro_0700fc', 'pro_d753df', 'pro_fa60a5', 'pro_66a35d', 'pro_b52581', 'pro_91fdb2');

INSERT INTO "properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (-2147483645, 'House', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'q_0_3a2f2d', 'pro_ef4f89', -664303813, 0.0004, 0.0004, 0.0004, 'pro_34dc5c', 'pro_701d46', 'pro_1d430d', 'pro_8128bf', 'pro_4335a0', 'pro_b88987', 'pro_686275', 'pro_10be99', 'pro_5990b7', 'pro_436578', 'pro_0700fc', 'pro_d753df', 'pro_fa60a5', 'pro_66a35d', 'pro_b52581', 'pro_91fdb2');

INSERT INTO "properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (3, 'pro_2940bc', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00', 'pro_f4a05a', 'pro_ef4f89', 1, 0.0005, 0.0005, 0.0005, 'pro_34dc5c', 'pro_701d46', 'pro_1d430d', 'pro_8128bf', 'pro_4335a0', 'pro_b88987', 'pro_686275', 'pro_10be99', 'pro_5990b7', 'pro_436578', 'pro_0700fc', 'pro_d753df', 'pro_fa60a5', 'pro_66a35d', 'pro_b52581', 'pro_91fdb2');

INSERT INTO "properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (2, 'pro_2940bc', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'pro_f4a05a', 'pro_ef4f89', 1, 0.0006, 0.0006, 0.0006, 'pro_34dc5c', 'pro_701d46', 'pro_1d430d', 'pro_8128bf', 'pro_4335a0', 'pro_b88987', 'pro_686275', 'pro_10be99', 'pro_5990b7', 'pro_436578', 'pro_0700fc', 'pro_d753df', 'pro_fa60a5', 'pro_66a35d', 'pro_b52581', 'pro_91fdb2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "property_name" FROM (SELECT * FROM "properties" WHERE ("room_count" >= 1)) WHERE ("property_type_code" = 'House' OR "property_type_code" = 'Apartment') ORDER BY property_name, "property_name" NULLS LAST;

/*
Gold Result:
('pro_11dd51',)
('pro_83178c',)
*/

-- Prediction Query
SELECT property_name FROM Properties WHERE property_type_code = 'House' UNION SELECT property_name FROM Properties WHERE property_type_code = 'Apartment' AND room_count > 1;

/*
Prediction Result:
('pro_11dd51',)
('pro_83178c',)
('q_0_3a2f2d',)
*/