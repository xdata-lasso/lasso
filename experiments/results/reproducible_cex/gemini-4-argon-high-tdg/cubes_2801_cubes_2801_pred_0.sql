-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (10, 'B10', 'Tower Ten', 'Luxury Tower', '10 Tenth Ave', 'Bob Jones', '555-0110');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (10, 10, 'PENT', '10A', 3, 5, '7');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (20, 10, 'PENT', '20A', 4, 6, '9');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (30, 10, 'FLAT', '30A', 1, 2, '4');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (10, 'POOL');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (10, 'GYM');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (20, 'POOL');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (20, 'WIFI');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (30, 'POOL');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (30, 'SAUNA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT facility_code FROM (SELECT * FROM apartment_facilities AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM apartments WHERE (bedroom_count > 4)) AS RHS WHERE (LHS.apt_id = RHS.apt_id))) ORDER BY facility_code;

/*
Gold Result:
('GYM',)
('POOL',)
('POOL',)
('WIFI',)
*/

-- Prediction Query
SELECT T1.facility_code FROM Apartment_Facilities AS T1 JOIN Apartments AS T2 ON T1.apt_id = T2.apt_id WHERE T2.bedroom_count > 4;

/*
Prediction Result:
('POOL',)
('GYM',)
('POOL',)
('WIFI',)
*/