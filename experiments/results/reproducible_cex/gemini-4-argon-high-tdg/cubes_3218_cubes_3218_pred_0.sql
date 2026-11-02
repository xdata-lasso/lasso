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
INSERT INTO Problem_Category_Codes (problem_category_code, problem_category_description) VALUES ('CAT1', 'UI Bug');
INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) VALUES ('OPEN', 'Open Status');
INSERT INTO Product (product_id, product_name, product_details) VALUES (1, 'System X', 'Core platform');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (10, 'Rylan', 'Smith', 'First name match only');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (20, 'Alice', 'Homenick', 'Last name match only');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (30, 'Rylan', 'Homenick', 'Both names match');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (40, 'Bob', 'Jones', 'No match');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (50, 'Homenick', 'Rylan', 'Swapped names decoy');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (100, 40, 1, 40, '2023-01-01 10:00:00', '2023-01-05 10:00:00', 'Problem 100', 'None');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (200, 10, 1, 20, '2023-01-02 10:00:00', '2023-01-06 10:00:00', 'Problem 200 reported by Rylan', 'None');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (300, 40, 1, 40, '2023-01-03 10:00:00', '2023-01-07 10:00:00', 'Problem 300', 'None');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (1001, 'OPEN', 200, 40, 'CAT1', '2023-01-02 12:00:00', 'Assigned to non-matching staff', 'None', 'Decoy');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (1002, 'OPEN', 100, 20, 'CAT1', '2023-01-03 12:00:00', 'Assigned to Homenick', 'Fix 1', 'Valid');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (1005, 'OPEN', 300, 10, 'CAT1', '2023-01-01 12:00:00', 'Assigned to Rylan', 'Fix 2', 'Valid');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (1008, 'OPEN', 100, 30, 'CAT1', '2023-01-04 12:00:00', 'Assigned to Rylan Homenick', 'Fix 3', 'Valid');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (1009, 'OPEN', 200, 50, 'CAT1', '2023-01-05 12:00:00', 'Assigned to swapped name staff', 'None', 'Decoy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "problem_id", "problem_log_id" FROM (SELECT "LHS"."problem_log_id" AS "problem_log_id", "LHS"."assigned_to_staff_id" AS "assigned_to_staff_id", "LHS"."problem_id" AS "problem_id", "LHS"."problem_category_code" AS "problem_category_code", "LHS"."problem_status_code" AS "problem_status_code", "LHS"."log_entry_date" AS "log_entry_date", "LHS"."log_entry_description" AS "log_entry_description", "LHS"."log_entry_fix" AS "log_entry_fix", "LHS"."other_log_details" AS "other_log_details", "RHS"."staff_first_name" AS "staff_first_name", "RHS"."staff_last_name" AS "staff_last_name", "RHS"."other_staff_details" AS "other_staff_details" FROM "problem_log" AS "LHS" INNER JOIN (SELECT * FROM "staff" WHERE ("staff_first_name" = 'Rylan' OR "staff_last_name" = 'Homenick')) AS RHS ON (LHS.assigned_to_staff_id = RHS.staff_id)) ORDER BY problem_id, "problem_id" NULLS LAST, "problem_log_id" NULLS LAST;

/*
Gold Result:
(100, 1002)
(100, 1008)
(300, 1005)
*/

-- Prediction Query
SELECT DISTINCT T2.problem_id, T2.problem_log_id FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T1.staff_first_name = 'Rylan' AND T1.staff_last_name = 'Homenick';

/*
Prediction Result:
(100, 1008)
*/