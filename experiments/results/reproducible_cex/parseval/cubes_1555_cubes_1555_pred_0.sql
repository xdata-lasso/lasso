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
-- Inserting into table: department --
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('ins_2998b2', 'dep_f0958c', 0.01);

-- Inserting into table: instructor --
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('ins_aaeaad', 'ins_2998b2', 'ins_6fec44', 1.0);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('A', 'ins_2998b2', NULL, 0.02);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('@', 'ins_2998b2', 'ins_48f70c', 0.03);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('B', 'ins_2998b2', 'ins_48f70c', 0.04);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('"', 'ins_2998b2', 'ins_48f70c', 0.05);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('C', 'ins_2998b2', 'ins_48f70c', 0.06);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('_', 'ins_2998b2', 'ins_48f70c', 0.07);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('#', 'ins_2998b2', 'ins_48f70c', 0.08);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('G', 'ins_2998b2', 'ins_48f70c', 0.09);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name, dept_name, salary FROM instructor ORDER BY id;

/*
Gold Result:
('"', 'ins_48f70c', 'ins_2998b2', 0.05)
('#', 'ins_48f70c', 'ins_2998b2', 0.08)
('@', 'ins_48f70c', 'ins_2998b2', 0.03)
('A', None, 'ins_2998b2', 0.02)
('B', 'ins_48f70c', 'ins_2998b2', 0.04)
('C', 'ins_48f70c', 'ins_2998b2', 0.06)
('G', 'ins_48f70c', 'ins_2998b2', 0.09)
('_', 'ins_48f70c', 'ins_2998b2', 0.07)
('ins_aaeaad', 'ins_6fec44', 'ins_2998b2', 1.0)
*/

-- Prediction Query
SELECT * FROM instructor ORDER BY salary, instructor.id NULLS LAST;

/*
Prediction Result:
('A', 'ins_2998b2', None, 0.02)
('@', 'ins_2998b2', 'ins_48f70c', 0.03)
('B', 'ins_2998b2', 'ins_48f70c', 0.04)
('"', 'ins_2998b2', 'ins_48f70c', 0.05)
('C', 'ins_2998b2', 'ins_48f70c', 0.06)
('_', 'ins_2998b2', 'ins_48f70c', 0.07)
('#', 'ins_2998b2', 'ins_48f70c', 0.08)
('G', 'ins_2998b2', 'ins_48f70c', 0.09)
('ins_aaeaad', 'ins_2998b2', 'ins_6fec44', 1.0)
*/