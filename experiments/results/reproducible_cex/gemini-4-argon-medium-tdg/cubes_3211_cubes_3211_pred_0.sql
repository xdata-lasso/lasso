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
-- Tests basic join conditions (closure_authorised_by_staff_id = staff_id AND problem_description = other_staff_details)
-- vs wrong join key (reported_by_staff_id = staff_id) or missing secondary join condition.
INSERT INTO "Product" ("product_id", "product_name", "product_details") VALUES (10, 'ProdA', 'DetailsA');
INSERT INTO "Product" ("product_id", "product_name", "product_details") VALUES (20, 'ProdB', 'DetailsB');
INSERT INTO "Product" ("product_id", "product_name", "product_details") VALUES (30, 'ProdC', 'DetailsC');
INSERT INTO "Staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1, 'Ashley', 'Smith', 'MatchDesc');
INSERT INTO "Staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (2, 'John', 'Doe', 'OtherDesc');
-- Valid match on both join conditions
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (100, 2, 10, 1, '2023-01-01', '2023-01-02', 'MatchDesc', 'None');
-- Fails second join condition (problem_description <> other_staff_details)
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (101, 2, 20, 1, '2023-01-01', '2023-01-02', 'MismatchDesc', 'None');
-- Wrong FK matched (reported_by_staff_id matches Staff 1, but closure_authorised_by_staff_id is Staff 2)
INSERT INTO "Problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (102, 1, 30, 2, '2023-01-01', '2023-01-02', 'MatchDesc', 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_id" FROM (SELECT * FROM (SELECT "problem_id", "product_id", "closure_authorised_by_staff_id", "reported_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details", "staff_first_name", "staff_last_name", "staff_id", "problem_description" AS "other_staff_details" FROM (SELECT "problem_id", "product_id", "closure_authorised_by_staff_id", "reported_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details", "staff_first_name", "staff_last_name", "closure_authorised_by_staff_id" AS "staff_id" FROM (SELECT "LHS"."problem_id" AS "problem_id", "LHS"."product_id" AS "product_id", "LHS"."closure_authorised_by_staff_id" AS "closure_authorised_by_staff_id", "LHS"."reported_by_staff_id" AS "reported_by_staff_id", "LHS"."date_problem_reported" AS "date_problem_reported", "LHS"."date_problem_closed" AS "date_problem_closed", "LHS"."problem_description" AS "problem_description", "LHS"."other_problem_details" AS "other_problem_details", "RHS"."staff_first_name" AS "staff_first_name", "RHS"."staff_last_name" AS "staff_last_name" FROM "problems" AS "LHS" INNER JOIN "staff" AS "RHS" ON ("LHS"."closure_authorised_by_staff_id" = "RHS"."staff_id" AND "LHS"."problem_description" = "RHS"."other_staff_details")))) WHERE ("staff_first_name" = 'Ashley' OR "staff_last_name" = 'Medhurst')) WHERE ("staff_first_name" = 'Christop' OR "staff_last_name" <> 'Berge') ORDER BY product_id, "product_id" NULLS LAST;

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT product_id FROM problems AS T1 JOIN staff AS T2 ON T1.reported_by_staff_id = T2.staff_id WHERE T2.staff_first_name = 'Christop' AND T2.staff_last_name = 'Berge' INTERSECT SELECT product_id FROM problems AS T1 JOIN staff AS T2 ON T1.closure_authorised_by_staff_id = T2.staff_id WHERE T2.staff_first_name = 'Ashley' AND T2.staff_last_name = 'Medhurst';

/*
Prediction Result:
*/