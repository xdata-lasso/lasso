-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (1, 'F', 'Alice', 'Smith', 'alice@example.com', '555-0101');
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (2, 'M', 'Bob', 'Jones', 'bob@example.com', '555-0102');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (1, 'REG', '10 Main St', NULL, 'Austin', 'TX', 'cust1@example.com', '555-0201');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (2, 'VIP', '20 Oak Ave', 'Apt 4', 'Dallas', 'TX', 'cust2@example.com', '555-0202');
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (1, NULL, 'ELEC', '2020-01-01 00:00:00', NULL, 'Laptop', '15-inch laptop', 999.99);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 101, 'Outcome_A', 'S1', 'T1', '2023-01-01 10:00:00', '2023-01-05 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (2, 1, 1, 102, 'Outcome_A', 'S2', 'T1', '2023-01-02 10:00:00', '2023-01-06 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 103, 'Outcome_A', 'S3', 'T2', '2023-01-03 10:00:00', '2023-01-07 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 104, 'Outcome_A', 'S4', 'T3', '2023-01-04 10:00:00', '2023-01-08 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 105, 'Outcome_B', 'S1', 'T1', '2023-02-01 10:00:00', '2023-02-05 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 106, 'Outcome_B', 'S2', 'T1', '2023-02-02 10:00:00', '2023-02-06 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 107, 'Outcome_B', 'S3', 'T1', '2023-02-03 10:00:00', '2023-02-07 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 108, 'Outcome_C', 'S1', 'T2', '2023-03-01 10:00:00', '2023-03-05 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 109, 'Outcome_C', 'S2', 'T4', '2023-03-02 10:00:00', '2023-03-06 12:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 110, 'Outcome_D', 'S5', 'T5', '2023-04-01 10:00:00', '2023-04-05 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_complaint_type_code_ FROM (SELECT complaint_outcome_code, COUNT(DISTINCT complaint_type_code) AS n_distinct FROM complaints GROUP BY complaint_outcome_code) ORDER BY count_distinct_complaint_type_code_;

/*
Gold Result:
(1,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT complaint_type_code) FROM complaints;

/*
Prediction Result:
(5,)
*/