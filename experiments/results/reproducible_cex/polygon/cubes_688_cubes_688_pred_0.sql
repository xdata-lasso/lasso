-- Schema DDL
CREATE TABLE "Ref_Feature_Types" ("feature_type_code" TEXT(20) PRIMARY KEY, "feature_type_name" TEXT(80));

CREATE TABLE "Ref_Property_Types" ("property_type_code" TEXT(20) PRIMARY KEY, "property_type_description" TEXT(80));

CREATE TABLE "Other_Available_Features" ("feature_id" INTEGER PRIMARY KEY, "feature_type_code" TEXT(20), "feature_name" TEXT(80), "feature_description" TEXT(80), FOREIGN KEY ("feature_type_code") REFERENCES "Ref_Feature_Types" ("feature_type_code"));

CREATE TABLE "Properties" ("property_id" INTEGER PRIMARY KEY, "property_type_code" TEXT(20), "date_on_market" DATETIME, "date_sold" DATETIME, "property_name" TEXT(80), "property_address" TEXT(255), "room_count" INTEGER, "vendor_requested_price" REAL(19, 4), "buyer_offered_price" REAL(19, 4), "agreed_selling_price" REAL(19, 4), "apt_feature_1" TEXT(255), "apt_feature_2" TEXT(255), "apt_feature_3" TEXT(255), "fld_feature_1" TEXT(255), "fld_feature_2" TEXT(255), "fld_feature_3" TEXT(255), "hse_feature_1" TEXT(255), "hse_feature_2" TEXT(255), "hse_feature_3" TEXT(255), "oth_feature_1" TEXT(255), "oth_feature_2" TEXT(255), "oth_feature_3" TEXT(255), "shp_feature_1" TEXT(255), "shp_feature_2" TEXT(255), "shp_feature_3" TEXT(255), "other_property_details" TEXT(255), FOREIGN KEY ("property_type_code") REFERENCES "Ref_Property_Types" ("property_type_code"));

CREATE TABLE "Other_Property_Features" ("property_id" INTEGER, "feature_id" INTEGER, "property_feature_description" TEXT(80), FOREIGN KEY ("property_id") REFERENCES "Properties" ("property_id"), FOREIGN KEY ("feature_id") REFERENCES "Other_Available_Features" ("feature_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ref_Feature_Types" ("feature_type_code", "feature_type_name") VALUES ('29', '35');
INSERT INTO "Ref_Feature_Types" ("feature_type_code", "feature_type_name") VALUES ('28', '35');
INSERT INTO "Ref_Property_Types" ("property_type_code", "property_type_description") VALUES ('31', '35');
INSERT INTO "Ref_Property_Types" ("property_type_code", "property_type_description") VALUES ('30', '35');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (33, '29', '35', '35');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (32, '28', '35', '35');
INSERT INTO "Properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (34, '30', 40, 41, '42', '43', 44, 45, 46, 47, '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', NULL, '61', '62', '63');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT property_type_description FROM ref_property_types ORDER BY property_type_description, ref_property_types.property_type_code NULLS LAST;

/*
Gold Result:
('35',)
('35',)
*/

-- Prediction Query
SELECT T2.property_type_description FROM Properties AS T1 JOIN Ref_Property_Types AS T2 ON T1.property_type_code = T2.property_type_code GROUP BY T1.property_type_code;

/*
Prediction Result:
('35',)
*/