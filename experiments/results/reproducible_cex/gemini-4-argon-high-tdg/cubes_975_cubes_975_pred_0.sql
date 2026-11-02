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
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('GAL', 'Gallery');
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('GRD', 'Garden');
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('CST', 'Castle');
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('ZOO', 'Zoo');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (100, 'North Sector', '660 Shea Crescent', 'Loc Details A');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (200, 'South Sector', '999 Other St', 'Loc Details B');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (40, 'Decoy Sector', '660 Shea Crescent', 'Loc Details C');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (10, 'GAL', 100, 'bus', 'Zeta Gallery', 'Modern art', '9-5', 'Attr Details 1');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (20, 'GRD', 200, 'walk', 'Alpha Gardens', 'Botanical', '8-6', 'Attr Details 2');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (30, 'CST', 100, 'walk', 'Mu Castle', 'Historic', '10-4', 'Attr Details 3');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (40, 'ZOO', 200, 'subway', 'Beta Zoo', 'Wildlife', '9-6', 'Attr Details 4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."tourist_attraction_id" AS "tourist_attraction_id", "LHS"."attraction_type_code" AS "attraction_type_code", "LHS"."location_id" AS "location_id", "LHS"."how_to_get_there" AS "how_to_get_there", "LHS"."name" AS "name", "LHS"."description" AS "description", "LHS"."opening_hours" AS "opening_hours", "LHS"."other_details" AS "other_details", "RHS"."location_name" AS "location_name", "RHS"."address" AS "address", "RHS"."other_details" AS "other_details_other" FROM "tourist_attractions" AS "LHS" INNER JOIN "locations" AS "RHS" ON ("LHS"."location_id" = "RHS"."location_id")) WHERE ("address" = '660 Shea Crescent' OR "how_to_get_there" = 'walk') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alpha Gardens',)
('Mu Castle',)
('Zeta Gallery',)
*/

-- Prediction Query
SELECT T2.Name FROM Locations AS T1 JOIN Tourist_Attractions AS T2 ON T1.Location_ID = T2.Location_ID WHERE T1.Address = '660 Shea Crescent' OR T2.How_to_Get_There = 'walk';

/*
Prediction Result:
('Zeta Gallery',)
('Alpha Gardens',)
('Mu Castle',)
*/