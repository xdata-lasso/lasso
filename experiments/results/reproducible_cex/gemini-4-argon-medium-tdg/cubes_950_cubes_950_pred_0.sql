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
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (1, 'UK Gallery', '10 Downing St', 'Detail B');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (2, 'UK Gallery', '11 Downing St', 'Detail A');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (3, 'UK Gallery', '12 Downing St', 'Detail A');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (4, 'UK Gallery', '13 Downing St', NULL);
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (5, 'British Museum', 'Great Russell St', 'Detail C');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (6, 'uk gallery', '14 Downing St', 'Lowercase Match');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (7, 'UK Gallery ', '15 Downing St', 'Trailing Space');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (8, NULL, '16 Downing St', 'Null Location Name');
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('MUSEUM', 'Museum Attraction');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (101, 'MUSEUM', 1, 'Bus', 'UK Gallery Main', 'Art gallery', '9-5', 'Attraction Detail 1');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (102, 'MUSEUM', 1, 'Train', 'UK Gallery Annex', 'Modern art', '10-6', 'Attraction Detail 2');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (103, 'MUSEUM', 5, 'Tube', 'UK Gallery', 'Named UK Gallery but at British Museum location', '9-5', 'Wrong Table Detail');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "other_details" FROM "locations" WHERE ("location_name" = 'UK Gallery') ORDER BY other_details, locations.location_id NULLS LAST;

/*
Gold Result:
(None,)
('Detail A',)
('Detail A',)
('Detail B',)
*/

-- Prediction Query
SELECT Other_Details FROM LOCATIONS WHERE Location_Name = 'UK Gallery';

/*
Prediction Result:
('Detail B',)
('Detail A',)
('Detail A',)
(None,)
*/