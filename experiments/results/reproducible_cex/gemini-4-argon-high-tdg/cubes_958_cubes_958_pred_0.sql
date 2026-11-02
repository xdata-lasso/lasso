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
INSERT INTO "Locations" ("Location_ID", "Location_Name", "Address", "Other_Details") VALUES (1, 'Downtown', '100 Main St', 'Central area');
INSERT INTO "Ref_Attraction_Types" ("Attraction_Type_Code", "Attraction_Type_Description") VALUES ('MUSEUM', 'Historical and Art Museums');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (1, 'MUSEUM', 1, 'Bus', 'City Museum', 'History', '9-5', 'None');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (2, 'MUSEUM', 1, 'Walk', 'Art Gallery', 'Modern Art', '10-6', 'None');
INSERT INTO "Tourist_Attractions" ("Tourist_Attraction_ID", "Attraction_Type_Code", "Location_ID", "How_to_Get_There", "Name", "Description", "Opening_Hours", "Other_Details") VALUES (3, 'MUSEUM', 1, 'Metro', 'Science Center', 'Science', '8-4', 'None');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (1, 'Alice');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (2, 'Bob');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (3, 'Charlie');
INSERT INTO "Visitors" ("Tourist_ID", "Tourist_Details") VALUES (4, 'Diana');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (1, 3, 2, '2023-06-15 14:00:00', 'B');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (2, 1, 3, '2021-03-10 09:30:00', 'D');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (3, 2, 1, '2023-06-15 14:00:00', 'A');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (4, 4, 1, '2022-11-20 18:15:00', 'E');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (5, 2, 2, '2024-01-05 08:00:00', 'C');
INSERT INTO "Visits" ("Visit_ID", "Tourist_ID", "Tourist_Attraction_ID", "Visit_Date", "Visit_Details") VALUES (6, 1, 3, '2022-11-20 07:45:00', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT visit_date FROM visits ORDER BY visit_date, visits.visit_id NULLS LAST;

/*
Gold Result:
('2021-03-10 09:30:00',)
('2022-11-20 07:45:00',)
('2022-11-20 18:15:00',)
('2023-06-15 14:00:00',)
('2023-06-15 14:00:00',)
('2024-01-05 08:00:00',)
*/

-- Prediction Query
SELECT DISTINCT Visit_Date FROM VISITS;

/*
Prediction Result:
('2023-06-15 14:00:00',)
('2021-03-10 09:30:00',)
('2022-11-20 18:15:00',)
('2024-01-05 08:00:00',)
('2022-11-20 07:45:00',)
*/