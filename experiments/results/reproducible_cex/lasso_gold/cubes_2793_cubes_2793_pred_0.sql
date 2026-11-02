-- Schema DDL
CREATE TABLE "Apartment_Buildings" ("building_id" INTEGER PRIMARY KEY, "building_short_name" TEXT(15), "building_full_name" TEXT(80), "building_description" TEXT(255), "building_address" TEXT(255), "building_manager" TEXT(50), "building_phone" TEXT(80));

CREATE TABLE "Apartments" ("apt_id" INTEGER PRIMARY KEY, "building_id" INTEGER, "apt_type_code" TEXT(15), "apt_number" TEXT(10), "bathroom_count" INTEGER, "bedroom_count" INTEGER, "room_count" TEXT(5), FOREIGN KEY ("building_id") REFERENCES "Apartment_Buildings" ("building_id"));

CREATE TABLE "Apartment_Facilities" ("apt_id" INTEGER, "facility_code" TEXT(15), PRIMARY KEY ("apt_id", "facility_code"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "Guests" ("guest_id" INTEGER PRIMARY KEY, "gender_code" TEXT(1), "guest_first_name" TEXT(80), "guest_last_name" TEXT(80), "date_of_birth" DATETIME);

CREATE TABLE "Apartment_Bookings" ("apt_booking_id" INTEGER PRIMARY KEY, "guest_id" INTEGER, "apt_id" INTEGER, "booking_status_code" TEXT(15), "booking_start_date" DATETIME, "booking_end_date" DATETIME, FOREIGN KEY ("guest_id") REFERENCES "Guests" ("guest_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

CREATE TABLE "View_Unit_Status" ("status_date" DATETIME PRIMARY KEY, "apt_booking_id" INTEGER, "apt_id" INTEGER, "available_yn" BIT, FOREIGN KEY ("apt_booking_id") REFERENCES "Apartment_Bookings" ("apt_booking_id"), FOREIGN KEY ("apt_id") REFERENCES "Apartments" ("apt_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1017, 'Barry Bernard', 'Andre Wright', 'Perform draw list.', '8377 Mcguire Course Suite 363
Elizabethstad, NJ 73045', 'Brenden', '(273)554-5494');
INSERT INTO "apartment_buildings" ("building_id", "building_short_name", "building_full_name", "building_description", "building_address", "building_manager", "building_phone") VALUES (1018, 'Matthew Smith', 'John Hamilton', 'Player stock religious itself safe whole.', '4529 Kimberly Estates
Danieltown, ME 75971', 'Brenden', '+1-866-731-9314x91905');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "building_address", "building_phone" FROM "apartment_buildings" WHERE ("building_manager" = 'Brenden') ORDER BY building_address, apartment_buildings.building_id NULLS LAST;

/*
Gold Result:
('4529 Kimberly Estates\nDanieltown, ME 75971', '+1-866-731-9314x91905')
('8377 Mcguire Course Suite 363\nElizabethstad, NJ 73045', '(273)554-5494')
*/

-- Prediction Query
SELECT building_address, building_phone FROM Apartment_Buildings WHERE building_manager = 'Brenden';

/*
Prediction Result:
('8377 Mcguire Course Suite 363\nElizabethstad, NJ 73045', '(273)554-5494')
('4529 Kimberly Estates\nDanieltown, ME 75971', '+1-866-731-9314x91905')
*/