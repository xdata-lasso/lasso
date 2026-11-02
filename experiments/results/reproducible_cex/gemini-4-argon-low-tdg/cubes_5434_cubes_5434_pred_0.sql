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
-- Tests basic join conditions (matching vs non-matching stu_hrs = emp_num and dept_code = dept_code),
-- multiple students per department (testing grouping/deduplication vs raw join),
-- and departments with zero matching students (testing INNER JOIN vs LEFT/RIGHT JOIN).
INSERT INTO EMPLOYEE (EMP_NUM, EMP_LNAME, EMP_FNAME) VALUES (10, 'Smith', 'John');
INSERT INTO EMPLOYEE (EMP_NUM, EMP_LNAME, EMP_FNAME) VALUES (20, 'Doe', 'Jane');
INSERT INTO EMPLOYEE (EMP_NUM, EMP_LNAME, EMP_FNAME) VALUES (30, 'Brown', 'Bob');
INSERT INTO EMPLOYEE (EMP_NUM, EMP_LNAME, EMP_FNAME) VALUES (40, 'White', 'Alice');
INSERT INTO DEPARTMENT (DEPT_CODE, EMP_NUM, DEPT_NAME, SCHOOL_CODE, DEPT_ADDRESS, DEPT_EXTENSION) VALUES ('CS', 10, 'Computer Science', 'ENG', 'Bldg 1', '1111');
INSERT INTO DEPARTMENT (DEPT_CODE, EMP_NUM, DEPT_NAME, SCHOOL_CODE, DEPT_ADDRESS, DEPT_EXTENSION) VALUES ('MATH', 20, 'Mathematics', 'SCI', 'Bldg 2', '2222');
INSERT INTO DEPARTMENT (DEPT_CODE, EMP_NUM, DEPT_NAME, SCHOOL_CODE, DEPT_ADDRESS, DEPT_EXTENSION) VALUES ('PHYS', 30, 'Physics', 'SCI', 'Bldg 3', '3333');
INSERT INTO DEPARTMENT (DEPT_CODE, EMP_NUM, DEPT_NAME, SCHOOL_CODE, DEPT_ADDRESS, DEPT_EXTENSION) VALUES ('HIST', 40, 'History', 'ART', 'Bldg 4', '4444');
-- Matches CS (DEPT_CODE = 'CS' and STU_HRS = 10) - 2 students to test GROUP BY deduplication
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_HRS, PROF_NUM) VALUES (1, 'CS', 'Adams', 10, 10);
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_HRS, PROF_NUM) VALUES (2, 'CS', 'Baker', 10, 20);
-- Matches MATH (DEPT_CODE = 'MATH' and STU_HRS = 20) - 1 student
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_HRS, PROF_NUM) VALUES (3, 'MATH', 'Clark', 20, 10);
-- Partial match 1: DEPT_CODE matches 'PHYS', but STU_HRS (99) != EMP_NUM (30), while PROF_NUM (30) == EMP_NUM (30)
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_HRS, PROF_NUM) VALUES (4, 'PHYS', 'Davis', 99, 30);
-- Partial match 2: STU_HRS (30) matches PHYS EMP_NUM (30), but DEPT_CODE is 'CS'
INSERT INTO STUDENT (STU_NUM, DEPT_CODE, STU_LNAME, STU_HRS, PROF_NUM) VALUES (5, 'CS', 'Evans', 30, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name, dept_address FROM (SELECT dept_address, dept_name, MAX(n) AS maxn FROM (SELECT dept_address, dept_name, COUNT(*) AS n FROM (SELECT stu_num, stu_lname, stu_fname, stu_init, stu_dob, stu_hrs, stu_class, stu_gpa, stu_transfer, dept_code, stu_phone, prof_num, dept_name, school_code, dept_address, dept_extension, stu_hrs AS emp_num FROM (SELECT LHS.stu_num AS stu_num, LHS.stu_lname AS stu_lname, LHS.stu_fname AS stu_fname, LHS.stu_init AS stu_init, LHS.stu_dob AS stu_dob, LHS.stu_hrs AS stu_hrs, LHS.stu_class AS stu_class, LHS.stu_gpa AS stu_gpa, LHS.stu_transfer AS stu_transfer, LHS.dept_code AS dept_code, LHS.stu_phone AS stu_phone, LHS.prof_num AS prof_num, RHS.dept_name AS dept_name, RHS.school_code AS school_code, RHS.dept_address AS dept_address, RHS.dept_extension AS dept_extension FROM student AS LHS INNER JOIN department AS RHS ON (LHS.stu_hrs = RHS.emp_num AND LHS.dept_code = RHS.dept_code))) GROUP BY dept_address, dept_name) GROUP BY dept_address, dept_name) ORDER BY dept_name, dept_address NULLS LAST;

/*
Gold Result:
('Computer Science', 'Bldg 1')
('Mathematics', 'Bldg 2')
*/

-- Prediction Query
SELECT T2.dept_name, T2.dept_address FROM student AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code GROUP BY T1.dept_code ORDER BY COUNT(*) DESC, T2.dept_name NULLS LAST, T2.dept_address NULLS LAST LIMIT 1;

/*
Prediction Result:
('Computer Science', 'Bldg 1')
*/