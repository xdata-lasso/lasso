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
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (1, 'B1', 'Sunset Towers', 'Luxury apartments', '100 Main St', 'Alice Smith', '555-0100');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (10, 1, 'Studio', '101', 1, 1, '2');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (20, 1, 'Duplex', '202', 2, 3, '5');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (10, 'WiFi');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (1, 'Male', 'Charlie', 'Zimmerman', '1995-08-20');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (2, 'Female', 'Diana', 'Prince', '1988-03-10');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (3, 'Male', 'Aaron', 'Baker', '1972-11-05');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (4, 'Male', 'Bob', 'Miller', '1985-04-15');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (5, 'Male', 'Edward', 'Davis', '1985-04-15');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (6, 'M', 'Frank', 'Wright', '1990-01-01');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (7, NULL, 'Grace', 'Hopper', '1965-12-09');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (100, 1, 10, 'Confirmed', '2023-01-01', '2023-01-10');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (101, 1, 20, 'Confirmed', '2023-02-01', '2023-02-10');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (102, 2, 10, 'Cancelled', '2023-03-01', '2023-03-05');
INSERT INTO View_Unit_Status (status_date, apt_booking_id, apt_id, available_yn) VALUES ('2023-01-02', 100, 10, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_birth" FROM "guests" WHERE ("gender_code" = 'Male') ORDER BY date_of_birth, guests.guest_id NULLS LAST;

/*
Gold Result:
('1972-11-05',)
('1985-04-15',)
('1985-04-15',)
('1995-08-20',)
*/

-- Prediction Query
SELECT date_of_birth FROM Guests WHERE gender_code = 'Male';

/*
Prediction Result:
('1995-08-20',)
('1972-11-05',)
('1985-04-15',)
('1985-04-15',)
*/