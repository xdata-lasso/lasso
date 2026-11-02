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
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 1, 'Ed', 'Edward', 'J', 'Smith', '1980-05-10', '2015-01-01', NULL);
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (1, 'Sedan');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'ACTIVE', '2022-01-01', '1995-03-15', 'Ray', 'Johnson', 0.0, 'ray1@example.com', '111-1111', '111-1112');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (2, 1, 'ACTIVE', '2022-02-01', '1992-07-20', 'Ray', 'Williams', 10.0, 'ray2@example.com', '222-2221', '222-2222');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (3, 1, 'ACTIVE', '2022-03-01', '1990-11-05', 'Alice', 'Brown', 0.0, 'alice@example.com', '333-3331', '333-3332');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (4, 1, 'ACTIVE', '2022-04-01', '1988-09-12', 'Bob', 'Ray', 5.0, 'bob@example.com', '444-4441', '444-4442');
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (1, 1, 1, 1, 'Completed', '2023-01-01', '09:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (2, 1, 1, 1, 'Completed', '2023-01-02', '09:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (3, 1, 1, 1, 'Completed', '2023-01-03', '09:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (4, 1, 1, 1, 'Cancelled', '2023-01-04', '09:00', 0.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (5, 2, 1, 1, 'Completed', '2023-01-05', '10:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (6, 2, 1, 1, 'Completed', '2023-01-06', '10:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (7, 3, 1, 1, 'Completed', '2023-01-07', '11:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (8, 3, 1, 1, 'Completed', '2023-01-08', '11:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (9, 3, 1, 1, 'Completed', '2023-01-09', '11:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (10, 3, 1, 1, 'Completed', '2023-01-10', '11:00', 50.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (11, 4, 1, 1, 'Completed', '2023-01-11', '12:00', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT * FROM (SELECT "customer_id", "lesson_status_code", COUNT(*) AS "n" FROM "lessons" GROUP BY "customer_id", "lesson_status_code") AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "customers" WHERE ("first_name" <> 'Ray')) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Lessons AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'Ray';

/*
Prediction Result:
(6,)
*/