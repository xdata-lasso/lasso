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
INSERT INTO "Ref_Hotel_Star_Ratings" ("star_rating_code", "star_rating_description") VALUES ('Vivian35', 'Vincent42');
INSERT INTO "Ref_Hotel_Star_Ratings" ("star_rating_code", "star_rating_description") VALUES ('Vincent34', 'Vincent42');
INSERT INTO "Locations" ("location_id", "location_name", "address", "other_details") VALUES (64, 'Vincent42', 'Vincent42', 'Vincent42');
INSERT INTO "Locations" ("location_id", "location_name", "address", "other_details") VALUES (57, 'Vincent42', 'Vincent42', 'Vincent42');
INSERT INTO "Ref_Attraction_Types" ("attraction_type_code", "attraction_type_description") VALUES ('Vivian63', 'Vincent42');
INSERT INTO "Visitors" ("tourist_id", "tourist_details") VALUES (42, 'Vivian');
INSERT INTO "Features" ("feature_id", "feature_details") VALUES (37, 'Vincent42');
INSERT INTO "Features" ("feature_id", "feature_details") VALUES (36, 'Vincent42');
INSERT INTO "Hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (39, 'Vincent34', 'Vincent42', 42, 'Vincent42');
INSERT INTO "Hotels" ("hotel_id", "star_rating_code", "pets_allowed_yn", "price_range", "other_hotel_details") VALUES (38, 'Vincent34', 'Vincent42', 42, 'Vincent42');
INSERT INTO "Tourist_Attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (44, NULL, 57, 'Vincent58', NULL, 'Vincent60', 'Vivian61', 'Vincent62');
INSERT INTO "Tourist_Attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (43, 'Vivian63', 64, 'Vivian65', NULL, 'Vivian67', 'Vincent68', 'Vivian69');
INSERT INTO "Street_Markets" ("market_id", "market_details") VALUES (43, 'Vincent42');
INSERT INTO "Shops" ("shop_id", "shop_details") VALUES (43, 'Vincent42');
INSERT INTO "Museums" ("museum_id", "museum_details") VALUES (44, 'Vincent42');
INSERT INTO "Museums" ("museum_id", "museum_details") VALUES (43, 'Vincent42');
INSERT INTO "Royal_Family" ("royal_family_id", "royal_family_details") VALUES (43, 'Vincent42');
INSERT INTO "Theme_Parks" ("theme_park_id", "theme_park_details") VALUES (43, 'Vincent42');
INSERT INTO "Visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (41, 42, 43, 70, 'Vincent54');
INSERT INTO "Visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (40, 42, 44, 70, NULL);
INSERT INTO "Photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (46, 43, 'Vincent42', 'Vincent42', 'Vincent42', 'Vincent42');
INSERT INTO "Photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (45, 43, 'Vincent42', 'Vincent42', 'Vincent42', 'Vincent42');
INSERT INTO "Staff" ("staff_id", "tourist_attraction_id", "name", "other_details") VALUES (42, 44, 'Vincent42', 'Vincent42');
INSERT INTO "Tourist_Attraction_Features" ("tourist_attraction_id", "feature_id") VALUES (44, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "visit_date" FROM (SELECT "LHS"."tourist_id" AS "tourist_id", "LHS"."tourist_details" AS "tourist_details", "LHS"."tourist_attraction_id" AS "tourist_attraction_id", "LHS"."attraction_type_code" AS "attraction_type_code", "LHS"."location_id" AS "location_id", "LHS"."how_to_get_there" AS "how_to_get_there", "LHS"."name" AS "name", "LHS"."description" AS "description", "LHS"."opening_hours" AS "opening_hours", "LHS"."other_details" AS "other_details", "RHS"."visit_id" AS "visit_id", "RHS"."visit_date" AS "visit_date", "RHS"."visit_details" AS "visit_details" FROM (SELECT "LHS"."tourist_id" AS "tourist_id", "LHS"."tourist_details" AS "tourist_details", "RHS"."tourist_attraction_id" AS "tourist_attraction_id", "RHS"."attraction_type_code" AS "attraction_type_code", "RHS"."location_id" AS "location_id", "RHS"."how_to_get_there" AS "how_to_get_there", "RHS"."name" AS "name", "RHS"."description" AS "description", "RHS"."opening_hours" AS "opening_hours", "RHS"."other_details" AS "other_details" FROM "visitors" AS "LHS" CROSS JOIN "tourist_attractions" AS "RHS") AS "LHS" INNER JOIN "visits" AS "RHS" ON ("LHS"."tourist_id" = "RHS"."tourist_id" AND "LHS"."tourist_attraction_id" = "RHS"."tourist_attraction_id")) WHERE ("tourist_details" = 'Vincent' OR "tourist_details" = 'Vivian') ORDER BY name, "name" NULLS LAST, "visit_date" NULLS LAST;

/*
Gold Result:
(None, 70)
(None, 70)
*/

-- Prediction Query
SELECT T1.Name, T3.Visit_Date FROM Tourist_Attractions AS T1 CROSS JOIN VISITORS AS T2 JOIN VISITS AS T3 ON T1.Tourist_Attraction_ID = T3.Tourist_Attraction_ID AND T2.Tourist_ID = T3.Tourist_ID WHERE T2.Tourist_Details = 'Vincent' OR T2.Tourist_Details = 'Vivian';

/*
Prediction Result:
(None, 70)
(None, 70)
*/