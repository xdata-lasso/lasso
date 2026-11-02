-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (1, NULL, 'J1', 'Janessa', 'A', 'Sawayn', '1985-01-01 00:00:00', '2021-06-10 08:00:00', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (2, NULL, 'J2', 'Janessa', 'B', 'Sawayn', '1986-02-02 00:00:00', '2018-02-20 08:00:00', '2020-02-20 08:00:00');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (3, NULL, 'J3', 'Janessa', 'C', 'Sawayn', '1987-03-03 00:00:00', '2021-06-10 08:00:00', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (4, NULL, 'J4', 'Janessa', 'D', 'Sawayn', '1988-04-04 00:00:00', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_joined_staff" FROM "staff" WHERE ("first_name" = 'Janessa' AND "last_name" = 'Sawayn') ORDER BY date_joined_staff, staff.staff_id NULLS LAST;

/*
Gold Result:
(None,)
('2018-02-20 08:00:00',)
('2021-06-10 08:00:00',)
('2021-06-10 08:00:00',)
*/

-- Prediction Query
SELECT date_joined_staff FROM Staff WHERE first_name = 'Janessa' AND last_name = 'Sawayn';

/*
Prediction Result:
('2021-06-10 08:00:00',)
('2018-02-20 08:00:00',)
('2021-06-10 08:00:00',)
(None,)
*/