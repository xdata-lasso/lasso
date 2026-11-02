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
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '1 First Ave', 'Boston', '02101', 'MA', 'USA');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'Z', '2020-01-01', '1990-01-01', 'C1', 'L1', 10.0, 'c1@example.com', '101', '201');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (2, 1, 'Z', '2020-01-02', '1990-01-02', 'C2', 'L2', 20.0, 'c2@example.com', '102', '202');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (3, 1, 'Z', '2020-01-03', '1990-01-03', 'C3', 'L3', 30.0, 'c3@example.com', '103', '203');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (4, 1, 'A', '2020-01-04', '1990-01-04', 'C4', 'L4', 40.0, 'c4@example.com', '104', '204');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (5, 1, 'A', '2020-01-05', '1990-01-05', 'C5', 'L5', 50.0, 'c5@example.com', '105', '205');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (6, 1, 'M', '2020-01-06', '1990-01-06', 'C6', 'L6', 60.0, 'c6@example.com', '106', '206');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_status_code_other AS customer_status_code FROM (SELECT LHS.customer_status_code AS customer_status_code, LHS.n AS n, RHS.customer_status_code AS customer_status_code_other, RHS.n AS n_other FROM (SELECT customer_status_code, COUNT(*) AS n FROM customers GROUP BY customer_status_code) AS LHS CROSS JOIN (SELECT customer_status_code, COUNT(*) AS n FROM customers GROUP BY customer_status_code) AS RHS) WHERE (n > n_other) ORDER BY customer_status_code;

/*
Gold Result:
('A',)
('M',)
('M',)
*/

-- Prediction Query
SELECT customer_status_code FROM Customers GROUP BY customer_status_code ORDER BY COUNT(*) ASC, customer_status_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('M',)
*/