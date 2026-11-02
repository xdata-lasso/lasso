-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (12, '-387', '-387', '-387', '-387', '-387', '-387');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (11, 12, '18', '19', -387, 20, '21');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (10, 12, '-387', '-387', -388, -387, '-387');
INSERT INTO "Apartment_Facilities" ("apt_id", "facility_code") VALUES (11, '-387');
INSERT INTO "Guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (14, '-387', '-387', '-387', -387);
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (15, 14, 11, '-387', -387, -387);
INSERT INTO "View_Unit_Status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES (17, 15, 11, -387);
INSERT INTO "View_Unit_Status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES (16, 15, 11, -387);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MIN(bathroom_count) OVER () AS min_bathroom_count_, maxbathroom_count AS max_bathroom_count_ FROM (SELECT apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count, MAX(bathroom_count) OVER () AS maxbathroom_count FROM apartments) ORDER BY min_bathroom_count_, max_bathroom_count_ NULLS LAST;

/*
Gold Result:
(-388, -387)
*/

-- Prediction Query
SELECT MIN(bathroom_count), MAX(bathroom_count) FROM Apartments;

/*
Prediction Result:
(-388, -387)
*/