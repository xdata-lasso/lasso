-- Schema DDL
CREATE TABLE "CLASS" ("CLASS_CODE" TEXT(5) PRIMARY KEY, "PROF_NUM" INTEGER, "CRS_CODE" TEXT(10), "CLASS_SECTION" TEXT(2), "CLASS_TIME" TEXT(20), "CLASS_ROOM" TEXT(8), FOREIGN KEY ("PROF_NUM") REFERENCES "EMPLOYEE" ("EMP_NUM"), FOREIGN KEY ("CRS_CODE") REFERENCES "COURSE" ("CRS_CODE"));

CREATE TABLE "COURSE" ("CRS_CODE" TEXT(10) PRIMARY KEY, "DEPT_CODE" TEXT(10), "CRS_DESCRIPTION" TEXT(35), "CRS_CREDIT" REAL(8), FOREIGN KEY ("DEPT_CODE") REFERENCES "DEPARTMENT" ("DEPT_CODE"));

CREATE TABLE "DEPARTMENT" ("DEPT_CODE" TEXT(10) PRIMARY KEY, "EMP_NUM" INTEGER, "DEPT_NAME" TEXT(30), "SCHOOL_CODE" TEXT(8), "DEPT_ADDRESS" TEXT(20), "DEPT_EXTENSION" TEXT(4), FOREIGN KEY ("EMP_NUM") REFERENCES "EMPLOYEE" ("EMP_NUM"));

CREATE TABLE "EMPLOYEE" ("EMP_NUM" INTEGER PRIMARY KEY, "EMP_LNAME" TEXT(15), "EMP_FNAME" TEXT(12), "EMP_INITIAL" TEXT(1), "EMP_JOBCODE" TEXT(5), "EMP_HIREDATE" DATETIME, "EMP_DOB" DATETIME);

CREATE TABLE "ENROLL" ("STU_NUM" INTEGER, "CLASS_CODE" TEXT(5), "ENROLL_GRADE" TEXT(50), FOREIGN KEY ("STU_NUM") REFERENCES "STUDENT" ("STU_NUM"), FOREIGN KEY ("CLASS_CODE") REFERENCES "CLASS" ("CLASS_CODE"));

CREATE TABLE "PROFESSOR" ("DEPT_CODE" TEXT(10), "EMP_NUM" INTEGER, "PROF_OFFICE" TEXT(50), "PROF_EXTENSION" TEXT(4), "PROF_HIGH_DEGREE" TEXT(5), FOREIGN KEY ("DEPT_CODE") REFERENCES "DEPARTMENT" ("DEPT_CODE"), FOREIGN KEY ("EMP_NUM") REFERENCES "EMPLOYEE" ("EMP_NUM"));

