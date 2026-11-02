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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1001, 'Clinical research associate', 'Megan Mcclain', 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1004.0, 'Agricultural consultant', 'Megan Mcclain', 1007);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1007.0, 'Haematologist', 'Megan Mcclain', 1008);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1010.0, 'Financial risk analyst', 'Megan Mcclain', 1009);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1013.0, 'Environmental health practitioner', 'Megan Mcclain', 1010);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1016.0, 'Corporate treasurer', 'Megan Mcclain', 1011);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Megan Mcclain', 1012, 1013);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('Megan Mcclain', 5047)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/