-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1102, 'George Hobbs', 'Trevor Fisher', 'Like see appear weight.', '003 Mary Road
East David, TN 15494', 'Kyle', '001-437-645-2991');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1107, 'George Hobbs', 'Trevor Fisher', 'Like see appear weight.', '003 Mary Road
East David, TN 15494', 'Kyle', '001-437-645-2991');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1116, 'Allen Rosales', 'Daniel Salinas', 'Evidence other they new might course.', '8377 Mcguire Course Suite 363
Elizabethstad, NJ 73045', 'Kyle', '356.485.5744x43135');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1121, 'Allen Rosales', 'Daniel Salinas', 'Evidence other they new might course.', '8377 Mcguire Course Suite 363
Elizabethstad, NJ 73045', 'Kyle', '356.485.5744x43135');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1103, 1102, 'box', 'particular', 1104, 1105, 'agree');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1108, NULL, 'box', 'particular', 1104, 1105, 'agree');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1110, 1102, 'over', 'poor', 1111, 1112, 'relate');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1117, 1116, 'dark', 'direction', 1118, 1119, 'single');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1122, NULL, 'dark', 'direction', 1118, 1119, 'single');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "apt_type_code", "apt_number" FROM (SELECT "LHS"."apt_id" AS "apt_id", "LHS"."building_id" AS "building_id", "LHS"."apt_type_code" AS "apt_type_code", "LHS"."apt_number" AS "apt_number", "LHS"."bathroom_count" AS "bathroom_count", "LHS"."bedroom_count" AS "bedroom_count", "LHS"."room_count" AS "room_count", "RHS"."building_short_name" AS "building_short_name", "RHS"."building_full_name" AS "building_full_name", "RHS"."building_description" AS "building_description", "RHS"."building_address" AS "building_address", "RHS"."building_manager" AS "building_manager", "RHS"."building_phone" AS "building_phone" FROM "apartments" AS "LHS" LEFT JOIN "apartment_buildings" AS "RHS" ON ("LHS"."building_id" = "RHS"."building_id")) WHERE ("building_manager" = 'Kyle') ORDER BY apt_type_code, "apt_type_code" NULLS LAST, "apt_number" NULLS LAST;

/*
Gold Result:
('box', 'particular')
('dark', 'direction')
('over', 'poor')
*/

-- Prediction Query
SELECT T2.apt_type_code, T2.apt_number FROM Apartment_Buildings AS T1 JOIN Apartments AS T2 ON T1.building_id = T2.building_id WHERE T1.building_manager = 'Kyle';

/*
Prediction Result:
('box', 'particular')
('over', 'poor')
('dark', 'direction')
*/