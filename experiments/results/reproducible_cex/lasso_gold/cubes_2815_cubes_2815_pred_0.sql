-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1050, 'Jennifer Clark', 'Taylor Silva', 'Task she herself.', '6688 Tracy Groves Suite 706
Elizabethfurt, VA 22133', 'though', '929.480.6990x162');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1054, 'Daniel Murphy', 'Jamie Walton', 'Edge bank affect much yourself glass.', '33092 David Skyway
New Staciemouth, UT 34087', 'speak', '(829)891-2419x049');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1051, 1050, 'Flat', 'decide', 1052, 1053, 'ever');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1055, 1054, 'Flat', 'apply', 1053, 1054, 'senior');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "apt_number" FROM "apartments" WHERE ("apt_type_code" = 'Flat') ORDER BY apt_number, apartments.apt_id NULLS LAST;

/*
Gold Result:
('apply',)
('decide',)
*/

-- Prediction Query
SELECT apt_number FROM Apartments WHERE apt_type_code = 'Flat';

/*
Prediction Result:
('decide',)
('apply',)
*/