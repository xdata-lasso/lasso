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
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483648, -2147483648, 'apa_86654a', 'apa_8d69e6', -55602865, -59984348, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483647, -2147483648, 'apa_86654a', 'apa_8d69e6', 1258409369, -1981402255, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483646, -2147483648, 'apa_86654a', 'apa_8d69e6', 247012447, -1980249628, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (2, -2147483648, 'apa_86654a', 'apa_8d69e6', 1871297066, 809183447, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (3, -2147483648, 'apa_86654a', 'apa_8d69e6', -1865039888, 1160656988, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483645, -2147483648, 'apa_86654a', 'apa_8d69e6', -252690330, 1115440883, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483642, -2147483648, 'apa_86654a', 'apa_8d69e6', 1465859724, -1349201381, 'A');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483641, -2147483648, 'apa_86654a', 'apa_8d69e6', -1910425938, -845863578, '(');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483640, -2147483648, 'apa_86654a', 'apa_8d69e6', -1364429300, -1257178728, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483639, -2147483648, 'apa_86654a', 'apa_8d69e6', 2087640001, 907682809, 'd');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483638, -2147483648, 'apa_86654a', 'apa_8d69e6', -918961358, -1602639011, '!');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483637, -2147483648, 'apa_86654a', 'apa_8d69e6', -1209887326, -1399556171, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483636, -2147483648, 'apa_86654a', 'apa_8d69e6', 1419861592, 700088193, 'D');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483635, -2147483648, 'apa_86654a', 'apa_8d69e6', 1274489983, -1683203397, '!');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483634, -2147483648, 'apa_86654a', 'apa_8d69e6', -1585009206, -53231346, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483633, -2147483648, 'M', 'apa_8d69e6', -747753377, 902887186, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483632, -2147483648, 'M', 'apa_8d69e6', 418417917, -1031969798, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483631, -2147483648, '!', 'apa_8d69e6', -921187550, -2070843029, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483630, -2147483648, 'Q', 'apa_8d69e6', 882961052, 743312762, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483629, -2147483648, 'Q', 'apa_8d69e6', -751275471, -1347802441, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483628, -2147483648, 'A', 'apa_8d69e6', -2118135981, 2074205376, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483627, -2147483648, 'G', 'apa_8d69e6', 2137741668, -525979501, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483626, -2147483648, 'G', 'apa_8d69e6', 624571013, 1644911394, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483625, -2147483648, 'A', 'apa_8d69e6', 226938182, 90119032, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483624, -2147483648, 'G', 'apa_8d69e6', -1390245819, 1055976837, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483623, -2147483648, 'G', 'apa_8d69e6', -74849714, 105869088, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483622, -2147483648, 'A', 'apa_8d69e6', 481163439, 2123196517, '7c69c');

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483621, -2147483648, 'apa_86654a', 'apa_8d69e6', 1485335077, -511185946, NULL);

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483620, -2147483648, 'apa_86654a', 'apa_8d69e6', -1097120355, 244829661, NULL);

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483619, -2147483648, 'apa_86654a', 'apa_8d69e6', 1661181156, -1372125820, NULL);

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483618, -2147483648, NULL, 'apa_8d69e6', 1692174491, -1025564911, NULL);

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483617, -2147483648, NULL, 'apa_8d69e6', -975213201, -705985602, NULL);

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483616, -2147483648, NULL, 'apa_8d69e6', 1178000634, 1836127587, NULL);

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483615, -2147483648, 'apa_86654a', 'apa_8d69e6', 836513442, 176555546, NULL);

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483614, -2147483648, 'apa_86654a', 'apa_8d69e6', 1196308825, 910894705, NULL);

INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (-2147483613, -2147483648, 'apa_86654a', 'apa_8d69e6', 1675430660, -688509700, NULL);

-- Inserting into table: apartment_buildings --
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (-2147483648, 'apa_4d20e1', 'apa_50a089', 'apa_de7e8d', 'apa_139439', 'apa_9c102e', 'apa_269390');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT apt_type_code FROM (SELECT LHS.apt_id AS apt_id, LHS.building_id AS building_id, LHS.apt_type_code AS apt_type_code, LHS.apt_number AS apt_number, LHS.bathroom_count AS bathroom_count, LHS.bedroom_count AS bedroom_count, LHS.room_count AS room_count FROM apartments AS LHS INNER JOIN (SELECT * FROM apartments WHERE (room_count <> 3)) AS RHS ON (LHS.apt_id = RHS.apt_id AND LHS.building_id = RHS.building_id AND LHS.apt_type_code = RHS.apt_type_code AND LHS.apt_number = RHS.apt_number AND LHS.bathroom_count = RHS.bathroom_count AND LHS.bedroom_count = RHS.bedroom_count AND LHS.room_count = RHS.room_count)) ORDER BY apt_type_code;

/*
Gold Result:
('!',)
('A',)
('G',)
('M',)
('Q',)
('apa_86654a',)
*/

-- Prediction Query
SELECT apt_type_code FROM Apartments GROUP BY apt_type_code ORDER BY AVG(room_count) DESC, apt_type_code NULLS LAST LIMIT 3;

/*
Prediction Result:
('!',)
('A',)
('G',)
*/