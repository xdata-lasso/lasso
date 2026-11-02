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
INSERT INTO "Locations" ("Location_ID", "Location_Name", "Address", "Other_Details") VALUES (1, 'Downtown', '100 Center St', 'Main district');
INSERT INTO "Ref_Attraction_Types" ("Attraction_Type_Code", "Attraction_Type_Description") VALUES ('CULT', 'Cultural');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (10, 'CULT', 1, 'Bus', 'museum', 'art museum', '9-5', 'Indoor');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (20, 'CULT', 1, 'Metro', 'film festival', 'annual cinema event', '10-22', 'Tickets required');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (30, 'CULT', 1, 'Walk', 'botanical garden', 'city park', '8-18', 'Outdoor');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (40, 'CULT', 1, 'Tram', 'film festival', 'indie film showcase', '12-23', 'VIP pass');
INSERT INTO "Photos" ("Photo_ID", "Tourist_Attraction_ID", "Name", "Description", "Filename", "Other_Details") VALUES (10, 20, 'red carpet', 'opening night', 'carpet.jpg', 'HD');
INSERT INTO "Photos" ("Photo_ID", "Tourist_Attraction_ID", "Name", "Description", "Filename", "Other_Details") VALUES (20, 10, 'film festival', 'statue photo', 'statue.jpg', 'BW');
INSERT INTO "Photos" ("Photo_ID", "Tourist_Attraction_ID", "Name", "Description", "Filename", "Other_Details") VALUES (30, 30, 'flowers', 'spring bloom', 'bloom.jpg', 'Color');
INSERT INTO "Photos" ("Photo_ID", "Tourist_Attraction_ID", "Name", "Description", "Filename", "Other_Details") VALUES (40, 40, 'award ceremony', 'best director', 'award.jpg', 'HD');
INSERT INTO "Photos" ("Photo_ID", "Tourist_Attraction_ID", "Name", "Description", "Filename", "Other_Details") VALUES (50, 20, 'screening', 'main theater', 'screen.jpg', 'Wide');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "description" FROM (SELECT * FROM "photos" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "tourist_attractions" WHERE ("name" <> 'film festival')) AS RHS WHERE (LHS.tourist_attraction_id = RHS.tourist_attraction_id))) ORDER BY name, "name" NULLS LAST, "description" NULLS LAST;

/*
Gold Result:
('award ceremony', 'best director')
('red carpet', 'opening night')
('screening', 'main theater')
*/

-- Prediction Query
SELECT T1.Name, T1.Description FROM PHOTOS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID = T2.Tourist_Attraction_ID WHERE T2.Name = 'film festival';

/*
Prediction Result:
('red carpet', 'opening night')
('award ceremony', 'best director')
('screening', 'main theater')
*/