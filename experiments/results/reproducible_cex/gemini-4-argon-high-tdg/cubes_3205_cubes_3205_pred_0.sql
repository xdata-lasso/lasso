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
INSERT INTO Product (product_id, product_name, product_details) VALUES (30, 'Alpha', 'Detail A');
INSERT INTO Product (product_id, product_name, product_details) VALUES (10, 'Beta', 'Detail B');
INSERT INTO Product (product_id, product_name, product_details) VALUES (20, 'Gamma', 'Detail C');
INSERT INTO Product (product_id, product_name, product_details) VALUES (15, 'Delta', 'Detail D');
INSERT INTO Product (product_id, product_name, product_details) VALUES (40, 'Epsilon', 'No problems product');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (100, 'Alice', 'Smith', 'Senior');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (101, 'Bob', 'Jones', 'Junior');
INSERT INTO Problem_Category_Codes (problem_category_code, problem_category_description) VALUES ('CAT1', 'Hardware');
INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) VALUES ('OPEN', 'Open Status');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1001, 100, 10, 101, '2023-01-01 10:00:00', '2023-01-02 10:00:00', 'Crash 1', 'D1');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1002, 101, 10, 100, '2023-01-03 10:00:00', '2023-01-04 10:00:00', 'Crash 2', 'D2');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1003, 100, 10, 101, '2023-01-05 10:00:00', '2023-01-06 10:00:00', 'Crash 3', 'D3');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1004, 100, 20, 101, '2023-01-07 10:00:00', '2023-01-08 10:00:00', 'Bug 1', 'D4');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1005, 101, 30, 100, '2023-01-09 10:00:00', '2023-01-10 10:00:00', 'Glitch 1', 'D5');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1006, 101, 30, 100, '2023-01-11 10:00:00', '2023-01-12 10:00:00', 'Glitch 2', 'D6');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1007, 100, 15, 101, '2023-01-13 10:00:00', '2023-01-14 10:00:00', 'Error 1', 'D7');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1008, 100, 15, 101, '2023-01-15 10:00:00', '2023-01-16 10:00:00', 'Error 2', 'D8');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (501, 'OPEN', 1004, 100, 'CAT1', '2023-01-07 11:00:00', 'Log 1', 'Fix 1', 'L1');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (502, 'OPEN', 1004, 100, 'CAT1', '2023-01-07 12:00:00', 'Log 2', 'Fix 2', 'L2');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (503, 'OPEN', 1004, 101, 'CAT1', '2023-01-07 13:00:00', 'Log 3', 'Fix 3', 'L3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, product_id FROM (SELECT product_id, COUNT(*) AS n FROM (SELECT LHS.product_id AS product_id, LHS.product_name AS product_name, LHS.product_details AS product_details, RHS.problem_id AS problem_id, RHS.closure_authorised_by_staff_id AS closure_authorised_by_staff_id, RHS.reported_by_staff_id AS reported_by_staff_id, RHS.date_problem_reported AS date_problem_reported, RHS.date_problem_closed AS date_problem_closed, RHS.problem_description AS problem_description, RHS.other_problem_details AS other_problem_details FROM product AS LHS INNER JOIN problems AS RHS ON (LHS.product_id = RHS.product_id)) GROUP BY product_id) ORDER BY count___, product_id NULLS LAST;

/*
Gold Result:
(1, 20)
(2, 15)
(2, 30)
(3, 10)
*/

-- Prediction Query
SELECT COUNT(*), T2.product_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id GROUP BY T2.product_id;

/*
Prediction Result:
(3, 10)
(2, 15)
(1, 20)
(2, 30)
*/