-- Schema DDL
CREATE TABLE "Ref_Feature_Types" ("feature_type_code" TEXT(20) PRIMARY KEY, "feature_type_name" TEXT(80));

CREATE TABLE "Ref_Property_Types" ("property_type_code" TEXT(20) PRIMARY KEY, "property_type_description" TEXT(80));

CREATE TABLE "Other_Available_Features" ("feature_id" INTEGER PRIMARY KEY, "feature_type_code" TEXT(20), "feature_name" TEXT(80), "feature_description" TEXT(80), FOREIGN KEY ("feature_type_code") REFERENCES "Ref_Feature_Types" ("feature_type_code"));

CREATE TABLE "Properties" ("property_id" INTEGER PRIMARY KEY, "property_type_code" TEXT(20), "date_on_market" DATETIME, "date_sold" DATETIME, "property_name" TEXT(80), "property_address" TEXT(255), "room_count" INTEGER, "vendor_requested_price" REAL(19, 4), "buyer_offered_price" REAL(19, 4), "agreed_selling_price" REAL(19, 4), "apt_feature_1" TEXT(255), "apt_feature_2" TEXT(255), "apt_feature_3" TEXT(255), "fld_feature_1" TEXT(255), "fld_feature_2" TEXT(255), "fld_feature_3" TEXT(255), "hse_feature_1" TEXT(255), "hse_feature_2" TEXT(255), "hse_feature_3" TEXT(255), "oth_feature_1" TEXT(255), "oth_feature_2" TEXT(255), "oth_feature_3" TEXT(255), "shp_feature_1" TEXT(255), "shp_feature_2" TEXT(255), "shp_feature_3" TEXT(255), "other_property_details" TEXT(255), FOREIGN KEY ("property_type_code") REFERENCES "Ref_Property_Types" ("property_type_code"));

CREATE TABLE "Other_Property_Features" ("property_id" INTEGER, "feature_id" INTEGER, "property_feature_description" TEXT(80), FOREIGN KEY ("property_id") REFERENCES "Properties" ("property_id"), FOREIGN KEY ("feature_id") REFERENCES "Other_Available_Features" ("feature_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Property_Types (property_type_code, property_type_description) VALUES ('House', 'Residential House');
INSERT INTO Ref_Property_Types (property_type_code, property_type_description) VALUES ('Apartment', 'Residential Apartment');
INSERT INTO Ref_Property_Types (property_type_code, property_type_description) VALUES ('Shop', 'Commercial Shop');
INSERT INTO Ref_Property_Types (property_type_code, property_type_description) VALUES ('Other', 'Other Property');
INSERT INTO Properties (property_id, property_type_code, property_name, property_address, room_count, vendor_requested_price) VALUES (1, 'House', 'Zebra Cottage', '10 Zebra Ln', 1, 250000.00);
INSERT INTO Properties (property_id, property_type_code, property_name, property_address, room_count, vendor_requested_price) VALUES (2, 'Apartment', 'Alpha Studio', '1 Alpha St', 1, 150000.00);
INSERT INTO Properties (property_id, property_type_code, property_name, property_address, room_count, vendor_requested_price) VALUES (3, 'House', 'Maple Manor', '22 Maple Ave', 4, 550000.00);
INSERT INTO Properties (property_id, property_type_code, property_name, property_address, room_count, vendor_requested_price) VALUES (4, 'Apartment', 'Beacon Heights', '5 Beacon Rd', 2, 320000.00);
INSERT INTO Properties (property_id, property_type_code, property_name, property_address, room_count, vendor_requested_price) VALUES (5, 'House', 'Zero Room House', '99 Empty Way', 0, 100000.00);
INSERT INTO Properties (property_id, property_type_code, property_name, property_address, room_count, vendor_requested_price) VALUES (6, 'Apartment', 'Zero Room Apt', '98 Empty Way', 0, 90000.00);
INSERT INTO Properties (property_id, property_type_code, property_name, property_address, room_count, vendor_requested_price) VALUES (7, 'Shop', 'Corner Mart', '1 Main St', 3, 400000.00);
INSERT INTO Properties (property_id, property_type_code, property_name, property_address, room_count, vendor_requested_price) VALUES (8, 'Other', 'Storage Lot', '2 Main St', 1, 50000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "property_name" FROM (SELECT * FROM "properties" WHERE ("room_count" >= 1)) WHERE ("property_type_code" = 'House' OR "property_type_code" = 'Apartment') ORDER BY property_name, "property_name" NULLS LAST;

/*
Gold Result:
('Alpha Studio',)
('Beacon Heights',)
('Maple Manor',)
('Zebra Cottage',)
*/

-- Prediction Query
SELECT property_name FROM Properties WHERE property_type_code = 'House' UNION SELECT property_name FROM Properties WHERE property_type_code = 'Apartment' AND room_count > 1;

/*
Prediction Result:
('Beacon Heights',)
('Maple Manor',)
('Zebra Cottage',)
('Zero Room House',)
*/