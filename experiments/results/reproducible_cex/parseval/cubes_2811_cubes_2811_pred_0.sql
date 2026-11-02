-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: apartments --
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483648, -2147483648, 'apa_28fd34', 'apa_8d69e6', -1437333179, -921145356, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1, -2147483648, 'apa_28fd34', 'apa_8d69e6', -1022641847, -1726781632, '7c69c');

-- Inserting into table: apartment_buildings --
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (-2147483648, 'apa_4d20e1', 'apa_50a089', 'apa_de7e8d', 'apa_139439', 'apa_9c102e', 'apa_269390');

-- Inserting into table: guests --
INSERT INTO "guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (1, 'Female', 'lhs_e5abdb', 'lhs_4af946', '2024-06-15 00:00:00+00:00');

INSERT INTO "guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (-2147483647, 'Female', 'lhs_4cfe96', 'lhs_676835', '2024-06-15 00:00:00+00:00');

-- Inserting into table: apartment_bookings --
INSERT INTO "apartment_bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (1, 1, -2147483648, 'apa_2f77c5', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "apartment_bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (-2147483647, 1, -2147483648, 'apa_b1cdf4', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "booking_start_date" AS "booking_start_date___1", "booking_start_date_other" AS "booking_start_date___2" FROM (SELECT "LHS"."guest_id" AS "guest_id", "LHS"."gender_code" AS "gender_code", "LHS"."guest_first_name" AS "guest_first_name", "LHS"."guest_last_name" AS "guest_last_name", "LHS"."date_of_birth" AS "date_of_birth", "RHS"."apt_booking_id" AS "apt_booking_id", "RHS"."apt_id" AS "apt_id", "RHS"."booking_status_code" AS "booking_status_code", "RHS"."booking_start_date" AS "booking_start_date", "RHS"."booking_end_date" AS "booking_end_date", "RHS"."apt_booking_id_other" AS "apt_booking_id_other", "RHS"."booking_status_code_other" AS "booking_status_code_other", "RHS"."booking_start_date_other" AS "booking_start_date_other", "RHS"."booking_end_date_other" AS "booking_end_date_other" FROM "guests" AS "LHS" INNER JOIN (SELECT "LHS"."apt_booking_id" AS "apt_booking_id", "LHS"."apt_id" AS "apt_id", "LHS"."guest_id" AS "guest_id", "LHS"."booking_status_code" AS "booking_status_code", "LHS"."booking_start_date" AS "booking_start_date", "LHS"."booking_end_date" AS "booking_end_date", "RHS"."apt_booking_id" AS "apt_booking_id_other", "RHS"."booking_status_code" AS "booking_status_code_other", "RHS"."booking_start_date" AS "booking_start_date_other", "RHS"."booking_end_date" AS "booking_end_date_other" FROM "apartment_bookings" AS "LHS" INNER JOIN "apartment_bookings" AS "RHS" ON ("LHS"."apt_id" = "RHS"."apt_id" AND "LHS"."guest_id" = "RHS"."guest_id")) AS "RHS" ON ("LHS"."guest_id" = "RHS"."guest_id")) WHERE ("gender_code" = 'Female') ORDER BY booking_start_date___1, booking_start_date___2 NULLS LAST;

/*
Gold Result:
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
*/

-- Prediction Query
SELECT T1.booking_start_date, T1.booking_start_date FROM Apartment_Bookings AS T1 JOIN Guests AS T2 ON T1.guest_id = T2.guest_id WHERE T2.gender_code = 'Female';

/*
Prediction Result:
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
*/