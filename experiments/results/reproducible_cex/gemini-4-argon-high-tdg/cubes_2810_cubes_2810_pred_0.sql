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
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (1, 'B1', 'Building One', 'Main residential tower', '100 Main St', 'Alice Manager', '555-0100');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (10, 1, 'STUDIO', '101', 1, 1, '2');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (20, 1, 'LUXURY', '202', 2, 3, '5');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (10, 'WIFI');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (20, 'POOL');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (101, 'M', 'John', 'Smith', '1985-04-12 00:00:00');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (102, 'O', 'Alex', 'Smith', '1992-08-23 00:00:00');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (103, 'F', 'Jane', 'Doe', '1990-01-15 00:00:00');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (104, 'M', 'John', 'Smith', NULL);
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (105, 'F', NULL, 'Doe', '1990-01-15 00:00:00');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (106, 'M', 'Bob', NULL, '1978-11-30 00:00:00');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1001, 101, 10, 'CONFIRMED', '2023-01-01 14:00:00', '2023-01-05 11:00:00');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1002, 101, 20, 'CONFIRMED', '2023-02-01 14:00:00', '2023-02-10 11:00:00');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1003, 103, 10, 'CANCELLED', '2023-03-01 14:00:00', '2023-03-05 11:00:00');
INSERT INTO View_Unit_Status (status_date, apt_booking_id, apt_id, available_yn) VALUES ('2023-01-02 00:00:00', 1001, 10, 0);
INSERT INTO View_Unit_Status (status_date, apt_booking_id, apt_id, available_yn) VALUES ('2023-02-02 00:00:00', 1002, 20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gender_code, n AS count___ FROM (SELECT gender_code, COUNT(*) AS n FROM guests GROUP BY gender_code) ORDER BY gender_code, count___ NULLS LAST;

/*
Gold Result:
('F', 2)
('M', 3)
('O', 1)
*/

-- Prediction Query
SELECT gender_code, COUNT(*) FROM Guests GROUP BY gender_code ORDER BY COUNT(*) DESC, gender_code NULLS LAST;

/*
Prediction Result:
('M', 3)
('F', 2)
('O', 1)
*/