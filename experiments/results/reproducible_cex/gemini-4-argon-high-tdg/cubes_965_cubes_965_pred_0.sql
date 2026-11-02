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
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (1, 'Westminster', 'London SW1A', 'Central');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (2, 'Windsor', 'Berkshire SL4', 'Suburban');
INSERT INTO Locations (Location_ID, Location_Name, Address, Other_Details) VALUES (3, 'Edinburgh', 'Castlehill EH1', 'Historic');
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('PAL', 'Palace');
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('MUS', 'Museum');
INSERT INTO Ref_Attraction_Types (Attraction_Type_Code, Attraction_Type_Description) VALUES ('SHP', 'Shop');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (1, 'PAL', 2, 'Take Tube to Victoria', 'Buckingham Palace', 'Z_Official Residence', '09:00-17:00', 'Crown Jewels Info');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (2, 'PAL', 3, 'Train from Paddington', 'Windsor Castle', 'A_Oldest Occupied Castle', '10:00-16:00', 'State Apartments');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (3, 'PAL', 1, 'Walk from Royal Mile', 'Holyrood Palace', 'M_Scottish Royal Palace', '09:30-18:00', 'Abbey Ruins');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (4, 'MUS', 1, 'Bus 14 to South Kensington', 'Victoria Museum', 'B_Art and Design Museum', '10:00-17:45', 'Free Entry');
INSERT INTO Tourist_Attractions (Tourist_Attraction_ID, Attraction_Type_Code, Location_ID, How_to_Get_There, Name, Description, Opening_Hours, Other_Details) VALUES (5, 'SHP', 2, 'Underground to Piccadilly', 'Royal Gift Shop', 'C_Souvenir Store', '08:00-20:00', 'Tax Free');
INSERT INTO Royal_Family (Royal_Family_ID, Royal_Family_Details) VALUES (1, 'A_Monarch_Details');
INSERT INTO Royal_Family (Royal_Family_ID, Royal_Family_Details) VALUES (2, 'Z_Monarch_Details');
INSERT INTO Royal_Family (Royal_Family_ID, Royal_Family_Details) VALUES (3, 'M_Monarch_Details');
INSERT INTO Museums (Museum_ID, Museum_Details) VALUES (4, 'National Collection');
INSERT INTO Shops (Shop_ID, Shop_Details) VALUES (5, 'Official Merchandise');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT description AS royal_family_details, how_to_get_there FROM (SELECT LHS.tourist_attraction_id AS tourist_attraction_id, LHS.attraction_type_code AS attraction_type_code, LHS.location_id AS location_id, LHS.how_to_get_there AS how_to_get_there, LHS.name AS name, LHS.description AS description, LHS.opening_hours AS opening_hours, LHS.other_details AS other_details, RHS.royal_family_details AS royal_family_details FROM tourist_attractions AS LHS INNER JOIN royal_family AS RHS ON (LHS.tourist_attraction_id = RHS.royal_family_id)) ORDER BY royal_family_details, how_to_get_there NULLS LAST;

/*
Gold Result:
('A_Oldest Occupied Castle', 'Train from Paddington')
('M_Scottish Royal Palace', 'Walk from Royal Mile')
('Z_Official Residence', 'Take Tube to Victoria')
*/

-- Prediction Query
SELECT T1.Royal_Family_Details, T2.How_to_Get_There FROM ROYAL_FAMILY AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Royal_Family_ID = T2.Tourist_Attraction_ID;

/*
Prediction Result:
('A_Monarch_Details', 'Take Tube to Victoria')
('Z_Monarch_Details', 'Train from Paddington')
('M_Monarch_Details', 'Walk from Royal Mile')
*/