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
INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (1, 'attraction_ty_1', -2147483648, 'tou_e811c3', 't1__1750e4', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (-2147483647, 'attraction_ty_1', -2147483648, 'tou_e811c3', 't1__1750e4', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (-2147483646, 'attraction_ty_1', -2147483648, 'tou_e811c3', 't1__03b25f', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (2, 'attraction_ty_1', -2147483648, 'tou_e811c3', 't1__79392f', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (3, 'attraction_ty_1', -2147483648, 'tou_e811c3', 't1__79392f', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (4, 'attraction_ty_1', -2147483648, 'tou_e811c3', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (5, 'attraction_ty_1', -2147483648, 'tou_e811c3', 'tou_77df77', 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (6, 'attraction_ty_1', -2147483648, 'tou_e811c3', NULL, 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

INSERT INTO "tourist_attractions" ("tourist_attraction_id", "attraction_type_code", "location_id", "how_to_get_there", "name", "description", "opening_hours", "other_details") VALUES (7, 'attraction_ty_1', -2147483648, 'tou_e811c3', NULL, 'tou_c7a55d', 'tou_c29f85', 'tou_2e17b3');

-- Inserting into table: locations --
INSERT INTO "locations" ("location_id", "location_name", "address", "other_details") VALUES (-2147483648, 'loc_9ab024', 'loc_7925b7', 'loc_d8a7fd');

-- Inserting into table: ref_attraction_types --
INSERT INTO "ref_attraction_types" ("attraction_type_code", "attraction_type_description") VALUES ('attraction_ty_1', 'ref_cff9ae');

-- Inserting into table: visitors --
INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (1, 'Alison');

INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (-2147483647, 'Alison');

INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (-2147483646, 'Alison');

INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (3, 'Alison');

INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (2, 'vis_e91a82');

INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (4, 'Rosalind');

INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (5, NULL);

INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (6, 'Alison');

INSERT INTO "visitors" ("tourist_id", "tourist_details") VALUES (7, 'Rosalind');

-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483648, 1, 1, '2024-02-19 01:18:26+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483647, 1, 1, '2022-06-06 02:35:43+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483646, 1, 1, '2025-02-21 23:30:13+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483645, 1, 1, '2024-07-26 19:47:18+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483644, 1, 1, '2020-04-30 23:22:06+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483643, 1, 1, '2024-01-16 07:29:50+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483642, 1, 1, '2022-04-15 05:01:35+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483641, 1, 1, '2021-02-21 20:09:01+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483640, 1, 2, '2020-01-15 18:18:33+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483639, 1, 2, '2023-10-02 15:43:02+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483638, 1, 2, '2020-12-10 17:36:20+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483637, 1, 1, '2022-07-05 02:28:20+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483636, 2, 1, '2022-01-03 02:42:55+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483635, 1, 1, '2024-04-12 00:38:47+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483634, 1, 2, '2020-06-20 11:35:06+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483633, 1, 1, '2021-07-11 07:27:32+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483632, 2, 1, '2020-03-11 00:23:16+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483631, 1, 1, '2025-02-07 06:53:31+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483630, 1, 2, '2025-09-01 05:13:03+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483629, 1, 1, '2025-03-03 08:26:45+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483628, 2, 1, '2021-02-17 05:47:13+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483627, 1, 1, '2021-01-29 03:06:29+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483626, 1, 1, '2022-12-10 02:38:39+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483625, 1, 3, '2024-05-04 23:07:19+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483624, 1, 1, '2024-12-31 04:19:17+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483623, 2, 1, '2024-10-02 15:57:32+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483622, 1, 1, '2024-03-03 15:52:53+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483621, 1, 3, '2020-04-28 17:03:46+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483620, 1, 1, '2025-03-10 20:24:26+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483619, 2, 1, '2020-12-01 20:25:15+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483618, 1, 1, '2021-02-10 21:10:52+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483617, 1, 3, '2022-09-29 20:25:58+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483616, 1, 1, '2020-03-09 02:18:16+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483615, 2, 1, '2025-10-02 08:51:14+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483614, 1, 1, '2025-01-09 01:18:18+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483613, 1, 3, '2022-05-20 13:35:30+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483612, 1, 1, '2024-12-28 10:57:01+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483611, 2, 1, '2022-03-17 22:33:35+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483610, 1, 2, '2024-04-01 02:40:29+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483609, 1, 1, '2020-02-25 10:33:58+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483608, 2, 1, '2024-11-25 22:27:17+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483607, 1, 1, '2020-08-22 17:31:36+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (2, 1, 1, '2022-02-19 15:51:21+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (3, 1, 1, '2020-01-22 05:30:29+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483604, 1, 1, '2023-08-20 20:02:04+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483603, 1, 1, '2022-07-23 18:54:52+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483602, 1, 1, '2024-09-13 14:36:04+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483601, 1, 1, '2021-07-01 18:29:24+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483600, 1, 1, '2021-03-25 19:22:18+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483599, 1, 1, '2022-08-31 15:38:50+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483598, 1, 1, '2022-05-13 17:57:39+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483597, 1, 1, '2023-03-13 16:07:34+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483596, 1, 1, '2021-03-27 18:00:10+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483595, 1, 1, '2023-12-31 18:03:51+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483594, 1, 1, '2021-03-04 06:15:13+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483593, 1, 1, '2024-09-10 08:04:52+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483592, 1, 1, '2024-08-09 01:13:45+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483591, 1, 1, '2025-12-29 07:05:42+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483590, 1, 1, '2023-11-06 04:09:03+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483589, 1, 1, '2023-02-15 11:45:56+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483588, 1, 1, '2020-03-11 08:08:02+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483587, 1, 1, '2020-06-06 08:33:45+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483586, 1, 1, '2023-09-26 13:08:37+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483585, 1, 1, '2020-12-04 21:49:29+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483584, 1, 1, '2020-04-10 05:04:30+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (-2147483583, 1, 1, '2025-05-09 05:17:21+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (4, 4, 4, '2025-05-27 16:57:17+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (5, 5, 5, '2024-02-19 01:18:26+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (6, 6, 6, '2024-02-19 01:18:26+00:00', 'vis_56194a');

INSERT INTO "visits" ("visit_id", "tourist_id", "tourist_attraction_id", "visit_date", "visit_details") VALUES (7, 7, 7, '2023-01-16 20:10:41+00:00', 'vis_56194a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."tourist_id" AS "tourist_id", "LHS"."tourist_details" AS "tourist_details", "LHS"."tourist_attraction_id" AS "tourist_attraction_id", "LHS"."attraction_type_code" AS "attraction_type_code", "LHS"."location_id" AS "location_id", "LHS"."how_to_get_there" AS "how_to_get_there", "LHS"."name" AS "name", "LHS"."description" AS "description", "LHS"."opening_hours" AS "opening_hours", "LHS"."other_details" AS "other_details", "RHS"."visit_id" AS "visit_id", "RHS"."visit_date" AS "visit_date", "RHS"."visit_details" AS "visit_details" FROM (SELECT "LHS"."tourist_id" AS "tourist_id", "LHS"."tourist_details" AS "tourist_details", "RHS"."tourist_attraction_id" AS "tourist_attraction_id", "RHS"."attraction_type_code" AS "attraction_type_code", "RHS"."location_id" AS "location_id", "RHS"."how_to_get_there" AS "how_to_get_there", "RHS"."name" AS "name", "RHS"."description" AS "description", "RHS"."opening_hours" AS "opening_hours", "RHS"."other_details" AS "other_details" FROM "visitors" AS "LHS" CROSS JOIN "tourist_attractions" AS "RHS") AS "LHS" INNER JOIN "visits" AS "RHS" ON ("LHS"."tourist_id" = "RHS"."tourist_id" AND "LHS"."tourist_attraction_id" = "RHS"."tourist_attraction_id")) WHERE ("tourist_details" = 'Alison' AND "tourist_details" <> 'Rosalind') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__1750e4',)
('t1__79392f',)
('t1__79392f',)
('t1__79392f',)
('t1__79392f',)
('t1__79392f',)
('t1__79392f',)
('t1__79392f',)
('t1__79392f',)
('t1__79392f',)
('t1__79392f',)
*/

-- Prediction Query
SELECT T1.Name FROM Tourist_Attractions AS T1 CROSS JOIN VISITORS AS T2 JOIN VISITS AS T3 ON T1.Tourist_Attraction_ID = T3.Tourist_Attraction_ID AND T2.Tourist_ID = T3.Tourist_ID WHERE T2.Tourist_Details = 'Alison' EXCEPT SELECT T1.Name FROM Tourist_Attractions AS T1 CROSS JOIN VISITORS AS T2 JOIN VISITS AS T3 ON T1.Tourist_Attraction_ID = T3.Tourist_Attraction_ID AND T2.Tourist_ID = T3.Tourist_ID WHERE T2.Tourist_Details = 'Rosalind';

/*
Prediction Result:
('t1__1750e4',)
('t1__79392f',)
*/