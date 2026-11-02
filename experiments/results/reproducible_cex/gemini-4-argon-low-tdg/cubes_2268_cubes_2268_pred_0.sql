-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by email_address (ASC vs DESC), tie-breaking by customer_id, and duplicate (email_address, phone_number) pairs to catch DISTINCT mutants.
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (1, 'RET', '10 Main St', 'Apt 1', 'Boston', 'MA', 'charlie@example.com', '555-0103');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (2, 'CORP', '20 Oak St', 'Suite 2', 'Chicago', 'IL', 'alice@example.com', '555-0102');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (3, 'RET', '30 Pine St', 'Apt 3', 'Seattle', 'WA', 'alice@example.com', '555-0101');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (4, 'RET', '40 Elm St', 'Apt 4', 'Austin', 'TX', 'alice@example.com', '555-0101');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (5, 'GOV', '50 Maple St', 'Floor 5', 'Denver', 'CO', 'bob@example.com', '555-0100');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, phone_number FROM customers ORDER BY email_address, customers.customer_id NULLS LAST;

/*
Gold Result:
('alice@example.com', '555-0102')
('alice@example.com', '555-0101')
('alice@example.com', '555-0101')
('bob@example.com', '555-0100')
('charlie@example.com', '555-0103')
*/

-- Prediction Query
SELECT email_address, phone_number FROM customers ORDER BY email_address, phone_number, customers.customer_id NULLS LAST;

/*
Prediction Result:
('alice@example.com', '555-0101')
('alice@example.com', '555-0101')
('alice@example.com', '555-0102')
('bob@example.com', '555-0100')
('charlie@example.com', '555-0103')
*/