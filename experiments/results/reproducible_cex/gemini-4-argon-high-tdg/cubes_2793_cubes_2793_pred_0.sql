-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1, 'B1', 'Oak Residence', 'Luxury units', '200 Oak St', 'Brenden', '555-0101');
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (2, 'B2', 'Elm Towers', 'Downtown apartments', '100 Elm St', 'Brenden', '555-0202');
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (3, 'B3', 'Pine Court', 'Quiet complex', '050 Pine St', 'Alice', '555-0303');
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (4, 'B4', 'Maple Suites', 'Modern living', '300 Maple St', 'Charlie', '555-0404');
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (5, 'B5', 'Cedar Lofts', 'Studio lofts', '400 Cedar St', NULL, '555-0505');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (101, 2, 'STUDIO', '2A', 1, 1, '2');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (102, 2, 'LUX', '2B', 2, 3, '5');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (103, 3, 'STD', '3A', 1, 2, '4');
INSERT INTO "Apartment_Facilities" ("apt_id", "facility_code") VALUES (101, 'WIFI');
INSERT INTO "Apartment_Facilities" ("apt_id", "facility_code") VALUES (102, 'POOL');
INSERT INTO "Guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (1, 'M', 'John', 'Doe', '1985-06-15 00:00:00');
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (1001, 1, 101, 'CONFIRMED', '2023-01-01 12:00:00', '2023-01-10 12:00:00');
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (1002, 1, 102, 'CONFIRMED', '2023-02-01 12:00:00', '2023-02-10 12:00:00');
INSERT INTO "View_Unit_Status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES ('2023-01-05 00:00:00', 1001, 101, 0);
INSERT INTO "View_Unit_Status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES ('2023-02-05 00:00:00', 1002, 102, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "building_address", "building_phone" FROM "apartment_buildings" WHERE ("building_manager" = 'Brenden') ORDER BY building_address, apartment_buildings.building_id NULLS LAST;

/*
Gold Result:
('100 Elm St', '555-0202')
('200 Oak St', '555-0101')
*/

-- Prediction Query
SELECT building_address, building_phone FROM Apartment_Buildings WHERE building_manager = 'Brenden';

/*
Prediction Result:
('200 Oak St', '555-0101')
('100 Elm St', '555-0202')
*/