-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: apartments --
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1, -2147483648, 'apa_28fd34', 'apa_8d69e6', -55602865, -59984348, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483647, 1, 'apa_28fd34', 'apa_8d69e6', -1022641847, -1726781632, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (2, -2147483648, 'apa_28fd34', 'apa_8d69e6', 1610062532, -106629402, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (3, -2147483648, 'apa_28fd34', 'apa_8d69e6', 809183447, 89267185, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483644, -2147483648, 'apa_28fd34', 'q_2_c08883', 1744686505, -1633151678, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483643, -2147483648, 'apa_28fd34', 'q_2_c08883', 1914020640, 1268590800, '7c69c');

-- Inserting into table: apartment_buildings --
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (-2147483648, 'apa_4d20e1', 'apa_50a089', 'apa_de7e8d', 'apa_139439', 'apa_9c102e', 'apa_269390');

INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1, 'apa_4d20e1', 'apa_50a089', 'apa_de7e8d', 'apa_139439', 'apa_9c102e', 'apa_269390');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_number FROM (SELECT * FROM (SELECT * FROM (SELECT apt_id, building_id, apt_type_code, apt_number, bathroom_count, bedroom_count, room_count, MAX(bedroom_count) OVER () AS maxbedroom_count FROM apartments) ORDER BY apt_type_code DESC) LIMIT 1);

/*
Gold Result:
('apa_8d69e6',)
*/

-- Prediction Query
SELECT apt_number FROM Apartments ORDER BY bedroom_count DESC, Apartments.apt_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_c08883',)
*/