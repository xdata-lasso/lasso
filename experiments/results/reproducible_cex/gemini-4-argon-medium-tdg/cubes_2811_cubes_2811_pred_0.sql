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
-- Core logic, self-join on (apt_id, guest_id), gender_code filtering ('Female' vs 'F' vs 'Male' vs NULL), and booking_start_date vs booking_end_date differentiation
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1, 'B1', 'Building One', 'Desc 1', '123 Main St', 'Alice', '555-0100');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (10, 1, 'Studio', '101', 1, 1, '2');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_type_code", "apt_number", "bathroom_count", "bedroom_count", "room_count") VALUES (20, 1, '2BR', '102', 2, 2, '4');
INSERT INTO "Guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (1, 'Female', 'Jane', 'Doe', '1990-05-15');
INSERT INTO "Guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (2, 'Male', 'John', 'Smith', '1985-08-20');
INSERT INTO "Guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (3, 'F', 'Emily', 'Clark', '1992-11-30');
INSERT INTO "Guests" ("guest_id", "gender_code", "guest_first_name", "guest_last_name", "date_of_birth") VALUES (4, NULL, 'Alex', 'Taylor', '1988-02-10');
-- Guest 1 ('Female') has two bookings in the same apartment (10) -> should produce 2x2 = 4 pairs
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (100, 1, 10, 'Confirmed', '2023-03-10', '2023-03-15');
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (101, 1, 10, 'Provisional', '2023-01-05', '2023-01-20');
-- Guest 1 ('Female') also has one booking in a different apartment (20) -> should only self-pair (1x1 = 1 pair), NOT pair with apt 10
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (102, 1, 20, 'Confirmed', '2023-02-01', '2023-02-10');
-- Guest 2 ('Male') has bookings in apartment 10 -> should be filtered out by gender_code = 'Female', and must NOT join with Guest 1's apt 10 bookings
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (103, 2, 10, 'Confirmed', '2023-04-01', '2023-04-05');
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (104, 2, 10, 'Confirmed', '2023-04-10', '2023-04-15');
-- Guest 3 ('F') and Guest 4 (NULL) bookings -> should be filtered out
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (105, 3, 10, 'Confirmed', '2023-05-01', '2023-05-05');
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id", "booking_status_code", "booking_start_date", "booking_end_date") VALUES (106, 4, 10, 'Confirmed', '2023-06-01', '2023-06-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "booking_start_date" AS "booking_start_date___1", "booking_start_date_other" AS "booking_start_date___2" FROM (SELECT "LHS"."guest_id" AS "guest_id", "LHS"."gender_code" AS "gender_code", "LHS"."guest_first_name" AS "guest_first_name", "LHS"."guest_last_name" AS "guest_last_name", "LHS"."date_of_birth" AS "date_of_birth", "RHS"."apt_booking_id" AS "apt_booking_id", "RHS"."apt_id" AS "apt_id", "RHS"."booking_status_code" AS "booking_status_code", "RHS"."booking_start_date" AS "booking_start_date", "RHS"."booking_end_date" AS "booking_end_date", "RHS"."apt_booking_id_other" AS "apt_booking_id_other", "RHS"."booking_status_code_other" AS "booking_status_code_other", "RHS"."booking_start_date_other" AS "booking_start_date_other", "RHS"."booking_end_date_other" AS "booking_end_date_other" FROM "guests" AS "LHS" INNER JOIN (SELECT "LHS"."apt_booking_id" AS "apt_booking_id", "LHS"."apt_id" AS "apt_id", "LHS"."guest_id" AS "guest_id", "LHS"."booking_status_code" AS "booking_status_code", "LHS"."booking_start_date" AS "booking_start_date", "LHS"."booking_end_date" AS "booking_end_date", "RHS"."apt_booking_id" AS "apt_booking_id_other", "RHS"."booking_status_code" AS "booking_status_code_other", "RHS"."booking_start_date" AS "booking_start_date_other", "RHS"."booking_end_date" AS "booking_end_date_other" FROM "apartment_bookings" AS "LHS" INNER JOIN "apartment_bookings" AS "RHS" ON ("LHS"."apt_id" = "RHS"."apt_id" AND "LHS"."guest_id" = "RHS"."guest_id")) AS "RHS" ON ("LHS"."guest_id" = "RHS"."guest_id")) WHERE ("gender_code" = 'Female') ORDER BY booking_start_date___1, booking_start_date___2 NULLS LAST;

/*
Gold Result:
('2023-01-05', '2023-01-05')
('2023-01-05', '2023-03-10')
('2023-02-01', '2023-02-01')
('2023-03-10', '2023-01-05')
('2023-03-10', '2023-03-10')
*/

-- Prediction Query
SELECT T1.booking_start_date, T1.booking_start_date FROM Apartment_Bookings AS T1 JOIN Guests AS T2 ON T1.guest_id = T2.guest_id WHERE T2.gender_code = 'Female';

/*
Prediction Result:
('2023-03-10', '2023-03-10')
('2023-01-05', '2023-01-05')
('2023-02-01', '2023-02-01')
*/