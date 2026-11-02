-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Apartment_Buildings" ("building_id") VALUES (1);
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_number") VALUES (1, 1, 'B');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_number") VALUES (2, 1, 'A');
INSERT INTO "Guests" ("guest_id") VALUES (1);
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code") VALUES (1, 1, 1, 'Confirmed');
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code") VALUES (2, 1, 2, 'Confirmed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "apt_number" FROM (SELECT "LHS"."apt_id" AS "apt_id", "LHS"."building_id" AS "building_id", "LHS"."apt_type_code" AS "apt_type_code", "LHS"."apt_number" AS "apt_number", "LHS"."bathroom_count" AS "bathroom_count", "LHS"."bedroom_count" AS "bedroom_count", "LHS"."room_count" AS "room_count", "RHS"."apt_booking_id" AS "apt_booking_id", "RHS"."guest_id" AS "guest_id", "RHS"."booking_status_code" AS "booking_status_code", "RHS"."booking_start_date" AS "booking_start_date", "RHS"."booking_end_date" AS "booking_end_date" FROM "apartments" AS "LHS" INNER JOIN "apartment_bookings" AS "RHS" ON ("LHS"."apt_id" = "RHS"."apt_id")) WHERE ("booking_status_code" = 'Confirmed') ORDER BY apt_number, "apt_number" NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT DISTINCT T2.apt_number FROM Apartment_Bookings AS T1 JOIN Apartments AS T2 ON T1.apt_id = T2.apt_id WHERE T1.booking_status_code = 'Confirmed';

/*
Prediction Result:
('B',)
('A',)
*/