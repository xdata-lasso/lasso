-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1012, 'during', '316 Rivera Mountain
Brownchester, MS 77057', '4641 Smith Plains Apt. 531
Port Anthonybury, ID 03172', 'East David', 'Delaware', 'acastaneda@example.net', '(699)812-4190');
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1011, 'wide', '9901 Taylor Mountain
North Jorge, MD 28243', 'USS Gates
FPO AP 50358', 'Smithstad', 'Maryland', 'acastaneda@example.net', '001-489-937-3467x0656');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, phone_number FROM customers ORDER BY email_address, customers.customer_id NULLS LAST;

/*
Gold Result:
('acastaneda@example.net', '001-489-937-3467x0656')
('acastaneda@example.net', '(699)812-4190')
*/

-- Prediction Query
SELECT email_address, phone_number FROM customers ORDER BY email_address, phone_number, customers.customer_id NULLS LAST;

/*
Prediction Result:
('acastaneda@example.net', '(699)812-4190')
('acastaneda@example.net', '001-489-937-3467x0656')
*/