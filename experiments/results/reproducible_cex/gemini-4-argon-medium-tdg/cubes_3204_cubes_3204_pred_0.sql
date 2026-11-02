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
INSERT INTO "Product" ("product_id", "product_name", "product_details") VALUES (1, 'ProdA', 'DetailsA');
INSERT INTO "Staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1, 'Christop', 'Smith', 'Details1');
INSERT INTO "Staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (2, 'Christop', 'Jones', 'Details2');
INSERT INTO "Staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (3, 'Alice', 'Christop', 'Christop');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (10, 1, 1, 3, '2023-01-01 10:00:00', '2023-01-02 10:00:00', 'Zebra bug', 'Other1');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (11, 1, 1, 3, '2023-01-03 10:00:00', '2023-01-04 10:00:00', 'Alpha bug', 'Other2');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (12, 2, 1, 3, '2023-01-05 10:00:00', '2023-01-06 10:00:00', 'Alpha bug', 'Other3');
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (13, 3, 1, 1, '2023-01-07 10:00:00', '2023-01-08 10:00:00', 'Closure by Christop only', 'Other4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "problem_description" FROM (SELECT "LHS"."staff_id" AS "staff_id", "LHS"."staff_first_name" AS "staff_first_name", "LHS"."staff_last_name" AS "staff_last_name", "LHS"."other_staff_details" AS "other_staff_details", "RHS"."problem_id" AS "problem_id", "RHS"."product_id" AS "product_id", "RHS"."closure_authorised_by_staff_id" AS "closure_authorised_by_staff_id", "RHS"."date_problem_reported" AS "date_problem_reported", "RHS"."date_problem_closed" AS "date_problem_closed", "RHS"."problem_description" AS "problem_description", "RHS"."other_problem_details" AS "other_problem_details" FROM (SELECT * FROM "staff" WHERE ("staff_first_name" = 'Christop')) AS LHS INNER JOIN problems AS RHS ON (LHS.staff_id = RHS.reported_by_staff_id)) ORDER BY problem_description, "problem_description" NULLS LAST;

/*
Gold Result:
('Alpha bug',)
('Alpha bug',)
('Zebra bug',)
*/

-- Prediction Query
SELECT T1.problem_description FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = 'Christop';

/*
Prediction Result:
('Zebra bug',)
('Alpha bug',)
('Alpha bug',)
*/