-- Schema DDL
CREATE TABLE "Problem_Category_Codes" ("problem_category_code" TEXT(20) PRIMARY KEY, "problem_category_description" TEXT(80));

CREATE TABLE "Problem_Log" ("problem_log_id" INTEGER PRIMARY KEY, "problem_status_code" TEXT(20), "problem_id" INTEGER, "assigned_to_staff_id" INTEGER, "problem_category_code" TEXT(20), "log_entry_date" DATETIME, "log_entry_description" TEXT(255), "log_entry_fix" TEXT(255), "other_log_details" TEXT(255), FOREIGN KEY ("problem_status_code") REFERENCES "Problem_Status_Codes" ("problem_status_code"), FOREIGN KEY ("problem_id") REFERENCES "Problems" ("problem_id"), FOREIGN KEY ("assigned_to_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("problem_category_code") REFERENCES "Problem_Category_Codes" ("problem_category_code"));

CREATE TABLE "Problem_Status_Codes" ("problem_status_code" TEXT(20) PRIMARY KEY, "problem_status_description" TEXT(80));

CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(80), "product_details" TEXT(255));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_first_name" TEXT(80), "staff_last_name" TEXT(80), "other_staff_details" TEXT(255));

CREATE TABLE "Problems" ("problem_id" INTEGER PRIMARY KEY, "reported_by_staff_id" INTEGER, "product_id" INTEGER, "closure_authorised_by_staff_id" INTEGER, "date_problem_reported" DATETIME, "date_problem_closed" DATETIME, "problem_description" TEXT(255), "other_problem_details" TEXT(255), FOREIGN KEY ("reported_by_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), FOREIGN KEY ("closure_authorised_by_staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1, 'Rylan', '_Ah', 'sta_31dbed');

INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (-2147483647, 'Rylan', '-_?', 'sta_6758d5');

-- Inserting into table: problem_category_codes --
INSERT INTO "problem_category_codes" ("problem_category_code", "problem_category_description") VALUES ('lhs_73b3c2', 'pro_1b66cc');

INSERT INTO "problem_category_codes" ("problem_category_code", "problem_category_description") VALUES ('lhs_8a0668', 'pro_1b66cc');

-- Inserting into table: problem_status_codes --
INSERT INTO "problem_status_codes" ("problem_status_code", "problem_status_description") VALUES ('lhs_e8bc01', 'pro_73ec6b');

INSERT INTO "problem_status_codes" ("problem_status_code", "problem_status_description") VALUES ('lhs_8a9991', 'pro_73ec6b');

-- Inserting into table: product --
INSERT INTO "product" ("product_id", "product_name", "product_details") VALUES (-2147483648, 'pro_bd3179', 'pro_7ee57b');

-- Inserting into table: problems --
INSERT INTO "problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (1, 1, -2147483648, 1, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'pro_822619', 'pro_2ee873');

-- Inserting into table: problem_log --
INSERT INTO "problem_log" ("problem_log_id", "problem_status_code", "problem_id", "assigned_to_staff_id", "problem_category_code", "log_entry_date", "log_entry_description", "log_entry_fix", "other_log_details") VALUES (1, 'lhs_e8bc01', 1, 1, 'lhs_73b3c2', '2024-06-15 00:00:00+00:00', 'lhs_e13b9f', 'lhs_d8ec3e', 'lhs_f569c7');

INSERT INTO "problem_log" ("problem_log_id", "problem_status_code", "problem_id", "assigned_to_staff_id", "problem_category_code", "log_entry_date", "log_entry_description", "log_entry_fix", "other_log_details") VALUES (-2147483647, 'lhs_8a9991', 1, 1, 'lhs_8a0668', '2024-06-15 00:00:00+00:00', 'lhs_a52f4d', 'lhs_76257f', 'lhs_277e09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "problem_id", "problem_log_id" FROM (SELECT "LHS"."problem_log_id" AS "problem_log_id", "LHS"."assigned_to_staff_id" AS "assigned_to_staff_id", "LHS"."problem_id" AS "problem_id", "LHS"."problem_category_code" AS "problem_category_code", "LHS"."problem_status_code" AS "problem_status_code", "LHS"."log_entry_date" AS "log_entry_date", "LHS"."log_entry_description" AS "log_entry_description", "LHS"."log_entry_fix" AS "log_entry_fix", "LHS"."other_log_details" AS "other_log_details", "RHS"."staff_first_name" AS "staff_first_name", "RHS"."staff_last_name" AS "staff_last_name", "RHS"."other_staff_details" AS "other_staff_details" FROM "problem_log" AS "LHS" INNER JOIN (SELECT * FROM "staff" WHERE ("staff_first_name" = 'Rylan' OR "staff_last_name" = 'Homenick')) AS RHS ON (LHS.assigned_to_staff_id = RHS.staff_id)) ORDER BY problem_id, "problem_id" NULLS LAST, "problem_log_id" NULLS LAST;

/*
Gold Result:
(1, -2147483647)
(1, 1)
*/

-- Prediction Query
SELECT DISTINCT T2.problem_id, T2.problem_log_id FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T1.staff_first_name = 'Rylan' AND T1.staff_last_name = 'Homenick';

/*
Prediction Result:
*/