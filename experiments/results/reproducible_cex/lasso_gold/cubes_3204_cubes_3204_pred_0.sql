-- Schema DDL
CREATE TABLE "Problem_Category_Codes" ("problem_category_code" TEXT(20) PRIMARY KEY, "problem_category_description" TEXT(80));

CREATE TABLE "Problem_Log" ("problem_log_id" INTEGER PRIMARY KEY, "problem_status_code" TEXT(20), "problem_id" INTEGER, "assigned_to_staff_id" INTEGER, "problem_category_code" TEXT(20), "log_entry_date" DATETIME, "log_entry_description" TEXT(255), "log_entry_fix" TEXT(255), "other_log_details" TEXT(255), FOREIGN KEY ("problem_status_code") REFERENCES "Problem_Status_Codes" ("problem_status_code"), FOREIGN KEY ("problem_id") REFERENCES "Problems" ("problem_id"), FOREIGN KEY ("assigned_to_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("problem_category_code") REFERENCES "Problem_Category_Codes" ("problem_category_code"));

CREATE TABLE "Problem_Status_Codes" ("problem_status_code" TEXT(20) PRIMARY KEY, "problem_status_description" TEXT(80));

CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(80), "product_details" TEXT(255));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_first_name" TEXT(80), "staff_last_name" TEXT(80), "other_staff_details" TEXT(255));

CREATE TABLE "Problems" ("problem_id" INTEGER PRIMARY KEY, "reported_by_staff_id" INTEGER, "product_id" INTEGER, "closure_authorised_by_staff_id" INTEGER, "date_problem_reported" DATETIME, "date_problem_closed" DATETIME, "problem_description" TEXT(255), "other_problem_details" TEXT(255), FOREIGN KEY ("reported_by_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), FOREIGN KEY ("closure_authorised_by_staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "product_details") VALUES (1045, 'Christopher Ashley', 'win');
INSERT INTO "product" ("product_id", "product_name", "product_details") VALUES (1053, 'Daniel Ryan', 'show');
INSERT INTO "product" ("product_id", "product_name", "product_details") VALUES (1049, NULL, NULL);
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1046, 'Christop', 'Moreno', 'a');
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1054, 'Christop', 'Vaughn', 'sell');
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1048, NULL, NULL, NULL);
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1052, NULL, NULL, NULL);
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1056, NULL, NULL, NULL);
INSERT INTO "problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (1047, 1046, 1045, 1048, '1990-10-21', '1991-11-22', 'Food affect upon these story film around there.', 'your');
INSERT INTO "problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (1051, 1046, 1049, 1052, '1992-01-23', '1993-02-01', 'Process water close month.', 'policy');
INSERT INTO "problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (1055, 1054, 1053, 1056, '1994-03-02', '1995-04-03', 'Human public health tonight later.', 'end');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "problem_description" FROM (SELECT "LHS"."staff_id" AS "staff_id", "LHS"."staff_first_name" AS "staff_first_name", "LHS"."staff_last_name" AS "staff_last_name", "LHS"."other_staff_details" AS "other_staff_details", "RHS"."problem_id" AS "problem_id", "RHS"."product_id" AS "product_id", "RHS"."closure_authorised_by_staff_id" AS "closure_authorised_by_staff_id", "RHS"."date_problem_reported" AS "date_problem_reported", "RHS"."date_problem_closed" AS "date_problem_closed", "RHS"."problem_description" AS "problem_description", "RHS"."other_problem_details" AS "other_problem_details" FROM (SELECT * FROM "staff" WHERE ("staff_first_name" = 'Christop')) AS LHS INNER JOIN problems AS RHS ON (LHS.staff_id = RHS.reported_by_staff_id)) ORDER BY problem_description, "problem_description" NULLS LAST;

/*
Gold Result:
('Food affect upon these story film around there.',)
('Human public health tonight later.',)
('Process water close month.',)
*/

-- Prediction Query
SELECT T1.problem_description FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = 'Christop';

/*
Prediction Result:
('Food affect upon these story film around there.',)
('Process water close month.',)
('Human public health tonight later.',)
*/