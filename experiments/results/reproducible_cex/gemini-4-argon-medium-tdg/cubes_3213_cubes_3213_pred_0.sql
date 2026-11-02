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
INSERT INTO Problem_Category_Codes (problem_category_code, problem_category_description) VALUES ('CAT1', 'Category 1');
INSERT INTO Problem_Status_Codes (problem_status_code, problem_status_description) VALUES ('STAT1', 'Status 1');
INSERT INTO Product (product_id, product_name, product_details) VALUES (1, 'Product 1', 'Details 1');
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (1, 'John', 'Doe', 'Details');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1, 1, 1, 1, '2023-01-01 00:00:00', '2023-01-02 00:00:00', 'Desc', 'Other');
-- Row 10 joins with Row 20: tests LHS vs RHS direction, self-join vs distinct-row join, and join predicate conditions
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (10, 'STAT1', 1, 1, 'CAT1', '2023-01-01 10:00:00', 'DescA', 'Val1', 'Val2');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (20, 'STAT1', 1, 1, 'CAT1', '2023-01-02 10:00:00', 'DescA', 'Val3', 'Val1');
-- Row 5 self-joins: tests ORDER BY (5 before 10) and self-join matching where fix = other_log_details
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (5, 'STAT1', 1, 1, 'CAT1', '2023-01-03 10:00:00', 'DescB', 'SameVal', 'SameVal');
-- Row 30 & 40: matches log_entry_description ONLY, fails log_entry_fix = other_log_details
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (30, 'STAT1', 1, 1, 'CAT1', '2023-01-04 10:00:00', 'DescC', 'FixX', 'DetX');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (40, 'STAT1', 1, 1, 'CAT1', '2023-01-05 10:00:00', 'DescC', 'FixX', 'DetY');
-- Row 50 & 60: matches log_entry_fix = other_log_details ONLY, fails log_entry_description
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (50, 'STAT1', 1, 1, 'CAT1', '2023-01-06 10:00:00', 'DescD1', 'MatchVal', 'Other1');
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code, log_entry_date, log_entry_description, log_entry_fix, other_log_details) VALUES (60, 'STAT1', 1, 1, 'CAT1', '2023-01-07 10:00:00', 'DescD2', 'Other2', 'MatchVal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT problem_log_id FROM (SELECT LHS.problem_log_id AS problem_log_id, LHS.assigned_to_staff_id AS assigned_to_staff_id, LHS.problem_id AS problem_id, LHS.problem_category_code AS problem_category_code, LHS.problem_status_code AS problem_status_code, LHS.log_entry_date AS log_entry_date, LHS.log_entry_description AS log_entry_description, LHS.log_entry_fix AS log_entry_fix, LHS.other_log_details AS other_log_details, RHS.problem_log_id AS problem_log_id_other, RHS.assigned_to_staff_id AS assigned_to_staff_id_other, RHS.problem_id AS problem_id_other, RHS.problem_category_code AS problem_category_code_other, RHS.problem_status_code AS problem_status_code_other, RHS.log_entry_date AS log_entry_date_other, RHS.log_entry_fix AS log_entry_fix_other FROM problem_log AS LHS INNER JOIN problem_log AS RHS ON (LHS.log_entry_description = RHS.log_entry_description AND LHS.log_entry_fix = RHS.other_log_details)) ORDER BY problem_log_id;

/*
Gold Result:
(5,)
(10,)
*/

-- Prediction Query
SELECT problem_log_id FROM problem_log ORDER BY log_entry_date DESC, problem_log.problem_log_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(60,)
*/