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
INSERT INTO "Locations" ("Location_ID", "Location_Name", "Address", "Other_Details") VALUES (1, 'Downtown', '123 Main St', 'Central');
INSERT INTO "Ref_Attraction_Types" ("Attraction_Type_Code", "Attraction_Type_Description") VALUES ('MUS', 'Museum');
INSERT INTO "Ref_Attraction_Types" ("Attraction_Type_Code", "Attraction_Type_Description") VALUES ('PRK', 'Park');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (1, 'MUS', 1, 'Bus', 'City Museum', 'Desc_B', '09:00-17:00', 'None');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (2, 'PRK', 1, 'Walk', 'Central Park', 'Desc_A', '24 Hours', 'Green');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (3, 'PRK', 1, 'Walk', 'West Park', 'Desc_A', '08:00-20:00', 'Duplicate Description');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (4, 'MUS', 1, 'Subway', 'Mystery Spot', NULL, '10:00-18:00', 'Null Description');
INSERT INTO "Museums" ("Museum_ID", "Museum_Details") VALUES (1, 'Details_Z');
INSERT INTO "Museums" ("Museum_ID", "Museum_Details") VALUES (4, 'Details_A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT museum_details, description AS opening_hours FROM (SELECT LHS.tourist_attraction_id AS tourist_attraction_id, LHS.attraction_type_code AS attraction_type_code, LHS.location_id AS location_id, LHS.how_to_get_there AS how_to_get_there, LHS.name AS name, LHS.description AS description, LHS.opening_hours AS opening_hours, LHS.other_details AS other_details, RHS.museum_id AS museum_id, RHS.museum_details AS museum_details FROM tourist_attractions AS LHS CROSS JOIN museums AS RHS) ORDER BY museum_details, opening_hours NULLS LAST;

/*
Gold Result:
('Details_A', 'Desc_A')
('Details_A', 'Desc_B')
('Details_A', None)
('Details_Z', 'Desc_A')
('Details_Z', 'Desc_B')
('Details_Z', None)
*/

-- Prediction Query
SELECT T1.Museum_Details, T2.Opening_Hours FROM MUSEUMS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Museum_ID = T2.Tourist_Attraction_ID;

/*
Prediction Result:
('Details_Z', '09:00-17:00')
('Details_A', '10:00-18:00')
*/