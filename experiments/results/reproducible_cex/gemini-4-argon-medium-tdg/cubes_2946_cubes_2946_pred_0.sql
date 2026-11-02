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
-- DATASET 2
-- Tests GROUP BY dept_code vs GROUP BY dept_name/dept_address when two different dept_codes share the exact same dept_name and dept_address, plus ORDER BY count___ tie-breaking.
INSERT INTO EMPLOYEE (EMP_NUM, EMP_LNAME, EMP_FNAME, EMP_INITIAL, EMP_JOBCODE, EMP_HIREDATE, EMP_DOB) VALUES (10, 'Adams', 'Sarah', 'M', 'PROF', '2012-01-10', '1980-06-20');
INSERT INTO DEPARTMENT (DEPT_CODE, EMP_NUM, DEPT_NAME, SCHOOL_CODE, DEPT_ADDRESS, DEPT_EXTENSION) VALUES ('ENG1', 10, 'Engineering', 'ENG', 'Hall 1', '2001');
INSERT INTO DEPARTMENT (DEPT_CODE, EMP_NUM, DEPT_NAME, SCHOOL_CODE, DEPT_ADDRESS, DEPT_EXTENSION) VALUES ('ENG2', 10, 'Engineering', 'ENG', 'Hall 1', '2002');
INSERT INTO DEPARTMENT (DEPT_CODE, EMP_NUM, DEPT_NAME, SCHOOL_CODE, DEPT_ADDRESS, DEPT_EXTENSION) VALUES ('ENG3', 10, 'Engineering', 'ENG', 'Hall 1', '2003');
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_FNAME, STU_INIT, STU_DOB, STU_HRS, STU_CLASS, STU_GPA, STU_TRANSFER, STU_PHONE, PROF_NUM) VALUES (201, 'ENG1', 'A', 'A', 'A', '2000-05-05', 30, 'SO', 3.0, 0, '1111', 10);
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_FNAME, STU_INIT, STU_DOB, STU_HRS, STU_CLASS, STU_GPA, STU_TRANSFER, STU_PHONE, PROF_NUM) VALUES (202, 'ENG1', 'B', 'B', 'B', '2000-05-05', 30, 'SO', 3.0, 0, '1112', 10);
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_FNAME, STU_INIT, STU_DOB, STU_HRS, STU_CLASS, STU_GPA, STU_TRANSFER, STU_PHONE, PROF_NUM) VALUES (203, 'ENG2', 'C', 'C', 'C', '2000-05-05', 30, 'SO', 3.0, 0, '1113', 10);
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_FNAME, STU_INIT, STU_DOB, STU_HRS, STU_CLASS, STU_GPA, STU_TRANSFER, STU_PHONE, PROF_NUM) VALUES (204, 'ENG3', 'D', 'D', 'D', '2000-05-05', 30, 'SO', 3.0, 0, '1114', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT dept_name, dept_address, n AS count___ FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, LHS.stu_num AS stu_num, LHS.stu_lname AS stu_lname, LHS.stu_fname AS stu_fname, LHS.stu_init AS stu_init, LHS.stu_dob AS stu_dob, LHS.stu_hrs AS stu_hrs, LHS.stu_class AS stu_class, LHS.stu_gpa AS stu_gpa, LHS.stu_transfer AS stu_transfer, LHS.stu_phone AS stu_phone, LHS.prof_num AS prof_num, RHS.n AS n FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, RHS.stu_num AS stu_num, RHS.stu_lname AS stu_lname, RHS.stu_fname AS stu_fname, RHS.stu_init AS stu_init, RHS.stu_dob AS stu_dob, RHS.stu_hrs AS stu_hrs, RHS.stu_class AS stu_class, RHS.stu_gpa AS stu_gpa, RHS.stu_transfer AS stu_transfer, RHS.stu_phone AS stu_phone, RHS.prof_num AS prof_num FROM department AS LHS INNER JOIN student AS RHS ON (LHS.dept_code = RHS.dept_code)) AS LHS INNER JOIN (SELECT dept_code, COUNT(*) AS n FROM student GROUP BY dept_code) AS RHS ON (LHS.dept_code = RHS.dept_code)) ORDER BY dept_name, dept_address NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('Engineering', 'Hall 1', 1)
('Engineering', 'Hall 1', 2)
*/

-- Prediction Query
SELECT T2.dept_name, T2.dept_address, COUNT(*) FROM student AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code GROUP BY T1.dept_code ORDER BY COUNT(*) DESC, T2.dept_name NULLS LAST, T2.dept_address NULLS LAST LIMIT 3;

/*
Prediction Result:
('Engineering', 'Hall 1', 2)
('Engineering', 'Hall 1', 1)
('Engineering', 'Hall 1', 1)
*/