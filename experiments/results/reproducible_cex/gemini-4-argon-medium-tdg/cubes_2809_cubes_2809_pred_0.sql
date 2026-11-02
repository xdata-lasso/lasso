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
-- Tests semi-join multiplicity (EXISTS vs INNER JOIN without DISTINCT) and ordering (ASC vs DESC).
INSERT INTO "Apartment_Buildings" ("building_id", "building_short_name") VALUES (1, 'B1');
INSERT INTO "Guests" ("guest_id", "guest_first_name") VALUES (1, 'John');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_number") VALUES (10, 1, '202');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_number") VALUES (20, 1, '101');
INSERT INTO "Apartments" ("apt_id", "building_id", "apt_number") VALUES (30, 1, '303');
INSERT INTO "Apartment_Bookings" ("apt_booking_id", "guest_id", "apt_id") VALUES (100, 1, 10);
INSERT INTO "View_Unit_Status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES ('2023-01-01', 100, 10, 0);
INSERT INTO "View_Unit_Status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES ('2023-01-02', 100, 10, 0);
INSERT INTO "View_Unit_Status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES ('2023-01-03', 100, 20, 0);
INSERT INTO "View_Unit_Status" ("status_date", "apt_booking_id", "apt_id", "available_yn") VALUES ('2023-01-04', 100, 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT apt_number FROM (SELECT * FROM apartments AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM view_unit_status WHERE (available_yn <> 1)) AS RHS WHERE (LHS.apt_id = RHS.apt_id))) ORDER BY apt_number;

/*
Gold Result:
('101',)
('202',)
*/

-- Prediction Query
SELECT T1.apt_number FROM Apartments AS T1 JOIN View_Unit_Status AS T2 ON T1.apt_id = T2.apt_id WHERE T2.available_yn = 0 INTERSECT SELECT T1.apt_number FROM Apartments AS T1 JOIN View_Unit_Status AS T2 ON T1.apt_id = T2.apt_id WHERE T2.available_yn = 1;

/*
Prediction Result:
*/