-- Schema DDL
CREATE TABLE "Ref_Feature_Types" ("feature_type_code" TEXT(20) PRIMARY KEY, "feature_type_name" TEXT(80));

CREATE TABLE "Ref_Property_Types" ("property_type_code" TEXT(20) PRIMARY KEY, "property_type_description" TEXT(80));

CREATE TABLE "Other_Available_Features" ("feature_id" INTEGER PRIMARY KEY, "feature_type_code" TEXT(20), "feature_name" TEXT(80), "feature_description" TEXT(80), FOREIGN KEY ("feature_type_code") REFERENCES "Ref_Feature_Types" ("feature_type_code"));

CREATE TABLE "Properties" ("property_id" INTEGER PRIMARY KEY, "property_type_code" TEXT(20), "date_on_market" DATETIME, "date_sold" DATETIME, "property_name" TEXT(80), "property_address" TEXT(255), "room_count" INTEGER, "vendor_requested_price" REAL(19, 4), "buyer_offered_price" REAL(19, 4), "agreed_selling_price" REAL(19, 4), "apt_feature_1" TEXT(255), "apt_feature_2" TEXT(255), "apt_feature_3" TEXT(255), "fld_feature_1" TEXT(255), "fld_feature_2" TEXT(255), "fld_feature_3" TEXT(255), "hse_feature_1" TEXT(255), "hse_feature_2" TEXT(255), "hse_feature_3" TEXT(255), "oth_feature_1" TEXT(255), "oth_feature_2" TEXT(255), "oth_feature_3" TEXT(255), "shp_feature_1" TEXT(255), "shp_feature_2" TEXT(255), "shp_feature_3" TEXT(255), "other_property_details" TEXT(255), FOREIGN KEY ("property_type_code") REFERENCES "Ref_Property_Types" ("property_type_code"));

CREATE TABLE "Other_Property_Features" ("property_id" INTEGER, "feature_id" INTEGER, "property_feature_description" TEXT(80), FOREIGN KEY ("property_id") REFERENCES "Properties" ("property_id"), FOREIGN KEY ("feature_id") REFERENCES "Other_Available_Features" ("feature_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Feature_Types (feature_type_code, feature_type_name) VALUES ('FT1', 'Amenity');
INSERT INTO Ref_Feature_Types (feature_type_code, feature_type_name) VALUES ('FT2', 'Security');
INSERT INTO Ref_Property_Types (property_type_code, property_type_description) VALUES ('PT_A', 'Villa');
INSERT INTO Ref_Property_Types (property_type_code, property_type_description) VALUES ('PT_B', 'Apartment');
INSERT INTO Ref_Property_Types (property_type_code, property_type_description) VALUES ('PT_C', 'House');
INSERT INTO Other_Available_Features (feature_id, feature_type_code, feature_name, feature_description) VALUES (1, 'FT1', 'Pool', 'Swimming Pool');
INSERT INTO Other_Available_Features (feature_id, feature_type_code, feature_name, feature_description) VALUES (2, 'FT2', 'Alarm', 'Burglar Alarm');
INSERT INTO Properties (property_id, property_type_code, date_on_market, date_sold, property_name, property_address, room_count, vendor_requested_price, buyer_offered_price, agreed_selling_price, other_property_details) VALUES (101, 'PT_B', '2023-01-10', '2023-02-15', 'Sunny Apt', '10 Main St', 3, 250000.0, 240000.0, 245000.0, 'Modern apartment');
INSERT INTO Properties (property_id, property_type_code, date_on_market, date_sold, property_name, property_address, room_count, vendor_requested_price, buyer_offered_price, agreed_selling_price, other_property_details) VALUES (102, 'PT_B', '2023-03-01', '2023-04-01', 'City Apt', '20 High St', 2, 180000.0, 175000.0, 178000.0, 'Central location');
INSERT INTO Properties (property_id, property_type_code, date_on_market, date_sold, property_name, property_address, room_count, vendor_requested_price, buyer_offered_price, agreed_selling_price, other_property_details) VALUES (103, 'PT_C', '2023-05-01', NULL, 'Oak House', '5 Oak Ave', 5, 500000.0, NULL, NULL, 'Spacious garden');
INSERT INTO Other_Property_Features (property_id, feature_id, property_feature_description) VALUES (101, 1, 'Heated indoor pool');
INSERT INTO Other_Property_Features (property_id, feature_id, property_feature_description) VALUES (103, 2, '24/7 monitored alarm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT property_type_description FROM ref_property_types ORDER BY property_type_description, ref_property_types.property_type_code NULLS LAST;

/*
Gold Result:
('Apartment',)
('House',)
('Villa',)
*/

-- Prediction Query
SELECT T2.property_type_description FROM Properties AS T1 JOIN Ref_Property_Types AS T2 ON T1.property_type_code = T2.property_type_code GROUP BY T1.property_type_code;

/*
Prediction Result:
('Apartment',)
('House',)
*/