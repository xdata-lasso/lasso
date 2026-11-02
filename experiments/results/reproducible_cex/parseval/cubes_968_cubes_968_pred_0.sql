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
INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (1, 'attraction_ty_1', -2147483648, 'walk', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (2, 'attraction_ty_1', -2147483648, 'bus', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (-2147483647, 'attraction_ty_1', -2147483648, 'bus', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (3, 'attraction_ty_1', -2147483648, 'tou_e811c3', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (4, 'attraction_ty_1', -2147483648, NULL, 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (5, 'attraction_ty_1', -2147483648, NULL, 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (6, 'attraction_ty_1', -2147483648, NULL, 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (7, 'attraction_ty_1', -2147483648, NULL, 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (8, 'attraction_ty_1', -2147483648, NULL, 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (9, 'attraction_ty_1', -2147483648, NULL, 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (10, 'attraction_ty_1', -2147483648, NULL, 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

-- Inserting into table: locations --
INSERT INTO "locations" ("location_id", "location_name", "address", "other_details") VALUES (-2147483648, 'loc_9ab024', 'loc_7925b7', 'loc_d8a7fd');

-- Inserting into table: ref_attraction_types --
INSERT INTO "ref_attraction_types" ("attraction_type_code", "attraction_type_description") VALUES ('attraction_ty_1', 'ref_cff9ae');

-- Inserting into table: street_markets --
INSERT INTO "street_markets" ("market_id", "market_details") VALUES (1, 't1__e749a2');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (2, 't1__e749a2');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (3, 't1__e749a2');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (4, 'str_32e225');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (5, 'str_32e225');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (6, 'str_32e225');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (7, 'str_32e225');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (8, 'str_32e225');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (9, 'str_32e225');

INSERT INTO "street_markets" ("market_id", "market_details") VALUES (10, 'str_32e225');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "market_details" FROM (SELECT "LHS"."market_id" AS "market_id", "LHS"."market_details" AS "market_details", "RHS"."tourist_attraction_id" AS "tourist_attraction_id", "RHS"."attraction_type_code" AS "attraction_type_code", "RHS"."location_id" AS "location_id", "RHS"."how_to_get_there" AS "how_to_get_there", "RHS"."name" AS "name", "RHS"."description" AS "description", "RHS"."opening_hours" AS "opening_hours", "RHS"."other_details" AS "other_details" FROM "street_markets" AS "LHS" CROSS JOIN (SELECT * FROM "tourist_attractions" WHERE ("how_to_get_there" <> 'walk' AND "how_to_get_there" = 'bus')) AS RHS) ORDER BY market_details, "market_details" NULLS LAST;

/*
Gold Result:
('str_32e225',)
('t1__e749a2',)
*/

-- Prediction Query
SELECT T1.Market_Details FROM Street_Markets AS T1 JOIN TOURIST_ATTRACTIONS AS T2 ON T1.Market_ID = T2.Tourist_Attraction_ID WHERE T2.How_to_Get_There = 'walk' OR T2.How_to_Get_There = 'bus';

/*
Prediction Result:
('t1__e749a2',)
('t1__e749a2',)
*/