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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_31c2cf', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483648, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: class --
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('rhs_c141a3', -2147483648, 'crs_code_1', 'value', 'value', 'value');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('rhs_86075e', -2147483648, 'crs_code_1', 'value', 'value', 'value');

-- Inserting into table: course --
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('crs_code_1', 'lhs_31c2cf', 'cou_c97447', 486.033807);

-- Inserting into table: student --
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1, 'lhs_31c2cf', 'lhs_d017c8', 'lhs_dd4ba6', 'lhs_b24e2d', '2024-06-15 00:00:00+00:00', 1, 'lhs_7f8eab', 1.0, 1.0, 'lhs_7322b3', 1);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (2, 'lhs_31c2cf', 'lhs_d017c8', 'lhs_dd4ba6', 'lhs_b24e2d', '2024-06-15 00:00:00+00:00', 1, 'lhs_7f8eab', 1.0, 1.0, 'lhs_7322b3', 1);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (3, 'lhs_31c2cf', 'stu_c368ab', 'stu_13d6e2', 'c', '2023-01-16 20:10:41+00:00', -1022641847, 'f6', 97.952323, 171.746906, '4099', 247012447);

-- Inserting into table: enroll --
INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (3, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (3, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (3, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (3, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (3, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_86075e', 'rhs_fa3004');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_86075e', 'rhs_fa3004');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_86075e', 'rhs_fa3004');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_86075e', 'rhs_fa3004');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_86075e', 'rhs_fa3004');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'C');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 'rhs_c141a3', 'rhs_e4c197');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "stu_fname" FROM (SELECT "LHS"."stu_num" AS "stu_num", "LHS"."stu_lname" AS "stu_lname", "LHS"."stu_fname" AS "stu_fname", "LHS"."stu_init" AS "stu_init", "LHS"."stu_dob" AS "stu_dob", "LHS"."stu_hrs" AS "stu_hrs", "LHS"."stu_class" AS "stu_class", "LHS"."stu_gpa" AS "stu_gpa", "LHS"."stu_transfer" AS "stu_transfer", "LHS"."dept_code" AS "dept_code", "LHS"."stu_phone" AS "stu_phone", "LHS"."prof_num" AS "prof_num", "RHS"."class_code" AS "class_code", "RHS"."enroll_grade" AS "enroll_grade" FROM "student" AS "LHS" LEFT JOIN "enroll" AS "RHS" ON ("LHS"."stu_num" = "RHS"."stu_num")) WHERE ("enroll_grade" <> 'C') ORDER BY stu_fname, "stu_fname" NULLS LAST;

/*
Gold Result:
('lhs_dd4ba6',)
('stu_13d6e2',)
*/

-- Prediction Query
SELECT DISTINCT stu_fname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num = T2.stu_num WHERE enroll_grade = 'C';

/*
Prediction Result:
('lhs_dd4ba6',)
*/