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
-- Inserting into table: tourist_attractions --
INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (1, 'lhs_c6801e', 1, 'lhs_57fc60', 'lhs_a446c8', 'lhs_64769c', 'lhs_3a86bb', 'lhs_a1eb92');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (2, 'lhs_c6801e', 1, 'lhs_57fc60', 'lhs_a446c8', 'lhs_64769c', 'lhs_3a86bb', 'lhs_a1eb92');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (3, 'lhs_c6801e', 1, 'tou_e811c3', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (-2147483645, 'lhs_c6801e', 1, 'q_0_3527f8', 'tou_77df77', 'q_0_f19c98', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (-2147483644, 'lhs_c6801e', 1, 'q_0_3527f8', 'tou_77df77', 'q_0_f19c98', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (4, 'lhs_c6801e', 1, 'tou_e811c3', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (5, 'lhs_c6801e', 1, 'tou_e811c3', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

-- Inserting into table: locations --
INSERT INTO "locations" ("location_id", "location_name", "address", "other_details") VALUES (1, 'loc_9ab024', 'loc_7925b7', 'loc_d8a7fd');

-- Inserting into table: ref_attraction_types --
INSERT INTO "ref_attraction_types" ("attraction_type_code", "attraction_type_description") VALUES ('lhs_c6801e', 'ref_cff9ae');

-- Inserting into table: royal_family --
INSERT INTO "royal_family" ("royal_family_id", "royal_family_details") VALUES (1, 'rhs_727f43');

INSERT INTO "royal_family" ("royal_family_id", "royal_family_details") VALUES (3, 'rhs_727f43');

INSERT INTO "royal_family" ("royal_family_id", "royal_family_details") VALUES (4, 'roy_7a9205');

INSERT INTO "royal_family" ("royal_family_id", "royal_family_details") VALUES (5, 'roy_7a9205');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT description AS royal_family_details, how_to_get_there FROM (SELECT LHS.tourist_attraction_id AS tourist_attraction_id, LHS.attraction_type_code AS attraction_type_code, LHS.location_id AS location_id, LHS.how_to_get_there AS how_to_get_there, LHS.name AS name, LHS.description AS description, LHS.opening_hours AS opening_hours, LHS.other_details AS other_details, RHS.royal_family_details AS royal_family_details FROM tourist_attractions AS LHS INNER JOIN royal_family AS RHS ON (LHS.tourist_attraction_id = RHS.royal_family_id)) ORDER BY royal_family_details, how_to_get_there NULLS LAST;

/*
Gold Result:
('lhs_64769c', 'lhs_57fc60')
('tou_c7a55d', 'tou_e811c3')
('tou_c7a55d', 'tou_e811c3')
('tou_c7a55d', 'tou_e811c3')
*/

-- Prediction Query
SELECT T1.Royal_Family_Details, T2.How_to_Get_There FROM ROYAL_FAMILY AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Royal_Family_ID = T2.Tourist_Attraction_ID;

/*
Prediction Result:
('rhs_727f43', 'lhs_57fc60')
('rhs_727f43', 'tou_e811c3')
('roy_7a9205', 'tou_e811c3')
('roy_7a9205', 'tou_e811c3')
*/