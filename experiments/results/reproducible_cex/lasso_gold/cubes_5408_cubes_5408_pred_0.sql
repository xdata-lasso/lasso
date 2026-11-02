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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1021, 'Simmons', 'Rebecca', 'like', 'Designer, interior/spatial', '1977-04-14', '1978-05-15');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1022, 'Russell', 'Rebecca', 'just', 'Biomedical engineer', '1979-06-16', '1980-07-17');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('six', 1021, 'Joanna Walton', 'though', '347 Jennifer Freeway Suite 558
East Edwardfurt, UT 20529', 'seat');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('manage', 1022, 'Jean Carrillo', 'young', '0546 Medina Street Apt. 734
Tuckerfurt, MA 88171', 'respond');
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('six', 1021, 'difficult', 'attack', 'join');
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('manage', 1022, 'wide', 'care', 'prevent');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_fname, prof_office FROM (SELECT LHS.emp_num AS emp_num, LHS.dept_code AS dept_code, LHS.prof_office AS prof_office, LHS.prof_extension AS prof_extension, LHS.prof_high_degree AS prof_high_degree, RHS.emp_num AS emp_num_other, RHS.emp_lname AS emp_lname, RHS.emp_fname AS emp_fname, RHS.emp_initial AS emp_initial, RHS.emp_jobcode AS emp_jobcode, RHS.emp_hiredate AS emp_hiredate, RHS.emp_dob AS emp_dob FROM professor AS LHS CROSS JOIN employee AS RHS) WHERE (emp_num = emp_num_other) ORDER BY emp_fname, prof_office NULLS LAST;

/*
Gold Result:
('Rebecca', 'difficult')
('Rebecca', 'wide')
*/

-- Prediction Query
SELECT T2.emp_fname, T1.prof_office FROM professor AS T1 JOIN employee AS T2 ON T1.emp_num = T2.emp_num ORDER BY T2.emp_fname, T1.dept_code NULLS LAST, T1.emp_num NULLS LAST, T1.prof_office NULLS LAST, T1.prof_extension NULLS LAST, T1.prof_high_degree NULLS LAST, T2.emp_num NULLS LAST;

/*
Prediction Result:
('Rebecca', 'wide')
('Rebecca', 'difficult')
*/