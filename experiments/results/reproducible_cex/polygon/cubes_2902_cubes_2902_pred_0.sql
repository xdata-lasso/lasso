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
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('C42', NULL, 'C23', 'C41', 'C41', 'C41');
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('C25', 22, NULL, 'C41', 'C41', 'C41');
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('C23', 'C31', 'C41', 41);
INSERT INTO "DEPARTMENT" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('C31', NULL, 'C41', 'C41', 'C41', 'C41');
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (21, 'C41', 'C41', 'C41', 'C41', 41, 41);
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (22, 'C41', 'C41', 'C41', 'C41', 41, 41);
INSERT INTO "ENROLL" ("stu_num", "class_code", "enroll_grade") VALUES (41, 'C25', NULL);
INSERT INTO "ENROLL" ("stu_num", "class_code", "enroll_grade") VALUES (41, 'C42', 'C');
INSERT INTO "STUDENT" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (41, 'C31', 'C32', 'C43', 'C33', 34, 35, 'C36', 37, 38, 'C39', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "stu_fname" FROM (SELECT "LHS"."stu_num" AS "stu_num", "LHS"."stu_lname" AS "stu_lname", "LHS"."stu_fname" AS "stu_fname", "LHS"."stu_init" AS "stu_init", "LHS"."stu_dob" AS "stu_dob", "LHS"."stu_hrs" AS "stu_hrs", "LHS"."stu_class" AS "stu_class", "LHS"."stu_gpa" AS "stu_gpa", "LHS"."stu_transfer" AS "stu_transfer", "LHS"."dept_code" AS "dept_code", "LHS"."stu_phone" AS "stu_phone", "LHS"."prof_num" AS "prof_num", "RHS"."class_code" AS "class_code", "RHS"."enroll_grade" AS "enroll_grade" FROM "student" AS "LHS" LEFT JOIN "enroll" AS "RHS" ON ("LHS"."stu_num" = "RHS"."stu_num")) WHERE ("enroll_grade" <> 'C') ORDER BY stu_fname, "stu_fname" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT stu_fname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num = T2.stu_num WHERE enroll_grade = 'C';

/*
Prediction Result:
('C43',)
*/