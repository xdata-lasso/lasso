-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join, ordering, duplicate first_names (DISTINCT vs ALL), and joining on wrong Lesson columns (lesson_id, customer_id, vehicle_id)
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, '10 Main St', 'Metro', '10001', 'NY', 'USA');
INSERT INTO "Vehicles" ("vehicle_id", "vehicle_details") VALUES (2, 'Sedan');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1, 1, 'Active', '2020-01-01', '1990-01-01', 'CustOne', 'Smith', 0.0, 'c1@test.com', '111', '222');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (1, 1, 'ZackNick', 'Zack', 'M1', 'Last1', '1980-01-01', '2015-01-01', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (2, 1, 'AaronNick1', 'Aaron', 'M2', 'Last2', '1982-01-01', '2016-01-01', '2021-01-01');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (3, 1, 'AaronNick2', 'Aaron', 'M3', 'Last3', '1985-01-01', '2017-01-01', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (4, NULL, 'BobNick', 'Bob', 'M4', 'Last4', '1988-01-01', '2018-01-01', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (5, 1, 'CharlieNick', 'Charlie', 'M5', 'Last5', '1990-01-01', '2019-01-01', NULL);
INSERT INTO "Lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (3, 1, 4, 2, 'Completed', '2022-05-01', '10:00', 50.0);
INSERT INTO "Lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (10, 1, 5, 2, 'Cancelled', '2022-05-02', '11:00', 0.0);
INSERT INTO "Lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (11, 1, 5, 2, 'Completed', '2022-05-03', '12:00', 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM (SELECT * FROM staff AS LHS WHERE NOT EXISTS(SELECT 1 FROM lessons AS RHS WHERE (LHS.staff_id = RHS.staff_id))) ORDER BY first_name;

/*
Gold Result:
('Aaron',)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT first_name FROM Staff EXCEPT SELECT T2.first_name FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id;

/*
Prediction Result:
('Aaron',)
('Zack',)
*/