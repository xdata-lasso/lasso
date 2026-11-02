-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1062, 'Michelle Cruz', 'Charles Watts', 'Sing despite sound receive.', '72788 Dodson Mills
Rivasside, NV 21362', 'six', '674.734.8734x7143');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1074, 'Shawn Ramirez', 'Jennifer Conley', 'Affect much yourself glass practice sit prepare.', '09232 Caldwell Port
South Holly, WI 48852', 'computer', '+1-591-324-1904x966');
INSERT INTO "guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (1063, 'front', 'Patricia', 'Miller', '1997-06-05');
INSERT INTO "guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (1075, 'person', 'Hannah', 'Burton', '1974-01-11');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1064, 1062, 'city', 'during', 1065, 1066, 'identify');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1076, 1074, 'blue', 'same', 1077, 1078, 'spring');
INSERT INTO "apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (1070, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "apartment_bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (1067, 1063, 1064, 'Confirmed', '1998-07-06', '1970-08-07');
INSERT INTO "apartment_bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (1073, 1063, 1070, 'Confirmed', '1972-10-09', '1973-11-10');
INSERT INTO "apartment_bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (1079, 1075, 1076, 'Confirmed', '1975-02-12', '1976-03-13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "guest_first_name", "guest_last_name" FROM (SELECT "LHS"."guest_id" AS "guest_id", "LHS"."gender_code" AS "gender_code", "LHS"."guest_first_name" AS "guest_first_name", "LHS"."guest_last_name" AS "guest_last_name", "LHS"."date_of_birth" AS "date_of_birth", "RHS"."apt_booking_id" AS "apt_booking_id", "RHS"."apt_id" AS "apt_id", "RHS"."booking_status_code" AS "booking_status_code", "RHS"."booking_start_date" AS "booking_start_date", "RHS"."booking_end_date" AS "booking_end_date" FROM "guests" AS "LHS" INNER JOIN "apartment_bookings" AS "RHS" ON ("LHS"."guest_id" = "RHS"."guest_id")) WHERE ("booking_status_code" = 'Confirmed') ORDER BY guest_first_name, "guest_first_name" NULLS LAST, "guest_last_name" NULLS LAST;

/*
Gold Result:
('Hannah', 'Burton')
('Patricia', 'Miller')
('Patricia', 'Miller')
*/

-- Prediction Query
SELECT T2.guest_first_name, T2.guest_last_name FROM Apartment_Bookings AS T1 JOIN Guests AS T2 ON T1.guest_id = T2.guest_id WHERE T1.booking_status_code = 'Confirmed';

/*
Prediction Result:
('Patricia', 'Miller')
('Patricia', 'Miller')
('Hannah', 'Burton')
*/