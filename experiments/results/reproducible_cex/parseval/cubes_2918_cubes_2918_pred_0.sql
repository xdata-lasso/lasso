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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('t1__8d8dc5', -2147483648, 't2__50f171', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('A', -2147483648, 't2__50f171', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_2', -2147483648, 't2__50f171', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('t2__c606de', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('@', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('I', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483648, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: professor --
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('A', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('A', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('A', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('t1__8d8dc5', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('@', -2147483648, 'pro_694edd', 'f495', '7ebf3');

INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('@', -2147483648, 'pro_694edd', 'f495', '7ebf3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, RHS.emp_num AS emp_num_other, RHS.n AS n FROM department AS LHS INNER JOIN (SELECT emp_num, prof_extension, COUNT(*) AS n FROM professor GROUP BY emp_num, prof_extension) AS RHS ON (LHS.dept_extension = RHS.prof_extension)) ORDER BY dept_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.dept_name FROM professor AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code GROUP BY T1.dept_code ORDER BY COUNT(*), T2.dept_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('dep_974eac',)
*/