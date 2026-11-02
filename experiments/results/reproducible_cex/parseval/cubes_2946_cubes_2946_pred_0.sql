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
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('t1__a3674a', -2147483648, 't2__a9704f', 'd_d58d0d', 't2__d8c60c', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('dept_cod_2', -2147483648, 't2__a9704f', 'd_d58d0d', 't2__d8c60c', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('O', -2147483648, 't2__a9704f', 'd_d58d0d', 't2__d8c60c', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('A', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('G', -2147483648, 't2__a9704f', 'd_d58d0d', 't2__d8c60c', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('t2__1e2618', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('@', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('B', -2147483648, 'dep_974eac', 'd_d58d0d', 'dep_3cd133', '76e4');

-- Inserting into table: employee --
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (-2147483648, 'emp_103a39', 'emp_d05cb6', 'b', 'c52b7', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00');

-- Inserting into table: student --
INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483648, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2024-02-19 01:18:26+00:00', -921145356, 'f6', 357.862717, 792.996259, '4099', -1981402255);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483647, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-06-28 11:34:24+00:00', 247012447, 'f6', 868.436572, 537.136345, '4099', -1980249628);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483646, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-02-14 19:27:39+00:00', 1871297066, 'f6', 688.4027, 520.784135, '4099', -1865039888);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483645, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-01-15 18:18:33+00:00', 1268590800, 'f6', 378.476082, 783.93201, '4099', -1670923962);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483644, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-08-22 00:34:24+00:00', -1349201381, 'f6', 737.440743, 334.878198, '4099', -1910425938);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483643, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-07-30 13:34:14+00:00', -841692980, 'f6', 182.319045, 998.421621, '4099', -1257178728);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (2, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-12-31 07:20:26+00:00', 2026480202, 'f6', 133.007885, 75.403642, '4099', -1209887326);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (3, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2024-05-04 23:07:19+00:00', -1399556171, 'f6', 741.842896, 587.783596, '4099', 1419861592);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483642, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-08-21 21:00:40+00:00', -1964997180, 'f6', 734.586266, 767.720387, '4099', -1833165707);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483639, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-08-19 01:10:02+00:00', 283598170, 'f6', 452.706544, 672.826911, '4099', -747753377);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483638, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-10-19 18:29:54+00:00', -967741825, 'f6', 680.514642, 586.906897, '4099', -472966518);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483637, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-02-25 10:33:58+00:00', 2107872094, 'f6', 705.580387, 673.065986, '4099', -1822992503);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483636, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-02-19 15:51:21+00:00', -2118135981, 'f6', 982.938576, 274.580687, '4099', 274769912);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483635, 'O', 'stu_c368ab', 'stu_13d6e2', 'c', '2023-11-18 08:10:54+00:00', -1666765085, 'f6', 731.301441, 691.846832, '4099', 1178636309);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483634, 'O', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-07-01 18:29:24+00:00', -305670381, 'f6', 144.777217, 598.409165, '4099', -453362185);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483633, 'A', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-08-31 15:38:50+00:00', 1909986641, 'f6', 845.831524, 721.918386, '4099', -511185946);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483632, 'G', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-01-29 19:28:25+00:00', -533293970, 'f6', 520.715697, 541.066766, '4099', -977635379);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483631, 'G', 'stu_c368ab', 'stu_13d6e2', 'c', '2021-03-27 18:00:10+00:00', -904834265, 'f6', 419.361606, 470.165282, '4099', 1692174491);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483630, 'A', 'stu_c368ab', 'stu_13d6e2', 'c', '2024-03-18 20:04:07+00:00', 1255852738, 'f6', 137.842122, 272.94048, '4099', -705985602);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483629, 'G', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-12-09 03:18:27+00:00', 1836127587, 'f6', 410.133844, 88.474525, '4099', -1529584866);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483628, 'G', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-10-30 07:33:08+00:00', 910894705, 'f6', 452.27611, 434.003102, '4099', 233994589);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483627, 'A', 'stu_c368ab', 'stu_13d6e2', 'c', '2023-02-15 11:45:56+00:00', -1492524358, 'f6', 124.573829, 22.63964, '4099', -736979194);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483626, 'G', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-12-04 21:49:29+00:00', -1264842910, 'f6', 893.16532, 254.83756, '4099', -1245682094);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483625, 'G', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-04-10 05:04:30+00:00', 555413010, 'f6', 668.309685, 635.267184, '4099', -1245312912);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483624, 'A', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-01-23 03:13:33+00:00', -988981234, 'f6', 304.188492, 415.830002, '4099', 401805964);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483623, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-10-05 05:32:26+00:00', -1056308489, 'f6', 406.816852, 108.525871, '4099', -1454058168);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483622, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2023-05-15 04:44:08+00:00', 1686459626, 'f6', 138.057338, 728.712934, '4099', 638024588);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483621, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2025-11-22 09:05:23+00:00', 32204797, 'f6', 34.258887, 161.889639, '4099', -1672720816);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483620, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-12-13 04:17:12+00:00', -639539893, 'f6', 260.513699, 969.559316, '4099', 1255343543);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483619, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-03-06 15:32:29+00:00', 602161869, 'f6', 814.417862, 987.646344, '4099', -961217731);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (-2147483618, 't1__a3674a', 'stu_c368ab', 'stu_13d6e2', 'c', '2020-09-26 17:28:32+00:00', 1427161052, 'f6', 276.61064, 399.319982, '4099', 564390026);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (4, '@', 'stu_c368ab', 'stu_13d6e2', 'c', '2024-02-19 01:18:26+00:00', -921145356, 'f6', 357.862717, 792.996259, '4099', -1981402255);

