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
INSERT INTO Staff (staff_id, staff_first_name, staff_last_name, other_staff_details) VALUES (1, 'Alice', 'Smith', 'Tech');
INSERT INTO Product (product_id, product_name, product_details) VALUES (1, 'Laptop', '15-inch');
INSERT INTO Product (product_id, product_name, product_details) VALUES (2, 'Mouse', 'Wireless');
INSERT INTO Product (product_id, product_name, product_details) VALUES (3, 'Monitor', '4K');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (1, 1, 2, 1, '2023-01-01 10:00:00', '2023-01-02 10:00:00', 'Laptop', 'Exact match on id and name but different RHS.product_id');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (2, 1, 2, 1, '2023-01-03 10:00:00', '2023-01-04 10:00:00', 'Keyboard', 'Matches id 2 but different description');
INSERT INTO Problems (problem_id, reported_by_staff_id, product_id, closure_authorised_by_staff_id, date_problem_reported, date_problem_closed, problem_description, other_problem_details) VALUES (4, 1, 3, 1, '2023-01-05 10:00:00', '2023-01-06 10:00:00', 'Monitor', 'Matches name and RHS.product_id 3, but problem_id is 4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT product_id, product_name, product_details, product_id_other, closure_authorised_by_staff_id, reported_by_staff_id, date_problem_reported, date_problem_closed, other_problem_details, problem_id, product_name AS problem_description FROM (SELECT product_id, product_name, product_details, product_id_other, closure_authorised_by_staff_id, reported_by_staff_id, date_problem_reported, date_problem_closed, other_problem_details, product_id AS problem_id FROM (SELECT LHS.product_id AS product_id, LHS.product_name AS product_name, LHS.product_details AS product_details, RHS.product_id AS product_id_other, RHS.closure_authorised_by_staff_id AS closure_authorised_by_staff_id, RHS.reported_by_staff_id AS reported_by_staff_id, RHS.date_problem_reported AS date_problem_reported, RHS.date_problem_closed AS date_problem_closed, RHS.other_problem_details AS other_problem_details FROM product AS LHS INNER JOIN problems AS RHS ON (LHS.product_id = RHS.problem_id AND LHS.product_name = RHS.problem_description))))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM product AS T1 JOIN problems AS T2 ON T1.product_id = T2.product_id WHERE T1.product_name = 'voluptatem';

/*
Prediction Result:
(0,)
*/