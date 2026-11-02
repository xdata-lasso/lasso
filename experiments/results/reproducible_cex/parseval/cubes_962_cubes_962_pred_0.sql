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
INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('t1__034ebf', 't2__80bf61');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('star_rating_c_2', 't2__80bf61');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('A', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('O', 't2__80bf61');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('t2__10d28f', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('@', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('star_rating_c_7', NULL);

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('H', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('star_rating_c_9', NULL);

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('D', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('star_rating__11', NULL);

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('`', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('star_rating__13', NULL);

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('a', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('star_rating__15', NULL);

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('$', 'ref_57ea1f');

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('star_rating__17', NULL);

INSERT INTO "ref_hotel_star_ratings" ("star_rating_code", "star_rating_description") VALUES ('%', 'ref_57ea1f');

-- Inserting into table: hotels --
INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483648, 't1__034ebf', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483647, 't1__034ebf', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483646, 'A', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483645, 'A', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483644, 'A', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483643, 'A', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (2, 't1__034ebf', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (3, 't1__034ebf', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483640, 't1__034ebf', '5', 10000.0, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (-2147483639, 't1__034ebf', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (4, '@', '5', NULL, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (5, 'H', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (6, 'D', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (7, '`', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (8, 'a', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (9, '$', '5', 10000.01, 'hot_18e7ec');

INSERT INTO "hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (10, '%', '5', 10000.01, 'hot_18e7ec');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT star_rating_description FROM (SELECT * FROM (SELECT LHS.hotel_id AS hotel_id, LHS.star_rating_code AS star_rating_code, LHS.pets_allowed_yn AS pets_allowed_yn, LHS.price_range AS price_range, LHS.other_hotel_details AS other_hotel_details, RHS.star_rating_description AS star_rating_description FROM hotels AS LHS LEFT JOIN ref_hotel_star_ratings AS RHS ON (LHS.star_rating_code = RHS.star_rating_code)) AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM hotels WHERE (price_range <= 10000.0)) AS RHS WHERE (LHS.price_range = RHS.price_range AND LHS.star_rating_code = RHS.star_rating_code))) ORDER BY star_rating_description;

/*
Gold Result:
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('t2__80bf61',)
('t2__80bf61',)
('t2__80bf61',)
('t2__80bf61',)
('t2__80bf61',)
*/

-- Prediction Query
SELECT T2.star_rating_description FROM HOTELS AS T1 JOIN Ref_Hotel_Star_Ratings AS T2 ON T1.star_rating_code = T2.star_rating_code WHERE T1.price_range > 10000;

/*
Prediction Result:
('t2__80bf61',)
('t2__80bf61',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('t2__80bf61',)
('t2__80bf61',)
('t2__80bf61',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
('ref_57ea1f',)
*/