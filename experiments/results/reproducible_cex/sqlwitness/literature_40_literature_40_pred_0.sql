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
INSERT INTO student (id, name, dept_name, tot_cred) VALUES (2, 'default2', 'default1', 2), (3, NULL, NULL, 3), (0, 'default1', NULL, 1), (0, 'default2', 'default2', NULL), (NULL, 'default1', NULL, 3), (2, 'default2', 'default2', 0), (2, 'default1', NULL, NULL), (1, 'default2', 'default2', 1);
INSERT INTO takes (id, course_id, sec_id, year, grade) VALUES (1, 0, 2, 2, 2), (1, 3, 3, 0, 3), (2, 3, 1, 3, NULL), (1, 3, 2, 3, NULL), (1, NULL, 2, 1, 2), (0, 0, 3, 0, NULL), (3, 1, 3, 3, NULL), (3, 3, 3, 1, 1), (NULL, 1, 1, NULL, 1), (2, 2, 3, 1, 0), (0, 1, 3, 2, 1), (NULL, NULL, 2, NULL, 2), (0, 2, NULL, 2, 0), (NULL, 2, 1, 2, 2), (2, 2, NULL, 3, 0), (0, 3, NULL, NULL, 3), (NULL, 0, 0, 2, 2), (1, 1, 1, NULL, NULL), (1, 1, 2, NULL, 2), (1, NULL, 2, 1, 0), (2, 1, NULL, 0, 0);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (2, 0, 2, 3, 1, 2), (NULL, 2, 2, 2, 3, 2), (0, NULL, 3, NULL, 1, NULL), (NULL, 2, 2, 2, 3, 3), (NULL, NULL, 3, NULL, 3, 2), (1, 3, 0, NULL, 0, 1), (3, 1, 3, 1, 3, 2), (3, 2, 2, 2, 0, 3), (1, 2, 2, 3, 3, 1), (1, NULL, 2, 1, NULL, 3), (0, 3, 2, 1, 2, NULL), (3, NULL, 1, 3, 3, NULL);
INSERT INTO department (dept_name, building, budget) VALUES ('default1', 2, 2), (NULL, 1, 2), (NULL, 1, 1), ('default2', 2, 2), ('default2', 3, 2), ('default1', 2, 1), (NULL, 3, NULL), (NULL, 3, 3), ('default1', 1, 1), ('default2', NULL, 2), ('default2', 1, NULL), ('default1', 1, 0), ('default2', 3, 3), ('default1', 0, 3), ('default1', 3, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (3, 'default2', 'default2', 3), (NULL, NULL, 'default2', NULL), (3, NULL, 'default2', 3), (3, 'default1', 'default1', NULL), (0, 'default2', 'default2', NULL), (3, 'default2', NULL, NULL), (0, 'default1', 'default2', 2), (3, 'default1', 'default2', 3), (2, 'default2', 'default2', 3), (2, NULL, 'default1', NULL), (1, 'default1', NULL, NULL), (2, 'default1', 'default1', 0), (NULL, 'default1', 'default2', 3), (3, 'default1', 'default1', 3), (1, NULL, 'default1', 2), (3, 'default2', 'default1', 0), (3, 'default2', 'default1', 1), (3, 'default2', 'default2', 2), (2, 'default1', 'default2', NULL), (NULL, 'default1', NULL, NULL), (2, 'default2', 'default1', 0), (2, 'default2', 'default1', 0), (3, NULL, 'default1', 3), (3, 'default1', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID, STUDENT.DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
(2,)
(2,)
*/

-- Prediction Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(2,)
*/