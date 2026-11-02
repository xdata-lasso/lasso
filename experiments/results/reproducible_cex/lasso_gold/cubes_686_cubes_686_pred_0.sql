-- Schema DDL
CREATE TABLE "Ref_Feature_Types" ("feature_type_code" TEXT(20) PRIMARY KEY, "feature_type_name" TEXT(80));

CREATE TABLE "Ref_Property_Types" ("property_type_code" TEXT(20) PRIMARY KEY, "property_type_description" TEXT(80));

CREATE TABLE "Other_Available_Features" ("feature_id" INTEGER PRIMARY KEY, "feature_type_code" TEXT(20), "feature_name" TEXT(80), "feature_description" TEXT(80), FOREIGN KEY ("feature_type_code") REFERENCES "Ref_Feature_Types" ("feature_type_code"));

CREATE TABLE "Properties" ("property_id" INTEGER PRIMARY KEY, "property_type_code" TEXT(20), "date_on_market" DATETIME, "date_sold" DATETIME, "property_name" TEXT(80), "property_address" TEXT(255), "room_count" INTEGER, "vendor_requested_price" REAL(19, 4), "buyer_offered_price" REAL(19, 4), "agreed_selling_price" REAL(19, 4), "apt_feature_1" TEXT(255), "apt_feature_2" TEXT(255), "apt_feature_3" TEXT(255), "fld_feature_1" TEXT(255), "fld_feature_2" TEXT(255), "fld_feature_3" TEXT(255), "hse_feature_1" TEXT(255), "hse_feature_2" TEXT(255), "hse_feature_3" TEXT(255), "oth_feature_1" TEXT(255), "oth_feature_2" TEXT(255), "oth_feature_3" TEXT(255), "shp_feature_1" TEXT(255), "shp_feature_2" TEXT(255), "shp_feature_3" TEXT(255), "other_property_details" TEXT(255), FOREIGN KEY ("property_type_code") REFERENCES "Ref_Property_Types" ("property_type_code"));

CREATE TABLE "Other_Property_Features" ("property_id" INTEGER, "feature_id" INTEGER, "property_feature_description" TEXT(80), FOREIGN KEY ("property_id") REFERENCES "Properties" ("property_id"), FOREIGN KEY ("feature_id") REFERENCES "Other_Available_Features" ("feature_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_property_types" ("property_type_code", "property_type_description") VALUES ('House', 'Away real physical big significant.');
INSERT INTO "ref_property_types" ("property_type_code", "property_type_description") VALUES ('Apartment', 'South someone not American mouth product attention positive.');
INSERT INTO "properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (1068, 'House', '1977-04-14', '1979-06-16', 'Jason Henry', '2849 Marshall Views
Marcusbury, MP 11860', 1, 1070.5, 1072.5, 1074.5, 'nation', 'cut', 'effort', 'investment', 'one', 'effect', 'maybe', 'seek', 'line', 'adult', 'financial', 'interview', 'follow', 'party', 'material', 'nice');
INSERT INTO "properties" ("property_id", "property_type_code", "date_on_market", "date_sold", "property_name", "property_address", "room_count", "vendor_requested_price", "buyer_offered_price", "agreed_selling_price", "apt_feature_1", "apt_feature_2", "apt_feature_3", "fld_feature_1", "fld_feature_2", "fld_feature_3", "hse_feature_1", "hse_feature_2", "hse_feature_3", "oth_feature_1", "oth_feature_2", "oth_feature_3", "shp_feature_1", "shp_feature_2", "shp_feature_3", "other_property_details") VALUES (1069, 'Apartment', '1977-04-15', '1979-06-17', 'Jack Snow', '79965 Troy Islands Apt. 735
Matthewview, OH 01831', 1, 1087.5, 1091.5, 1095.5, 'yourself', 'bed', 'service', 'middle', 'son', 'rock', 'race', 'military', 'structure', 'better', 'do', 'role', 'record', 'home', 'on', 'guy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "property_name" FROM (SELECT * FROM "properties" WHERE ("room_count" >= 1)) WHERE ("property_type_code" = 'House' OR "property_type_code" = 'Apartment') ORDER BY property_name, "property_name" NULLS LAST;

/*
Gold Result:
('Jack Snow',)
('Jason Henry',)
*/

-- Prediction Query
SELECT property_name FROM Properties WHERE property_type_code = 'House' UNION SELECT property_name FROM Properties WHERE property_type_code = 'Apartment' AND room_count > 1;

/*
Prediction Result:
('Jason Henry',)
*/