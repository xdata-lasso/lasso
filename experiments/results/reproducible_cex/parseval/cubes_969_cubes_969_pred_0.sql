-- Schema DDL
CREATE TABLE "Ref_Hotel_Star_Ratings" ("star_rating_code" TEXT(15) PRIMARY KEY, "star_rating_description" TEXT(80));

CREATE TABLE "Locations" ("Location_ID" INTEGER PRIMARY KEY, "Location_Name" TEXT(255), "Address" TEXT(255), "Other_Details" TEXT(255));

CREATE TABLE "Ref_Attraction_Types" ("Attraction_Type_Code" TEXT(15) PRIMARY KEY, "Attraction_Type_Description" TEXT(255));

CREATE TABLE "Visitors" ("Tourist_ID" INTEGER PRIMARY KEY, "Tourist_Details" TEXT(255));

CREATE TABLE "Features" ("Feature_ID" INTEGER PRIMARY KEY, "Feature_Details" TEXT(255));

CREATE TABLE "Hotels" ("hotel_id" INTEGER PRIMARY KEY, "star_rating_code" TEXT(15), "pets_allowed_yn" TEXT(1), "price_range" REAL, "other_hotel_details" TEXT(255), FOREIGN KEY ("star_rating_code") REFERENCES "Ref_Hotel_Star_Ratings" ("star_rating_code"));

CREATE TABLE "Tourist_Attractions" ("Tourist_Attraction_ID" INTEGER PRIMARY KEY, "Attraction_Type_Code" TEXT(15), "Location_ID" INTEGER, "How_to_Get_There" TEXT(255), "Name" TEXT(255), "Description" TEXT(255), "Opening_Hours" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Attraction_Type_Code") REFERENCES "Ref_Attraction_Types" ("Attraction_Type_Code"), FOREIGN KEY ("Location_ID") REFERENCES "Locations" ("Location_ID"));

CREATE TABLE "Street_Markets" ("Market_ID" INTEGER PRIMARY KEY, "Market_Details" TEXT(255), FOREIGN KEY ("Market_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

CREATE TABLE "Shops" ("Shop_ID" INTEGER PRIMARY KEY, "Shop_Details" TEXT(255), FOREIGN KEY ("Shop_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

CREATE TABLE "Museums" ("Museum_ID" INTEGER PRIMARY KEY, "Museum_Details" TEXT(255), FOREIGN KEY ("Museum_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

CREATE TABLE "Royal_Family" ("Royal_Family_ID" INTEGER PRIMARY KEY, "Royal_Family_Details" TEXT(255), FOREIGN KEY ("Royal_Family_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

CREATE TABLE "Theme_Parks" ("Theme_Park_ID" INTEGER PRIMARY KEY, "Theme_Park_Details" TEXT(255), FOREIGN KEY ("Theme_Park_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

CREATE TABLE "Visits" ("Visit_ID" INTEGER PRIMARY KEY, "Tourist_ID" INTEGER, "Tourist_Attraction_ID" INTEGER, "Visit_Date" DATETIME, "Visit_Details" TEXT(40), FOREIGN KEY ("Tourist_ID") REFERENCES "Visitors" ("Tourist_ID"), FOREIGN KEY ("Tourist_Attraction_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

CREATE TABLE "Photos" ("Photo_ID" INTEGER PRIMARY KEY, "Tourist_Attraction_ID" INTEGER, "Name" TEXT(255), "Description" TEXT(255), "Filename" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Tourist_Attraction_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

CREATE TABLE "Staff" ("Staff_ID" INTEGER PRIMARY KEY, "Tourist_Attraction_ID" INTEGER, "Name" TEXT(40), "Other_Details" TEXT(255), FOREIGN KEY ("Tourist_Attraction_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

CREATE TABLE "Tourist_Attraction_Features" ("Tourist_Attraction_ID" INTEGER, "Feature_ID" INTEGER, PRIMARY KEY ("Tourist_Attraction_ID", "Feature_ID"), FOREIGN KEY ("Feature_ID") REFERENCES "Features" ("Feature_ID"), FOREIGN KEY ("Tourist_Attraction_ID") REFERENCES "Tourist_Attractions" ("Tourist_Attraction_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: tourist_attractions --
INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (1, 'attraction_ty_1', -2147483648, 'tou_e811c3', 'film festival', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (-2147483647, 'attraction_ty_1', -2147483648, 'tou_e811c3', 'film festival', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (3, 'attraction_ty_1', -2147483648, 'tou_e811c3', 'film festival', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (2, 'attraction_ty_1', -2147483648, 'tou_e811c3', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (4, 'attraction_ty_1', -2147483648, 'tou_e811c3', NULL, 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

-- Inserting into table: locations --
INSERT INTO "locations" ("location_id", "location_name", "address", "other_details") VALUES (-2147483648, 'loc_9ab024', 'loc_7925b7', 'loc_d8a7fd');

-- Inserting into table: ref_attraction_types --
INSERT INTO "ref_attraction_types" ("attraction_type_code", "attraction_type_description") VALUES ('attraction_ty_1', 'ref_cff9ae');

-- Inserting into table: photos --
INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (-2147483648, 1, 't1__dfec4b', 't1__312b06', 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (2, 1, 't1__dfec4b', 't1__312b06', 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (3, 1, 't1__dfec4b', 't1__312b06', 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (-2147483645, 2, 't1__dfec4b', 't1__312b06', 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (-2147483644, 2, 't1__dfec4b', 't1__312b06', 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (-2147483643, 2, 't1__dfec4b', 't1__312b06', 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (-2147483642, 1, 't1__dfec4b', 't1__312b06', 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (-2147483641, 1, 't1__dfec4b', NULL, 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (-2147483640, 1, NULL, 't1__312b06', 'pho_5e9d46', 'pho_7dc9df');

INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (4, 4, 'pho_b4684a', 'pho_083c6e', 'pho_5e9d46', 'pho_7dc9df');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "description" FROM (SELECT * FROM "photos" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "tourist_attractions" WHERE ("name" <> 'film festival')) AS RHS WHERE (LHS.tourist_attraction_id = RHS.tourist_attraction_id))) ORDER BY name, "name" NULLS LAST, "description" NULLS LAST;

/*
Gold Result:
(None, 't1__312b06')
('pho_b4684a', 'pho_083c6e')
('t1__dfec4b', 't1__312b06')
('t1__dfec4b', 't1__312b06')
('t1__dfec4b', 't1__312b06')
('t1__dfec4b', 't1__312b06')
('t1__dfec4b', None)
*/

-- Prediction Query
SELECT T1.Name, T1.Description FROM PHOTOS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID = T2.Tourist_Attraction_ID WHERE T2.Name = 'film festival';

/*
Prediction Result:
('t1__dfec4b', 't1__312b06')
('t1__dfec4b', 't1__312b06')
('t1__dfec4b', None)
(None, 't1__312b06')
('t1__dfec4b', 't1__312b06')
('t1__dfec4b', 't1__312b06')
*/