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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_1', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483648, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: class --
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('10018', -2147483648, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('t2__0552bd', -2147483648, 'crs_code_1', 'value', 'value', 'value');

-- Inserting into table: course --
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('crs_code_1', 'dept_cod_1', 'cou_c97447', 292.730571);

-- Inserting into table: student --
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1, 'dept_cod_1', 't1__91694d', 'stu_13d6e2', 'c', '2025-10-14 06:39:08+00:00', 600401919, 'f6', 165.344793, 285.529132, '4099', 1258409369);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (2, 'dept_cod_1', 't1__91694d', 'stu_13d6e2', 'c', '2025-02-21 23:30:13+00:00', -1980249628, 'f6', 249.706432, 99.523333, '4099', -734455130);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (3, 'dept_cod_1', 't1__91694d', 'stu_13d6e2', 'c', '2024-02-11 16:43:27+00:00', 1160656988, 'f6', 268.82475, 710.998147, '4099', 1914020640);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (4, 'dept_cod_1', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-05-28 17:00:04+00:00', -59984348, 'f6', 345.329712, 833.684115, '4099', -1022641847);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (5, 'dept_cod_1', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-06-17 14:22:38+00:00', 1610062532, 'f6', 475.173408, 935.695299, '4099', 809183447);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (6, 'dept_cod_1', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-07-23 07:32:15+00:00', -1633151678, 'f6', 134.487977, 941.961117, '4099', -252690330);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (7, 'dept_cod_1', 'stu_c368ab', 'stu_13d6e2', 'c', '2023-05-25 17:04:36+00:00', 1465859724, 'f6', 294.861575, 268.234631, '4099', -1349201381);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (8, 'dept_cod_1', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-06-20 11:35:06+00:00', -1377057208, 'f6', 304.02808, 182.319045, '4099', -1257178728);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (9, 'dept_cod_1', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-09-01 05:13:03+00:00', 462974032, 'f6', 792.223623, 938.037625, '4099', -1137908826);

-- Inserting into table: enroll --
INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (2, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (2, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (2, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (2, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (2, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 't2__edcacb');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, 't2__0552bd', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (4, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (5, 't2__0552bd', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (6, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (7, '10018', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (8, 't2__0552bd', 'A');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (9, 't2__0552bd', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "stu_lname" FROM (SELECT "LHS"."stu_num" AS "stu_num", "LHS"."stu_lname" AS "stu_lname", "LHS"."stu_fname" AS "stu_fname", "LHS"."stu_init" AS "stu_init", "LHS"."stu_dob" AS "stu_dob", "LHS"."stu_hrs" AS "stu_hrs", "LHS"."stu_class" AS "stu_class", "LHS"."stu_gpa" AS "stu_gpa", "LHS"."stu_transfer" AS "stu_transfer", "LHS"."dept_code" AS "dept_code", "LHS"."stu_phone" AS "stu_phone", "LHS"."prof_num" AS "prof_num", "RHS"."class_code" AS "class_code" FROM "student" AS "LHS" INNER JOIN (SELECT * FROM "enroll" WHERE ("enroll_grade" = 'A' OR class_code <> 10018)) AS RHS ON (LHS.stu_num = RHS.stu_num AND LHS.stu_init = RHS.enroll_grade)) ORDER BY stu_lname, "stu_lname" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.stu_lname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num = T2.stu_num WHERE T2.enroll_grade = 'A' AND T2.class_code = 10018;

/*
Prediction Result:
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('t1__91694d',)
('stu_c368ab',)
('stu_c368ab',)
('stu_c368ab',)
*/