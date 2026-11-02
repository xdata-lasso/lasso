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
INSERT INTO Ref_Hotel_Star_Ratings (star_rating_code, star_rating_description) VALUES ('5-STAR', 'Luxury Five Star');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (1, 'Downtown', '100 Main St', 'Loc Details 1');
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('MUSEUM', 'Historical Museum');
INSERT INTO Features (Feature_ID, Feature_Details) VALUES (1, 'Parking Available');
INSERT INTO Hotels (hotel_id, star_rating_code, pets_allowed_yn, price_range, other_hotel_details) VALUES (1, '5-STAR', 'Y', 250.0, 'Hotel Details 1');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (1, 'MUSEUM', 1, 'Bus', 'City Museum', 'Art and History', '9-5', 'Attraction Details 1');
INSERT INTO Street_Markets (Market_ID, Market_Details) VALUES (1, 'Market Details 1');
INSERT INTO Shops (Shop_ID, Shop_Details) VALUES (1, 'Shop Details 1');
INSERT INTO Museums (Museum_ID, Museum_Details) VALUES (1, 'Museum Details 1');
INSERT INTO Royal_Family (Royal_Family_ID, Royal_Family_Details) VALUES (1, 'Royal Details 1');
INSERT INTO Theme_Parks (Theme_Park_ID, Theme_Park_Details) VALUES (1, 'Theme Park Details 1');
INSERT INTO Photos (Photo_ID, Tourist_Attraction_ID, Name, Description, Filename, Other_Details) VALUES (1, 1, 'Front View', 'Entrance', 'front.jpg', 'Photo Details 1');
INSERT INTO Staff (Staff_ID, Tourist_Attraction_ID, Name, Other_Details) VALUES (1, 1, 'John Smith', 'Staff Details 1');
INSERT INTO Tourist_Attraction_Features (Tourist_Attraction_ID, Feature_ID) VALUES (1, 1);
INSERT INTO Visitors (Tourist_ID, Tourist_Details) VALUES (1, 'Charlie');
INSERT INTO Visitors (Tourist_ID, Tourist_Details) VALUES (2, 'Bob');
INSERT INTO Visitors (Tourist_ID, Tourist_Details) VALUES (3, 'Alice');
INSERT INTO Visitors (Tourist_ID, Tourist_Details) VALUES (4, 'Bob');
INSERT INTO Visits (Visit_ID, Tourist_ID, Tourist_Attraction_ID, Visit_Date, Visit_Details) VALUES (1, 1, 1, '2023-05-01 10:00:00', 'First Visit');
INSERT INTO Visits (Visit_ID, Tourist_ID, Tourist_Attraction_ID, Visit_Date, Visit_Details) VALUES (2, 1, 1, '2023-05-02 14:00:00', 'Second Visit');
INSERT INTO Visits (Visit_ID, Tourist_ID, Tourist_Attraction_ID, Visit_Date, Visit_Details) VALUES (3, 2, 1, '2023-05-03 11:00:00', 'Solo Visit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT tourist_details FROM visitors ORDER BY tourist_details, visitors.tourist_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Tourist_Details FROM VISITORS;

/*
Prediction Result:
('Charlie',)
('Bob',)
('Alice',)
('Bob',)
*/