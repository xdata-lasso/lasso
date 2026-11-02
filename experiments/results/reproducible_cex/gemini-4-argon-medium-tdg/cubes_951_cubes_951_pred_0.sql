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
INSERT INTO "Locations" ("Location_ID", "Location_Name", "Address", "Other_Details") VALUES (1, 'Downtown', '123 Main St', 'None');
INSERT INTO "Ref_Attraction_Types" ("Attraction_Type_Code", "Attraction_Type_Description") VALUES ('MUSEUM', 'Museum');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (1, 'Vincent');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (2, 'Vivian');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (3, 'Victor');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (4, 'Vincent');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (10, 'MUSEUM', 1, 'Bus', 'Zoo', 'City Zoo', '9-5', 'None');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (20, 'MUSEUM', 1, 'Walk', 'Aquarium', 'City Aquarium', '10-6', 'None');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (30, 'MUSEUM', 1, 'Subway', 'Botanical Garden', 'Plants', '8-4', 'None');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (100, 1, 10, '2023-05-10 10:00:00', 'Morning visit');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (101, 2, 20, '2023-05-12 14:00:00', 'Afternoon visit');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (102, 1, 20, '2023-05-01 09:00:00', 'Early visit');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (103, 3, 10, '2023-05-15 11:00:00', 'Other tourist');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "visit_date" FROM (SELECT "LHS"."tourist_id" AS "tourist_id", "LHS"."tourist_details" AS "tourist_details", "LHS"."tourist_attraction_id" AS "tourist_attraction_id", "LHS"."attraction_type_code" AS "attraction_type_code", "LHS"."location_id" AS "location_id", "LHS"."how_to_get_there" AS "how_to_get_there", "LHS"."name" AS "name", "LHS"."description" AS "description", "LHS"."opening_hours" AS "opening_hours", "LHS"."other_details" AS "other_details", "RHS"."visit_id" AS "visit_id", "RHS"."visit_date" AS "visit_date", "RHS"."visit_details" AS "visit_details" FROM (SELECT "LHS"."tourist_id" AS "tourist_id", "LHS"."tourist_details" AS "tourist_details", "RHS"."tourist_attraction_id" AS "tourist_attraction_id", "RHS"."attraction_type_code" AS "attraction_type_code", "RHS"."location_id" AS "location_id", "RHS"."how_to_get_there" AS "how_to_get_there", "RHS"."name" AS "name", "RHS"."description" AS "description", "RHS"."opening_hours" AS "opening_hours", "RHS"."other_details" AS "other_details" FROM "visitors" AS "LHS" CROSS JOIN "tourist_attractions" AS "RHS") AS "LHS" INNER JOIN "visits" AS "RHS" ON ("LHS"."tourist_id" = "RHS"."tourist_id" AND "LHS"."tourist_attraction_id" = "RHS"."tourist_attraction_id")) WHERE ("tourist_details" = 'Vincent' OR "tourist_details" = 'Vivian') ORDER BY name, "name" NULLS LAST, "visit_date" NULLS LAST;

/*
Gold Result:
('Aquarium', '2023-05-01 09:00:00')
('Aquarium', '2023-05-12 14:00:00')
('Zoo', '2023-05-10 10:00:00')
*/

-- Prediction Query
SELECT T1.Name, T3.Visit_Date FROM Tourist_Attractions AS T1 CROSS JOIN VISITORS AS T2 JOIN VISITS AS T3 ON T1.Tourist_Attraction_ID = T3.Tourist_Attraction_ID AND T2.Tourist_ID = T3.Tourist_ID WHERE T2.Tourist_Details = 'Vincent' OR T2.Tourist_Details = 'Vivian';

/*
Prediction Result:
('Zoo', '2023-05-10 10:00:00')
('Aquarium', '2023-05-12 14:00:00')
('Aquarium', '2023-05-01 09:00:00')
*/