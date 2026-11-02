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
-- Tests basic anti-join behavior, ORDER BY ASC vs DESC, duplicate first_names (SELECT vs SELECT DISTINCT),
-- and incorrect column selection (first_name vs last_name/middle_name/nickname).
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '123 Main St', 'Metropolis', '10001', 'NY', 'USA');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 1, 'ZackNick', 'Zack', 'M1', 'Alpha', '1980-01-01', '2010-01-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (2, 1, 'AliceNick1', 'Alice', 'M2', 'Zeta', '1985-02-02', '2012-02-02', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (3, 1, 'AliceNick2', 'Alice', 'M3', 'Beta', '1990-03-03', '2015-03-03', '2020-03-03');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (4, 1, 'BobNick', 'Bob', 'M4', 'Gamma', '1982-04-04', '2011-04-04', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (5, 1, 'CharlieNick', 'Charlie', 'M5', 'Delta', '1988-05-05', '2014-05-05', NULL);
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (1, 'Sedan');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'ACTIVE', '2020-01-01', '2000-01-01', 'CustFirst', 'CustLast', 0.0, 'cust@example.com', '111-2222', '333-4444');
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (10, 1, 4, 1, 'COMPLETED', '2021-01-01', '10:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (11, 1, 5, 1, 'COMPLETED', '2021-01-02', '11:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (12, 1, 5, 1, 'CANCELLED', '2021-01-03', '12:00', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM (SELECT * FROM staff AS LHS WHERE NOT EXISTS(SELECT 1 FROM lessons AS RHS WHERE (LHS.staff_id = RHS.staff_id))) ORDER BY first_name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT first_name FROM Staff EXCEPT SELECT T2.first_name FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id;

/*
Prediction Result:
('Alice',)
('Zack',)
*/