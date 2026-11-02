-- Schema DDL
CREATE TABLE "Ref_Feature_Types" ("feature_type_code" TEXT(20) PRIMARY KEY, "feature_type_name" TEXT(80));

CREATE TABLE "Ref_Property_Types" ("property_type_code" TEXT(20) PRIMARY KEY, "property_type_description" TEXT(80));

CREATE TABLE "Other_Available_Features" ("feature_id" INTEGER PRIMARY KEY, "feature_type_code" TEXT(20), "feature_name" TEXT(80), "feature_description" TEXT(80), FOREIGN KEY ("feature_type_code") REFERENCES "Ref_Feature_Types" ("feature_type_code"));

CREATE TABLE "Properties" ("property_id" INTEGER PRIMARY KEY, "property_type_code" TEXT(20), "date_on_market" DATETIME, "date_sold" DATETIME, "property_name" TEXT(80), "property_address" TEXT(255), "room_count" INTEGER, "vendor_requested_price" REAL(19, 4), "buyer_offered_price" REAL(19, 4), "agreed_selling_price" REAL(19, 4), "apt_feature_1" TEXT(255), "apt_feature_2" TEXT(255), "apt_feature_3" TEXT(255), "fld_feature_1" TEXT(255), "fld_feature_2" TEXT(255), "fld_feature_3" TEXT(255), "hse_feature_1" TEXT(255), "hse_feature_2" TEXT(255), "hse_feature_3" TEXT(255), "oth_feature_1" TEXT(255), "oth_feature_2" TEXT(255), "oth_feature_3" TEXT(255), "shp_feature_1" TEXT(255), "shp_feature_2" TEXT(255), "shp_feature_3" TEXT(255), "other_property_details" TEXT(255), FOREIGN KEY ("property_type_code") REFERENCES "Ref_Property_Types" ("property_type_code"));

CREATE TABLE "Other_Property_Features" ("property_id" INTEGER, "feature_id" INTEGER, "property_feature_description" TEXT(80), FOREIGN KEY ("property_id") REFERENCES "Properties" ("property_id"), FOREIGN KEY ("feature_id") REFERENCES "Other_Available_Features" ("feature_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM other_available_features ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Other_Available_Features;

/*
Prediction Result:
(0,)
*/