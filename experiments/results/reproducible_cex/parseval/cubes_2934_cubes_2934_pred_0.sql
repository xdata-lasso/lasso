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
-- Inserting into table: department --
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('rhs_29127b', 1, 'rhs_0e6d5c', 'rhs_82c28f', 'rhs_eecd1b', 'rhs_87628c');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_2', 1, 'rhs_e705a5', 'rhs_1dc8a6', 'rhs_01ad97', 'rhs_42dc22');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('rhs_559949', 1, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: class --
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('lhs_4ffd86', 1, 'lhs_b97fcc', 'lhs_2e1d7b', 'lhs_6053ba', 'lhs_74f53c');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('lhs_4b41fd', 1, 'rhs_9ca94c', 'lhs_3a185b', 'lhs_ce0d7d', 'lhs_4f384d');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('O', 1, 'lhs_b97fcc', 'lhs_2e1d7b', 'lhs_6053ba', 'lhs_74f53c');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('A', 1, 'lhs_b97fcc', 'lhs_3a185b', 'lhs_ce0d7d', 'lhs_4f384d');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('?', 1, 'lhs_b97fcc', 'lhs_2e1d7b', 'lhs_6053ba', 'lhs_74f53c');

-- Inserting into table: course --
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('lhs_b97fcc', 'rhs_29127b', 'rhs_0b6164', 1.0);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('rhs_24f756', 'rhs_29127b', 'rhs_0b6164', 1.0);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('crs_code_2', 'rhs_559949', 'rhs_90b9ef', 1.0);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('rhs_9ca94c', 'dept_cod_2', 'cou_c97447', 171.746906);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('A', 'rhs_29127b', 'rhs_0b6164', 1.0);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('C', 'rhs_559949', 'cou_c97447', 206.939346);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('Q', 'rhs_29127b', 'rhs_0b6164', 1.0);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('G', 'rhs_29127b', 'rhs_0b6164', 1.0);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('O', 'rhs_29127b', 'rhs_0b6164', 1.0);

-- Inserting into table: student --
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1, 'rhs_29127b', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-05-28 17:00:04+00:00', -59984348, 'f6', 345.329712, 833.684115, '4099', -1022641847);

-- Inserting into table: enroll --
INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_855975');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'A', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'A', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'A', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'A', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'lhs_4ffd86', 'rhs_ce7129');
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