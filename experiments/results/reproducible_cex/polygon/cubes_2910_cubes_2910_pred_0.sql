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
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('Ph.D.25', 58, 'Ph.D.27', 'Ph.D.57', 'Ph.D.57', 'Ph.D.57');
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('Ph.D.27', 'Ph.D.57', 'Ph.D.57', 57);
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('History28', 'Ph.D.29', 'Ph.D.57', 57);
INSERT INTO "DEPARTMENT" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('Ph.D.57', NULL, 'History', 'Ph.D.37', 'History38', 'Ph.D.39');
INSERT INTO "DEPARTMENT" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('Ph.D.29', NULL, 'Ph.D.57', 'Ph.D.57', 'Ph.D.57', 'Ph.D.57');
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (49, 'Ph.D.43', 'History44', 'Ph.D.45', 'History46', 47, 48);
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (58, 'History52', 'History44', 'Ph.D.53', 'History54', 55, 56);
INSERT INTO "PROFESSOR" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('Ph.D.57', 58, NULL, 'History60', 'Ph.D.');
INSERT INTO "PROFESSOR" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('Ph.D.57', 49, NULL, 'Ph.D.51', 'Ph.D.');
INSERT INTO "STUDENT" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (32, 'Ph.D.57', 'Ph.D.57', 'Ph.D.57', 'Ph.D.57', 57, 57, 'Ph.D.57', 57, 57, 'Ph.D.57', 57);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "emp_fname", "prof_office" FROM (SELECT "LHS"."dept_code" AS "dept_code", "LHS"."dept_name" AS "dept_name", "LHS"."school_code" AS "school_code", "LHS"."emp_num" AS "emp_num", "LHS"."dept_address" AS "dept_address", "LHS"."dept_extension" AS "dept_extension", "LHS"."emp_lname" AS "emp_lname", "LHS"."emp_fname" AS "emp_fname", "LHS"."emp_initial" AS "emp_initial", "LHS"."emp_jobcode" AS "emp_jobcode", "LHS"."emp_hiredate" AS "emp_hiredate", "LHS"."emp_dob" AS "emp_dob", "RHS"."prof_office" AS "prof_office", "RHS"."prof_extension" AS "prof_extension", "RHS"."prof_high_degree" AS "prof_high_degree" FROM (SELECT "LHS"."dept_code" AS "dept_code", "LHS"."dept_name" AS "dept_name", "LHS"."school_code" AS "school_code", "LHS"."emp_num" AS "emp_num", "LHS"."dept_address" AS "dept_address", "LHS"."dept_extension" AS "dept_extension", "RHS"."emp_lname" AS "emp_lname", "RHS"."emp_fname" AS "emp_fname", "RHS"."emp_initial" AS "emp_initial", "RHS"."emp_jobcode" AS "emp_jobcode", "RHS"."emp_hiredate" AS "emp_hiredate", "RHS"."emp_dob" AS "emp_dob" FROM "department" AS "LHS" INNER JOIN "employee" AS "RHS" ON ("LHS"."emp_num" = "RHS"."emp_num")) AS "LHS" INNER JOIN "professor" AS "RHS" ON ("LHS"."dept_code" = "RHS"."dept_code" AND "LHS"."emp_num" = "RHS"."emp_num")) WHERE ("dept_name" = 'History' AND "prof_high_degree" = 'Ph.D.') ORDER BY emp_fname, "emp_fname" NULLS LAST, "prof_office" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.emp_fname, T2.prof_office FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num = T2.emp_num JOIN department AS T3 ON T3.dept_code = T2.dept_code WHERE T3.dept_name = 'History' AND T2.prof_high_degree = 'Ph.D.';

/*
Prediction Result:
('History44', None)
('History44', None)
*/