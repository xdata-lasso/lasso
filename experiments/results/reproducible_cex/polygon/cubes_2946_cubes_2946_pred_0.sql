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
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('22', 28, '25', '27', '27', '27');
INSERT INTO "CLASS" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('21', 23, '25', '27', '27', '27');
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('24', '26', '27', 27);
INSERT INTO "COURSE" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('25', '27', '27', 27);
INSERT INTO "DEPARTMENT" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('26', 28, NULL, '37', NULL, '39');
INSERT INTO "DEPARTMENT" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('27', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (23, '27', '27', '27', '27', 27, 27);
INSERT INTO "EMPLOYEE" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (28, '27', '27', '27', '27', 27, 27);
INSERT INTO "ENROLL" ("stu_num", "class_code", "enroll_grade") VALUES (31, '22', '27');
INSERT INTO "ENROLL" ("stu_num", "class_code", "enroll_grade") VALUES (31, '21', '27');
INSERT INTO "PROFESSOR" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('27', 28, '27', '27', '27');
INSERT INTO "PROFESSOR" ("dept_code", "emp_num", "prof_office", "prof_extension", "prof_high_degree") VALUES ('27', 28, '27', '27', '27');
INSERT INTO "STUDENT" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (30, '27', '40', '41', '42', 43, 44, '45', 46, 47, '48', 49);
INSERT INTO "STUDENT" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (31, '26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT dept_name, dept_address, n AS count___ FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, LHS.stu_num AS stu_num, LHS.stu_lname AS stu_lname, LHS.stu_fname AS stu_fname, LHS.stu_init AS stu_init, LHS.stu_dob AS stu_dob, LHS.stu_hrs AS stu_hrs, LHS.stu_class AS stu_class, LHS.stu_gpa AS stu_gpa, LHS.stu_transfer AS stu_transfer, LHS.stu_phone AS stu_phone, LHS.prof_num AS prof_num, RHS.n AS n FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, RHS.stu_num AS stu_num, RHS.stu_lname AS stu_lname, RHS.stu_fname AS stu_fname, RHS.stu_init AS stu_init, RHS.stu_dob AS stu_dob, RHS.stu_hrs AS stu_hrs, RHS.stu_class AS stu_class, RHS.stu_gpa AS stu_gpa, RHS.stu_transfer AS stu_transfer, RHS.stu_phone AS stu_phone, RHS.prof_num AS prof_num FROM department AS LHS INNER JOIN student AS RHS ON (LHS.dept_code = RHS.dept_code)) AS LHS INNER JOIN (SELECT dept_code, COUNT(*) AS n FROM student GROUP BY dept_code) AS RHS ON (LHS.dept_code = RHS.dept_code)) ORDER BY dept_name, dept_address NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, None, 1)
*/

-- Prediction Query
SELECT T2.dept_name, T2.dept_address, COUNT(*) FROM student AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code GROUP BY T1.dept_code ORDER BY COUNT(*) DESC, T2.dept_name NULLS LAST, T2.dept_address NULLS LAST LIMIT 3;

/*
Prediction Result:
(None, None, 1)
(None, None, 1)
*/