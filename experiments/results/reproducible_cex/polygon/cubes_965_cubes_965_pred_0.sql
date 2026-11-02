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
INSERT INTO "Ref_Hotel_Star_Ratings" ("star_rating_code", "star_rating_description") VALUES ('26', '31');
INSERT INTO "Ref_Hotel_Star_Ratings" ("star_rating_code", "star_rating_description") VALUES ('25', '31');
INSERT INTO "Locations" ("location_id", "location_name", "address", "other_details") VALUES (36, '31', '31', '31');
INSERT INTO "Ref_Attraction_Types" ("attraction_type_code", "attraction_type_description") VALUES ('34', '31');
INSERT INTO "Visitors" ("tourist_id", "tourist_details") VALUES (27, '31');
INSERT INTO "Features" ("feature_id", "feature_details") VALUES (28, '31');
INSERT INTO "Hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (30, '25', '31', 31, '31');
INSERT INTO "Hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (29, '26', '31', 31, '31');
INSERT INTO "Tourist_Attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (32, NULL, NULL, '56', NULL, NULL, NULL, NULL);
INSERT INTO "Tourist_Attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (31, '34', 36, '56', '50', NULL, '52', '53');
INSERT INTO "Street_Markets" ("market_id", "market_details") VALUES (32, '31');
INSERT INTO "Street_Markets" ("market_id", "market_details") VALUES (31, '31');
INSERT INTO "Shops" ("shop_id", "shop_details") VALUES (32, '31');
INSERT INTO "Museums" ("museum_id", "museum_details") VALUES (31, '31');
INSERT INTO "Royal_Family" ("royal_family_id", "royal_family_details") VALUES (32, NULL);
INSERT INTO "Royal_Family" ("royal_family_id", "royal_family_details") VALUES (31, '55');
INSERT INTO "Theme_Parks" ("theme_park_id", "theme_park_details") VALUES (31, '31');
INSERT INTO "Visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (37, 27, 32, 31, '31');
INSERT INTO "Photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (40, 31, '31', '31', '31', '31');
INSERT INTO "Photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (39, 31, '31', '31', '31', '31');
INSERT INTO "Staff" ("staff_id", "tourist_attraction_id", "name", "other_details") VALUES (31, 31, '31', '31');
INSERT INTO "Tourist_Attraction_Features" ("tourist_attraction_id", "feature_id") VALUES (31, 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT description AS royal_family_details, how_to_get_there FROM (SELECT LHS.tourist_attraction_id AS tourist_attraction_id, LHS.attraction_type_code AS attraction_type_code, LHS.location_id AS location_id, LHS.how_to_get_there AS how_to_get_there, LHS.name AS name, LHS.description AS description, LHS.opening_hours AS opening_hours, LHS.other_details AS other_details, RHS.royal_family_details AS royal_family_details FROM tourist_attractions AS LHS INNER JOIN royal_family AS RHS ON (LHS.tourist_attraction_id = RHS.royal_family_id)) ORDER BY royal_family_details, how_to_get_there NULLS LAST;

/*
Gold Result:
(None, '56')
(None, '56')
*/

-- Prediction Query
SELECT T1.Royal_Family_Details, T2.How_to_Get_There FROM ROYAL_FAMILY AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Royal_Family_ID = T2.Tourist_Attraction_ID;

/*
Prediction Result:
('55', '56')
(None, '56')
*/