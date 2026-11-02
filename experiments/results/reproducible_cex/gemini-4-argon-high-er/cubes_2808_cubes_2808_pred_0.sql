-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (1, 'B1', 'Building 1', 'Desc', 'Addr', 'Mgr', '123');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (1, 1, 'Studio', 'Suite 634', 1, 1, '2');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (1, 'M', 'John', 'Doe', '1990-01-01');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1, 1, 1, 'Provisional', '2023-01-01', '2023-01-05');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (2, 1, 1, 'Confirmed', '2023-02-01', '2023-02-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "booking_status_code" FROM (SELECT "LHS"."apt_booking_id" AS "apt_booking_id", "LHS"."apt_id" AS "apt_id", "LHS"."guest_id" AS "guest_id", "LHS"."booking_status_code" AS "booking_status_code", "LHS"."booking_start_date" AS "booking_start_date", "LHS"."booking_end_date" AS "booking_end_date", "RHS"."building_id" AS "building_id", "RHS"."apt_type_code" AS "apt_type_code", "RHS"."apt_number" AS "apt_number", "RHS"."bathroom_count" AS "bathroom_count", "RHS"."bedroom_count" AS "bedroom_count", "RHS"."room_count" AS "room_count" FROM "apartment_bookings" AS "LHS" LEFT JOIN "apartments" AS "RHS" ON ("LHS"."apt_id" = "RHS"."apt_id")) WHERE ("apt_number" = 'Suite 634') ORDER BY booking_status_code, "booking_status_code" NULLS LAST;

/*
Gold Result:
('Confirmed',)
('Provisional',)
*/

-- Prediction Query
SELECT T1.booking_status_code FROM Apartment_Bookings AS T1 JOIN Apartments AS T2 ON T1.apt_id = T2.apt_id WHERE T2.apt_number = 'Suite 634';

/*
Prediction Result:
('Provisional',)
('Confirmed',)
*/