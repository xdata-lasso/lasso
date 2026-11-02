-- Schema DDL
CREATE TABLE "Problem_Category_Codes" ("problem_category_code" TEXT(20) PRIMARY KEY, "problem_category_description" TEXT(80));

CREATE TABLE "Problem_Log" ("problem_log_id" INTEGER PRIMARY KEY, "problem_status_code" TEXT(20), "problem_id" INTEGER, "assigned_to_staff_id" INTEGER, "problem_category_code" TEXT(20), "log_entry_date" DATETIME, "log_entry_description" TEXT(255), "log_entry_fix" TEXT(255), "other_log_details" TEXT(255), FOREIGN KEY ("problem_status_code") REFERENCES "Problem_Status_Codes" ("problem_status_code"), FOREIGN KEY ("problem_id") REFERENCES "Problems" ("problem_id"), FOREIGN KEY ("assigned_to_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("problem_category_code") REFERENCES "Problem_Category_Codes" ("problem_category_code"));

CREATE TABLE "Problem_Status_Codes" ("problem_status_code" TEXT(20) PRIMARY KEY, "problem_status_description" TEXT(80));

CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(80), "product_details" TEXT(255));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_first_name" TEXT(80), "staff_last_name" TEXT(80), "other_staff_details" TEXT(255));

CREATE TABLE "Problems" ("problem_id" INTEGER PRIMARY KEY, "reported_by_staff_id" INTEGER, "product_id" INTEGER, "closure_authorised_by_staff_id" INTEGER, "date_problem_reported" DATETIME, "date_problem_closed" DATETIME, "problem_description" TEXT(255), "other_problem_details" TEXT(255), FOREIGN KEY ("reported_by_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), FOREIGN KEY ("closure_authorised_by_staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name) VALUES (1, 'Rylan', 'Smith');
INSERT INTO Problem_Category_Codes (problem_category_code) VALUES ('C1');
INSERT INTO Problem_Status_Codes (problem_status_code) VALUES ('S1');
INSERT INTO Product (product_id) VALUES (1);
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id) VALUES (1, 1, 1, 1);
INSERT INTO Problem_Log (problem_log_id, problem_status_code, problem_id, assigned_to_staff_id, problem_category_code) VALUES (1, 'S1', 1, 1, 'C1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "problem_id", "problem_log_id" FROM (SELECT "LHS"."problem_log_id" AS "problem_log_id", "LHS"."assigned_to_staff_id" AS "assigned_to_staff_id", "LHS"."problem_id" AS "problem_id", "LHS"."problem_category_code" AS "problem_category_code", "LHS"."problem_status_code" AS "problem_status_code", "LHS"."log_entry_date" AS "log_entry_date", "LHS"."log_entry_description" AS "log_entry_description", "LHS"."log_entry_fix" AS "log_entry_fix", "LHS"."other_log_details" AS "other_log_details", "RHS"."staff_first_name" AS "staff_first_name", "RHS"."staff_last_name" AS "staff_last_name", "RHS"."other_staff_details" AS "other_staff_details" FROM "problem_log" AS "LHS" INNER JOIN (SELECT * FROM "staff" WHERE ("staff_first_name" = 'Rylan' OR "staff_last_name" = 'Homenick')) AS RHS ON (LHS.assigned_to_staff_id = RHS.staff_id)) ORDER BY problem_id, "problem_id" NULLS LAST, "problem_log_id" NULLS LAST;

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
SELECT DISTINCT T2.problem_id, T2.problem_log_id FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T1.staff_first_name = 'Rylan' AND T1.staff_last_name = 'Homenick';

/*
Prediction Result:
*/