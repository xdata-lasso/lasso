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
INSERT INTO PROBLEM_CATEGORY_CODES VALUES (15, 0);
INSERT INTO PROBLEM_CATEGORY_CODES VALUES (3, 0);
INSERT INTO PROBLEM_LOG VALUES (2, 9, 0, 0, 15, -1, 24, 25, 25);
INSERT INTO PROBLEM_LOG VALUES (1, 10, 0, -1, 15, 0, 24, 25, 25);
INSERT INTO PROBLEM_STATUS_CODES VALUES (9, 0);
INSERT INTO PROBLEM_STATUS_CODES VALUES (10, 0);
INSERT INTO PRODUCT VALUES (-1, 0, 0);
INSERT INTO PRODUCT VALUES (0, 0, 0);
INSERT INTO STAFF VALUES (0, 0, 0, 0);
INSERT INTO STAFF VALUES (-1, 0, 0, 0);
INSERT INTO PROBLEMS VALUES (0, 0, -1, -1, 0, 0, 0, 0);
INSERT INTO PROBLEMS VALUES (-1, 0, -1, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT problem_log_id FROM (SELECT LHS.problem_log_id AS problem_log_id, LHS.assigned_to_staff_id AS assigned_to_staff_id, LHS.problem_id AS problem_id, LHS.problem_category_code AS problem_category_code, LHS.problem_status_code AS problem_status_code, LHS.log_entry_date AS log_entry_date, LHS.log_entry_description AS log_entry_description, LHS.log_entry_fix AS log_entry_fix, LHS.other_log_details AS other_log_details, RHS.problem_log_id AS problem_log_id_other, RHS.assigned_to_staff_id AS assigned_to_staff_id_other, RHS.problem_id AS problem_id_other, RHS.problem_category_code AS problem_category_code_other, RHS.problem_status_code AS problem_status_code_other, RHS.log_entry_date AS log_entry_date_other, RHS.log_entry_fix AS log_entry_fix_other FROM problem_log AS LHS INNER JOIN problem_log AS RHS ON (LHS.log_entry_description = RHS.log_entry_description AND LHS.log_entry_fix = RHS.other_log_details)) ORDER BY problem_log_id;

/*
Gold Result:
(1,)
(1,)
(2,)
(2,)
*/

-- Prediction Query
SELECT problem_log_id FROM problem_log ORDER BY log_entry_date DESC, problem_log.problem_log_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/