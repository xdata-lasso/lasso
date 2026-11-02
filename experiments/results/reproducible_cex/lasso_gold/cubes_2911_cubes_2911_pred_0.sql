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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1014, 'Ramirez', 'Todd', 'notice', 'Consulting civil engineer', '1980-11-11', '1981-01-12');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1018, 'Sanchez', 'Brooke', 'president', 'Ceramics designer', '1984-04-15', '1985-05-16');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('several', 1014, 'Laura Kennedy', 'still', '11656 Owens Stream Apt. 106
Laurenville, IA 25613', 'customer');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('kind', 1018, 'Krystal Stewart', 'every', '46247 Hickman Cliffs Apt. 799
North Amandahaven, KS 17862', 'worker');
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('not', 'several', 'Cell contain leg themselves away space task.', 1015.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('happy', 'kind', 'These hard citizen street.', 1019.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('wide', NULL, NULL, NULL);
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('billion', 1014, 'not', 'apply', 'reach', 'now');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('call', 1014, 'wide', 'year', 'voice', 'over');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('score', 1018, 'happy', 'five', 'population', 'surface');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT emp_fname, crs_code FROM (SELECT LHS.class_code AS class_code, LHS.crs_code AS crs_code, LHS.class_section AS class_section, LHS.class_time AS class_time, LHS.class_room AS class_room, LHS.prof_num AS prof_num, RHS.emp_lname AS emp_lname, RHS.emp_fname AS emp_fname, RHS.emp_initial AS emp_initial, RHS.emp_jobcode AS emp_jobcode, RHS.emp_hiredate AS emp_hiredate, RHS.emp_dob AS emp_dob FROM class AS LHS INNER JOIN employee AS RHS ON (LHS.prof_num = RHS.emp_num)) ORDER BY emp_fname, crs_code NULLS LAST;

/*
Gold Result:
('Brooke', 'happy')
('Todd', 'not')
('Todd', 'wide')
*/

-- Prediction Query
SELECT T2.emp_fname, T1.crs_code FROM CLASS AS T1 JOIN employee AS T2 ON T1.prof_num = T2.emp_num;

/*
Prediction Result:
('Todd', 'not')
('Todd', 'wide')
('Brooke', 'happy')
*/