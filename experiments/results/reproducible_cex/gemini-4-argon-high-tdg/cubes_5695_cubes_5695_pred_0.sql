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
INSERT INTO Product (product_id, product_name, product_details) VALUES (1, 'Router', 'Network Router');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (1, 'Zack', 'WrongStaffIdOne', 'Staff ID 1');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (2, 'Yara', 'Reporter', 'Reported Problem 1');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (3, 'Xander', 'Closer', 'Closed Problem 1');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (4, 'Bob', 'Smith', 'Assigned to Problem 1');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (5, 'Alice', 'Zimmer', 'Assigned to Problem 1');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (6, 'Alice', 'Adams', 'Assigned to Problem 1');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (7, 'Charlie', 'OtherProblem', 'Assigned to Problem 2');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1, 2, 1, 3, '2023-01-01 10:00:00', '2023-01-05 10:00:00', 'Problem One', 'Details 1');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (2, 4, 1, 5, '2023-01-02 10:00:00', '2023-01-06 10:00:00', 'Problem Two', 'Details 2');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (1, 'OPEN', 2, 7, 'CAT1', '2023-01-02 12:00:00', 'Log ID 1 for Problem 2', 'None', 'Other 1');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (2, 'OPEN', 1, 4, 'CAT1', '2023-01-01 12:00:00', 'Log 2 for Problem 1', 'Fix 2', 'Other 2');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (3, 'OPEN', 1, 5, 'CAT1', '2023-01-01 13:00:00', 'Log 3 for Problem 1', 'Fix 3', 'Other 3');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (4, 'OPEN', 1, 6, 'CAT1', '2023-01-01 14:00:00', 'Log 4 for Problem 1', 'Fix 4', 'Other 4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT staff_first_name, staff_last_name FROM (SELECT LHS.problem_log_id AS problem_log_id, LHS.assigned_to_staff_id AS assigned_to_staff_id, LHS.problem_id AS problem_id, LHS.problem_category_code AS problem_category_code, LHS.problem_status_code AS problem_status_code, LHS.log_entry_date AS log_entry_date, LHS.log_entry_description AS log_entry_description, LHS.log_entry_fix AS log_entry_fix, LHS.other_log_details AS other_log_details, RHS.staff_first_name AS staff_first_name, RHS.staff_last_name AS staff_last_name, RHS.other_staff_details AS other_staff_details FROM (SELECT * FROM problem_log WHERE (problem_id = 1)) AS LHS INNER JOIN staff AS RHS ON (LHS.assigned_to_staff_id = RHS.staff_id)) ORDER BY staff_first_name, staff_last_name NULLS LAST;

/*
Gold Result:
('Alice', 'Adams')
('Alice', 'Zimmer')
('Bob', 'Smith')
*/

-- Prediction Query
SELECT DISTINCT staff_first_name, staff_last_name FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T2.problem_id = 1;

/*
Prediction Result:
('Bob', 'Smith')
('Alice', 'Zimmer')
('Alice', 'Adams')
*/