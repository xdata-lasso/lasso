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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_1', 1, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1, 'Graztevski', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (3, 'Graztevski', 'emp_d05cb6', 'b', 'c52b7', '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (2, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (4, NULL, 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (5, 'Graztevski', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (6, 'Graztevski', 'emp_d05cb6', 'b', 'c52b7', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (7, 'Graztevski', 'emp_d05cb6', 'b', 'c52b7', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (8, 'Graztevski', 'emp_d05cb6', 'b', 'c52b7', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (9, 'Graztevski', 'emp_d05cb6', 'b', 'c52b7', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00');

INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (10, 'Graztevski', 'emp_d05cb6', 'b', 'c52b7', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00');

-- Inserting into table: class --
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_1', 1, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_2', 2, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_3', 2, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_4', 2, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_5', 2, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('C', 1, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('A', 1, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('_', 1, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('O', 1, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cl_10', 1, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cl_11', 1, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('E', 4, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('@', 5, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('D', 6, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('!', 7, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('B', 8, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('b', 9, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('"', 10, 'crs_code_1', 'c8', 'cla_36790f', 'c_88cd26');

-- Inserting into table: course --
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('crs_code_1', 'dept_cod_1', 'cou_c97447', 165.344793);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "LHS"."prof_num" AS "prof_num", "LHS"."n" AS "n", "RHS"."emp_lname" AS "emp_lname", "RHS"."emp_fname" AS "emp_fname", "RHS"."emp_initial" AS "emp_initial", "RHS"."emp_jobcode" AS "emp_jobcode", "RHS"."emp_hiredate" AS "emp_hiredate", "RHS"."emp_dob" AS "emp_dob" FROM (SELECT "prof_num", COUNT(*) AS "n" FROM "class" GROUP BY "prof_num") AS "LHS" INNER JOIN (SELECT * FROM "employee" WHERE ("emp_lname" = 'Graztevski')) AS RHS ON (LHS.prof_num = RHS.emp_num)) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(7,)
*/

-- Prediction Query
SELECT COUNT(*) FROM employee AS T1 JOIN CLASS AS T2 ON T1.EMP_NUM = T2.PROF_NUM WHERE T1.EMP_LNAME = 'Graztevski';

/*
Prediction Result:
(13,)
*/