CREATE TABLE "STUDENT" ("STU_NUM" INTEGER PRIMARY KEY, "DEPT_CODE" TEXT(18), "STU_LNAME" TEXT(15), "STU_FNAME" TEXT(15), "STU_INIT" TEXT(1), "STU_DOB" DATETIME, "STU_HRS" INTEGER, "STU_CLASS" TEXT(2), "STU_GPA" REAL(8), "STU_TRANSFER" REAL, "STU_PHONE" TEXT(4), "PROF_NUM" INTEGER, FOREIGN KEY ("DEPT_CODE") REFERENCES "DEPARTMENT" ("DEPT_CODE"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: department --
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_3d6eb8', 1, 'History', 'lhs_bd72d6', 'lhs_ce2481', 'lhs_95981a');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_cb92bc', 1, 'History', 'lhs_33e9f7', 'lhs_98eabf', 'lhs_294218');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('C', 1, 'History', 'lhs_bd72d6', 'lhs_ce2481', 'lhs_95981a');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('A', 1, 'History', 'lhs_33e9f7', 'lhs_98eabf', 'lhs_294218');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('_', 1, 'History', 'lhs_bd72d6', 'lhs_ce2481', 'lhs_95981a');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('O', 1, 'History', 'lhs_bd72d6', 'lhs_ce2481', 'lhs_95981a');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1, 'rhs_232231', 'rhs_fa3d3b', 'rhs_52caf5', 'rhs_5ed1b6', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483647, 'rhs_ba0df4', 'rhs_4ebffd', 'rhs_7c02d2', 'rhs_051e6b', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (3, 'rhs_232231', 'rhs_fa3d3b', 'rhs_52caf5', 'rhs_5ed1b6', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (2, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00');

-- Inserting into table: professor --
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_3d6eb8', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_cb92bc', -2147483647, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_cb92bc', -2147483647, 'rhs_231d2c', 'rhs_be350a', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_3d6eb8', 3, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_3d6eb8', -2147483647, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_3d6eb8', 2, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_3d6eb8', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_cb92bc', 3, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_3d6eb8', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('A', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('C', -2147483647, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('O', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('A', 2, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_cb92bc', 3, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('A', 1, 'rhs_a88c52', 'rhs_75d072', 'rhs_d17263');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('C', 3, NULL, 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('O', 3, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_3d6eb8', 1, 'rhs_a88c52', NULL, 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('O', -2147483647, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('_', -2147483647, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('C', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('C', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_cb92bc', 3, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('C', -2147483647, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_cb92bc', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('_', -2147483647, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_cb92bc', 3, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('lhs_cb92bc', 1, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('O', -2147483647, 'rhs_a88c52', 'rhs_75d072', 'Ph.D.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "emp_fname", "prof_office" FROM (SELECT "LHS"."dept_code" AS "dept_code", "LHS"."dept_name" AS "dept_name", "LHS"."school_code" AS "school_code", "LHS"."emp_num" AS "emp_num", "LHS"."dept_address" AS "dept_address", "LHS"."dept_extension" AS "dept_extension", "LHS"."emp_lname" AS "emp_lname", "LHS"."emp_fname" AS "emp_fname", "LHS"."emp_initial" AS "emp_initial", "LHS"."emp_jobcode" AS "emp_jobcode", "LHS"."emp_hiredate" AS "emp_hiredate", "LHS"."emp_dob" AS "emp_dob", "RHS"."prof_office" AS "prof_office", "RHS"."prof_extension" AS "prof_extension", "RHS"."prof_high_degree" AS "prof_high_degree" FROM (SELECT "LHS"."dept_code" AS "dept_code", "LHS"."dept_name" AS "dept_name", "LHS"."school_code" AS "school_code", "LHS"."emp_num" AS "emp_num", "LHS"."dept_address" AS "dept_address", "LHS"."dept_extension" AS "dept_extension", "RHS"."emp_lname" AS "emp_lname", "RHS"."emp_fname" AS "emp_fname", "RHS"."emp_initial" AS "emp_initial", "RHS"."emp_jobcode" AS "emp_jobcode", "RHS"."emp_hiredate" AS "emp_hiredate", "RHS"."emp_dob" AS "emp_dob" FROM "department" AS "LHS" INNER JOIN "employee" AS "RHS" ON ("LHS"."emp_num" = "RHS"."emp_num")) AS "LHS" INNER JOIN "professor" AS "RHS" ON ("LHS"."dept_code" = "RHS"."dept_code" AND "LHS"."emp_num" = "RHS"."emp_num")) WHERE ("dept_name" = 'History' AND "prof_high_degree" = 'Ph.D.') ORDER BY emp_fname, "emp_fname" NULLS LAST, "prof_office" NULLS LAST;

/*
Gold Result:
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
*/

-- Prediction Query
SELECT T1.emp_fname, T2.prof_office FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num = T2.emp_num JOIN department AS T3 ON T3.dept_code = T2.dept_code WHERE T3.dept_name = 'History' AND T2.prof_high_degree = 'Ph.D.';

/*
Prediction Result:
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_231d2c')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_a88c52')
('emp_d05cb6', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('emp_d05cb6', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', None)
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_fa3d3b', 'rhs_a88c52')
('rhs_4ebffd', 'rhs_a88c52')
*/