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
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1, 'B1', 'Building One', 'Desc 1', '123 St', 'Mgr 1', '555-0001');
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (2, 'B2', 'Building Two', 'Desc 2', '456 St', 'Mgr 2', '555-0002');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1, 1, 'TYPE_Z_LHS', '101', 1, 2, '5');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (2, 2, 'TYPE_A_RHS1', '201', 2, 3, '5');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (3, 1, 'TYPE_B_RHS2', '102', 2, 4, '5');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (4, 1, 'TYPE_C_SELF', '103', 3, 3, '6');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (5, 2, 'TYPE_D_DIFFRM', '202', 2, 1, '7');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (6, 2, 'TYPE_E_NOMATCH', '203', 5, 6, '8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_type_code FROM (SELECT apt_id, building_id, apt_type_code, apt_number, bedroom_count AS bathroom_count, bedroom_count, room_count, apt_id_other, building_id_other, apt_type_code_other, apt_number_other, bedroom_count_other FROM (SELECT LHS.apt_id AS apt_id, LHS.building_id AS building_id, LHS.apt_type_code AS apt_type_code, LHS.apt_number AS apt_number, LHS.bathroom_count AS bathroom_count, LHS.bedroom_count AS bedroom_count, LHS.room_count AS room_count, RHS.apt_id AS apt_id_other, RHS.building_id AS building_id_other, RHS.apt_type_code AS apt_type_code_other, RHS.apt_number AS apt_number_other, RHS.bedroom_count AS bedroom_count_other FROM apartments AS LHS INNER JOIN apartments AS RHS ON (LHS.bedroom_count = RHS.bathroom_count AND LHS.room_count = RHS.room_count))) ORDER BY apt_type_code;

/*
Gold Result:
('TYPE_C_SELF',)
('TYPE_Z_LHS',)
('TYPE_Z_LHS',)
*/

-- Prediction Query
SELECT apt_type_code FROM Apartments WHERE bathroom_count > 1 GROUP BY apt_type_code ORDER BY COUNT(*) DESC, apt_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('TYPE_A_RHS1',)
*/