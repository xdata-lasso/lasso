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
-- Tests basic INNER JOIN, ORDER BY ASC vs DESC, and DISTINCT vs ALL (multiplicity via N:M join)
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, '10 Main St', 'Boston', '02101', 'MA', 'USA');
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (2, '20 Oak St', 'Chicago', '60601', 'IL', 'USA');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (101, 1, 'Active', '2021-01-01', '1990-05-05', 'Alice', 'Zimmerman', 50.0, 'alice@example.com', '111-2222', '111-3333');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (102, 1, 'Active', '2021-02-01', '1985-06-06', 'Bob', 'Adams', 0.0, 'bob@example.com', '222-3333', '222-4444');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (103, 2, 'Inactive', '2021-03-01', '1992-07-07', 'Charlie', 'Adams', 10.0, 'charlie@example.com', '333-4444', '333-5555');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (104, 2, 'Active', '2021-04-01', '1995-08-08', 'David', 'UnmatchedCust', 0.0, 'david@example.com', '444-5555', '444-6666');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (201, 2, 'Zim', 'Zach', 'M', 'Zimmerman', '1980-01-01', '2019-01-01', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (202, 2, 'Addy', 'Amy', 'N', 'Adams', '1982-02-02', '2018-05-01', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (203, 1, 'Art', 'Arthur', 'O', 'Adams', '1975-03-03', '2015-06-01', '2022-01-01');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (204, 1, 'Sam', 'Samantha', 'P', 'UnmatchedStaff', '1988-04-04', '2020-07-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_address_id AS customer_address_id, LHS.customer_status_code AS customer_status_code, LHS.date_became_customer AS date_became_customer, LHS.date_of_birth AS date_of_birth, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.amount_outstanding AS amount_outstanding, LHS.email_address AS email_address, LHS.phone_number AS phone_number, LHS.cell_mobile_phone_number AS cell_mobile_phone_number, RHS.staff_id AS staff_id, RHS.staff_address_id AS staff_address_id, RHS.nickname AS nickname, RHS.first_name AS first_name_other, RHS.middle_name AS middle_name, RHS.date_of_birth AS date_of_birth_other, RHS.date_joined_staff AS date_joined_staff, RHS.date_left_staff AS date_left_staff FROM customers AS LHS INNER JOIN staff AS RHS ON (LHS.last_name = RHS.last_name)) ORDER BY last_name;

/*
Gold Result:
('Adams',)
('Adams',)
('Adams',)
('Adams',)
('Zimmerman',)
*/

-- Prediction Query
SELECT last_name FROM Customers INTERSECT SELECT last_name FROM Staff;

/*
Prediction Result:
('Adams',)
('Zimmerman',)
*/