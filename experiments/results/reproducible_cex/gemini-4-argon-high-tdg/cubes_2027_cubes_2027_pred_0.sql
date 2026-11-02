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
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '101 Main St', 'Springfield', '12345', 'IL', 'USA');
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (2, '202 Oak Ave', 'Shelbyville', '67890', 'IL', 'USA');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 1, 'Ace', 'John', 'M', 'Doe', '1970-01-01 00:00:00', '2010-01-01 00:00:00', NULL);
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (1, 'Toyota Corolla 2020');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'Good Customer', '2018-01-01 00:00:00', '1990-06-15 00:00:00', 'Alice', 'Smith', 0.0, 'alice@example.com', '111-222-3333', '111-222-3334');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (2, 1, 'Good Customer', '2020-05-10 00:00:00', '1975-03-20 00:00:00', 'Bob', 'Jones', 50.0, 'bob@example.com', '222-333-4444', '222-333-4445');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (3, NULL, 'Good Customer', '2019-07-01 00:00:00', '1990-06-15 00:00:00', 'Charlie', 'Brown', 25.5, 'charlie@example.com', '333-444-5555', '333-444-5556');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (4, 2, 'Bad Customer', '2017-01-01 00:00:00', '1980-01-01 00:00:00', 'David', 'White', 500.0, 'david@example.com', '444-555-6666', '444-555-6667');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (5, 2, 'New Customer', '2021-01-01 00:00:00', '1985-12-12 00:00:00', 'Eve', 'Black', 0.0, 'eve@example.com', '555-666-7777', '555-666-7778');
INSERT INTO Customer_Payments (customer_id, datetime_payment, payment_method_code, amount_payment) VALUES (2, '2021-01-15 10:00:00', 'CARD', 100.0);
INSERT INTO Customer_Payments (customer_id, datetime_payment, payment_method_code, amount_payment) VALUES (2, '2021-02-15 11:00:00', 'CASH', 50.0);
INSERT INTO Customer_Payments (customer_id, datetime_payment, payment_method_code, amount_payment) VALUES (4, '2021-03-15 12:00:00', 'CARD', 20.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (1, 1, 1, 1, 'Completed', '2021-04-01 00:00:00', '09:00', 45.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (2, 1, 1, 1, 'Completed', '2021-04-08 00:00:00', '10:00', 45.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, lesson_status_code, lesson_date, lesson_time, price) VALUES (3, 4, 1, 1, 'Cancelled', '2021-04-09 00:00:00', '14:00', 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_birth" FROM "customers" WHERE ("customer_status_code" = 'Good Customer') ORDER BY date_of_birth, customers.customer_id NULLS LAST;

/*
Gold Result:
('1975-03-20 00:00:00',)
('1990-06-15 00:00:00',)
('1990-06-15 00:00:00',)
*/

-- Prediction Query
SELECT date_of_birth FROM Customers WHERE customer_status_code = 'Good Customer';

/*
Prediction Result:
('1990-06-15 00:00:00',)
('1975-03-20 00:00:00',)
('1990-06-15 00:00:00',)
*/