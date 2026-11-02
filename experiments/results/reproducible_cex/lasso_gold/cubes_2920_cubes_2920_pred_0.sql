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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1007, 'Callahan', 'Eric', 'collection', 'Pharmacist, hospital', '1976-07-07', '1977-08-08');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1009, 'Romero', 'James', 'hour', 'Designer, television/film set', '1978-09-09', '1979-10-10');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1011, 'Marquez', 'Raymond', 'remain', 'Midwife', '1980-11-11', '1981-01-12');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('pick', 1007, 'James Ferrell', 'newspaper', '184 Rodriguez Mews
South Aaron, VA 94830', 'everyone');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('notice', 1009, 'Tammy Sellers', 'place', '54303 Christopher Oval
Port Amandaberg, DC 86975', 'may');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('part', 1011, 'Joseph Martinez', 'down', '839 Adrian Station
East Carloston, VI 43810', 'avoid');
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('month', 'pick', 'Medical blood personal success.', 1008.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('your', 'notice', 'Close month parent who up sense ready.', NULL);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('my', 'notice', 'Everything magazine much rich think.', 1012.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumcrs_credit AS sum_crs_credit_, dept_code FROM (SELECT dept_code, SUM(crs_credit) AS sumcrs_credit FROM course GROUP BY dept_code) ORDER BY sum_crs_credit_, dept_code NULLS LAST;

/*
Gold Result:
(1008.5, 'pick')
(1012.5, 'notice')
*/

-- Prediction Query
SELECT SUM(crs_credit), dept_code FROM course GROUP BY dept_code;

/*
Prediction Result:
(1012.5, 'notice')
(1008.5, 'pick')
*/