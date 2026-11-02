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
-- Tests duplicate preservation (INNER JOIN multiplicity vs INTERSECT, SELECT DISTINCT, or IN/EXISTS).
-- 2 Customers with 'Smith' and 3 Staff with 'Smith' must yield 6 rows of 'Smith'.
INSERT INTO Addresses (address_id, line_1_number_building, city) VALUES (1, '456 Oak Rd', 'Gotham');
INSERT INTO Customers (customer_id, customer_address_id, first_name, last_name) VALUES (1, 1, 'John', 'Smith');
INSERT INTO Customers (customer_id, customer_address_id, first_name, last_name) VALUES (2, 1, 'Jane', 'Smith');
INSERT INTO Staff (staff_id, staff_address_id, first_name, last_name) VALUES (1, 1, 'Agent1', 'Smith');
INSERT INTO Staff (staff_id, staff_address_id, first_name, last_name) VALUES (2, 1, 'Agent2', 'Smith');
INSERT INTO Staff (staff_id, staff_address_id, first_name, last_name) VALUES (3, 1, 'Agent3', 'Smith');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_address_id AS customer_address_id, LHS.customer_status_code AS customer_status_code, LHS.date_became_customer AS date_became_customer, LHS.date_of_birth AS date_of_birth, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.amount_outstanding AS amount_outstanding, LHS.email_address AS email_address, LHS.phone_number AS phone_number, LHS.cell_mobile_phone_number AS cell_mobile_phone_number, RHS.staff_id AS staff_id, RHS.staff_address_id AS staff_address_id, RHS.nickname AS nickname, RHS.first_name AS first_name_other, RHS.middle_name AS middle_name, RHS.date_of_birth AS date_of_birth_other, RHS.date_joined_staff AS date_joined_staff, RHS.date_left_staff AS date_left_staff FROM customers AS LHS INNER JOIN staff AS RHS ON (LHS.last_name = RHS.last_name)) ORDER BY last_name;

/*
Gold Result:
('Smith',)
('Smith',)
('Smith',)
('Smith',)
('Smith',)
('Smith',)
*/

-- Prediction Query
SELECT last_name FROM Customers INTERSECT SELECT last_name FROM Staff;

/*
Prediction Result:
('Smith',)
*/