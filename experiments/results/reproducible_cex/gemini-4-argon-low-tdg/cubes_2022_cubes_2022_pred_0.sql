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
-- Tests basic filtering (AND vs OR), column confusion (nickname/middle_name), Customers vs Staff table confusion, ordering (ASC vs DESC), and duplicate preservation (SELECT vs SELECT DISTINCT).
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '123 Main St', 'Metropolis', '10001', 'NY', 'USA');
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (1, 'Toyota Corolla');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'Active', '2020-01-01', '1995-05-05', 'Janessa', 'Sawayn', 0.0, 'janessa.c@example.com', '123-456-7890', '098-765-4321');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (2, 1, 'Active', '2020-01-01', '1995-05-05', 'Bob', 'Builder', 0.0, 'bob@example.com', '123-456-7890', '098-765-4321');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 1, 'Jan', 'Janessa', 'Marie', 'Sawayn', '1985-04-12', '2015-06-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (2, 1, 'Janny', 'Janessa', 'Marie', 'Smith', '1986-04-12', '2016-06-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (3, 1, 'Saw', 'John', 'Edward', 'Sawayn', '1987-04-12', '2017-06-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (4, 1, 'Janessa', 'Alice', 'Janessa', 'Sawayn', '1988-04-12', '2018-06-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (5, 1, 'Sawayn', 'Janessa', 'Sawayn', 'Doe', '1989-04-12', '2019-06-01', NULL);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (1, 2, 1, 1, 'Completed', '2023-01-10', '14:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (2, 2, 1, 1, 'Completed', '2023-01-11', '09:30', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (3, 2, 1, 1, 'Completed', '2023-01-12', '14:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (4, 2, 2, 1, 'Completed', '2023-01-13', '10:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (5, 2, 3, 1, 'Completed', '2023-01-14', '11:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (6, 2, 4, 1, 'Completed', '2023-01-15', '12:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (7, 2, 5, 1, 'Completed', '2023-01-16', '13:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (8, 1, 2, 1, 'Completed', '2023-01-17', '15:00', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lesson_time" AS "sum_lesson_time_" FROM (SELECT "LHS"."staff_id" AS "staff_id", "LHS"."staff_address_id" AS "staff_address_id", "LHS"."nickname" AS "nickname", "LHS"."first_name" AS "first_name", "LHS"."middle_name" AS "middle_name", "LHS"."last_name" AS "last_name", "LHS"."date_of_birth" AS "date_of_birth", "LHS"."date_joined_staff" AS "date_joined_staff", "LHS"."date_left_staff" AS "date_left_staff", "RHS"."lesson_id" AS "lesson_id", "RHS"."customer_id" AS "customer_id", "RHS"."lesson_status_code" AS "lesson_status_code", "RHS"."vehicle_id" AS "vehicle_id", "RHS"."lesson_date" AS "lesson_date", "RHS"."lesson_time" AS "lesson_time", "RHS"."price" AS "price" FROM "staff" AS "LHS" INNER JOIN "lessons" AS "RHS" ON ("LHS"."staff_id" = "RHS"."staff_id")) WHERE ("first_name" = 'Janessa' AND "last_name" = 'Sawayn') ORDER BY sum_lesson_time_;

/*
Gold Result:
('09:30',)
('14:00',)
('14:00',)
*/

-- Prediction Query
SELECT SUM(lesson_time) FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id WHERE T2.first_name = 'Janessa' AND T2.last_name = 'Sawayn';

/*
Prediction Result:
(37.0,)
*/