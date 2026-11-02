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
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1, 1, 'lhs_a9bea0', 'lhs_0b91a2', 1, 1, 'lhs_aef0fd');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483648, 1, 'lhs_084282', 'lhs_e038e5', 1, 1, 'lhs_3e0236');

-- Inserting into table: apartment_buildings --
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1, 'apa_4d20e1', 'apa_50a089', 'apa_de7e8d', 'apa_139439', 'apa_9c102e', 'apa_269390');

-- Inserting into table: guests --
INSERT INTO "guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (-2147483648, '2', 'gue_4d584f', 'gue_881515', '2025-11-23 07:28:46+00:00');

-- Inserting into table: apartment_bookings --
INSERT INTO "apartment_bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (1, -2147483648, -2147483648, 'apa_1ecede', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00');

-- Inserting into table: view_unit_status --
INSERT INTO "view_unit_status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES ('2024-06-15 00:00:00+00:00', 1, 1, 2);

INSERT INTO "view_unit_status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES ('2024-12-15 00:56:33+00:00', 1, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_number FROM (SELECT * FROM apartments AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM view_unit_status WHERE (available_yn <> 1)) AS RHS WHERE (LHS.apt_id = RHS.apt_id))) ORDER BY apt_number;

/*
Gold Result:
('lhs_0b91a2',)
*/

-- Prediction Query
SELECT T1.apt_number FROM Apartments AS T1 JOIN View_Unit_Status AS T2 ON T1.apt_id = T2.apt_id WHERE T2.available_yn = 0 INTERSECT SELECT T1.apt_number FROM Apartments AS T1 JOIN View_Unit_Status AS T2 ON T1.apt_id = T2.apt_id WHERE T2.available_yn = 1;

/*
Prediction Result:
*/