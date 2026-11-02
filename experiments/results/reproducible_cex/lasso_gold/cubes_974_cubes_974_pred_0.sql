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
INSERT INTO "locations" ("location_id", "location_name", "address", "other_details") VALUES (1041, '1746 Mason Park Suite 190
Navarroview, AK 12471', '490 Thomas Run
Moonburgh, OR 57633', 'prove');
INSERT INTO "locations" ("location_id", "location_name", "address", "other_details") VALUES (1047, '662 Hanna Crossroad Suite 171
Smithberg, MT 86324', 'Unit 1745 Box 9615
DPO AP 70443', 'husband');
INSERT INTO "ref_attraction_types" ("attraction_type_code", "attraction_type_description") VALUES ('teach', 'Why like impact fly bit claim in.');
INSERT INTO "ref_attraction_types" ("attraction_type_code", "attraction_type_description") VALUES ('free', 'Responsibility service their along attention piece TV young.');
INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (1042, 'teach', 1041, 'mission', 'Tony Cervantes', 'Already because education break significant ten stay.', 'ability', 'really');
INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (1048, 'free', 1047, 'believe', 'Brett Schultz', 'Kitchen really tough animal.', 'style', 'arrive');
INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (1043, 1042, 'game1', 'Left approach million performance material kind appear.', 'Carlos Roberts', 'up');
INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (1046, 1042, 'game1', 'Necessary myself lay focus country recently.', 'Cynthia Rowe', 'animal');
INSERT INTO "photos" ("photo_id", "tourist_attraction_id", "name", "description", "filename", "other_details") VALUES (1049, 1048, 'game1', 'Grow issue each include radio.', 'Christopher Lynch', 'idea');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."tourist_attraction_id" AS "tourist_attraction_id", "LHS"."attraction_type_code" AS "attraction_type_code", "LHS"."location_id" AS "location_id", "LHS"."how_to_get_there" AS "how_to_get_there", "LHS"."name" AS "name", "LHS"."description" AS "description", "LHS"."opening_hours" AS "opening_hours", "LHS"."other_details" AS "other_details", "RHS"."photo_id" AS "photo_id", "RHS"."name" AS "name_other", "RHS"."description" AS "description_other", "RHS"."filename" AS "filename", "RHS"."other_details" AS "other_details_other" FROM "tourist_attractions" AS "LHS" INNER JOIN (SELECT * FROM "photos" WHERE ("name" = 'game1')) AS RHS ON (LHS.tourist_attraction_id = RHS.tourist_attraction_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Brett Schultz',)
('Tony Cervantes',)
('Tony Cervantes',)
*/

-- Prediction Query
SELECT T2.Name FROM PHOTOS AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Tourist_Attraction_ID = T2.Tourist_Attraction_ID WHERE T1.Name = 'game1';

/*
Prediction Result:
('Tony Cervantes',)
('Tony Cervantes',)
('Brett Schultz',)
*/