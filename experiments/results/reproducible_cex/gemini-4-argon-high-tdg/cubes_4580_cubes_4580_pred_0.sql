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
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 1, 'Dan', 'Daniel', 'A', 'Smith', '1980-01-01', '2010-01-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (3, 1, 'Sam', 'Samuel', 'B', 'Jones', '1985-05-05', '2015-01-01', NULL);
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'ACTIVE', '2020-01-01', '2000-01-01', 'Alice', 'Brown', 0.0, 'alice@example.com', '111-2222', '111-3333');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (3, 1, 'ACTIVE', '2020-02-01', '2001-02-02', 'Bob', 'Green', 50.0, 'bob@example.com', '444-5555', '444-6666');
INSERT INTO Customer_Payments (customer_id, datetime_payment, payment_method_code, amount_payment) VALUES (3, '2020-03-01 10:00:00', 'CARD', 50.0);
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (10, 'Red Hatchback');
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (20, 'Blue Sedan');
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (30, 'Black SUV');
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (1, 3, 3, 20, 'COMPLETED', '2021-01-01', '09:00', 3.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (3, 1, 1, 10, 'SCHEDULED', '2021-01-02', '10:00', 45.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (4, 3, 1, 30, 'COMPLETED', '2021-01-03', '11:00', 60.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (20, 1, 3, 20, 'CANCELLED', '2021-01-04', '14:00', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT vehicle_id, vehicle_details FROM (SELECT vehicle_details, vehicle_id, MAX(n) AS maxn FROM (SELECT lesson_id, customer_id, lesson_status_code, staff_id, vehicle_id, lesson_date, lesson_time, price, vehicle_details, lesson_id AS n FROM (SELECT LHS.lesson_id AS lesson_id, LHS.customer_id AS customer_id, LHS.lesson_status_code AS lesson_status_code, LHS.staff_id AS staff_id, LHS.vehicle_id AS vehicle_id, LHS.lesson_date AS lesson_date, LHS.lesson_time AS lesson_time, LHS.price AS price, RHS.vehicle_details AS vehicle_details FROM lessons AS LHS INNER JOIN (SELECT vehicle_id, vehicle_details, COUNT(*) OVER () AS n FROM vehicles) AS RHS ON (LHS.vehicle_id = RHS.vehicle_id AND LHS.lesson_id = RHS.n))) GROUP BY vehicle_details, vehicle_id) ORDER BY vehicle_id, vehicle_details NULLS LAST;

/*
Gold Result:
(10, 'Red Hatchback')
*/

-- Prediction Query
SELECT T1.vehicle_id, T1.vehicle_details FROM Vehicles AS T1 JOIN Lessons AS T2 ON T1.vehicle_id = T2.vehicle_id GROUP BY T1.vehicle_id ORDER BY COUNT(*) DESC, T1.vehicle_id NULLS LAST, T1.vehicle_details NULLS LAST LIMIT 1;

/*
Prediction Result:
(20, 'Blue Sedan')
*/