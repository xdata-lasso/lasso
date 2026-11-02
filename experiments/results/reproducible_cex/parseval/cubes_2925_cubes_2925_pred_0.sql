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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: class --
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('cla_8a1e4e', 1, 'cla_dd40ed', 'cla_ab8be4', 'cla_073c7f', 'cla_960301');

-- Inserting into table: course --
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('cla_dd40ed', 'dept_cod_1', 'cou_c97447', 165.344793);

-- Inserting into table: student --
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483648, 'dept_cod_1', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-12-08 21:38:59+00:00', 1258409369, 'f6', 38.668834, 292.730571, '4099', 1610062532);

-- Inserting into table: enroll --
INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (-2147483648, 'cla_8a1e4e', 'value');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (-2147483648, 'cla_8a1e4e', 'value');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (-2147483648, 'cla_8a1e4e', 'value');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (-2147483648, 'cla_8a1e4e', 'value');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (-2147483648, 'cla_8a1e4e', 'value');

INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (-2147483648, 'cla_8a1e4e', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS "count___" FROM (SELECT * FROM (SELECT * FROM "class" WHERE ("crs_code" <> 'ACCT-211')) AS LHS WHERE EXISTS(SELECT 1 FROM enroll AS RHS WHERE (LHS.class_code = RHS.class_code))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM CLASS AS T1 JOIN enroll AS T2 ON T1.class_code = T2.class_code WHERE T1.crs_code = 'ACCT-211';

/*
Prediction Result:
(0,)
*/