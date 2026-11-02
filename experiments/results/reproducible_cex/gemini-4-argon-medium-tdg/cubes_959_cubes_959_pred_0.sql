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
-- DATASET 2
-- Tests DISTINCT vs ALL (multiplicity), multiple visitors named 'Vincent', ORDER BY ASC/DESC, and NULLS LAST behavior.
INSERT INTO "Locations" ("Location_ID", "Location_Name", "Address", "Other_Details") VALUES (1, 'Center', '456 Broadway', 'None');
INSERT INTO "Ref_Attraction_Types" ("Attraction_Type_Code", "Attraction_Type_Description") VALUES ('PARK', 'Theme Park');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (10, 'Vincent');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (20, 'Vincent');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (1, 'PARK', 1, 'Car', 'Zebra Zoo', 'Animals', '9-5', 'None');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (2, 'PARK', 1, 'Car', 'Alpha Arcade', 'Games', '9-5', 'None');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (3, 'PARK', 1, 'Car', NULL, 'Mystery', '9-5', 'None');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (1, 10, 1, '2023-05-01 10:00:00', 'First visit to Zoo');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (2, 10, 1, '2023-05-02 10:00:00', 'Second visit to Zoo');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (3, 20, 2, '2023-05-03 10:00:00', 'Other Vincent visit');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (4, 10, 3, '2023-05-04 10:00:00', 'Visit to NULL named attraction');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."tourist_attraction_id" AS "tourist_attraction_id", "LHS"."attraction_type_code" AS "attraction_type_code", "LHS"."location_id" AS "location_id", "LHS"."how_to_get_there" AS "how_to_get_there", "LHS"."name" AS "name", "LHS"."description" AS "description", "LHS"."opening_hours" AS "opening_hours", "LHS"."other_details" AS "other_details", "LHS"."visit_id" AS "visit_id", "LHS"."tourist_id" AS "tourist_id", "LHS"."visit_date" AS "visit_date", "LHS"."visit_details" AS "visit_details", "RHS"."tourist_details" AS "tourist_details" FROM (SELECT "LHS"."tourist_attraction_id" AS "tourist_attraction_id", "LHS"."attraction_type_code" AS "attraction_type_code", "LHS"."location_id" AS "location_id", "LHS"."how_to_get_there" AS "how_to_get_there", "LHS"."name" AS "name", "LHS"."description" AS "description", "LHS"."opening_hours" AS "opening_hours", "LHS"."other_details" AS "other_details", "RHS"."visit_id" AS "visit_id", "RHS"."tourist_id" AS "tourist_id", "RHS"."visit_date" AS "visit_date", "RHS"."visit_details" AS "visit_details" FROM "tourist_attractions" AS "LHS" INNER JOIN "visits" AS "RHS" ON ("LHS"."tourist_attraction_id" = "RHS"."tourist_attraction_id")) AS "LHS" INNER JOIN (SELECT * FROM "visitors" WHERE ("tourist_details" = 'Vincent')) AS RHS ON (LHS.tourist_id = RHS.tourist_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Arcade',)
('Zebra Zoo',)
('Zebra Zoo',)
*/

-- Prediction Query
SELECT T1.Name FROM Tourist_Attractions AS T1 JOIN VISITS AS T2 ON T1.Tourist_Attraction_ID = T2.Tourist_Attraction_ID JOIN VISITORS AS T3 ON T2.Tourist_ID = T3.Tourist_ID WHERE T3.Tourist_Details = 'Vincent';

/*
Prediction Result:
('Zebra Zoo',)
('Zebra Zoo',)
('Alpha Arcade',)
(None,)
*/