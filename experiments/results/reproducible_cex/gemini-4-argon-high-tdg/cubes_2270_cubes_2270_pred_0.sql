-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (1, 'M', 'John', 'Doe', 'john.doe@example.com', '555-0101');
INSERT INTO Staff (staff_id, gender, first_name, last_name, email_address, phone_number) VALUES (2, 'F', 'Jane', 'Smith', 'jane.smith@example.com', '555-0102');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (10, 'Retail', '123 Main St', NULL, 'Springfield', 'IL', 'cust10@example.com', '555-1001');
INSERT INTO Customers (customer_id, customer_type_code, address_line_1, address_line_2, town_city, state, email_address, phone_number) VALUES (20, 'Wholesale', '456 Oak Ave', 'Suite 2', 'Chicago', 'IL', 'cust20@example.com', '555-1002');
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (100, NULL, 'Electronics', '2020-01-01 00:00:00', NULL, 'Laptop', '15-inch Laptop', 999.99);
INSERT INTO Products (product_id, parent_product_id, product_category_code, date_product_first_available, date_product_discontinued, product_name, product_description, product_price) VALUES (200, 100, 'Accessories', '2020-06-01 00:00:00', NULL, 'Charger', 'Laptop Charger', 49.99);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (10, 100, 1, 1001, 'Refund', 'Open', 'Product Failure', '2023-01-10 09:00:00', NULL);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (20, 200, 2, 1002, 'Replacement', 'Open', 'Product Failure', '2023-01-11 10:00:00', NULL);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (10, 200, 1, 1003, 'Pending', 'Open', 'Product Failure', '2023-01-12 11:00:00', NULL);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (10, 100, 1, 1004, 'Pending', 'Open', 'Late Delivery', '2023-01-13 12:00:00', NULL);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (20, 100, 2, 1005, 'Escalated', 'Escalated', 'Product Failure', '2023-01-14 13:00:00', NULL);
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (10, 100, 1, 1006, 'Resolved', 'Closed', 'Product Failure', '2023-01-01 08:00:00', '2023-01-05 17:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (20, 200, 2, 1007, 'Resolved', 'Closed', 'Product Failure', '2023-01-02 08:30:00', '2023-01-06 16:00:00');
INSERT INTO Complaints (customer_id, product_id, staff_id, complaint_id, complaint_outcome_code, complaint_status_code, complaint_type_code, date_complaint_raised, date_complaint_closed) VALUES (20, 200, 2, 1008, 'Rejected', 'Rejected', 'Billing Issue', '2023-01-03 09:30:00', '2023-01-04 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "complaint_status_code", "n_distinct" AS "count___" FROM (SELECT "complaint_status_code", "complaint_type_code", COUNT(DISTINCT "complaint_type_code") AS "n_distinct" FROM "complaints" GROUP BY "complaint_status_code", "complaint_type_code") WHERE ("complaint_type_code" = 'Product Failure') ORDER BY complaint_status_code, "complaint_status_code" NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('Closed', 1)
('Escalated', 1)
('Open', 1)
*/

-- Prediction Query
SELECT complaint_status_code, COUNT(*) FROM complaints WHERE complaint_type_code = 'Product Failure' GROUP BY complaint_status_code;

/*
Prediction Result:
('Closed', 2)
('Escalated', 1)
('Open', 3)
*/