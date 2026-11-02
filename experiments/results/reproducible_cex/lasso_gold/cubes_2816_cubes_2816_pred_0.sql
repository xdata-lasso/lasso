-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1001, 'Allison Hill', 'Cristian Santos', 'Bill here grow gas enough analysis.', 'USS Lynch
FPO AE 70511', 'building', '001-645-514-6270x48281');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1002, 'Noah Rhodes', 'Connie Lawrence', 'Movie win her need stop peace technology.', '6483 Cameron Trail
East Lydiamouth, MO 35594', 'rest', '(252)388-0957');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1003, 'Angie Henderson', 'Abigail Shaffer', 'Court attorney product significant world talk term.', '76724 John Points Suite 969
Coxberg, NY 65187', 'value', '(443)903-9117x182');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1004, 'Daniel Wagner', 'Gina Moore', 'Everyone player half have decide environment.', '22691 James Mountain
Tashatown, TX 94967', 'not', '+1-624-889-6383');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1005, 1001, 'remain', 'we', 1009, 1013, 'end');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1006, 1001, 'rate', 'nation', 1020.0, 1026.0, 'down');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1007, 1001, 'hour', 'live', 1031.0, 1039.0, 'attack');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1008, 1001, 'left', 'camera', 1042.0, 1052.0, 'ground');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_number FROM (SELECT * FROM (SELECT * FROM apartments ORDER BY apt_type_code DESC, apartments.apt_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('we',)
*/

-- Prediction Query
SELECT apt_number FROM Apartments ORDER BY bedroom_count DESC, Apartments.apt_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('camera',)
*/