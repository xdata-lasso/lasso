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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1047, 'Adams', 'Billy', 'something', 'Economist', '1989-05-03', '1990-06-04');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1051, 'Bryant', 'Duane', 'cut', 'Tour manager', '1993-09-07', '1994-10-08');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1049, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('many', 1047, 'Jessica Ramirez', 'pay', '75655 Mia Isle Suite 746
South Christopherview, MD 15695', 'spring');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('movie', 1051, 'Breanna Jones', 'strategy', '404 Monroe Prairie Suite 278
Reedside, WV 71729', 'huge');
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('international', 'many', 'Stay ability thank left approach million performance.', 1048.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('lose', 'movie', 'Thank wonder draw him task improve.', 1052.5);
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('moment', 1047, 'international', 'process', 'letter', 'soon');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('they', 1049, 'international', 'meeting', 'marriage', 'either');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('friend', 1051, 'lose', 'size', 'material', 'season');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, dept_code FROM (SELECT dept_code, COUNT(*) AS n FROM (SELECT LHS.class_code AS class_code, LHS.crs_code AS crs_code, LHS.class_section AS class_section, LHS.class_time AS class_time, LHS.class_room AS class_room, LHS.prof_num AS prof_num, RHS.dept_code AS dept_code, RHS.crs_description AS crs_description, RHS.crs_credit AS crs_credit FROM class AS LHS INNER JOIN course AS RHS ON (LHS.crs_code = RHS.crs_code)) GROUP BY dept_code) ORDER BY count___, dept_code NULLS LAST;

/*
Gold Result:
(1, 'movie')
(2, 'many')
*/

-- Prediction Query
SELECT COUNT(*), dept_code FROM CLASS AS T1 JOIN course AS T2 ON T1.crs_code = T2.crs_code GROUP BY dept_code;

/*
Prediction Result:
(2, 'many')
(1, 'movie')
*/