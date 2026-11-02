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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('t2__77c7c9', -2147483648, 'value', 't3__ae0287', 'value', 'value');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('O', -2147483648, 'value', 't3__ae0287', 'value', 'value');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_2', -2147483648, 'value', 't3__ae0287', 'value', 'value');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('t2__d6b037', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('A', -2147483648, 'value', 't3__ae0287', 'value', 'value');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('@', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('t3__baad06', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('t2__a9f2ca', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('I', -2147483648, 'value', 't3__dfdf46', 'value', 'value');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('`', -2147483648, 'value', 't3__dfdf46', 'value', 'value');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('D', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('value', -2147483648, 'value', 'dep_317c7b', 'value', 'value');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('a', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_co_14', -2147483648, 'dep_974eac', 'val_1', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('!', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_co_16', -2147483648, 'dep_974eac', 'val_2', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('"', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_co_18', -2147483648, 'dep_974eac', 'val_3', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('B', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_co_20', -2147483648, 'dep_974eac', 'val_4', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('E', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_co_22', -2147483648, 'dep_974eac', 'val_5', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483648, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: class --
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_1', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_2', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_3', -2147483648, 't1__f10858', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_4', -2147483648, 'A', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_5', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_6', -2147483648, 'A', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_7', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_8', -2147483648, 'A', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_9', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('O', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('A', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cl_12', -2147483648, 'A', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('I', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cl_14', -2147483648, 'A', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cl_15', -2147483648, 'A', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cl_16', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cl_17', -2147483648, 't1__bca232', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('@', -2147483648, 'E', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('`', -2147483648, 'crs_code_2', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('H', -2147483648, '`', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('a', -2147483648, 'a', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('!', -2147483648, '!', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('"', -2147483648, '"', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('D', -2147483648, 'D', 'c8', 'cla_36790f', 'c_88cd26');

INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('B', -2147483648, 'B', 'c8', 'cla_36790f', 'c_88cd26');

-- Inserting into table: course --
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('t1__bca232', 't2__77c7c9', 'cou_c97447', 486.033807);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('crs_code_2', 't2__d6b037', 'cou_c97447', 292.730571);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('t1__f10858', 't2__d6b037', 'cou_c97447', 249.706432);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('G', 't2__77c7c9', 'cou_c97447', 86.520366);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('A', 't2__d6b037', 'cou_c97447', 779.409124);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('O', 't2__77c7c9', 'cou_c97447', 882.963176);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('_', 't2__77c7c9', 'cou_c97447', 320.851235);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('t2__b959c6', 't2__d6b037', 'cou_c97447', 983.124993);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('E', 't2__a9f2ca', 'cou_c97447', 285.529132);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('@', '@', 'cou_c97447', 833.684115);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('`', 'D', 'cou_c97447', 486.033807);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('a', 'a', 'cou_c97447', 38.668834);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('!', '!', 'cou_c97447', 868.436572);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('"', '"', 'cou_c97447', 935.695299);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('D', 'B', 'cou_c97447', 906.21648);

INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('B', 'E', 'cou_c97447', 134.487977);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, school_code FROM (SELECT LHS.crs_code AS crs_code, LHS.dept_code AS dept_code, LHS.crs_description AS crs_description, LHS.crs_credit AS crs_credit, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, RHS.class_code AS class_code, RHS.class_section AS class_section, RHS.class_time AS class_time, RHS.class_room AS class_room, RHS.prof_num AS prof_num, RHS.n AS n FROM (SELECT LHS.crs_code AS crs_code, LHS.dept_code AS dept_code, LHS.crs_description AS crs_description, LHS.crs_credit AS crs_credit, RHS.dept_name AS dept_name, RHS.school_code AS school_code, RHS.emp_num AS emp_num, RHS.dept_address AS dept_address, RHS.dept_extension AS dept_extension FROM course AS LHS INNER JOIN department AS RHS ON (LHS.dept_code = RHS.dept_code)) AS LHS INNER JOIN (SELECT class_code, crs_code, class_section, class_time, class_room, prof_num, COUNT(*) OVER () AS n FROM class) AS RHS ON (LHS.crs_code = RHS.crs_code)) ORDER BY count___, school_code NULLS LAST;

/*
Gold Result:
(25, 'd_d58d0d')
(25, 't3__ae0287')
*/

-- Prediction Query
SELECT COUNT(*), T3.school_code FROM CLASS AS T1 JOIN course AS T2 ON T1.crs_code = T2.crs_code JOIN department AS T3 ON T2.dept_code = T3.dept_code GROUP BY T3.school_code;

/*
Prediction Result:
(15, 'd_d58d0d')
(10, 't3__ae0287')
*/