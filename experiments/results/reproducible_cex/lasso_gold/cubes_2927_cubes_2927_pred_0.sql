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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1005, 'Martin', 'Noah', 'wish', 'Surveyor, hydrographic', '1974-05-05', '1975-06-06');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1007, 'Burton', 'Laura', 'knowledge', 'Therapist, occupational', '1976-07-07', '1977-08-08');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('discuss', 1005, 'Sarah Parsons', 'drop', '4139 Lewis Parks Suite 724
East Julie, ND 34939', 'skin');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('attack', 1007, 'Kyle Mcdonald', 'enter', 'Unit 0184 Box 5146
DPO AE 59971', 'about');
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('pattern', 'discuss', 'Today human despite young meeting before.', 1006.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('seven', 'attack', 'Will seven medical blood personal.', 1008.5);
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('anyone', 1005, 'pattern', 'traditional', 'break', 'claim');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('thought', 1007, 'seven', 'purpose', 'movement', 'politics');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, school_code FROM (SELECT LHS.crs_code AS crs_code, LHS.dept_code AS dept_code, LHS.crs_description AS crs_description, LHS.crs_credit AS crs_credit, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, RHS.class_code AS class_code, RHS.class_section AS class_section, RHS.class_time AS class_time, RHS.class_room AS class_room, RHS.prof_num AS prof_num, RHS.n AS n FROM (SELECT LHS.crs_code AS crs_code, LHS.dept_code AS dept_code, LHS.crs_description AS crs_description, LHS.crs_credit AS crs_credit, RHS.dept_name AS dept_name, RHS.school_code AS school_code, RHS.emp_num AS emp_num, RHS.dept_address AS dept_address, RHS.dept_extension AS dept_extension FROM course AS LHS INNER JOIN department AS RHS ON (LHS.dept_code = RHS.dept_code)) AS LHS INNER JOIN (SELECT class_code, crs_code, class_section, class_time, class_room, prof_num, COUNT(*) OVER () AS n FROM class) AS RHS ON (LHS.crs_code = RHS.crs_code)) ORDER BY count___, school_code NULLS LAST;

/*
Gold Result:
(2, 'drop')
(2, 'enter')
*/

-- Prediction Query
SELECT COUNT(*), T3.school_code FROM CLASS AS T1 JOIN course AS T2 ON T1.crs_code = T2.crs_code JOIN department AS T3 ON T2.dept_code = T3.dept_code GROUP BY T3.school_code;

/*
Prediction Result:
(1, 'drop')
(1, 'enter')
*/