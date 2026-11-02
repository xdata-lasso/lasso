-- Schema DDL
CREATE TABLE "Ref_Feature_Types" ("feature_type_code" TEXT(20) PRIMARY KEY, "feature_type_name" TEXT(80));

CREATE TABLE "Ref_Property_Types" ("property_type_code" TEXT(20) PRIMARY KEY, "property_type_description" TEXT(80));

CREATE TABLE "Other_Available_Features" ("feature_id" INTEGER PRIMARY KEY, "feature_type_code" TEXT(20), "feature_name" TEXT(80), "feature_description" TEXT(80), FOREIGN KEY ("feature_type_code") REFERENCES "Ref_Feature_Types" ("feature_type_code"));

CREATE TABLE "Properties" ("property_id" INTEGER PRIMARY KEY, "property_type_code" TEXT(20), "date_on_market" DATETIME, "date_sold" DATETIME, "property_name" TEXT(80), "property_address" TEXT(255), "room_count" INTEGER, "vendor_requested_price" REAL(19, 4), "buyer_offered_price" REAL(19, 4), "agreed_selling_price" REAL(19, 4), "apt_feature_1" TEXT(255), "apt_feature_2" TEXT(255), "apt_feature_3" TEXT(255), "fld_feature_1" TEXT(255), "fld_feature_2" TEXT(255), "fld_feature_3" TEXT(255), "hse_feature_1" TEXT(255), "hse_feature_2" TEXT(255), "hse_feature_3" TEXT(255), "oth_feature_1" TEXT(255), "oth_feature_2" TEXT(255), "oth_feature_3" TEXT(255), "shp_feature_1" TEXT(255), "shp_feature_2" TEXT(255), "shp_feature_3" TEXT(255), "other_property_details" TEXT(255), FOREIGN KEY ("property_type_code") REFERENCES "Ref_Property_Types" ("property_type_code"));

CREATE TABLE "Other_Property_Features" ("property_id" INTEGER, "feature_id" INTEGER, "property_feature_description" TEXT(80), FOREIGN KEY ("property_id") REFERENCES "Properties" ("property_id"), FOREIGN KEY ("feature_id") REFERENCES "Other_Available_Features" ("feature_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ref_Feature_Types" ("feature_type_code", "feature_type_name") VALUES ('FT1', 'Zebra Type');
INSERT INTO "Ref_Feature_Types" ("feature_type_code", "feature_type_name") VALUES ('FT2', 'Alpha Type');
INSERT INTO "Ref_Feature_Types" ("feature_type_code", "feature_type_name") VALUES ('FT3', NULL);
INSERT INTO "Ref_Feature_Types" ("feature_type_code", "feature_type_name") VALUES ('FT4', 'Unmatched Type');
INSERT INTO "Ref_Feature_Types" ("feature_type_code", "feature_type_name") VALUES ('FT5', 'AirCon');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (1, 'FT1', 'AirCon', 'Cooling system');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (2, 'FT2', 'AirCon', 'AC Unit 1');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (3, 'FT2', 'AirCon', 'AC Unit 2');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (4, 'FT3', 'AirCon', 'Null Type Name AC');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (5, 'FT4', 'Heating', 'AirCon');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (6, 'FT5', 'Pool', 'Swimming Pool');
INSERT INTO "Other_Available_Features" ("feature_id", "feature_type_code", "feature_name", "feature_description") VALUES (7, NULL, 'AirCon', 'Orphan AC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "feature_type_name" FROM (SELECT "LHS"."feature_type_code" AS "feature_type_code", "LHS"."feature_type_name" AS "feature_type_name", "RHS"."feature_id" AS "feature_id", "RHS"."feature_name" AS "feature_name", "RHS"."feature_description" AS "feature_description" FROM "ref_feature_types" AS "LHS" INNER JOIN (SELECT * FROM "other_available_features" WHERE ("feature_name" = 'AirCon')) AS RHS ON (LHS.feature_type_code = RHS.feature_type_code)) ORDER BY feature_type_name, "feature_type_name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Type',)
('Alpha Type',)
('Zebra Type',)
*/

-- Prediction Query
SELECT T2.feature_type_name FROM Other_Available_Features AS T1 JOIN Ref_Feature_Types AS T2 ON T1.feature_type_code = T2.feature_type_code WHERE T1.feature_name = 'AirCon';

/*
Prediction Result:
('Zebra Type',)
('Alpha Type',)
('Alpha Type',)
(None,)
*/