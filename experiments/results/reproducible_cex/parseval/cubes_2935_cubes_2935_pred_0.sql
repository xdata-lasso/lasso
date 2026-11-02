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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_1', 1, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1, 'rhs_c6ddf2', 'rhs_6ae41e', 'rhs_216cc6', 'rhs_318ff2', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (3, 'rhs_c6ddf2', 'rhs_6ae41e', 'rhs_216cc6', 'rhs_318ff2', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (2, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00');

-- Inserting into table: class --
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('lhs_35acf4', 1, 'QM-261', 'lhs_2961cb', 'lhs_ef32e3', 'lhs_4e6dd0');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('A', 1, 'QM-261', 'lhs_7fa03a', 'lhs_c16025', 'lhs_57f5bb');

-- Inserting into table: course --
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('QM-261', 'dept_cod_1', 'cou_c97447', 165.344793);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('lhs_e3bfeb', 'dept_cod_1', 'cou_c97447', 833.684115);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "emp_fname" FROM (SELECT "class_code", "crs_code", "class_section", "class_time", "class_room", "prof_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob", "prof_num" AS "emp_num" FROM (SELECT "LHS"."class_code" AS "class_code", "LHS"."crs_code" AS "crs_code", "LHS"."class_section" AS "class_section", "LHS"."class_time" AS "class_time", "LHS"."class_room" AS "class_room", "LHS"."prof_num" AS "prof_num", "RHS"."emp_lname" AS "emp_lname", "RHS"."emp_fname" AS "emp_fname", "RHS"."emp_initial" AS "emp_initial", "RHS"."emp_jobcode" AS "emp_jobcode", "RHS"."emp_hiredate" AS "emp_hiredate", "RHS"."emp_dob" AS "emp_dob" FROM "class" AS "LHS" INNER JOIN "employee" AS "RHS" ON ("LHS"."prof_num" = "RHS"."emp_num"))) WHERE ("crs_code" <> 'CIS-220' AND "crs_code" = 'QM-261') ORDER BY emp_fname, "emp_fname" NULLS LAST;

/*
Gold Result:
('rhs_6ae41e',)
*/

-- Prediction Query
SELECT T1.emp_fname FROM employee AS T1 JOIN CLASS AS T2 ON T1.emp_num = T2.prof_num WHERE crs_code = 'CIS-220' INTERSECT SELECT T1.emp_fname FROM employee AS T1 JOIN CLASS AS T2 ON T1.emp_num = T2.prof_num WHERE crs_code = 'QM-261';

/*
Prediction Result:
*/