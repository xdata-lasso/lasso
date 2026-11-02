-- Schema DDL
CREATE TABLE "classroom" ("building" TEXT(15) UNIQUE, "room_number" TEXT(7) UNIQUE, "capacity" REAL(4, 0), PRIMARY KEY ("building", "room_number"));

CREATE TABLE "department" ("dept_name" TEXT(20) PRIMARY KEY, "building" TEXT(15), "budget" REAL(12, 2));

CREATE TABLE "course" ("course_id" TEXT(8) PRIMARY KEY, "dept_name" TEXT(20), "title" TEXT(50), "credits" REAL(2, 0), FOREIGN KEY ("dept_name") REFERENCES "department" ("dept_name"));

CREATE TABLE "instructor" ("ID" TEXT(5) PRIMARY KEY, "dept_name" TEXT(20), "name" TEXT(20), "salary" REAL(8, 2), FOREIGN KEY ("dept_name") REFERENCES "department" ("dept_name"));

CREATE TABLE "section" ("course_id" TEXT(8) UNIQUE, "sec_id" TEXT(8) UNIQUE, "semester" TEXT(6) UNIQUE, "year" REAL(4, 0) UNIQUE, "building" TEXT(15), "room_number" TEXT(7), "time_slot_id" TEXT(4), PRIMARY KEY ("course_id", "sec_id", "semester", "year"), FOREIGN KEY ("building") REFERENCES "classroom" ("building"), FOREIGN KEY ("room_number") REFERENCES "classroom" ("room_number"), FOREIGN KEY ("course_id") REFERENCES "course" ("course_id"));

CREATE TABLE "teaches" ("ID" TEXT(5), "course_id" TEXT(8), "sec_id" TEXT(8), "semester" TEXT(6), "year" REAL(4, 0), PRIMARY KEY ("ID", "course_id", "sec_id", "semester", "year"), FOREIGN KEY ("ID") REFERENCES "instructor" ("ID"), FOREIGN KEY ("course_id") REFERENCES "section" ("course_id"), FOREIGN KEY ("sec_id") REFERENCES "section" ("sec_id"), FOREIGN KEY ("semester") REFERENCES "section" ("semester"), FOREIGN KEY ("year") REFERENCES "section" ("year"));

CREATE TABLE "student" ("ID" TEXT(5) PRIMARY KEY, "dept_name" TEXT(20), "name" TEXT(20), "tot_cred" REAL(3, 0), FOREIGN KEY ("dept_name") REFERENCES "department" ("dept_name"));

CREATE TABLE "takes" ("ID" TEXT(5), "course_id" TEXT(8), "sec_id" TEXT(8), "semester" TEXT(6), "year" REAL(4, 0), "grade" TEXT(2), PRIMARY KEY ("ID", "course_id", "sec_id", "semester", "year"), FOREIGN KEY ("ID") REFERENCES "student" ("ID"), FOREIGN KEY ("course_id") REFERENCES "section" ("course_id"), FOREIGN KEY ("sec_id") REFERENCES "section" ("sec_id"), FOREIGN KEY ("semester") REFERENCES "section" ("semester"), FOREIGN KEY ("year") REFERENCES "section" ("year"));

CREATE TABLE "advisor" ("s_ID" TEXT(5) PRIMARY KEY, "i_ID" TEXT(5), FOREIGN KEY ("s_ID") REFERENCES "student" ("ID"), FOREIGN KEY ("i_ID") REFERENCES "instructor" ("ID"));

CREATE TABLE "time_slot" ("time_slot_id" TEXT(4), "day" TEXT(1), "start_hr" REAL(2), "start_min" REAL(2), "end_hr" REAL(2), "end_min" REAL(2), PRIMARY KEY ("time_slot_id", "day", "start_hr", "start_min"));

CREATE TABLE "prereq" ("course_id" TEXT(8), "prereq_id" TEXT(8), PRIMARY KEY ("course_id", "prereq_id"), FOREIGN KEY ("prereq_id") REFERENCES "course" ("course_id"), FOREIGN KEY ("course_id") REFERENCES "course" ("course_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('CS', 'Taylor', 100000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Math', 'Watson', 80000);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('Taylor', '101', 50);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('Watson', '102', 40);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('Packard', '103', 30);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('CS101', 'CS', 'Intro to CS', 4);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('CS102', 'CS', 'Data Structures', 4);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('MATH101', 'Math', 'Calculus', 3);
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('CS101', '1', 'Spring', 2020, 'Taylor', '101', 'A');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('CS102', '2', 'Fall', 2021, 'Watson', '102', 'B');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('MATH101', '3', 'Summer', 2022, 'Packard', '103', 'C');
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('1', 'CS', 'Zebra', 90000);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('2', 'CS', 'Alice', 85000);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('3', 'Math', 'Bob', 75000);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('4', 'Math', 'Alice', 80000);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('5', 'CS', NULL, 70000);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('2', 'CS102', '2', 'Fall', 2021);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('2', 'MATH101', '3', 'Summer', 2022);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('3', 'CS101', '1', 'Spring', 2020);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('3', 'CS102', '2', 'Fall', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "instructor" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "teaches" WHERE ("semester" = 'Spring')) AS RHS WHERE (LHS.id = RHS.id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Zebra',)
*/

-- Prediction Query
SELECT name FROM instructor WHERE NOT id IN (SELECT id FROM teaches WHERE semester = 'Spring');

/*
Prediction Result:
('Zebra',)
('Alice',)
('Alice',)
(None,)
*/