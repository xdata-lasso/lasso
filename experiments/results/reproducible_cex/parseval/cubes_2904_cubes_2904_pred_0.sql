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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('rhs_e55e10', -2147483648, 'rhs_8fab83', 'rhs_940b27', 'rhs_88485b', 'rhs_594e61');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_43f972', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('rhs_0dc43a', -2147483648, 'rhs_932196', 'rhs_e0da75', 'rhs_3a904b', 'rhs_5fbd4c');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_84676e', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('A', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('@', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('"', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('H', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('B', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('D', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('G', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('`', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483648, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: student --
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1, 'lhs_43f972', 'lhs_c0dcbd', 'lhs_aaf1ea', 'lhs_b487ad', '2024-06-15 00:00:00+00:00', 1, 'lhs_4653e2', 1.0, 1.0, 'lhs_6123a6', 1);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483647, 'lhs_84676e', 'lhs_8ae5ca', 'lhs_8f3229', 'lhs_d36a76', '2024-06-15 00:00:00+00:00', 1, 'lhs_34658e', 1.0, 1.0, 'lhs_2811ab', 1);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (2, 'rhs_e55e10', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-04-15 05:01:35+00:00', -252690330, 'f6', 797.015047, 241.913711, '4099', 1115440883);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (3, 'rhs_e55e10', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-07-05 02:28:20+00:00', 700293388, 'f6', 711.020062, 944.247544, '4099', 2122220075);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (4, 'A', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-07-31 11:04:01+00:00', -1659388584, 'f6', 855.355181, 179.378884, '4099', -841692980);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (5, 'rhs_e55e10', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-02-07 06:53:31+00:00', -1257178728, 'f6', 787.938887, 986.066566, '4099', 907682809);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (6, 'A', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-02-17 05:47:13+00:00', -1602639011, 'f6', 489.397796, 933.422701, '4099', 44952191);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (7, 'lhs_43f972', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-01-18 08:28:25+00:00', 1419861592, 'f6', 663.001988, 587.103196, '4099', 1274489983);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (8, 'D', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-12-01 20:25:15+00:00', -1833165707, 'f6', 517.275698, 962.037451, '4099', 1155439218);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (9, '@', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-08-19 01:10:02+00:00', 283598170, 'f6', 452.706544, 672.826911, '4099', -747753377);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name FROM (SELECT LHS.stu_num AS stu_num, LHS.stu_lname AS stu_lname, LHS.stu_fname AS stu_fname, LHS.stu_init AS stu_init, LHS.stu_dob AS stu_dob, LHS.stu_hrs AS stu_hrs, LHS.stu_class AS stu_class, LHS.stu_gpa AS stu_gpa, LHS.stu_transfer AS stu_transfer, LHS.dept_code AS dept_code, LHS.stu_phone AS stu_phone, LHS.prof_num AS prof_num, RHS.dept_name AS dept_name, RHS.school_code AS school_code, RHS.dept_address AS dept_address, RHS.dept_extension AS dept_extension FROM student AS LHS INNER JOIN department AS RHS ON (LHS.stu_hrs = RHS.emp_num AND LHS.dept_code = RHS.dept_code)) ORDER BY dept_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.dept_name FROM student AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code ORDER BY stu_gpa, T1.stu_num NULLS LAST, T2.dept_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('dep_974eac',)
*/