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
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (10, 'B10', 'North Tower', 'Luxury tower', '10 North St', 'Alice Smith', '555-0100');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (20, 'B20', 'South Tower', 'Modern complex', '20 South St', 'Bob Jones', '555-0200');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (30, 'B30', 'East Wing', 'Garden apartments', '30 East St', 'Carol White', '555-0300');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (1, 20, 'Studio', 'B202', 2, 2, '4');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (2, 30, 'Duplex', 'C303', 3, 4, '7');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (3, 20, 'Studio', 'A101', 1, 1, '2');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (4, 10, 'Apartment', 'B205', 2, 3, '5');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (2, 'GYM');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (2, 'POOL');
INSERT INTO Apartment_Facilities (apt_id, facility_code) VALUES (4, 'PARKING');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (100, 'F', 'Jane', 'Doe', '1990-05-15');
INSERT INTO Guests (guest_id, gender_code, guest_first_name, guest_last_name, date_of_birth) VALUES (200, 'M', 'John', 'Roe', '1985-11-20');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1000, 100, 2, 'CONFIRMED', '2023-01-01', '2023-01-10');
INSERT INTO Apartment_Bookings (apt_booking_id, guest_id, apt_id, booking_status_code, booking_start_date, booking_end_date) VALUES (1001, 200, 4, 'PROVISIONAL', '2023-02-01', '2023-02-05');
INSERT INTO View_Unit_Status (status_date, apt_booking_id, apt_id, available_yn) VALUES ('2023-01-02', 1000, 2, 0);
INSERT INTO View_Unit_Status (status_date, apt_booking_id, apt_id, available_yn) VALUES ('2023-02-02', 1001, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_number FROM (SELECT * FROM (SELECT * FROM apartments ORDER BY apt_type_code DESC, apartments.apt_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('B202',)
*/

-- Prediction Query
SELECT apt_number FROM Apartments ORDER BY bedroom_count DESC, Apartments.apt_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('C303',)
*/