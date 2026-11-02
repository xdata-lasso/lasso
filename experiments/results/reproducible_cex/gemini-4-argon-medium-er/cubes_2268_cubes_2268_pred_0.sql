-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, email_address, phone_number) VALUES (1, 'a@example.com', '222');
INSERT INTO Customers (customer_id, email_address, phone_number) VALUES (2, 'a@example.com', '111');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, phone_number FROM customers ORDER BY email_address, customers.customer_id NULLS LAST;

/*
Gold Result:
('a@example.com', '222')
('a@example.com', '111')
*/

-- Prediction Query
SELECT email_address, phone_number FROM customers ORDER BY email_address, phone_number, customers.customer_id NULLS LAST;

/*
Prediction Result:
('a@example.com', '111')
('a@example.com', '222')
*/