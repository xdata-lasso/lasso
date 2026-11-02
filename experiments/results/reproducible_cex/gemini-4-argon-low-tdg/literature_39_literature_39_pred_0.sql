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
-- Tests basic positive case, COUNT(DISTINCT salary) vs COUNT(salary), AVG(salary) vs AVG(DISTINCT salary), and HAVING boundaries (AVG = 50000, COUNT < 4, COUNT > 4).
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 1, 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 2, 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Physics', 3, 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Biology', 4, 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'Intro CS', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'Calculus', 'Math', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 'Mechanics', 'Physics', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (401, 'Genetics', 'Biology', 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 'Alice', 40000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 'Bob', 50000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 'Charlie', 60000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 'David', 70000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (5, 'Eve', 70000, 'CS');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (6, 'Frank', 35000, 'Math');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (7, 'Grace', 45000, 'Math');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (8, 'Heidi', 55000, 'Math');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (9, 'Ivan', 65000, 'Math');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (10, 'Judy', 60000, 'Physics');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (11, 'Karl', 70000, 'Physics');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (12, 'Leo', 80000, 'Physics');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (13, 'Mallory', 80000, 'Physics');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (14, 'Nina', 51000, 'Biology');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (15, 'Oscar', 52000, 'Biology');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (16, 'Peggy', 53000, 'Biology');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (17, 'Quentin', 54000, 'Biology');
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (18, 'Rupert', 55000, 'Biology');
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (1, 101, 1, 2023, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (6, 201, 1, 2023, 6);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (10, 301, 1, 2023, 10);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (14, 401, 1, 2023, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) = 4;

/*
Gold Result:
('CS', 58000.0)
*/

-- Prediction Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) > 4;

/*
Prediction Result:
('Biology', 53000.0)
*/