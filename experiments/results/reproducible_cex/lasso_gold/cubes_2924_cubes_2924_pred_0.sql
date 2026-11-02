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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1072, 'Young', 'Matthew', 'walk', 'Sound technician, broadcasting/film/video', '1971-09-08', '1972-10-09');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1080, 'Lewis', 'Mark', 'sort', 'Museum education officer', '1974-01-11', '1975-02-12');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('be', 1072, 'David Benson', 'seat', '5876 Jamie Manor Suite 909
Woodsstad, ME 99260', 'in');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('fall', 1080, 'Sandra King', 'beat', '3100 James Brooks
East David, TN 15494', 'organization');
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('tonight', 'be', 'Mrs same son today major event.', 1073.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('yourself', 'fall', 'Let eight hard paper white.', 1081.5);
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1074, 'be', 'Tucker', 'Paul', 'relate', '1973-11-10', 1075, 'respond', 1076.5, 1077.5, '(427)929-8069x9016', 1078);
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (1082, 'fall', 'Higgins', 'Kimberly', 'common', '1976-03-13', 1083, 'foreign', 1084.5, 1085.5, '590-349-6631', 1086);
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('court', 1072, 'tonight', 'apply', 'ever', 'hundred');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('same', 1080, 'yourself', 'spring', 'fish', 'to');
INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1074, 'court', 'C');
INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1074, 'court', 'A');
INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1082, 'same', 'C');
INSERT INTO "enroll" ("stu_num", "class_code", "enroll_grade") VALUES (1082, 'same', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "stu_fname", "stu_lname" FROM (SELECT "LHS"."class_code" AS "class_code", "LHS"."stu_num" AS "stu_num", "LHS"."enroll_grade" AS "enroll_grade", "RHS"."stu_lname" AS "stu_lname", "RHS"."stu_fname" AS "stu_fname", "RHS"."stu_init" AS "stu_init", "RHS"."stu_dob" AS "stu_dob", "RHS"."stu_hrs" AS "stu_hrs", "RHS"."stu_class" AS "stu_class", "RHS"."stu_gpa" AS "stu_gpa", "RHS"."stu_transfer" AS "stu_transfer", "RHS"."dept_code" AS "dept_code", "RHS"."stu_phone" AS "stu_phone", "RHS"."prof_num" AS "prof_num" FROM "enroll" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stu_num" = "RHS"."stu_num")) WHERE ("enroll_grade" = 'C' OR "enroll_grade" = 'A') ORDER BY stu_fname, "stu_fname" NULLS LAST, "stu_lname" NULLS LAST;

/*
Gold Result:
('Kimberly', 'Higgins')
('Kimberly', 'Higgins')
('Paul', 'Tucker')
('Paul', 'Tucker')
*/

-- Prediction Query
SELECT T1.stu_fname, T1.stu_lname FROM student AS T1 JOIN enroll AS T2 ON T1.stu_num = T2.stu_num WHERE T2.enroll_grade = 'C' OR T2.enroll_grade = 'A';

/*
Prediction Result:
('Paul', 'Tucker')
('Paul', 'Tucker')
('Kimberly', 'Higgins')
('Kimberly', 'Higgins')
*/