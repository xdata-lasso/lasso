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
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Allison Hill', 'participant', 1001.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Noah Rhodes', 'dark', 1008.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Angie Henderson', 'sea', 1015.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Daniel Wagner', 'available', 1022.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Cristian Santos', 'answer', 1029.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Connie Lawrence', 'recently', 1036.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Abigail Shaffer', 'drive', 1043.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Gina Moore', 'spring', 1050.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Gabrielle Davis', 'figure', 1057.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Ryan Munoz', 'base', 1064.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Monica Herrera', 'top', 1071.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Jamie Arnold', 'early', 1078.5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Lisa Hensley', 'trial', 1085.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('blood', 'Allison Hill', 'Melinda Jones', 1014.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('husband', 'Allison Hill', 'Kimberly Sanchez', 1023.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('fall', 'Allison Hill', 'Devin Schaefer', 1032.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('long', 'Allison Hill', 'Colleen Nguyen', 1041.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('prove', 'Allison Hill', 'Amy Underwood', 1050.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('they', 'Allison Hill', 'Jennifer Jones', 1059.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('his', 'Allison Hill', 'Latoya Robbins', 1068.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('commercial', 'Allison Hill', 'Jonathan Wilkerson', 1077.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('hospital', 'Allison Hill', 'Brenda Taylor', 1086.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('hear', 'Allison Hill', 'Kimberly Burgess', 1095.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('determine', 'Allison Hill', 'Kevin Cox', 1104.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('religious', 'Allison Hill', 'Brenda Snyder PhD', 1113.5);
INSERT INTO "instructor" ("id", "dept_name", "name", "salary") VALUES ('example', 'Allison Hill', 'Brittany Moore', 1122.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "salary" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM (SELECT "id", "name", "dept_name", "salary", AVG("salary") OVER () AS "meansalary" FROM "instructor") WHERE ("dept_name" <> 'Physics' OR meansalary < salary)) ORDER BY salary) LIMIT 44);

/*
Gold Result:
('Melinda Jones', 1014.5)
('Kimberly Sanchez', 1023.5)
('Devin Schaefer', 1032.5)
('Colleen Nguyen', 1041.5)
('Amy Underwood', 1050.5)
('Jennifer Jones', 1059.5)
('Latoya Robbins', 1068.5)
('Jonathan Wilkerson', 1077.5)
('Brenda Taylor', 1086.5)
('Kimberly Burgess', 1095.5)
('Kevin Cox', 1104.5)
('Brenda Snyder PhD', 1113.5)
('Brittany Moore', 1122.5)
*/

-- Prediction Query
SELECT name, salary FROM instructor WHERE salary < (SELECT AVG(salary) FROM instructor WHERE dept_name = 'Physics');

/*
Prediction Result:
*/