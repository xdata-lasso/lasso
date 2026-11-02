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
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('11', NULL, '15', '1', '1', '1');
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('10', NULL, '14', '1', '1', '1');
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('14', '16', '1', 1);
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('15', '17', '1', 1);
INSERT INTO "DEPARTMENT" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('16', 13, NULL, '20', '1', '1');
INSERT INTO "DEPARTMENT" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('17', 12, '1', '22', '1', '1');
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (12, '1', '1', '1', '1', 1, 1);
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (13, '1', '1', '1', '1', 1, 1);
INSERT INTO "ENROLL" ("stu_num", "class_code", "enroll_grade") VALUES (19, '10', '1');
INSERT INTO "ENROLL" ("stu_num", "class_code", "enroll_grade") VALUES (NULL, '11', '1');
INSERT INTO "PROFESSOR" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('16', 13, '1', '1', '1');
INSERT INTO "PROFESSOR" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES (NULL, 13, '1', '1', '1');
INSERT INTO "STUDENT" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (19, '16', '1', '1', '1', 1, 1, '1', 1, 1, '1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count_distinct_dept_name_, school_code FROM (SELECT school_code, COUNT(*) AS n FROM department GROUP BY school_code) ORDER BY count_distinct_dept_name_, school_code NULLS LAST;

/*
Gold Result:
(1, '20')
(1, '22')
*/

-- Prediction Query
SELECT COUNT(DISTINCT dept_name), school_code FROM department GROUP BY school_code;

/*
Prediction Result:
(0, '20')
(1, '22')
*/