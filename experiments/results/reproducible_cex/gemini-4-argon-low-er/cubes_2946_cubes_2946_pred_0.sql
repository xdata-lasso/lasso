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
INSERT INTO DEPARTMENT (DEPT_CODE, DEPT_NAME, DEPT_ADDRESS) VALUES ('D1', 'A', 'A1');
INSERT INTO DEPARTMENT (DEPT_CODE, DEPT_NAME, DEPT_ADDRESS) VALUES ('D2', 'B', 'A2');
INSERT INTO DEPARTMENT (DEPT_CODE, DEPT_NAME, DEPT_ADDRESS) VALUES ('D3', 'C', 'A3');
INSERT INTO DEPARTMENT (DEPT_CODE, DEPT_NAME, DEPT_ADDRESS) VALUES ('D4', 'D', 'A4');
INSERT INTO STUDENT (STU_NUM, DEPT_CODE) VALUES (1, 'D1');
INSERT INTO STUDENT (STU_NUM, DEPT_CODE) VALUES (2, 'D2');
INSERT INTO STUDENT (STU_NUM, DEPT_CODE) VALUES (3, 'D3');
INSERT INTO STUDENT (STU_NUM, DEPT_CODE) VALUES (4, 'D4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT dept_name, dept_address, n AS count___ FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, LHS.stu_num AS stu_num, LHS.stu_lname AS stu_lname, LHS.stu_fname AS stu_fname, LHS.stu_init AS stu_init, LHS.stu_dob AS stu_dob, LHS.stu_hrs AS stu_hrs, LHS.stu_class AS stu_class, LHS.stu_gpa AS stu_gpa, LHS.stu_transfer AS stu_transfer, LHS.stu_phone AS stu_phone, LHS.prof_num AS prof_num, RHS.n AS n FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, RHS.stu_num AS stu_num, RHS.stu_lname AS stu_lname, RHS.stu_fname AS stu_fname, RHS.stu_init AS stu_init, RHS.stu_dob AS stu_dob, RHS.stu_hrs AS stu_hrs, RHS.stu_class AS stu_class, RHS.stu_gpa AS stu_gpa, RHS.stu_transfer AS stu_transfer, RHS.stu_phone AS stu_phone, RHS.prof_num AS prof_num FROM department AS LHS INNER JOIN student AS RHS ON (LHS.dept_code = RHS.dept_code)) AS LHS INNER JOIN (SELECT dept_code, COUNT(*) AS n FROM student GROUP BY dept_code) AS RHS ON (LHS.dept_code = RHS.dept_code)) ORDER BY dept_name, dept_address NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('A', 'A1', 1)
('B', 'A2', 1)
('C', 'A3', 1)
('D', 'A4', 1)
*/

-- Prediction Query
SELECT T2.dept_name, T2.dept_address, COUNT(*) FROM student AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code GROUP BY T1.dept_code ORDER BY COUNT(*) DESC, T2.dept_name NULLS LAST, T2.dept_address NULLS LAST LIMIT 3;

/*
Prediction Result:
('A', 'A1', 1)
('B', 'A2', 1)
('C', 'A3', 1)
*/