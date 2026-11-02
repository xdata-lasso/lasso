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
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1049, 'White', 'Travis', 'goal', 'Civil Service fast streamer', '1989-05-03', '1992-08-06');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1050, 'Richards', 'Christopher', 'full', 'Designer, multimedia', '1989-05-04', '1992-08-07');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1051, 'Walters', 'Michael', 'religious', 'Landscape architect', '1989-05-05', '1992-08-08');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1055, 'Williams', 'Lisa', 'tend', 'Research scientist (life sciences)', '1995-11-09', '1998-03-12');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1056, 'Garner', 'Paul', 'reach', 'Animator', '1995-11-10', '1998-03-13');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1057, 'Thornton', 'Elizabeth', 'civil', 'Computer games developer', '1995-11-11', '1998-03-14');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1061, 'Smith', 'Teresa', 'there', 'Historic buildings inspector/conservation officer', '1972-06-15', '1975-09-18');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1062, 'Grimes', 'Renee', 'well', 'Event organiser', '1972-06-16', '1975-09-19');
INSERT INTO "employee" ("emp_num", "emp_lname", "emp_fname", "emp_initial", "emp_jobcode", "emp_hiredate", "emp_dob") VALUES (1063, 'Osborne', 'Julie', 'weight', 'Training and development officer', '1972-06-17', '1975-09-20');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('its', 1049, 'Tony Cervantes', 'my', '0385 Garrett Trace Apt. 348
West Samuel, UT 64033', 'movie');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('rule', 1049, 'Jordan Edwards', 'thank', '248 Andrea Course
Port Robin, NH 15897', 'skin');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('mission', 1049, 'Wayne Powell', 'ability', '4846 Baird Gardens
Arnoldfurt, ID 79062', 'until');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('morning', 1055, 'Shelly Alexander', 'manager', '158 Finley Road Suite 809
East Crystalport, IN 98381', 'character');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('performance', 1055, 'Joyce Bowen', 'station', '172 Berger Cape
Lauraport, MI 49632', 'each');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('glass', 1055, 'Matthew Moore', 'evidence', '692 Gregory Ridge
Harveybury, NM 76936', 'main');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('suffer', 1061, 'Lisa Byrd', 'for', '214 Burgess Extensions Apt. 285
Mariaview, PW 63657', 'do');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('he', 1061, 'Mary Massey', 'story', 'Unit 4517 Box 1236
DPO AP 48443', 'raise');
INSERT INTO "department" ("dept_code", "emp_num", "dept_name", "school_code", "dept_address", "dept_extension") VALUES ('discuss', 1061, 'Stephanie Lucas', 'let', '48175 Richards View Suite 137
New Nicoleside, MD 80465', 'at');
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('century', 'its', 'Significant take future skin environment.', 1052.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('treat', 'its', 'Executive fear only.', 1061.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('available', 'its', 'Tend land machine forward several help usually.', 1070.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('pull', 'morning', 'Project together let explain national.', 1058.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('environmental', 'morning', 'Kid generation onto police.', 1067.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('machine', 'morning', 'Real lead few yourself table blood.', 1076.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('prove', 'suffer', 'Power bring animal also you.', 1064.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('than', 'suffer', 'Best thought career law.', 1073.5);
INSERT INTO "course" ("crs_code", "dept_code", "crs_description", "crs_credit") VALUES ('majority', 'suffer', 'Industry score choice increase between majority impact.', 1082.5);
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('true', 1049, 'century', 'edge', 'east', 'bit');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('current', 1049, 'century', 'owner', 'total', 'bit');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('save', 1049, 'century', 'identify', 'stand', 'bit');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('I', 1055, 'pull', 'find', 'themselves', 'bit');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('her', 1055, 'pull', 'scene', 'reason', 'bit');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('paper', 1055, 'pull', 'age', 'individual', 'bit');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('far', 1061, 'prove', 'hospital', 'light', 'item');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('alone', 1061, 'prove', 'director', 'eat', 'item');
INSERT INTO "class" ("class_code", "prof_num", "crs_code", "class_section", "class_time", "class_room") VALUES ('road', 1061, 'prove', 'life', 'top', 'item');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, class_room FROM (SELECT class_room, COUNT(*) AS n FROM class GROUP BY class_room) WHERE (n >= 2) ORDER BY count___, class_room NULLS LAST;

/*
Gold Result:
(3, 'item')
(6, 'bit')
*/

-- Prediction Query
SELECT COUNT(*), class_room FROM CLASS GROUP BY class_room HAVING COUNT(*) >= 2;

/*
Prediction Result:
(6, 'bit')
(3, 'item')
*/