-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (1, 'M', 'John', 'Smith', 'john.smith@staff.com', '555-0101');
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (2, 'F', 'Jane', 'Doe', 'jane.doe@staff.com', '555-0102');
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (1, NULL, 'ELEC', '2020-01-01 00:00:00', NULL, 'Laptop', '15-inch Laptop', 999.99);
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (2, 1, 'ACC', '2020-02-01 00:00:00', '2022-01-01 00:00:00', 'Mouse', 'Wireless Mouse', 29.99);
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (1, 'REG', '10 Main St', NULL, 'Austin', 'TX', 'charlie@example.com', '555-3000');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (2, 'VIP', '20 Oak Ave', 'Apt 2B', 'Dallas', 'TX', 'alice@example.com', '555-1000');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (3, 'REG', '30 Pine Rd', NULL, 'Houston', 'TX', 'bob@example.com', '555-2000');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (4, 'VIP', '40 Elm St', 'Suite 100', 'Austin', 'TX', 'david@example.com', '555-4000');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (3, 1, 1, 1, 'RESOLVED', 'CLOSED', 'DEFECT', '2021-05-01 10:00:00', '2021-05-05 14:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (4, 2, 2, 2, 'PENDING', 'OPEN', 'BILLING', '2021-06-01 09:00:00', NULL);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (4, 1, 1, 3, 'RESOLVED', 'CLOSED', 'DELIVERY', '2021-07-01 11:00:00', '2021-07-03 16:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, phone_number FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM complaints AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY email_address, phone_number NULLS LAST;

/*
Gold Result:
('alice@example.com', '555-1000')
('charlie@example.com', '555-3000')
*/

-- Prediction Query
SELECT email_address, phone_number FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM complaints);

/*
Prediction Result:
('charlie@example.com', '555-3000')
('alice@example.com', '555-1000')
*/