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
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (1, 'Zeta', 'AAA Full Name', 'First building', '100 First St', 'Emma', '111-111-1111');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (2, 'Alpha', 'ZZZ Full Name', 'Second building', '200 Second St', 'Emma', '222-222-2222');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (3, 'Beta', 'MMM Full Name', 'Third building', '300 Third St', 'Emma', '333-333-3333');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (4, 'Alpha', 'BBB Full Name', 'Fourth building', '400 Fourth St', 'Emma', '444-444-4444');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (5, 'Gamma', 'Gamma Full Name', 'Fifth building', '500 Fifth St', 'John', '555-555-5555');
INSERT INTO Apartment_Buildings (building_id, building_short_name, building_full_name, building_description, building_address, building_manager, building_phone) VALUES (6, 'Delta', 'Delta Full Name', 'Sixth building', '600 Sixth St', NULL, '666-666-6666');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (101, 2, 'Studio', '2A', 1, 1, '2');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (102, 2, 'Duplex', '2B', 2, 3, '5');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (103, 3, 'Loft', '3A', 1, 2, '3');
INSERT INTO Apartments (apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count) VALUES (104, 5, 'Studio', '5A', 1, 1, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "building_short_name" FROM "apartment_buildings" WHERE ("building_manager" = 'Emma') ORDER BY building_short_name, apartment_buildings.building_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT building_short_name FROM Apartment_Buildings WHERE building_manager = 'Emma';

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Beta',)
('Alpha',)
*/