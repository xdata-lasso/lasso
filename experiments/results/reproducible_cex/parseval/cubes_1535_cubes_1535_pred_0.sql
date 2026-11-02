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
-- Inserting into table: section --
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('tea_5cf700', 'sec_id_1', 'seme_1', 1.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_2', 'tea_b3b7fe', 'seme_2', 2.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_3', 'sec_id_3', 'tea_b73d3d', 3.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_4', 'sec_id_4', 'seme_4', 2010.0, 'building_1', 'room__1', 'aef7');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('tea_a8ee63', 'sec_id_5', 'seme_5', 5.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_6', 'tea_de4c04', 'seme_6', 6.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_7', 'sec_id_7', 'tea_4b2e1e', 7.0, 'building_1', 'room__1', 'value');

-- Inserting into table: department --
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('dept_name_1', 'dep_f0958c', 0.01);

-- Inserting into table: course --
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('tea_5cf700', 'dept_name_1', 'value', 1.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_2', 'dept_name_1', 'cou_aa4396', 2.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_3', 'dept_name_1', 'cou_aa4396', 3.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_4', 'dept_name_1', 'cou_aa4396', 4.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('tea_a8ee63', 'dept_name_1', 'value', 1.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_6', 'dept_name_1', 'cou_aa4396', 6.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_7', 'dept_name_1', 'cou_aa4396', 7.0);

-- Inserting into table: classroom --
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('building_1', 'room__1', 1.0);

-- Inserting into table: instructor --
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('tea_36ddd9', 'dept_name_1', 'value', 1.0);

INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('tea_cc41e3', 'dept_name_1', 'value', 1.0);

-- Inserting into table: teaches --
INSERT INTO "teaches" ("id", "course_id", "sec_id", "semester", "year") VALUES ('tea_36ddd9', 'tea_5cf700', 'tea_b3b7fe', 'tea_b73d3d', 2010.0);

INSERT INTO "teaches" ("id", "course_id", "sec_id", "semester", "year") VALUES ('tea_cc41e3', 'tea_a8ee63', 'tea_de4c04', 'tea_4b2e1e', 2010.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count__distinct_id_" FROM (SELECT COUNT(DISTINCT "id") AS "n_distinct" FROM (SELECT * FROM "teaches" WHERE ("semester" <> 'Spring' AND YEAR >= 2010.0))) ORDER BY count__distinct_id_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT ID) FROM teaches WHERE semester = 'Spring' AND YEAR = 2010;

/*
Prediction Result:
(0,)
*/