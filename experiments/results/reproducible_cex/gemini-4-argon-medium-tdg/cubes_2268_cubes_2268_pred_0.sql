-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by email_address, tie-breaking by customer_id, and distinguishing Customers from Staff and Complaints
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (1, 'M', 'John', 'Doe', 'staff1@example.com', '999-0001');
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (2, 'F', 'Jane', 'Smith', 'staff2@example.com', '999-0002');
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (1, NULL, 'ELEC', '2020-01-01', NULL, 'Laptop', 'Gaming Laptop', 1200.00);
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (10, 'REG', '123 A St', NULL, 'CityA', 'StateA', 'charlie@example.com', '111-2222');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (20, 'VIP', '456 B St', NULL, 'CityB', 'StateB', 'alice@example.com', '333-4444');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (5, 'REG', '789 C St', NULL, 'CityC', 'StateC', 'alice@example.com', '555-6666');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (15, 'VIP', '101 D St', NULL, 'CityD', 'StateD', 'bob@example.com', '777-8888');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (10, 1, 1, 100, 'RESOLVED', 'CLOSED', 'DEFECT', '2021-01-01', '2021-01-05');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (10, 1, 2, 101, 'PENDING', 'OPEN', 'BILLING', '2021-02-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, phone_number FROM customers ORDER BY email_address, customers.customer_id NULLS LAST;

/*
Gold Result:
('alice@example.com', '555-6666')
('alice@example.com', '333-4444')
('bob@example.com', '777-8888')
('charlie@example.com', '111-2222')
*/

-- Prediction Query
SELECT email_address, phone_number FROM customers ORDER BY email_address, phone_number, customers.customer_id NULLS LAST;

/*
Prediction Result:
('alice@example.com', '333-4444')
('alice@example.com', '555-6666')
('bob@example.com', '777-8888')
('charlie@example.com', '111-2222')
*/