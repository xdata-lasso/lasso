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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1022, 'Payne', 'Carrie', 'discussion', 'Ranger/warden', '1983-10-20', '1984-11-21');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1023, 'Rogers', 'Nichole', 'fall', 'Pharmacist, community', '1985-01-22', '1986-02-23');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1024, 'Caldwell', 'Anne', 'discover', 'Psychologist, occupational', '1987-03-01', '1988-04-02');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('discuss', 1022, 'John Price', 'relate', '272 Rebecca Ramp Apt. 162
Whiteview, MS 43407', 'development');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('spring', 1024, 'Jacob Obrien', 'small', '1904 Sanders Stravenue
North Brittany, MP 82714', 'eight');
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('discuss', 1022, 'look', 'general', 'Ph.D.');
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('discuss', 1023, 'card', 'material', 'Ph.D.');
INSERT INTO "professor" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('spring', 1024, 'blue', 'same', 'Ph.D.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___", "dept_code" FROM (SELECT "dept_code", "prof_high_degree", COUNT(*) AS "n" FROM "professor" GROUP BY "dept_code", "prof_high_degree") WHERE ("prof_high_degree" = 'Ph.D.') ORDER BY count___, "dept_code" NULLS LAST;

/*
Gold Result:
(1, 'spring')
(2, 'discuss')
*/

-- Prediction Query
SELECT COUNT(*), dept_code FROM professor WHERE prof_high_degree = 'Ph.D.' GROUP BY dept_code;

/*
Prediction Result:
(2, 'discuss')
(1, 'spring')
*/