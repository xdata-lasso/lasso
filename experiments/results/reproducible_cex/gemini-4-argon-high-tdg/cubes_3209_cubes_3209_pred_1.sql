-- Schema DDL
CREATE TABLE "Problem_Category_Codes" ("problem_category_code" TEXT(20) PRIMARY KEY, "problem_category_description" TEXT(80));

CREATE TABLE "Problem_Log" ("problem_log_id" INTEGER PRIMARY KEY, "problem_status_code" TEXT(20), "problem_id" INTEGER, "assigned_to_staff_id" INTEGER, "problem_category_code" TEXT(20), "log_entry_date" DATETIME, "log_entry_description" TEXT(255), "log_entry_fix" TEXT(255), "other_log_details" TEXT(255), FOREIGN KEY ("problem_status_code") REFERENCES "Problem_Status_Codes" ("problem_status_code"), FOREIGN KEY ("problem_id") REFERENCES "Problems" ("problem_id"), FOREIGN KEY ("assigned_to_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("problem_category_code") REFERENCES "Problem_Category_Codes" ("problem_category_code"));

CREATE TABLE "Problem_Status_Codes" ("problem_status_code" TEXT(20) PRIMARY KEY, "problem_status_description" TEXT(80));

CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(80), "product_details" TEXT(255));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_first_name" TEXT(80), "staff_last_name" TEXT(80), "other_staff_details" TEXT(255));

CREATE TABLE "Problems" ("problem_id" INTEGER PRIMARY KEY, "reported_by_staff_id" INTEGER, "product_id" INTEGER, "closure_authorised_by_staff_id" INTEGER, "date_problem_reported" DATETIME, "date_problem_closed" DATETIME, "problem_description" TEXT(255), "other_problem_details" TEXT(255), FOREIGN KEY ("reported_by_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), FOREIGN KEY ("closure_authorised_by_staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Problem_Category_Codes (problem_category_code, problem_category_description) VALUES ('CAT1', 'Hardware');
INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) VALUES ('OPEN', 'Open Status');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (1, 'Alice', 'Smith', 'Senior Tech');
INSERT INTO Product (product_id, product_name, product_details) VALUES (1, 'Router', 'Details Z');
INSERT INTO Product (product_id, product_name, product_details) VALUES (2, 'Adapter', 'Details Y');
INSERT INTO Product (product_id, product_name, product_details) VALUES (3, 'Monitor', 'Details X');
INSERT INTO Product (product_id, product_name, product_details) VALUES (4, 'Adapter', 'Details W');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (101, 1, 1, 1, '2023-01-01 10:00:00', '2023-01-02 10:00:00', 'Overheating', 'None');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (102, 1, 1, 1, '2023-01-03 10:00:00', NULL, 'Packet loss', 'Urgent');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (103, 1, 2, 1, '2023-01-04 10:00:00', NULL, 'Broken pin', 'Low priority');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (1001, 'OPEN', 101, 1, 'CAT1', '2023-01-01 11:00:00', 'Initial check', 'Replaced fan', 'Done');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM product ORDER BY product_name, product.product_id NULLS LAST;

/*
Gold Result:
('Adapter',)
('Adapter',)
('Monitor',)
('Router',)
*/

-- Prediction Query
SELECT DISTINCT product_name FROM product ORDER BY product_id, product_name NULLS LAST;

/*
Prediction Result:
('Router',)
('Adapter',)
('Monitor',)
*/