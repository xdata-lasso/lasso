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
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('rhs_6b5d41', 'sec_id_1', 'seme_1', 1.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_2', 'rhs_f46a94', 'seme_2', 2.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_3', 'sec_id_3', 'rhs_ee12ef', 3.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('rhs_ffb7a2', 'sec_id_4', 'seme_4', 4.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_5', 'rhs_0f60e7', 'seme_5', 5.0, 'building_1', 'room__1', 'value');

INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('course_6', 'sec_id_6', 'rhs_e0ff81', 6.0, 'building_1', 'room__1', 'value');

-- Inserting into table: department --
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('lhs_4030ea', 'dep_f0958c', 0.01);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('lhs_f6dd94', 'dep_f0958c', 0.02);

-- Inserting into table: course --
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('rhs_6b5d41', 'lhs_4030ea', 'value', 1.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_2', 'lhs_4030ea', 'cou_aa4396', 2.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_3', 'lhs_4030ea', 'cou_aa4396', 3.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('rhs_ffb7a2', 'lhs_4030ea', 'value', 1.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_5', 'lhs_f6dd94', 'cou_aa4396', 5.0);

INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('course_6', 'lhs_f6dd94', 'cou_aa4396', 6.0);

-- Inserting into table: classroom --
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('building_1', 'room__1', 1.0);

-- Inserting into table: student --
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('lhs_11a726', 'lhs_4030ea', 'lhs_8135a8', 1.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('lhs_aa7381', 'lhs_f6dd94', 'lhs_40dd5d', 1.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('C', 'lhs_4030ea', 'lhs_8135a8', 1.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('A', 'lhs_f6dd94', 'stu_c80b56', 4.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('Q', 'lhs_4030ea', 'stu_c80b56', 5.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('O', 'lhs_4030ea', 'stu_c80b56', 6.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('rhs_20ea25', 'lhs_4030ea', 'lhs_8135a8', 1.0);

-- Inserting into table: takes --
INSERT INTO "takes" ("id", "course_id", "sec_id", "semester", "year", "grade") VALUES ('lhs_11a726', 'rhs_6b5d41', 'rhs_f46a94', 'rhs_ee12ef', 1.0, 'rhs_6c7aed');

INSERT INTO "takes" ("id", "course_id", "sec_id", "semester", "year", "grade") VALUES ('lhs_11a726', 'rhs_ffb7a2', 'rhs_0f60e7', 'rhs_e0ff81', 1.0, 'rhs_9581ff');

INSERT INTO "takes" ("id", "course_id", "sec_id", "semester", "year", "grade") VALUES ('A', 'rhs_6b5d41', 'rhs_f46a94', 'rhs_ee12ef', 1.0, 'rhs_6c7aed');

INSERT INTO "takes" ("id", "course_id", "sec_id", "semester", "year", "grade") VALUES ('Q', 'rhs_6b5d41', 'rhs_f46a94', 'rhs_ee12ef', 1.0, 'rhs_6c7aed');

INSERT INTO "takes" ("id", "course_id", "sec_id", "semester", "year", "grade") VALUES ('O', 'rhs_6b5d41', 'rhs_f46a94', 'rhs_ee12ef', 1.0, 'rhs_6c7aed');

INSERT INTO "takes" ("id", "course_id", "sec_id", "semester", "year", "grade") VALUES ('rhs_20ea25', 'rhs_6b5d41', 'rhs_f46a94', 'rhs_ee12ef', 1.0, 'rhs_6c7aed');

INSERT INTO "takes" ("id", "course_id", "sec_id", "semester", "year", "grade") VALUES ('rhs_20ea25', 'rhs_ffb7a2', 'rhs_0f60e7', 'rhs_e0ff81', 1.0, 'rhs_9581ff');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."dept_name" AS "dept_name", "LHS"."tot_cred" AS "tot_cred", "RHS"."course_id" AS "course_id", "RHS"."sec_id" AS "sec_id", "RHS"."semester" AS "semester", "RHS"."year" AS "year", "RHS"."grade" AS "grade" FROM "student" AS "LHS" LEFT JOIN "takes" AS "RHS" ON ("LHS"."id" = "RHS"."id")) AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "course" WHERE ("dept_name" <> 'Statistics')) AS RHS WHERE (LHS.course_id = RHS.course_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('lhs_40dd5d',)
('lhs_8135a8',)
*/

-- Prediction Query
SELECT T3.name FROM course AS T1 JOIN takes AS T2 ON T1.course_id = T2.course_id JOIN student AS T3 ON T2.id = T3.id WHERE T1.dept_name = 'Statistics';

/*
Prediction Result:
*/