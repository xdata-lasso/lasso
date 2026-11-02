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
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '101 Main St', 'Springfield', '62701', 'IL', 'USA');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 1, 'Jan', 'Janessa', 'Ann', 'Sawayn', '1992-08-20 00:00:00', '2015-03-01 00:00:00', '2021-06-01 00:00:00');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (2, NULL, 'Janie', 'Janessa', 'Marie', 'Sawayn', '1985-04-12 00:00:00', '2018-07-15 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (3, 1, 'Nessa', 'Janessa', 'Lee', 'Sawayn', '1985-04-12 00:00:00', '2019-01-10 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (4, 1, 'JS', 'Janessa', 'May', 'Smith', '1970-01-01 00:00:00', '2010-01-01 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (5, 1, 'Rob', 'Robert', 'John', 'Sawayn', '1975-02-02 00:00:00', '2011-02-02 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (6, 1, 'Bob', 'Robert', 'Alan', 'Smith', '1960-03-03 00:00:00', '2012-03-03 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (7, 1, 'Janessa', 'Alice', 'Sawayn', 'Brown', '1999-09-09 00:00:00', '2020-09-09 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (8, 1, 'Sawayn', 'Sawayn', 'Janessa', 'Janessa', '1998-08-08 00:00:00', '2020-08-08 00:00:00', NULL);
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (1, 'Sedan');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'ACTIVE', '2020-01-01 00:00:00', '2001-12-25 00:00:00', 'Janessa', 'Sawayn', 0.0, 'janessa@example.com', '555-0100', '555-0101');
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (1, 1, 1, 1, 'COMPLETED', '2021-01-10 00:00:00', '09:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (2, 1, 1, 1, 'COMPLETED', '2021-01-17 00:00:00', '10:00', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_birth" FROM "staff" WHERE ("first_name" = 'Janessa' AND "last_name" = 'Sawayn') ORDER BY date_of_birth, staff.staff_id NULLS LAST;

/*
Gold Result:
('1985-04-12 00:00:00',)
('1985-04-12 00:00:00',)
('1992-08-20 00:00:00',)
*/

-- Prediction Query
SELECT date_of_birth FROM Staff WHERE first_name = 'Janessa' AND last_name = 'Sawayn';

/*
Prediction Result:
('1992-08-20 00:00:00',)
('1985-04-12 00:00:00',)
('1985-04-12 00:00:00',)
*/