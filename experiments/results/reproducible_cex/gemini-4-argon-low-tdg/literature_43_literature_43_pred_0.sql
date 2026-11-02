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
-- Tests:
-- 1. HAVING boundary conditions: COUNT(ID) = 5 (passes > 4) vs COUNT(ID) = 4 (fails > 4, passes >= 4).
-- 2. Outer SUM(T) and GROUP BY T: Two courses in year 2020 pass the filter, so outer SUM(T) should be 4040 (kills MAX/MIN/AVG/COUNT or missing subquery).
-- 3. Multiple years passing (2020 and 2021) to test outer GROUP BY T vs no GROUP BY.
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 1, 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'Intro CS', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'Data Structures', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'Algorithms', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'OS', 'CS', 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 'Inst1', 60000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 'Inst2', 65000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 'Inst3', 70000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 'Inst4', 75000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (5, 'Inst5', 80000, 'CS');
-- Year 2020, Course 101: 5 instructors (COUNT = 5 > 4 -> Included)
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 1, 2020, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 101, 2, 2020, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 101, 3, 2020, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 101, 4, 2020, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 101, 5, 2020, 5);
-- Year 2020, Course 102: 5 instructors (COUNT = 5 > 4 -> Included)
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 102, 1, 2020, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 102, 2, 2020, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 102, 3, 2020, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 102, 4, 2020, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 102, 5, 2020, 5);
-- Year 2020, Course 103: 4 instructors (COUNT = 4, NOT > 4 -> Excluded)
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 103, 1, 2020, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 103, 2, 2020, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 103, 3, 2020, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 103, 4, 2020, 4);
-- Year 2021, Course 104: 5 instructors (COUNT = 5 > 4 -> Included)
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 104, 1, 2021, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 104, 2, 2021, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 104, 3, 2021, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 104, 4, 2021, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 104, 5, 2021, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR, COURSE_ID HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Gold Result:
(4040,)
(2021,)
*/

-- Prediction Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Prediction Result:
(2020,)
(2021,)
*/