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
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (1, 'B1', 'Sunrise Towers', 'Luxury apartments', '100 Main St', 'Alice Smith', '555-0101');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (2, 'B2', 'Sunset Heights', 'Downtown living', '200 Oak Ave', 'Bob Jones', '555-0102');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (3, 'B3', 'Empty Plaza', 'Under renovation', '300 Pine Rd', 'Carol White', '555-0103');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (101, 1, '1 Bedroom', '1A', 1, 1, '3');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (102, 2, '1 Bedroom', '2A', 2, 1, '4');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (103, 1, 'Duplex', '1B', 2, 3, '6');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (104, 1, 'Duplex', '1C', 2, 2, '5');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (105, 2, 'Duplex', '2B', 3, 3, '7');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (106, 2, 'Studio', '2C', 1, 0, '2');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (101, 'WiFi');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (101, 'Gym');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (103, 'Pool');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (1, 'F', 'Jane', 'Doe', '1990-05-15');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (2, 'M', 'John', 'Taylor', '1985-11-20');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1001, 1, 101, 'Confirmed', '2023-01-01', '2023-01-10');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1002, 2, 101, 'Cancelled', '2023-02-01', '2023-02-05');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1003, 1, 103, 'Provisional', '2023-03-01', '2023-03-15');
INSERT INTO View_Unit_Status (status_date, apt_booking_id, apt_id, available_yn) VALUES ('2023-01-02', 1001, 101, 0);
INSERT INTO View_Unit_Status (status_date, apt_booking_id, apt_id, available_yn) VALUES ('2023-01-03', 1001, 101, 0);
INSERT INTO View_Unit_Status (status_date, apt_booking_id, apt_id, available_yn) VALUES ('2023-03-02', 1003, 103, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_type_code, n AS count___ FROM (SELECT apt_type_code, COUNT(*) AS n FROM apartments GROUP BY apt_type_code) ORDER BY apt_type_code, count___ NULLS LAST;

/*
Gold Result:
('1 Bedroom', 2)
('Duplex', 3)
('Studio', 1)
*/

-- Prediction Query
SELECT apt_type_code, COUNT(*) FROM Apartments GROUP BY apt_type_code ORDER BY COUNT(*) ASC, apt_type_code NULLS LAST;

/*
Prediction Result:
('Studio', 1)
('1 Bedroom', 2)
('Duplex', 3)
*/