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
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Arts', 'BldgA', 80000.0);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('BldgA', '201', 45.0);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('BldgB', '202', 55.0);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('BldgC', '203', 35.0);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('BldgD', '204', 25.0);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('ART-101', 'Arts', 'Design', 3.0);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('MUS-301', 'Arts', 'Harmony', 4.0);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('ENG-201', 'Arts', 'Literature', 3.0);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('MAT-105', 'Arts', 'Algebra', 4.0);
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('ART-101', '1', 'Fall', 2009.0, 'BldgA', '201', 'TS1');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('MUS-301', '2', 'Spring', 2011.0, 'BldgB', '202', 'TS2');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('ENG-201', '3', 'Winter', 2010.0, 'BldgC', '203', 'TS3');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('MAT-105', '4', 'Summer', 2007.0, 'BldgD', '204', 'TS4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "course_id" FROM (SELECT * FROM "section" WHERE ("semester" = 'Fall' OR "year" >= 2010.0)) WHERE ("semester" = 'Spring' OR YEAR = 2009.0) ORDER BY course_id, "course_id" NULLS LAST;

/*
Gold Result:
('ART-101',)
('MUS-301',)
*/

-- Prediction Query
SELECT course_id FROM SECTION WHERE semester = 'Fall' AND YEAR = 2009 UNION SELECT course_id FROM SECTION WHERE semester = 'Spring' AND YEAR = 2010;

/*
Prediction Result:
('ART-101',)
*/