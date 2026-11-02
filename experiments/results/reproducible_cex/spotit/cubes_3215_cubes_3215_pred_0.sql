-- Schema DDL
CREATE TABLE "PROBLEM_CATEGORY_CODES" (
    "PROBLEM_CATEGORY_CODE" TEXT,
    "PROBLEM_CATEGORY_DESCRIPTION" TEXT,
    PRIMARY KEY ("PROBLEM_CATEGORY_CODE")
);
CREATE TABLE "PROBLEM_LOG" (
    "PROBLEM_LOG_ID" INT,
    "PROBLEM_STATUS_CODE" TEXT,
    "PROBLEM_ID" INT,
    "ASSIGNED_TO_STAFF_ID" INT,
    "PROBLEM_CATEGORY_CODE" TEXT,
    "LOG_ENTRY_DATE" DATETIME,
    "LOG_ENTRY_DESCRIPTION" TEXT,
    "LOG_ENTRY_FIX" TEXT,
    "OTHER_LOG_DETAILS" TEXT,
    PRIMARY KEY ("PROBLEM_LOG_ID"),
    FOREIGN KEY ("PROBLEM_STATUS_CODE") REFERENCES "PROBLEM_STATUS_CODES"("PROBLEM_STATUS_CODE"),
    FOREIGN KEY ("PROBLEM_ID") REFERENCES "PROBLEMS"("PROBLEM_ID"),
    FOREIGN KEY ("ASSIGNED_TO_STAFF_ID") REFERENCES "STAFF"("STAFF_ID"),
    FOREIGN KEY ("PROBLEM_CATEGORY_CODE") REFERENCES "PROBLEM_CATEGORY_CODES"("PROBLEM_CATEGORY_CODE")
);
CREATE TABLE "PROBLEM_STATUS_CODES" (
    "PROBLEM_STATUS_CODE" TEXT,
    "PROBLEM_STATUS_DESCRIPTION" TEXT,
    PRIMARY KEY ("PROBLEM_STATUS_CODE")
);
CREATE TABLE "PRODUCT" (
    "PRODUCT_ID" INT,
    "PRODUCT_NAME" TEXT,
    "PRODUCT_DETAILS" TEXT,
    PRIMARY KEY ("PRODUCT_ID")
);
CREATE TABLE "STAFF" (
    "STAFF_ID" INT,
    "STAFF_FIRST_NAME" TEXT,
    "STAFF_LAST_NAME" TEXT,
    "OTHER_STAFF_DETAILS" TEXT,
    PRIMARY KEY ("STAFF_ID")
);
CREATE TABLE "PROBLEMS" (
    "PROBLEM_ID" INT,
    "REPORTED_BY_STAFF_ID" INT,
    "PRODUCT_ID" INT,
    "CLOSURE_AUTHORISED_BY_STAFF_ID" INT,
    "DATE_PROBLEM_REPORTED" DATETIME,
    "DATE_PROBLEM_CLOSED" DATETIME,
    "PROBLEM_DESCRIPTION" TEXT,
    "OTHER_PROBLEM_DETAILS" TEXT,
    PRIMARY KEY ("PROBLEM_ID"),
    FOREIGN KEY ("REPORTED_BY_STAFF_ID") REFERENCES "STAFF"("STAFF_ID"),
    FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCT"("PRODUCT_ID"),
    FOREIGN KEY ("CLOSURE_AUTHORISED_BY_STAFF_ID") REFERENCES "STAFF"("STAFF_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PROBLEM_CATEGORY_CODES VALUES (3, 0);
INSERT INTO PROBLEM_CATEGORY_CODES VALUES (4, 0);
INSERT INTO PROBLEM_LOG VALUES (0, 7, 0, -1, 3, 0, 0, 0, 0);
INSERT INTO PROBLEM_LOG VALUES (1, 7, 0, 0, 3, 0, 0, 0, 0);
INSERT INTO PROBLEM_STATUS_CODES VALUES (7, 0);
INSERT INTO PROBLEM_STATUS_CODES VALUES (8, 0);
INSERT INTO PRODUCT VALUES (1, 708300462255459435, 30);
INSERT INTO PRODUCT VALUES (0, 24, 34);
INSERT INTO STAFF VALUES (-1, 0, 0, 0);
INSERT INTO STAFF VALUES (0, 0, 0, 0);
INSERT INTO PROBLEMS VALUES (0, 0, 0, 0, 31, 32, 24, 33);
INSERT INTO PROBLEMS VALUES (1, 0, 1, -1, 35, 36, 708300462255459435, 37);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT product_id, product_name, product_details, product_id_other, closure_authorised_by_staff_id, reported_by_staff_id, date_problem_reported, date_problem_closed, other_problem_details, problem_id, product_name AS problem_description FROM (SELECT product_id, product_name, product_details, product_id_other, closure_authorised_by_staff_id, reported_by_staff_id, date_problem_reported, date_problem_closed, other_problem_details, product_id AS problem_id FROM (SELECT LHS.product_id AS product_id, LHS.product_name AS product_name, LHS.product_details AS product_details, RHS.product_id AS product_id_other, RHS.closure_authorised_by_staff_id AS closure_authorised_by_staff_id, RHS.reported_by_staff_id AS reported_by_staff_id, RHS.date_problem_reported AS date_problem_reported, RHS.date_problem_closed AS date_problem_closed, RHS.other_problem_details AS other_problem_details FROM product AS LHS INNER JOIN problems AS RHS ON (LHS.product_id = RHS.problem_id AND LHS.product_name = RHS.problem_description))))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM product AS T1 JOIN problems AS T2 ON T1.product_id = T2.product_id WHERE T1.product_name = 'voluptatem';

/*
Prediction Result:
(0,)
*/