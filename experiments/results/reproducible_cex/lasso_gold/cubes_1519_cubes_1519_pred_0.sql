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
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Lindsey Roman', 'sea', 1009.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Kimberly Dudley', 'available', 1016.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Juan Calderon', 'answer', 1023.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Shannon Ray', 'recently', 1030.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Danielle Ford', 'institution', 1017.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Timothy Watts', 'executive', 1024.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Frederick Tate', 'attorney', 1031.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Rodney Trujillo', 'development', 1038.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (NULL, 'image', 1025.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Zachary Taylor', 'I', 1032.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Peter Callahan Jr.', 'pick', 1039.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Michael Carlson', 'management', 1046.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('drive', 'Lindsey Roman', 'Sharon James', 1013.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('spring', 'Lindsey Roman', 'Roy Martin', 1022.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('figure', 'Lindsey Roman', 'Michael Miles', 1031.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('base', 'Lindsey Roman', 'Andrea Reid', 1040.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('white', NULL, 'Christy Porter', 1021.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('yes', NULL, 'Maria Thomas', 1030.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('our', NULL, 'Patrick Ryan', 1039.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('under', NULL, 'Jessica Silva', 1048.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('newspaper', NULL, 'Melanie Wilson', 1029.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('enter', NULL, 'Nicole Mack', 1038.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('on', NULL, 'Edward Moore', 1047.5);
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('traditional', NULL, 'Nathan Cortez', 1056.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name FROM (SELECT * FROM (SELECT * FROM (SELECT dept_name, id, COUNT(*) AS n FROM student GROUP BY dept_name, id) ORDER BY id) LIMIT 1);

/*
Gold Result:
('Lindsey Roman',)
*/

-- Prediction Query
SELECT dept_name FROM student GROUP BY dept_name ORDER BY COUNT(*) DESC, dept_name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/