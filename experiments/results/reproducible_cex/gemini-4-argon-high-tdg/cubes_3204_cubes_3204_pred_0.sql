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
INSERT INTO "Product" ("product_id", "product_name", "product_details") VALUES (1, 'CloudSync', 'Cloud synchronization tool');
INSERT INTO "Staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1, 'Christop', 'Miller', 'Senior QA');
INSERT INTO "Staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (2, 'Alice', 'Christop', 'Lead Developer');
INSERT INTO "Staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (3, 'Christopher', 'Davis', 'Support Engineer');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (10, 1, 1, 2, '2023-05-01 09:00:00', '2023-05-02 17:00:00', 'Z_Crash on login', 'Details 10');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (20, 1, 1, 2, '2023-05-03 10:00:00', NULL, 'A_Button misaligned', 'Details 20');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (30, 1, 1, 3, '2023-05-04 11:00:00', '2023-05-05 14:00:00', 'A_Button misaligned', 'Details 30');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (40, 2, 1, 1, '2023-05-06 12:00:00', '2023-05-07 15:00:00', 'M_Closed by Christop not reported', 'Details 40');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (50, 3, 1, 3, '2023-05-08 13:00:00', NULL, 'C_Reported by Christopher', 'Details 50');
INSERT INTO "Problem_Category_Codes" ("problem_category_code", "problem_category_description") VALUES ('UI', 'User Interface');
INSERT INTO "Problem_Status_Codes" ("problem_status_code", "problem_status_description") VALUES ('OPEN', 'Open Status');
INSERT INTO "Problem_Log" ("problem_log_id", "problem_status_code", "problem_id", "assigned_to_staff_id", "problem_category_code", "log_entry_date", "log_entry_description", "log_entry_fix", "other_log_details") VALUES (100, 'OPEN', 40, 1, 'UI', '2023-05-06 13:00:00', 'Assigned to Christop', 'Pending', 'Log 100');
INSERT INTO "Problem_Log" ("problem_log_id", "problem_status_code", "problem_id", "assigned_to_staff_id", "problem_category_code", "log_entry_date", "log_entry_description", "log_entry_fix", "other_log_details") VALUES (101, 'OPEN', 10, 2, 'UI', '2023-05-01 10:00:00', 'Assigned to Alice', 'Fixed', 'Log 101');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "problem_description" FROM (SELECT "LHS"."staff_id" AS "staff_id", "LHS"."staff_first_name" AS "staff_first_name", "LHS"."staff_last_name" AS "staff_last_name", "LHS"."other_staff_details" AS "other_staff_details", "RHS"."problem_id" AS "problem_id", "RHS"."product_id" AS "product_id", "RHS"."closure_authorised_by_staff_id" AS "closure_authorised_by_staff_id", "RHS"."date_problem_reported" AS "date_problem_reported", "RHS"."date_problem_closed" AS "date_problem_closed", "RHS"."problem_description" AS "problem_description", "RHS"."other_problem_details" AS "other_problem_details" FROM (SELECT * FROM "staff" WHERE ("staff_first_name" = 'Christop')) AS LHS INNER JOIN problems AS RHS ON (LHS.staff_id = RHS.reported_by_staff_id)) ORDER BY problem_description, "problem_description" NULLS LAST;

/*
Gold Result:
('A_Button misaligned',)
('A_Button misaligned',)
('Z_Crash on login',)
*/

-- Prediction Query
SELECT T1.problem_description FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = 'Christop';

/*
Prediction Result:
('Z_Crash on login',)
('A_Button misaligned',)
('A_Button misaligned',)
*/