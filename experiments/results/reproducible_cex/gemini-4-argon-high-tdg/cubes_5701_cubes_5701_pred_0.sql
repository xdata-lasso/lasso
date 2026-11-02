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
INSERT INTO Problem_Category_Codes (problem_category_code, problem_category_description) VALUES ('C1', 'Network');
INSERT INTO Problem_Category_Codes (problem_category_code, problem_category_description) VALUES ('C2', 'Database');
INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) VALUES ('S1', 'Open');
INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) VALUES ('S2', 'Closed');
INSERT INTO Product (product_id, product_name, product_details) VALUES (1, 'Router', 'Core Router');
INSERT INTO Product (product_id, product_name, product_details) VALUES (2, 'Switch', 'Edge Switch');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (1, 'Alice', 'Smith', 'Tech');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (2, 'Bob', 'Jones', 'Admin');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1, 1, 1, 2, '2023-01-01 08:00:00', '2023-01-02 08:00:00', 'Packet loss', 'Urgent');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (2, 2, 2, 1, '2023-01-03 08:00:00', '2023-01-04 08:00:00', 'Port down', 'Routine');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (5, 'S1', 1, 1, 'C2', '2023-06-01 10:00:00', 'Self matching row', 'FIX_B', 'FIX_B');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (10, 'S1', 1, 1, 'C1', '2023-05-01 10:00:00', 'LHS multi-match 1', 'FIX_X', 'FIX_A');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (20, 'S2', 2, 2, 'C1', '2023-04-01 10:00:00', 'RHS match target 1', 'FIX_A', 'FIX_Y');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (30, 'S2', 2, 1, 'C1', '2023-03-01 10:00:00', 'RHS match target 2', 'FIX_A', 'FIX_Z');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (40, 'S1', 2, 2, 'C1', '2023-01-01 10:00:00', 'LHS multi-match 2', 'FIX_W', 'FIX_A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT problem_log_id FROM (SELECT log_entry_date, problem_log_id, MAX(log_entry_date) AS maxlog_entry_date FROM (SELECT problem_log_id, assigned_to_staff_id, problem_id, problem_category_code, problem_status_code, log_entry_date, log_entry_description, other_log_details AS log_entry_fix, other_log_details, problem_log_id_other, assigned_to_staff_id_other, problem_id_other, problem_status_code_other, log_entry_date_other, log_entry_description_other, other_log_details_other FROM (SELECT LHS.problem_log_id AS problem_log_id, LHS.assigned_to_staff_id AS assigned_to_staff_id, LHS.problem_id AS problem_id, LHS.problem_category_code AS problem_category_code, LHS.problem_status_code AS problem_status_code, LHS.log_entry_date AS log_entry_date, LHS.log_entry_description AS log_entry_description, LHS.log_entry_fix AS log_entry_fix, LHS.other_log_details AS other_log_details, RHS.problem_log_id AS problem_log_id_other, RHS.assigned_to_staff_id AS assigned_to_staff_id_other, RHS.problem_id AS problem_id_other, RHS.problem_status_code AS problem_status_code_other, RHS.log_entry_date AS log_entry_date_other, RHS.log_entry_description AS log_entry_description_other, RHS.other_log_details AS other_log_details_other FROM problem_log AS LHS INNER JOIN problem_log AS RHS ON (LHS.problem_category_code = RHS.problem_category_code AND LHS.other_log_details = RHS.log_entry_fix))) GROUP BY log_entry_date, problem_log_id) ORDER BY problem_log_id;

/*
Gold Result:
(5,)
(10,)
(40,)
*/

-- Prediction Query
SELECT problem_log_id FROM problem_log ORDER BY log_entry_date DESC, problem_log.problem_log_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(5,)
*/