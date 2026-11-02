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
-- DATASET 2
-- Tests:
-- 1. Course with NULL dept_name (in SQL, NULL <> 'Statistics' is UNKNOWN/false, so NOT EXISTS succeeds and student is included; catches mutants using WHERE course.dept_name = 'Statistics').
-- 2. Two different students with the exact same name (tests DISTINCT vs ALL).
-- 3. Case sensitivity / boundary values on 'Statistics'.
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Statistics', 'B1', 50000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Math', 'B2', 60000);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('B1', 'R1', 30);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('B2', 'R2', 40);
-- Course with NULL dept_name
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('C_NULL', NULL, 'Mystery Course', 3);
-- Course with 'Math' dept_name
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('C_MATH', 'Math', 'Calculus', 4);
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('C_NULL', 'S1', 'Fall', 2020, 'B1', 'R1', 'T1');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('C_MATH', 'S2', 'Spring', 2021, 'B2', 'R2', 'T2');
-- S1: Takes course with NULL dept_name
INSERT INTO "student" ("ID", "dept_name", "name", "tot_cred") VALUES ('S1', 'Math', 'Zack', 3);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "semester", "year", "grade") VALUES ('S1', 'C_NULL', 'S1', 'Fall', 2020, 'A');
-- S2 & S3: Two distinct students with the same name 'Aaron' taking no courses
INSERT INTO "student" ("ID", "dept_name", "name", "tot_cred") VALUES ('S2', 'Statistics', 'Aaron', 10);
INSERT INTO "student" ("ID", "dept_name", "name", "tot_cred") VALUES ('S3', 'Math', 'Aaron', 20);
-- S4: Takes Math course, has NULL dept_name in student table
INSERT INTO "student" ("ID", "dept_name", "name", "tot_cred") VALUES ('S4', NULL, 'BlockedStudent', 4);
INSERT INTO "takes" ("ID", "course_id", "sec_id", "semester", "year", "grade") VALUES ('S4', 'C_MATH', 'S2', 'Spring', 2021, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."dept_name" AS "dept_name", "LHS"."tot_cred" AS "tot_cred", "RHS"."course_id" AS "course_id", "RHS"."sec_id" AS "sec_id", "RHS"."semester" AS "semester", "RHS"."year" AS "year", "RHS"."grade" AS "grade" FROM "student" AS "LHS" LEFT JOIN "takes" AS "RHS" ON ("LHS"."id" = "RHS"."id")) AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "course" WHERE ("dept_name" <> 'Statistics')) AS RHS WHERE (LHS.course_id = RHS.course_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Aaron',)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT T3.name FROM course AS T1 JOIN takes AS T2 ON T1.course_id = T2.course_id JOIN student AS T3 ON T2.id = T3.id WHERE T1.dept_name = 'Statistics';

/*
Prediction Result:
*/