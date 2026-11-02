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
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Lindsey Roman', 'blood', 1013.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Kimberly Dudley', 'husband', 1020.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Juan Calderon', 'fall', 1027.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Shannon Ray', 'long', 1034.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Amber Perez', 'prove', 1041.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Bobby Hall', 'they', 1048.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('James Mayo', 'who', 1025.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Kristin Cohen', 'question', 1032.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Patty Perez', 'low', 1039.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Ethan Adams', 'character', 1046.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Tommy Walter', 'evidence', 1053.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Matthew Foster', 'chair', 1060.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('his', 'Lindsey Roman', 'Geologist, engineering', 1019.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('commercial', 'Lindsey Roman', 'Building surveyor', 1028.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('hospital', 'Lindsey Roman', 'Transport planner', 1037.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('hear', 'Lindsey Roman', 'Dramatherapist', 1046.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('determine', 'Lindsey Roman', 'Social research officer, government', 1055.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('religious', 'Lindsey Roman', 'Financial risk analyst', 1064.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('employee', NULL, 'Television/film/video producer', 1031.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('size', NULL, 'Phytotherapist', 1040.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('option', NULL, 'Television production assistant', 1049.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('nothing', NULL, 'Oceanographer', 1058.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('everyone', NULL, 'Medical illustrator', 1067.5);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('skin', NULL, 'English as a foreign language teacher', 1076.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name FROM (SELECT * FROM (SELECT * FROM (SELECT dept_name, COUNT(*) AS n FROM course GROUP BY dept_name) ORDER BY n DESC) LIMIT 3);

/*
Gold Result:
(None,)
('Lindsey Roman',)
*/

-- Prediction Query
SELECT dept_name FROM course GROUP BY dept_name ORDER BY COUNT(*) DESC, dept_name NULLS LAST LIMIT 3;

/*
Prediction Result:
('Lindsey Roman',)
(None,)
*/