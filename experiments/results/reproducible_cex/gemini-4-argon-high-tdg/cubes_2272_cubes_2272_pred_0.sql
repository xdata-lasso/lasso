-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (1, 'F', 'Alice', 'Smith', 'alice@example.com', '555-0101');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (1, 'RETAIL', '123 Main St', 'Apt 4', 'Springfield', 'IL', 'cust1@example.com', '555-0201');
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (1, NULL, 'ELEC', '2023-12-01 00:00:00', '2023-12-15 00:00:00', 'Old Router', 'Wireless Router v1', 999.99);
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (2, 1, 'NETW', '2020-01-10 00:00:00', '2024-06-20 12:00:00', 'Pro Switch', 'Managed Switch 24p', 50.00);
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (3, 1, 'CABL', '2021-05-05 00:00:00', NULL, 'Active Cable', 'Cat6 Ethernet Cable', 10.00);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 1, 1, 101, 'RESOLVED', 'CLOSED', 'DEFECT', '2024-01-01 10:00:00', '2024-09-01 10:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (1, 3, 1, 102, 'PENDING', 'OPEN', 'BILLING', '2024-02-01 10:00:00', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, product_category_code FROM (SELECT * FROM (SELECT * FROM products ORDER BY date_product_discontinued DESC, products.product_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Pro Switch', 'NETW')
*/

-- Prediction Query
SELECT product_name, product_category_code FROM products ORDER BY product_price DESC, products.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Old Router', 'ELEC')
*/