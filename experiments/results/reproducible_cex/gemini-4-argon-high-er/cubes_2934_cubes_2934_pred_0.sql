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
INSERT INTO EMPLOYEE (EMP_NUM, EMP_LNAME) VALUES (1, 'Smith');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "dept_address", "emp_num", COUNT(*) AS "n" FROM (SELECT * FROM (SELECT "LHS"."class_code" AS "class_code", "LHS"."crs_code" AS "crs_code", "LHS"."class_section" AS "class_section", "LHS"."class_time" AS "class_time", "LHS"."class_room" AS "class_room", "LHS"."prof_num" AS "prof_num", "LHS"."dept_code" AS "dept_code", "LHS"."crs_description" AS "crs_description", "LHS"."crs_credit" AS "crs_credit", "LHS"."dept_name" AS "dept_name", "LHS"."school_code" AS "school_code", "LHS"."emp_num" AS "emp_num", "LHS"."dept_address" AS "dept_address", "LHS"."dept_extension" AS "dept_extension", "RHS"."stu_num" AS "stu_num", "RHS"."enroll_grade" AS "enroll_grade" FROM (SELECT "LHS"."class_code" AS "class_code", "LHS"."crs_code" AS "crs_code", "LHS"."class_section" AS "class_section", "LHS"."class_time" AS "class_time", "LHS"."class_room" AS "class_room", "LHS"."prof_num" AS "prof_num", "LHS"."dept_code" AS "dept_code", "LHS"."crs_description" AS "crs_description", "LHS"."crs_credit" AS "crs_credit", "RHS"."dept_name" AS "dept_name", "RHS"."school_code" AS "school_code", "RHS"."emp_num" AS "emp_num", "RHS"."dept_address" AS "dept_address", "RHS"."dept_extension" AS "dept_extension" FROM (SELECT "LHS"."class_code" AS "class_code", "LHS"."crs_code" AS "crs_code", "LHS"."class_section" AS "class_section", "LHS"."class_time" AS "class_time", "LHS"."class_room" AS "class_room", "LHS"."prof_num" AS "prof_num", "RHS"."dept_code" AS "dept_code", "RHS"."crs_description" AS "crs_description", "RHS"."crs_credit" AS "crs_credit" FROM "class" AS "LHS" INNER JOIN "course" AS "RHS" ON ("LHS"."crs_code" = "RHS"."crs_code")) AS "LHS" INNER JOIN "department" AS "RHS" ON ("LHS"."dept_code" = "RHS"."dept_code")) AS "LHS" INNER JOIN "enroll" AS "RHS" ON ("LHS"."class_code" = "RHS"."class_code")) WHERE ("dept_name" = 'Accounting')) GROUP BY dept_address, emp_num) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code = T2.class_code JOIN course AS T3 ON T1.crs_code = T3.crs_code JOIN department AS T4 ON T3.dept_code = T4.dept_code WHERE T4.dept_name = 'Accounting';

/*
Prediction Result:
(0,)
*/