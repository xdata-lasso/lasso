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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1013, 'Porter', 'Nicole', 'question', 'Proofreader', '1976-07-07', '1977-08-08');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1018, 'Mckay', 'Nancy', 'month', 'Editor, magazine features', '1979-10-10', '1980-11-11');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('character', 1013, 'David Hoffman', 'everyone', '653 William Course Apt. 122
Carlsonfurt, MS 78605', 'management');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('movement', 1018, 'Sheila Evans', 'purpose', '52880 Burns Creek
Natashaport, IA 08093', 'effect');
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1014, 'character', 'Rice', 'Tasha', 'traditional', '1978-09-09', 1013, 'yes', 1015.5, 1016.5, '9182451462', 1017);
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1019, 'movement', 'Humphrey', 'Stacey', 'bed', '1981-01-12', 1018, 'sign', 1020.5, 1021.5, '518.622.7824x8963', 1022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name, dept_address FROM (SELECT dept_address, dept_name, MAX(n) AS maxn FROM (SELECT dept_address, dept_name, COUNT(*) AS n FROM (SELECT stu_num, stu_lname, stu_fname, stu_init, stu_dob, stu_hrs, stu_class, stu_gpa, stu_transfer, dept_code, stu_phone, prof_num, dept_name, school_code, dept_address, dept_extension, stu_hrs AS emp_num FROM (SELECT LHS.stu_num AS stu_num, LHS.stu_lname AS stu_lname, LHS.stu_fname AS stu_fname, LHS.stu_init AS stu_init, LHS.stu_dob AS stu_dob, LHS.stu_hrs AS stu_hrs, LHS.stu_class AS stu_class, LHS.stu_gpa AS stu_gpa, LHS.stu_transfer AS stu_transfer, LHS.dept_code AS dept_code, LHS.stu_phone AS stu_phone, LHS.prof_num AS prof_num, RHS.dept_name AS dept_name, RHS.school_code AS school_code, RHS.dept_address AS dept_address, RHS.dept_extension AS dept_extension FROM student AS LHS INNER JOIN department AS RHS ON (LHS.stu_hrs = RHS.emp_num AND LHS.dept_code = RHS.dept_code))) GROUP BY dept_address, dept_name) GROUP BY dept_address, dept_name) ORDER BY dept_name, dept_address NULLS LAST;

/*
Gold Result:
('David Hoffman', '653 William Course Apt. 122\nCarlsonfurt, MS 78605')
('Sheila Evans', '52880 Burns Creek\nNatashaport, IA 08093')
*/

-- Prediction Query
SELECT T2.dept_name, T2.dept_address FROM student AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code GROUP BY T1.dept_code ORDER BY COUNT(*) DESC, T2.dept_name NULLS LAST, T2.dept_address NULLS LAST LIMIT 1;

/*
Prediction Result:
('David Hoffman', '653 William Course Apt. 122\nCarlsonfurt, MS 78605')
*/