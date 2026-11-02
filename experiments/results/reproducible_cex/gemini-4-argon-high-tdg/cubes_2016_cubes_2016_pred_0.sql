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
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '10 Main St', 'Austin', '78701', 'TX', 'USA');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 1, 'Chuck', 'Charlie', 'Ray', 'Brown', '1980-01-15 00:00:00', '2015-03-01 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (2, 1, 'Bobby', 'Bob', 'Lee', 'Miller', '1985-06-20 00:00:00', '2016-07-10 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (10, 1, 'Zed', 'Alice', 'Zoe', 'Zimmer', '1992-11-05 00:00:00', '2019-09-15 00:00:00', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (20, 1, 'Ace', 'Alice', 'Amy', 'Adams', '1975-04-12 00:00:00', '2010-01-20 00:00:00', NULL);
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'ACTIVE', '2020-01-01 00:00:00', '2000-01-01 00:00:00', 'Xavier', 'Woods', 0.0, 'xavier@example.com', '555-0100', '555-0101');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, middle_name, last_name FROM staff ORDER BY first_name, staff.staff_id NULLS LAST;

/*
Gold Result:
('Alice', 'Zoe', 'Zimmer')
('Alice', 'Amy', 'Adams')
('Bob', 'Lee', 'Miller')
('Charlie', 'Ray', 'Brown')
*/

-- Prediction Query
SELECT first_name, middle_name, last_name FROM Staff;

/*
Prediction Result:
('Charlie', 'Ray', 'Brown')
('Bob', 'Lee', 'Miller')
('Alice', 'Zoe', 'Zimmer')
('Alice', 'Amy', 'Adams')
*/