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
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1, 1, 'apa_e7ec16', 'apa_06dbd8', -55602865, 1, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483647, 1, 'apa_e553e4', 'apa_204bb9', -59984348, 1, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (2, 1, 'apa_28fd34', 'apa_8d69e6', -1726781632, 247012447, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (3, 1, 'apa_28fd34', 'apa_8d69e6', -106629402, 1871297066, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (4, 1, 'apa_28fd34', 'apa_8d69e6', 89267185, -1865039888, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (5, 1, 'apa_28fd34', 'apa_8d69e6', -992890117, 1914020640, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (6, 1, 'apa_28fd34', 'apa_8d69e6', 1219478689, -1670923962, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (7, 1, 'apa_28fd34', 'apa_8d69e6', 906324270, 1908028688, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (8, 1, 'apa_28fd34', 'apa_8d69e6', 1072996612, 13244799, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (9, 1, 'apa_28fd34', 'apa_8d69e6', 1019800248, -1910425938, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (10, 1, 'apa_28fd34', 'apa_8d69e6', -841692980, -1364429300, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (11, 1, 'apa_28fd34', 'apa_8d69e6', 462974032, -1137908826, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (12, 1, 'apa_28fd34', 'apa_8d69e6', -1576219117, -1823627488, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (13, 1, 'apa_28fd34', 'apa_8d69e6', 1861536320, 44952191, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (14, 1, 'apa_28fd34', 'apa_8d69e6', 1620389964, 546571701, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (15, 1, 'apa_28fd34', 'apa_8d69e6', 1990080517, 1408123494, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (16, 1, 'apa_28fd34', 'apa_8d69e6', 700088193, 374105386, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (17, 1, 'apa_28fd34', 'apa_8d69e6', -1683203397, 528680845, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (18, 1, 'apa_28fd34', 'apa_8d69e6', 1155439218, 1313172851, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (19, 1, 'apa_28fd34', 'apa_8d69e6', -53231346, -443340271, '7c69c');

-- Inserting into table: apartment_buildings --
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1, 'apa_4d20e1', 'apa_50a089', 'apa_de7e8d', 'apa_139439', 'apa_9c102e', 'apa_269390');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_type_code FROM (SELECT apt_id, building_id, apt_type_code, apt_number, bedroom_count AS bathroom_count, bedroom_count, room_count, apt_id_other, building_id_other, apt_type_code_other, apt_number_other, bedroom_count_other FROM (SELECT LHS.apt_id AS apt_id, LHS.building_id AS building_id, LHS.apt_type_code AS apt_type_code, LHS.apt_number AS apt_number, LHS.bathroom_count AS bathroom_count, LHS.bedroom_count AS bedroom_count, LHS.room_count AS room_count, RHS.apt_id AS apt_id_other, RHS.building_id AS building_id_other, RHS.apt_type_code AS apt_type_code_other, RHS.apt_number AS apt_number_other, RHS.bedroom_count AS bedroom_count_other FROM apartments AS LHS INNER JOIN apartments AS RHS ON (LHS.bedroom_count = RHS.bathroom_count AND LHS.room_count = RHS.room_count))) ORDER BY apt_type_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT apt_type_code FROM Apartments WHERE bathroom_count > 1 GROUP BY apt_type_code ORDER BY COUNT(*) DESC, apt_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('apa_28fd34',)
*/