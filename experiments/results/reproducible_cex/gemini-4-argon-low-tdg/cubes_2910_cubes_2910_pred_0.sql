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
-- DATASET 1
-- Tests basic positive match vs. join path mutations (e.g., joining PROFESSOR to DEPARTMENT without matching DEPARTMENT.EMP_NUM = PROFESSOR.EMP_NUM, or joining PROFESSOR to EMPLOYEE without matching PROFESSOR.DEPT_CODE = DEPARTMENT.DEPT_CODE).
INSERT INTO "EMPLOYEE" ("EMP_NUM", "EMP_LNAME", "EMP_FNAME", "EMP_INITIAL", "EMP_JOBCODE", "EMP_HIREDATE", "EMP_DOB") VALUES (1, 'Smith', 'Alice', 'A', 'PROF', '2010-08-15', '1975-04-12');
INSERT INTO "EMPLOYEE" ("EMP_NUM", "EMP_LNAME", "EMP_FNAME", "EMP_INITIAL", "EMP_JOBCODE", "EMP_HIREDATE", "EMP_DOB") VALUES (2, 'Jones', 'Bob', 'B', 'PROF', '2012-01-10', '1980-09-23');
INSERT INTO "EMPLOYEE" ("EMP_NUM", "EMP_LNAME", "EMP_FNAME", "EMP_INITIAL", "EMP_JOBCODE", "EMP_HIREDATE", "EMP_DOB") VALUES (3, 'Brown', 'Charlie', 'C', 'PROF', '2015-05-20', '1982-11-05');
INSERT INTO "DEPARTMENT" ("DEPT_CODE", "EMP_NUM", "DEPT_NAME", "SCHOOL_CODE", "DEPT_ADDRESS", "DEPT_EXTENSION") VALUES ('HIST1', 1, 'History', 'ARTS', 'Bldg A', '1001');
INSERT INTO "DEPARTMENT" ("DEPT_CODE", "EMP_NUM", "DEPT_NAME", "SCHOOL_CODE", "DEPT_ADDRESS", "DEPT_EXTENSION") VALUES ('HIST2', 2, 'History', 'ARTS', 'Bldg B', '1002');
INSERT INTO "DEPARTMENT" ("DEPT_CODE", "EMP_NUM", "DEPT_NAME", "SCHOOL_CODE", "DEPT_ADDRESS", "DEPT_EXTENSION") VALUES ('MATH1', 3, 'Math', 'SCI', 'Bldg C', '1003');
-- Valid full match: Emp 1 chairs HIST1 ('History') and is a Ph.D. professor in HIST1
INSERT INTO "PROFESSOR" ("DEPT_CODE", "EMP_NUM", "PROF_OFFICE", "PROF_EXTENSION", "PROF_HIGH_DEGREE") VALUES ('HIST1', 1, 'Room 101', '2001', 'Ph.D.');
-- Trap for missing (LHS.emp_num = RHS.emp_num): Emp 3 is a Ph.D. professor in HIST1, but Emp 1 is the chair of HIST1
INSERT INTO "PROFESSOR" ("DEPT_CODE", "EMP_NUM", "PROF_OFFICE", "PROF_EXTENSION", "PROF_HIGH_DEGREE") VALUES ('HIST1', 3, 'Room 102', '2002', 'Ph.D.');
-- Trap for missing (LHS.dept_code = RHS.dept_code): Emp 2 chairs HIST2 ('History'), but is a Ph.D. professor in MATH1
INSERT INTO "PROFESSOR" ("DEPT_CODE", "EMP_NUM", "PROF_OFFICE", "PROF_EXTENSION", "PROF_HIGH_DEGREE") VALUES ('MATH1', 2, 'Room 103', '2003', 'Ph.D.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "emp_fname", "prof_office" FROM (SELECT "LHS"."dept_code" AS "dept_code", "LHS"."dept_name" AS "dept_name", "LHS"."school_code" AS "school_code", "LHS"."emp_num" AS "emp_num", "LHS"."dept_address" AS "dept_address", "LHS"."dept_extension" AS "dept_extension", "LHS"."emp_lname" AS "emp_lname", "LHS"."emp_fname" AS "emp_fname", "LHS"."emp_initial" AS "emp_initial", "LHS"."emp_jobcode" AS "emp_jobcode", "LHS"."emp_hiredate" AS "emp_hiredate", "LHS"."emp_dob" AS "emp_dob", "RHS"."prof_office" AS "prof_office", "RHS"."prof_extension" AS "prof_extension", "RHS"."prof_high_degree" AS "prof_high_degree" FROM (SELECT "LHS"."dept_code" AS "dept_code", "LHS"."dept_name" AS "dept_name", "LHS"."school_code" AS "school_code", "LHS"."emp_num" AS "emp_num", "LHS"."dept_address" AS "dept_address", "LHS"."dept_extension" AS "dept_extension", "RHS"."emp_lname" AS "emp_lname", "RHS"."emp_fname" AS "emp_fname", "RHS"."emp_initial" AS "emp_initial", "RHS"."emp_jobcode" AS "emp_jobcode", "RHS"."emp_hiredate" AS "emp_hiredate", "RHS"."emp_dob" AS "emp_dob" FROM "department" AS "LHS" INNER JOIN "employee" AS "RHS" ON ("LHS"."emp_num" = "RHS"."emp_num")) AS "LHS" INNER JOIN "professor" AS "RHS" ON ("LHS"."dept_code" = "RHS"."dept_code" AND "LHS"."emp_num" = "RHS"."emp_num")) WHERE ("dept_name" = 'History' AND "prof_high_degree" = 'Ph.D.') ORDER BY emp_fname, "emp_fname" NULLS LAST, "prof_office" NULLS LAST;

/*
Gold Result:
('Alice', 'Room 101')
*/

-- Prediction Query
SELECT T1.emp_fname, T2.prof_office FROM employee AS T1 JOIN professor AS T2 ON T1.emp_num = T2.emp_num JOIN department AS T3 ON T3.dept_code = T2.dept_code WHERE T3.dept_name = 'History' AND T2.prof_high_degree = 'Ph.D.';

/*
Prediction Result:
('Alice', 'Room 101')
('Charlie', 'Room 102')
*/