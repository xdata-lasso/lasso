-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NOT EXISTS vs NOT IN when Complaints.customer_id contains a NULL value.
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (1, 'M', 'S1', 'L1', 's1@test.com', '999-9999');
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (1, NULL, 'CAT1', '2020-01-01', NULL, 'Prod1', 'Desc1', 10.0);
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (1, 'REG', 'Addr1', NULL, 'City', 'ST', 'c1@test.com', '111-2222');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (2, 'REG', 'Addr2', NULL, 'City', 'ST', 'c2@test.com', '333-4444');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 100, 'OUT1', 'CLOSED', 'TYPE1', '2021-01-01', '2021-01-02');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (NULL, 1, 1, 101, 'OUT1', 'OPEN', 'TYPE1', '2021-01-03', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, phone_number FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM complaints AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY email_address, phone_number NULLS LAST;

/*
Gold Result:
('c2@test.com', '333-4444')
*/

-- Prediction Query
SELECT email_address, phone_number FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM complaints);

/*
Prediction Result:
*/