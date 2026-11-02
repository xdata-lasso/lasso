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
-- 1. Boundary conditions for HAVING COUNT(ID) > 4 (groups with count = 4 vs count = 5).
-- 2. Outer SUM(T) aggregation where multiple courses in the same year (2020) satisfy HAVING (> 4), producing 4040 instead of 2020.
-- 3. GROUP BY YEAR, COURSE_ID vs GROUP BY YEAR or GROUP BY COURSE_ID alone.
-- 4. Outer GROUP BY T separating different years (2020 vs 2021).
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 1, 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'Intro CS', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'Data Structures', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'Algorithms', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'OS', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 'Compilers', 'CS', 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 'Inst1', 80000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 'Inst2', 80000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 'Inst3', 80000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 'Inst4', 80000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (5, 'Inst5', 80000, 'CS');
-- Year 2020, Course 101: 5 distinct instructors (Count = 5 > 4 -> Included)
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2020, 1, 10, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 1, 2020, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 101, 1, 2020, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 101, 1, 2020, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 101, 1, 2020, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 101, 1, 2020, 5);
-- Year 2020, Course 102: 5 distinct instructors (Count = 5 > 4 -> Included, makes SUM(T) for 2020 = 4040)
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 1, 2020, 1, 10, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 102, 1, 2020, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 102, 1, 2020, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 102, 1, 2020, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 102, 1, 2020, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 102, 1, 2020, 5);
-- Year 2020, Course 103: 4 distinct instructors (Boundary Count = 4 -> Excluded)
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (103, 1, 2020, 1, 10, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 103, 1, 2020, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 103, 1, 2020, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 103, 1, 2020, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 103, 1, 2020, 4);
-- Year 2021, Course 104: 5 distinct instructors (Count = 5 > 4 -> Included, SUM(T) for 2021 = 2021)
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (104, 1, 2021, 1, 10, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 104, 1, 2021, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 104, 1, 2021, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 104, 1, 2021, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (4, 104, 1, 2021, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (5, 104, 1, 2021, 5);
-- Course 105 across Year 2022 (3 rows) and Year 2023 (3 rows):
-- Total for Course 105 is 6 (> 4), but per (YEAR, COURSE_ID) is 3 (<= 4 -> Excluded)
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (105, 1, 2022, 1, 10, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 105, 1, 2022, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 105, 1, 2022, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 105, 1, 2022, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (105, 1, 2023, 1, 10, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 105, 1, 2023, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 105, 1, 2023, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 105, 1, 2023, 3);
-- Year 2024 across Course 101 (3 rows) and Course 102 (3 rows):
-- Total for Year 2024 is 6 (> 4), but per (YEAR, COURSE_ID) is 3 (<= 4 -> Excluded)
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2024, 1, 10, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 1, 2024, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 101, 1, 2024, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 101, 1, 2024, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 1, 2024, 1, 10, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 102, 1, 2024, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (2, 102, 1, 2024, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (3, 102, 1, 2024, 3);
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
(2024,)
*/