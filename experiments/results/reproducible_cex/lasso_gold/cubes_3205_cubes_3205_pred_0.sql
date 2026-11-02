-- Schema DDL
CREATE TABLE "Problem_Category_Codes" ("problem_category_code" TEXT(20) PRIMARY KEY, "problem_category_description" TEXT(80));

CREATE TABLE "Problem_Log" ("problem_log_id" INTEGER PRIMARY KEY, "problem_status_code" TEXT(20), "problem_id" INTEGER, "assigned_to_staff_id" INTEGER, "problem_category_code" TEXT(20), "log_entry_date" DATETIME, "log_entry_description" TEXT(255), "log_entry_fix" TEXT(255), "other_log_details" TEXT(255), FOREIGN KEY ("problem_status_code") REFERENCES "Problem_Status_Codes" ("problem_status_code"), FOREIGN KEY ("problem_id") REFERENCES "Problems" ("problem_id"), FOREIGN KEY ("assigned_to_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("problem_category_code") REFERENCES "Problem_Category_Codes" ("problem_category_code"));

CREATE TABLE "Problem_Status_Codes" ("problem_status_code" TEXT(20) PRIMARY KEY, "problem_status_description" TEXT(80));

CREATE TABLE "Product" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(80), "product_details" TEXT(255));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_first_name" TEXT(80), "staff_last_name" TEXT(80), "other_staff_details" TEXT(255));

CREATE TABLE "Problems" ("problem_id" INTEGER PRIMARY KEY, "reported_by_staff_id" INTEGER, "product_id" INTEGER, "closure_authorised_by_staff_id" INTEGER, "date_problem_reported" DATETIME, "date_problem_closed" DATETIME, "problem_description" TEXT(255), "other_problem_details" TEXT(255), FOREIGN KEY ("reported_by_staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("product_id") REFERENCES "Product" ("product_id"), FOREIGN KEY ("closure_authorised_by_staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "product" ("product_id", "product_name", "product_details") VALUES (1103, 'Ashley Landry', 'rock');
INSERT INTO "product" ("product_id", "product_name", "product_details") VALUES (1111, 'Allison Doyle', 'go');
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1104, 'Rebecca', 'Gardner', 'they');
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1112, 'Kimberly', 'Jenkins', 'relationship');
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1106, NULL, NULL, NULL);
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1108, NULL, NULL, NULL);
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1110, NULL, NULL, NULL);
INSERT INTO "staff" ("staff_id", "staff_first_name", "staff_last_name", "other_staff_details") VALUES (1114, NULL, NULL, NULL);
INSERT INTO "problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (1105, 1104, 1103, 1106, '1989-05-03', '1990-06-04', 'Old challenge camera final together someone.', 'traditional');
INSERT INTO "problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (1109, 1108, 1103, 1110, '1991-07-05', '1992-08-06', 'Wind see understand door class son.', 'cost');
INSERT INTO "problems" ("problem_id", "reported_by_staff_id", "product_id", "closure_authorised_by_staff_id", "date_problem_reported", "date_problem_closed", "problem_description", "other_problem_details") VALUES (1113, 1112, 1111, 1114, '1993-09-07', '1994-10-08', 'Environment skin blue the teach.', 'doctor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, product_id FROM (SELECT product_id, COUNT(*) AS n FROM (SELECT LHS.product_id AS product_id, LHS.product_name AS product_name, LHS.product_details AS product_details, RHS.problem_id AS problem_id, RHS.closure_authorised_by_staff_id AS closure_authorised_by_staff_id, RHS.reported_by_staff_id AS reported_by_staff_id, RHS.date_problem_reported AS date_problem_reported, RHS.date_problem_closed AS date_problem_closed, RHS.problem_description AS problem_description, RHS.other_problem_details AS other_problem_details FROM product AS LHS INNER JOIN problems AS RHS ON (LHS.product_id = RHS.product_id)) GROUP BY product_id) ORDER BY count___, product_id NULLS LAST;

/*
Gold Result:
(1, 1111)
(2, 1103)
*/

-- Prediction Query
SELECT COUNT(*), T2.product_id FROM problems AS T1 JOIN product AS T2 ON T1.product_id = T2.product_id GROUP BY T2.product_id;

/*
Prediction Result:
(2, 1103)
(1, 1111)
*/