-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1032, 'Toni Fitzgerald', 'Diane Beck', 'Friend stand seem pull different current agency each.', '6936 Ross Drive
Port Michelleville, WI 56225', 'discuss', '(987)708-3172');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1038, 'Michael Yates', 'Sara Calhoun', 'Move trade option production base investment term consider.', '75564 King Common Suite 080
Jeffreyland, WI 85927', 'amount', '001-603-730-9232x71937');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1033, 1032, 'someone', 'vote', 1034, 5, 'level');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1039, 1038, 'computer', 'police', 1040, 5, 'policy');
INSERT INTO "apartment_facilities" ("apt_id", "facility_code") VALUES (1033, 'position');
INSERT INTO "apartment_facilities" ("apt_id", "facility_code") VALUES (1033, 'air');
INSERT INTO "apartment_facilities" ("apt_id", "facility_code") VALUES (1039, 'small');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT facility_code FROM (SELECT * FROM apartment_facilities AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM apartments WHERE (bedroom_count > 4)) AS RHS WHERE (LHS.apt_id = RHS.apt_id))) ORDER BY facility_code;

/*
Gold Result:
('air',)
('position',)
('small',)
*/

-- Prediction Query
SELECT T1.facility_code FROM Apartment_Facilities AS T1 JOIN Apartments AS T2 ON T1.apt_id = T2.apt_id WHERE T2.bedroom_count > 4;

/*
Prediction Result:
('position',)
('air',)
('small',)
*/