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
-- DATASET 1
INSERT INTO "Ref_Hotel_Star_Ratings" ("star_rating_code", "star_rating_description") VALUES ('Y', 'Star Y');
INSERT INTO "Ref_Hotel_Star_Ratings" ("star_rating_code", "star_rating_description") VALUES ('N', 'Star N');
INSERT INTO "Ref_Hotel_Star_Ratings" ("star_rating_code", "star_rating_description") VALUES ('5', '5 Stars');
INSERT INTO "Hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (1, 'Y', 'Y', 100.0, 'Zebra Hotel');
INSERT INTO "Hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (2, 'N', 'N', 200.0, 'Alpha Hotel');
INSERT INTO "Hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (3, 'Y', 'N', 150.0, 'Beta Hotel');
INSERT INTO "Hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (4, '5', 'Y', 300.0, 'Gamma Hotel');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT other_hotel_details FROM (SELECT LHS.hotel_id AS hotel_id, LHS.star_rating_code AS star_rating_code, LHS.pets_allowed_yn AS pets_allowed_yn, LHS.price_range AS price_range, LHS.other_hotel_details AS other_hotel_details, RHS.star_rating_code AS star_rating_code_other, RHS.price_range AS price_range_other, RHS.other_hotel_details AS other_hotel_details_other FROM hotels AS LHS INNER JOIN hotels AS RHS ON (LHS.hotel_id = RHS.hotel_id AND LHS.star_rating_code = RHS.pets_allowed_yn)) ORDER BY other_hotel_details;

/*
Gold Result:
('Alpha Hotel',)
('Zebra Hotel',)
*/

-- Prediction Query
SELECT other_hotel_details FROM HOTELS ORDER BY price_range DESC, HOTELS.hotel_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('Gamma Hotel',)
('Alpha Hotel',)
('Beta Hotel',)
*/