INSERT INTO "student" ("stu_num", "dept_code", "stu_lname", "stu_fname", "stu_init", "stu_dob", "stu_hrs", "stu_class", "stu_gpa", "stu_transfer", "stu_phone", "prof_num") VALUES (5, '@', 'stu_c368ab', 'stu_13d6e2', 'c', '2022-06-28 11:34:24+00:00', 247012447, 'f6', 868.436572, 537.136345, '4099', -1980249628);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT dept_name, dept_address, n AS count___ FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, LHS.stu_num AS stu_num, LHS.stu_lname AS stu_lname, LHS.stu_fname AS stu_fname, LHS.stu_init AS stu_init, LHS.stu_dob AS stu_dob, LHS.stu_hrs AS stu_hrs, LHS.stu_class AS stu_class, LHS.stu_gpa AS stu_gpa, LHS.stu_transfer AS stu_transfer, LHS.stu_phone AS stu_phone, LHS.prof_num AS prof_num, RHS.n AS n FROM (SELECT LHS.dept_code AS dept_code, LHS.dept_name AS dept_name, LHS.school_code AS school_code, LHS.emp_num AS emp_num, LHS.dept_address AS dept_address, LHS.dept_extension AS dept_extension, RHS.stu_num AS stu_num, RHS.stu_lname AS stu_lname, RHS.stu_fname AS stu_fname, RHS.stu_init AS stu_init, RHS.stu_dob AS stu_dob, RHS.stu_hrs AS stu_hrs, RHS.stu_class AS stu_class, RHS.stu_gpa AS stu_gpa, RHS.stu_transfer AS stu_transfer, RHS.stu_phone AS stu_phone, RHS.prof_num AS prof_num FROM department AS LHS INNER JOIN student AS RHS ON (LHS.dept_code = RHS.dept_code)) AS LHS INNER JOIN (SELECT dept_code, COUNT(*) AS n FROM student GROUP BY dept_code) AS RHS ON (LHS.dept_code = RHS.dept_code)) ORDER BY dept_name, dept_address NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('dep_974eac', 'dep_3cd133', 2)
('dep_974eac', 'dep_3cd133', 4)
('t2__a9704f', 't2__d8c60c', 2)
('t2__a9704f', 't2__d8c60c', 6)
('t2__a9704f', 't2__d8c60c', 19)
*/

-- Prediction Query
SELECT T2.dept_name, T2.dept_address, COUNT(*) FROM student AS T1 JOIN department AS T2 ON T1.dept_code = T2.dept_code GROUP BY T1.dept_code ORDER BY COUNT(*) DESC, T2.dept_name NULLS LAST, T2.dept_address NULLS LAST LIMIT 3;

/*
Prediction Result:
('t2__a9704f', 't2__d8c60c', 19)
('t2__a9704f', 't2__d8c60c', 6)
('dep_974eac', 'dep_3cd133', 4)
*/