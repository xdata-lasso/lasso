-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" TEXT(255), "dept_name" TEXT(255), "credits" INTEGER);

CREATE TABLE "department" ("dept_name" TEXT(255), "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" TEXT(255), "salary" INTEGER, "dept_name" TEXT(255));

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" TEXT(255), "dept_name" TEXT(255), "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1154, 'Surveyor, mining', 'Kevin Hurst', 1156);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1157.0, 'Solicitor', 'Kevin Hurst', 1165.0);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1175, 'Pharmacist, hospital', 'Mark Conner', 1177);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1178.0, 'Therapist, occupational', 'Mark Conner', 1186.0);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1179.0, 'Therapist, occupational', 'Mark Conner', 1186.0);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Kevin Hurst', 1158, 1160);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Kevin Hurst', 1163.0, 1167.0);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Mark Conner', 1179, 1181);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Mark Conner', 1184.0, 1188.0);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1154, 1162, 1164, 1158, 1166, 1168);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1157.0, 1167.0, 1171.0, 1163.0, 1177.0, 1181.0);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1175, 1183, 1185, 1179, 1187, 1189);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (1178.0, 1188.0, 1192.0, 1184.0, 1198.0, 1202.0);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1170, 'Daniel Bright', 'Kevin Hurst', 1171);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1170, 'Ann Williams', 'Kevin Hurst', 1180.0);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1170, 'James Ferrell', 'Mark Conner', 1191);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (1170, 'Tricia Valencia', 'Mark Conner', 1200.0);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1170, 1154, 1162, 1164, 1173);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1170, 1157.0, 1167.0, 1171.0, 1184.0);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1170, 1175, 1183, 1185, 1193);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (1170, 1178.0, 1188.0, 1192.0, 1204.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID, STUDENT.DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
(1170,)
(1170,)
*/

-- Prediction Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(1170,)
*/