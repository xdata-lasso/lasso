-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1, 'M', 'John', 'Doe', 'staff1@example.com', '111-1111');
INSERT INTO "Staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (2, 'F', 'Jane', 'Smith', 'staff2@example.com', '222-2222');
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1, NULL, 'CAT1', '2020-01-01 00:00:00', NULL, 'Prod A', 'Desc A', 10.50);
INSERT INTO "Products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (2, 1, 'CAT1', '2020-02-01 00:00:00', NULL, 'Prod B', 'Desc B', 20.00);
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1, 'REG', '100 Main St', NULL, 'Metropolis', 'NY', 'c_complainer1@example.com', '900-0001');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (2, 'VIP', '200 Oak St', 'Apt 2', 'Gotham', 'NJ', 'c_complainer2@example.com', '900-0002');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (3, 'REG', '300 Pine St', NULL, 'Star City', 'CA', 'b_clean@example.com', '500-0002');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (4, 'VIP', '400 Maple St', NULL, 'Central City', 'MO', 'a_clean@example.com', '500-0003');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (5, 'REG', '500 Elm St', NULL, 'Coast City', 'CA', 'a_clean@example.com', '500-0001');
INSERT INTO "Customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (6, 'REG', '600 Birch St', NULL, 'Smallville', 'KS', 'b_clean@example.com', '500-0002');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 1, 1, 10, 'RESOLVED', 'CLOSED', 'BILLING', '2021-01-01 10:00:00', '2021-01-02 10:00:00');
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1, 2, 2, 11, 'PENDING', 'OPEN', 'DEFECT', '2021-02-01 10:00:00', NULL);
INSERT INTO "Complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (2, 1, 1, 12, 'VOID', 'CANCELLED', 'DELIVERY', '2021-03-01 10:00:00', '2021-03-01 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, phone_number FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM complaints AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY email_address, phone_number NULLS LAST;

/*
Gold Result:
('a_clean@example.com', '500-0001')
('a_clean@example.com', '500-0003')
('b_clean@example.com', '500-0002')
('b_clean@example.com', '500-0002')
*/

-- Prediction Query
SELECT email_address, phone_number FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM complaints);

/*
Prediction Result:
('b_clean@example.com', '500-0002')
('a_clean@example.com', '500-0003')
('a_clean@example.com', '500-0001')
('b_clean@example.com', '500-0002')
*/