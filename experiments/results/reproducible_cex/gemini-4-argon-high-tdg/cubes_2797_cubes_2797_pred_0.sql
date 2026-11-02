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
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (1, 'B1', 'Sunrise Towers', 'Luxury apartments', '100 Main St', 'Jane Doe', '555-0100');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (101, 1, 'STUDIO', '1A', 1, 1, '2');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (1, 'M', 'Charlie', 'Adams', '1990-05-10 00:00:00');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (2, 'M', 'Alice', 'Zimmerman', '1995-01-20 00:00:00');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (3, 'F', 'Alice', 'Baker', '1985-12-01 00:00:00');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (4, 'F', 'Bob', 'Clark', '1980-03-15 00:00:00');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (5, 'F', 'Bob', 'Clark', '1988-07-22 00:00:00');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1001, 1, 101, 'Confirmed', '2023-01-01 00:00:00', '2023-01-05 00:00:00');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1002, 1, 101, 'Confirmed', '2023-02-01 00:00:00', '2023-02-05 00:00:00');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1003, 2, 101, 'Provisional', '2023-03-01 00:00:00', '2023-03-10 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT guest_first_name, guest_last_name FROM guests ORDER BY guest_first_name, guests.guest_id NULLS LAST;

/*
Gold Result:
('Alice', 'Zimmerman')
('Alice', 'Baker')
('Bob', 'Clark')
('Bob', 'Clark')
('Charlie', 'Adams')
*/

-- Prediction Query
SELECT guest_first_name, guest_last_name FROM Guests;

/*
Prediction Result:
('Charlie', 'Adams')
('Alice', 'Zimmerman')
('Alice', 'Baker')
('Bob', 'Clark')
('Bob', 'Clark')
*/