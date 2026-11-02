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
-- Inserting into table: ref_hotel_star_ratings --
INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('hot_cf5237', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('lhs_8642ab', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('rhs_bd9e6b', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('hot_392aea', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('lhs_3ddd30', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('rhs_b3d26d', 'ref_57ea1f');

-- Inserting into table: hotels --
INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483648, 'hot_cf5237', '5', 1.0, 'hot_8528c6');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (1, 'lhs_8642ab', 'lhs_27253c', 1.0, 'lhs_f860f8');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483646, 'rhs_bd9e6b', '5', 1.0, 'rhs_aaec26');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483645, 'hot_cf5237', '5', 1.0, 'hot_8528c6');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483644, 'hot_392aea', '5', 1.0, 'hot_1891b1');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483643, 'rhs_bd9e6b', '5', 1.0, 'rhs_aaec26');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483642, 'rhs_b3d26d', '5', 1.0, 'rhs_b122af');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483641, 'hot_cf5237', '5', NULL, 'hot_8528c6');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483640, 'rhs_bd9e6b', '5', NULL, 'rhs_aaec26');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483639, 'hot_cf5237', NULL, 1.0, 'hot_8528c6');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483638, 'rhs_bd9e6b', NULL, 1.0, 'rhs_aaec26');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483637, 'lhs_3ddd30', '5', 1.0, 'hot_8528c6');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483636, 'rhs_b3d26d', '5', 1.0, 'rhs_aaec26');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483635, 'hot_cf5237', '5', 1.0, NULL);

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483634, 'rhs_bd9e6b', '5', 1.0, NULL);

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (2, 'rhs_b3d26d', '5', 487.053947, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (3, 'hot_392aea', '5', 285.529132, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (4, 'rhs_bd9e6b', '5', 833.684115, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (5, 'rhs_bd9e6b', '5', 38.668834, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (6, 'rhs_bd9e6b', '5', 171.746906, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (7, 'lhs_3ddd30', '5', 206.939346, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (8, 'lhs_3ddd30', '5', 537.136345, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (9, 'hot_cf5237', '5', 475.173408, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (10, 'hot_cf5237', '5', 688.4027, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (11, 'lhs_3ddd30', '5', 328.996339, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (12, 'hot_cf5237', '5', 483.665643, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (13, 'rhs_b3d26d', '5', 804.971537, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (14, 'hot_cf5237', '5', 268.82475, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (15, 'rhs_b3d26d', '5', 941.961117, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (16, 'hot_cf5237', '5', 795.366812, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (17, 'hot_392aea', '5', 797.015047, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (18, 'lhs_8642ab', '5', 718.397869, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (19, 'rhs_bd9e6b', '5', 882.963176, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (20, 'hot_cf5237', '5', 294.861575, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (21, 'rhs_bd9e6b', '5', 711.020062, 'hot_18e7ec');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT other_hotel_details FROM (SELECT LHS.hotel_id AS hotel_id, LHS.star_rating_code AS star_rating_code, LHS.pets_allowed_yn AS pets_allowed_yn, LHS.price_range AS price_range, LHS.other_hotel_details AS other_hotel_details, RHS.star_rating_code AS star_rating_code_other, RHS.price_range AS price_range_other, RHS.other_hotel_details AS other_hotel_details_other FROM hotels AS LHS INNER JOIN hotels AS RHS ON (LHS.hotel_id = RHS.hotel_id AND LHS.star_rating_code = RHS.pets_allowed_yn)) ORDER BY other_hotel_details;

/*
Gold Result:
*/

-- Prediction Query
SELECT other_hotel_details FROM HOTELS ORDER BY price_range DESC, HOTELS.hotel_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('hot_18e7ec',)
('hot_18e7ec',)
('hot_18e7ec',)
*/