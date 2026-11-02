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
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '100 First St', 'Metro', '10001', 'NY', 'USA');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'Active', '2020-01-01', '1990-01-01', 'Evan', 'Evans', 10.0, 'e1@example.com', '111-1111', '111-1112');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (2, 1, 'Active', '2020-01-02', '1991-01-01', 'Eve', 'Evans', 20.0, 'e2@example.com', '111-1113', '111-1114');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (3, 1, 'Active', '2020-01-03', '1992-01-01', 'Dan', 'Davis', 30.0, 'd1@example.com', '111-1115', '111-1116');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (4, 1, 'Active', '2020-01-04', '1993-01-01', 'Dave', 'Davis', 40.0, 'd2@example.com', '111-1117', '111-1118');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (5, 1, 'Active', '2020-01-05', '1994-01-01', 'Clara', 'Clark', 50.0, 'c1@example.com', '111-1119', '111-1120');
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (1, 1, 'E1', 'Edward', 'A', 'Evans', '1980-01-01', '2015-01-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (2, 1, 'E2', 'Emily', 'B', 'Evans', '1981-01-01', '2016-01-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (3, 1, 'E3', 'Eric', 'C', 'Evans', '1982-01-01', '2017-01-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (4, 1, 'D1', 'Diana', 'D', 'Davis', '1983-01-01', '2018-01-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (5, 1, 'C1', 'Carl', 'E', 'Clark', '1984-01-01', '2019-01-01', NULL);
INSERT INTO Staff (staff_id, staff_address_id, nickname, first_name, middle_name, last_name, date_of_birth, date_joined_staff, date_left_staff) VALUES (6, 1, 'C2', 'Cindy', 'F', 'Clark', '1985-01-01', '2020-01-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_address_id AS customer_address_id, LHS.customer_status_code AS customer_status_code, LHS.date_became_customer AS date_became_customer, LHS.date_of_birth AS date_of_birth, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.amount_outstanding AS amount_outstanding, LHS.email_address AS email_address, LHS.phone_number AS phone_number, LHS.cell_mobile_phone_number AS cell_mobile_phone_number, RHS.staff_id AS staff_id, RHS.staff_address_id AS staff_address_id, RHS.nickname AS nickname, RHS.first_name AS first_name_other, RHS.middle_name AS middle_name, RHS.date_of_birth AS date_of_birth_other, RHS.date_joined_staff AS date_joined_staff, RHS.date_left_staff AS date_left_staff FROM customers AS LHS INNER JOIN staff AS RHS ON (LHS.last_name = RHS.last_name)) ORDER BY last_name;

/*
Gold Result:
('Clark',)
('Clark',)
('Davis',)
('Davis',)
('Evans',)
('Evans',)
('Evans',)
('Evans',)
('Evans',)
('Evans',)
*/

-- Prediction Query
SELECT last_name FROM Customers INTERSECT SELECT last_name FROM Staff;

/*
Prediction Result:
('Clark',)
('Davis',)
('Evans',)
*/