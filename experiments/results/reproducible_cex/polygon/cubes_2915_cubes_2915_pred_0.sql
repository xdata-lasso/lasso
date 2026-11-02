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
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('ACCT-21114', 15, 'ACCT-211', 'ACCT-21121', 'ACCT-21122', 'ACCT-21123');
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('ACCT-21113', NULL, NULL, 'ACCT-21117', 'ACCT-21117', 'ACCT-21117');
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('ACCT-21116', 'ACCT-21117', 'ACCT-21117', 17);
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('ACCT-211', 'ACCT-21117', 'ACCT-21117', 17);
INSERT INTO "DEPARTMENT" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('ACCT-21117', 15, 'ACCT-21117', 'ACCT-21117', 'ACCT-21117', 'ACCT-21117');
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (15, 'ACCT-21117', 'ACCT-21117', 'ACCT-21117', 'ACCT-21117', 17, 17);
INSERT INTO "ENROLL" ("stu_num", "class_code", "enroll_grade") VALUES (19, 'ACCT-21113', 'ACCT-21117');
INSERT INTO "ENROLL" ("stu_num", "class_code", "enroll_grade") VALUES (19, 'ACCT-21113', 'ACCT-21117');
INSERT INTO "PROFESSOR" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('ACCT-21117', NULL, 'ACCT-21117', 'ACCT-21117', 'ACCT-21117');
INSERT INTO "PROFESSOR" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('ACCT-21117', 15, 'ACCT-21117', 'ACCT-21117', 'ACCT-21117');
INSERT INTO "STUDENT" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (18, 'ACCT-21117', 'ACCT-21117', 'ACCT-21117', 'ACCT-21117', 17, 17, 'ACCT-21117', 17, 17, 'ACCT-21117', 17);
INSERT INTO "STUDENT" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (19, 'ACCT-21117', 'ACCT-21117', 'ACCT-21117', 'ACCT-21117', 17, 17, 'ACCT-21117', 17, 17, 'ACCT-21117', 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count_distinct_class_section_" FROM (SELECT COUNT(*) AS "n" FROM (SELECT * FROM "class" WHERE ("crs_code" = 'ACCT-211'))) ORDER BY count_distinct_class_section_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT class_section) FROM CLASS WHERE crs_code = 'ACCT-211';

/*
Prediction Result:
(1,)
*/