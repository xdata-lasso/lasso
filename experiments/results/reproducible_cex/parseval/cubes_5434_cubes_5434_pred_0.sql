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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('rhs_5abbdf', -2147483648, 'rhs_8ff16b', 'rhs_3fdfda', 'rhs_5d137d', 'rhs_0f9e1a');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_da4bf6', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('rhs_08f30c', -2147483648, 'rhs_ed478e', 'rhs_dd69e0', 'rhs_437d10', 'rhs_d6cac8');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('lhs_2a8fc0', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('A', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('@', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('B', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('D', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('E', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('"', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('J', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('b', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483648, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: student --
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1, 'lhs_da4bf6', 'lhs_3867b8', 'lhs_d171fe', 'lhs_f4ccc7', '2024-06-15 00:00:00+00:00', 1, 'lhs_67aeb1', 1.0, 1.0, 'lhs_0da6c6', 1);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483647, 'lhs_2a8fc0', 'lhs_2a6bf4', 'lhs_1653e0', 'lhs_8a0f74', '2024-06-15 00:00:00+00:00', 1, 'lhs_879267', 1.0, 1.0, 'lhs_ca4520', 1);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (2, 'lhs_2a8fc0', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-01-21 14:23:36+00:00', -1670923962, 'f6', 663.049759, 711.020062, '4099', 1908028688);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (3, '@', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-01-03 02:42:55+00:00', 13244799, 'f6', 320.851235, 113.643485, '4099', 1526238907);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (4, 'rhs_08f30c', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-08-02 13:58:36+00:00', -1610064545, 'f6', 22.535764, 600.048938, '4099', 462974032);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (5, 'lhs_2a8fc0', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-04-09 18:22:58+00:00', 2026480202, 'f6', 133.007885, 75.403642, '4099', -1209887326);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (6, 'rhs_08f30c', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-09-15 12:11:12+00:00', 1038707349, 'f6', 587.783596, 558.971814, '4099', 1419861592);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (7, '"', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-08-19 16:47:31+00:00', 1274489983, 'f6', 128.76421, 610.208018, '4099', -1683203397);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (8, 'D', 'stu_c368ab', 'stu_13d6e2', 'c', '2024-05-26 02:52:16+00:00', -1585009206, 'f6', 191.847248, 807.142508, '4099', -53231346);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (9, 'rhs_5abbdf', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-10-02 08:51:14+00:00', -747753377, 'f6', 478.908865, 203.577612, '4099', 902887186);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name, dept_address FROM (SELECT dept_address, dept_name, MAX(n) AS maxn FROM (SELECT dept_address, dept_name, COUNT(*) AS n FROM (SELECT stu_num, stu_lname, stu_fname, stu_init, stu_dob, stu_hrs, stu_class, stu_gpa, stu_transfer, dept_code, stu_phone, prof_num, dept_name, school_code, dept_address, dept_extension, stu_hrs AS emp_num FROM (SELECT LHS.stu_num AS stu_num, LHS.stu_lname AS stu_lname, LHS.stu_fname AS stu_fname, LHS.stu_init AS stu_init, LHS.stu_dob AS stu_dob, LHS.stu_hrs AS stu_hrs, LHS.stu_class AS stu_class, LHS.stu_gpa AS stu_gpa, LHS.stu_transfer AS stu_transfer, LHS.dept_code AS dept_code, LHS.stu_phone AS stu_phone, LHS.prof_num AS prof_num, RHS.dept_name AS dept_name, RHS.school_code AS school_code, RHS.dept_address AS dept_address, RHS.dept_extension AS dept_extension FROM student AS LHS INNER JOIN department AS RHS ON (LHS.stu_hrs = RHS.emp_num AND LHS.dept_code = RHS.dept_code))) GROUP BY dept_address, dept_name) GROUP BY dept_address, dept_name) ORDER BY dept_name, dept_address NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.dept_name, T2.dept_address FROM student AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code GROUP BY T1.dept_code ORDER BY COUNT(*) DESC, T2.dept_name NULLS LAST, T2.dept_address NULLS LAST LIMIT 1;

/*
Prediction Result:
('dep_974eac', 'dep_3cd133')
*/