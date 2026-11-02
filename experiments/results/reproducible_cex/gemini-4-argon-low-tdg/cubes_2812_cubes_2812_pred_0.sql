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
-- Tests standard grouping, varying group sizes, inverse ordering between apt_type_code and count, and JOIN loss (orphan apartments not in Bookings/Facilities/Status).
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (1, 'B1', 'Building One', 'Desc 1', 'Addr 1', 'Mgr 1', '111-1111');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (2, 'B2', 'Building Two', 'Desc 2', 'Addr 2', 'Mgr 2', '222-2222');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (1, 1, 'Studio', '101', 1, 0, '1');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (2, 1, '1BR', '102', 1, 1, '3');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (3, 1, '1BR', '103', 1, 1, '3');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (4, 2, '2BR', '201', 2, 2, '4');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (5, 2, '2BR', '202', 2, 2, '4');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (6, 2, '2BR', '203', 2, 2, '4');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (7, 2, 'Duplex', '204', 2, 3, '5');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (8, 1, 'Duplex', '104', 2, 3, '5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_type_code, n AS count___ FROM (SELECT apt_type_code, COUNT(*) AS n FROM apartments GROUP BY apt_type_code) ORDER BY apt_type_code, count___ NULLS LAST;

/*
Gold Result:
('1BR', 2)
('2BR', 3)
('Duplex', 2)
('Studio', 1)
*/

-- Prediction Query
SELECT apt_type_code, COUNT(*) FROM Apartments GROUP BY apt_type_code ORDER BY COUNT(*) ASC, apt_type_code NULLS LAST;

/*
Prediction Result:
('Studio', 1)
('1BR', 2)
('Duplex', 2)
('2BR', 3)
*/