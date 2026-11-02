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
-- DATASET 1
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 1, 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'Intro CS', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'Algorithms', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'Databases', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'Networks', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 'OS', 'CS', 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 'Alice', 80000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 'Bob', 85000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 'Charlie', 90000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 'David', 95000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (5, 'Eve', 75000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (6, 'Frank', 70000, 'CS');
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2010, 1, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 2, 2010, 1, 10, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 3, 2010, 1, 10, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 4, 2010, 1, 10, 4);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 5, 2010, 1, 10, 5);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 1, 2010, 1, 20, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 2, 2010, 1, 20, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 3, 2010, 1, 20, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 4, 2010, 1, 20, 4);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 5, 2010, 1, 20, 5);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 6, 2010, 1, 20, 6);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2020, 1, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 2, 2020, 1, 10, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 3, 2020, 1, 10, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 4, 2020, 1, 10, 4);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 5, 2020, 1, 10, 5);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (103, 1, 2020, 1, 30, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (103, 2, 2020, 1, 30, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (103, 3, 2020, 1, 30, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (103, 4, 2020, 1, 30, 4);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (104, 1, 2030, 1, 40, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (104, 2, 2030, 1, 40, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (104, 3, 2030, 1, 40, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (105, 1, 2030, 1, 50, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (105, 2, 2030, 1, 50, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (105, 3, 2030, 1, 50, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 1, 2010, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 2, 2010, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 3, 2010, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 101, 4, 2010, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 101, 5, 2010, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 102, 1, 2010, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 102, 2, 2010, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 102, 3, 2010, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 102, 4, 2010, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 102, 5, 2010, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (6, 102, 6, 2010, 6);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 1, 2020, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 101, 2, 2020, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 101, 3, 2020, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 101, 4, 2020, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 101, 5, 2020, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 103, 1, 2020, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 103, 2, 2020, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 103, 3, 2020, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 103, 4, 2020, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 104, 1, 2030, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 104, 2, 2030, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 104, 3, 2030, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 105, 1, 2030, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 105, 2, 2030, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (6, 105, 3, 2030, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR, COURSE_ID HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Gold Result:
(4020,)
(2020,)
*/

-- Prediction Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Prediction Result:
(2010,)
(2020,)
(2030,)
*/