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
-- Tests:
-- 1. Multiple classes per course (SUM of joined rows vs SUM on COURSE table only, or SUM(DISTINCT crs_credit)).
-- 2. Multiple courses per department with identical and distinct credit values.
-- 3. Unmatched rows in COURSE (no classes) and CLASS (NULL crs_code) to kill LEFT/RIGHT/FULL JOIN mutants.
-- 4. Tie-breaking in ORDER BY: identical sum_t1_crs_credit_ values with different dept_codes, including a NULL dept_code to test NULLS LAST.
-- 5. Ordering direction (ASC vs DESC) on both sort keys.
INSERT INTO "EMPLOYEE" ("EMP_NUM", "EMP_LNAME", "EMP_FNAME") VALUES (1, 'Smith', 'John');
INSERT INTO "DEPARTMENT" ("DEPT_CODE", "EMP_NUM", "DEPT_NAME") VALUES ('CS', 1, 'Computer Science');
INSERT INTO "DEPARTMENT" ("DEPT_CODE", "EMP_NUM", "DEPT_NAME") VALUES ('MATH', 1, 'Mathematics');
INSERT INTO "DEPARTMENT" ("DEPT_CODE", "EMP_NUM", "DEPT_NAME") VALUES ('ENG', 1, 'English');
INSERT INTO "DEPARTMENT" ("DEPT_CODE", "EMP_NUM", "DEPT_NAME") VALUES ('HIST', 1, 'History');
-- CS: 1 course of 3.0 credits, taught in 2 class sections -> SUM = 6.0 (Tests SUM vs SUM(DISTINCT) and JOIN multiplicity)
INSERT INTO "COURSE" ("CRS_CODE", "DEPT_CODE", "CRS_DESCRIPTION", "CRS_CREDIT") VALUES ('CS101', 'CS', 'Intro to CS', 3.0);
-- MATH: 2 courses of 2.0 and 4.0 credits, 1 class each -> SUM = 6.0 (Ties with CS on sumcrs_credit=6.0)
INSERT INTO "COURSE" ("CRS_CODE", "DEPT_CODE", "CRS_DESCRIPTION", "CRS_CREDIT") VALUES ('MATH101', 'MATH', 'Calculus I', 2.0);
INSERT INTO "COURSE" ("CRS_CODE", "DEPT_CODE", "CRS_DESCRIPTION", "CRS_CREDIT") VALUES ('MATH102', 'MATH', 'Calculus II', 4.0);
-- NULL dept_code: 1 course of 6.0 credits, 1 class -> SUM = 6.0 (Ties with CS and MATH on sumcrs_credit=6.0, tests NULLS LAST on dept_code)
INSERT INTO "COURSE" ("CRS_CODE", "DEPT_CODE", "CRS_DESCRIPTION", "CRS_CREDIT") VALUES ('GEN101', NULL, 'General Studies', 6.0);
-- ENG: 1 course of 2.5 credits, 1 class -> SUM = 2.5 (Tests fractional credits and primary sort order < 6.0)
INSERT INTO "COURSE" ("CRS_CODE", "DEPT_CODE", "CRS_DESCRIPTION", "CRS_CREDIT") VALUES ('ENG101', 'ENG', 'Composition', 2.5);
-- HIST: 1 course of 4.0 credits, NO classes -> Tests INNER JOIN vs RIGHT JOIN on COURSE
INSERT INTO "COURSE" ("CRS_CODE", "DEPT_CODE", "CRS_DESCRIPTION", "CRS_CREDIT") VALUES ('HIST101', 'HIST', 'World History', 4.0);
-- Classes
INSERT INTO "CLASS" ("CLASS_CODE", "PROF_NUM", "CRS_CODE", "CLASS_SECTION") VALUES ('1001', 1, 'CS101', '1');
INSERT INTO "CLASS" ("CLASS_CODE", "PROF_NUM", "CRS_CODE", "CLASS_SECTION") VALUES ('1002', 1, 'CS101', '2');
INSERT INTO "CLASS" ("CLASS_CODE", "PROF_NUM", "CRS_CODE", "CLASS_SECTION") VALUES ('1003', 1, 'MATH101', '1');
INSERT INTO "CLASS" ("CLASS_CODE", "PROF_NUM", "CRS_CODE", "CLASS_SECTION") VALUES ('1004', 1, 'MATH102', '1');
INSERT INTO "CLASS" ("CLASS_CODE", "PROF_NUM", "CRS_CODE", "CLASS_SECTION") VALUES ('1005', 1, 'GEN101', '1');
INSERT INTO "CLASS" ("CLASS_CODE", "PROF_NUM", "CRS_CODE", "CLASS_SECTION") VALUES ('1006', 1, 'ENG101', '1');
-- Class with NULL crs_code -> Tests INNER JOIN vs LEFT JOIN on CLASS
INSERT INTO "CLASS" ("CLASS_CODE", "PROF_NUM", "CRS_CODE", "CLASS_SECTION") VALUES ('1007', 1, NULL, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumcrs_credit AS sum_t1_crs_credit_, dept_code FROM (SELECT dept_code, SUM(crs_credit) AS sumcrs_credit FROM (SELECT LHS.class_code AS class_code, LHS.crs_code AS crs_code, LHS.class_section AS class_section, LHS.class_time AS class_time, LHS.class_room AS class_room, LHS.prof_num AS prof_num, RHS.dept_code AS dept_code, RHS.crs_description AS crs_description, RHS.crs_credit AS crs_credit FROM class AS LHS INNER JOIN course AS RHS ON (LHS.crs_code = RHS.crs_code)) GROUP BY dept_code) ORDER BY sum_t1_crs_credit_, dept_code NULLS LAST;

/*
Gold Result:
(2.5, 'ENG')
(6.0, 'CS')
(6.0, 'MATH')
(6.0, None)
*/

-- Prediction Query
SELECT SUM(T1.crs_credit), T1.dept_code FROM course AS T1 JOIN CLASS AS T2 ON T1.crs_code = T2.crs_code GROUP BY T1.dept_code;

/*
Prediction Result:
(6.0, None)
(6.0, 'CS')
(2.5, 'ENG')
(6.0, 'MATH')
*/