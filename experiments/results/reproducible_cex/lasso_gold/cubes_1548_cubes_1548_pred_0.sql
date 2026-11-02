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
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Statistics', 'majority', 1139.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Colleen Brock', 'region', 1146.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Julie Grant', 'nice', 1153.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Barbara Anderson', 'operation', 1160.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Kari Allen', 'during', 1154.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Micheal Young', 'identify', 1161.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Steven Miller', 'rule', 1168.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Elizabeth Price', 'discuss', 1162.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Sara Medina', 'explain', 1169.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Rebecca Hurst', 'least', 1176.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('physical', 'Statistics', 'Robert Mcclain', 1143.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('free', 'Statistics', 'Terry Griffin', 1143.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('someone', 'Statistics', 'Scott Cole', 1143.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('vote', 'Statistics', 'Sara Ramirez', 1143.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('claim', 'Statistics', 'Robert Mcclain', 1145.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('seat', 'Statistics', 'Ross Price', 1145.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('difficult', 'Statistics', 'Theresa Smith', 1145.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('attack', 'Statistics', 'Laura Woods', 1145.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('mention', 'Statistics', 'Catherine Green', 1144.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('air', 'Statistics', 'Tamara Hooper', 1144.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('improve', 'Statistics', 'Susan Vargas', 1144.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('great', 'Statistics', 'Angela Patterson', 1144.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "instructor" WHERE ("dept_name" = 'Statistics')) ORDER BY salary) LIMIT 1);

/*
Gold Result:
('Robert Mcclain',)
*/

-- Prediction Query
SELECT name FROM instructor WHERE dept_name = 'Statistics' ORDER BY salary, instructor.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Terry Griffin',)
*/