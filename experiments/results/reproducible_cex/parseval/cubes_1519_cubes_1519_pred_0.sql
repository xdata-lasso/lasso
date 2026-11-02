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
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('stu_c7cb87', 'dep_f0958c', 0.01);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('''', 'dep_f0958c', 0.02);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('!', 'dep_f0958c', 0.03);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('O', 'dep_f0958c', 0.04);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('A', 'dep_f0958c', 0.05);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('G', 'dep_f0958c', 0.06);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('I', 'dep_f0958c', 0.07);

-- Inserting into table: student --
INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_1', 'stu_c7cb87', 'stu_c80b56', 1.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_2', 'stu_c7cb87', 'stu_c80b56', 2.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_3', 'stu_c7cb87', 'stu_c80b56', 3.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('O', 'stu_c7cb87', 'stu_c80b56', 4.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('A', 'stu_c7cb87', 'stu_c80b56', 5.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_4', 'stu_c7cb87', 'stu_c80b56', 6.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_7', '''', 'stu_c80b56', 7.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_8', '''', 'stu_c80b56', 8.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_9', '!', 'stu_c80b56', 9.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_10', 'O', 'stu_c80b56', 10.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_11', 'O', 'stu_c80b56', 11.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_12', 'A', 'stu_c80b56', 12.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_13', 'G', 'stu_c80b56', 13.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_14', 'G', 'stu_c80b56', 14.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_15', 'A', 'stu_c80b56', 15.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_16', 'I', 'stu_c80b56', 16.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_17', 'I', 'stu_c80b56', 17.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_18', 'A', 'stu_c80b56', 18.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_19', 'A', 'stu_c80b56', 19.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_20', 'G', 'stu_c80b56', 20.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_21', 'G', 'stu_c80b56', 21.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_22', 'stu_c7cb87', 'stu_c80b56', 22.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_23', 'stu_c7cb87', 'stu_c80b56', 23.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('id_24', 'stu_c7cb87', 'stu_c80b56', 24.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('B', '''', 'stu_c80b56', 25.0);

INSERT INTO "student" ("id", "dept_name", "name", "tot_cred") VALUES ('@', '''', 'stu_c80b56', 26.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name FROM (SELECT * FROM (SELECT * FROM (SELECT dept_name, id, COUNT(*) AS n FROM student GROUP BY dept_name, id) ORDER BY id) LIMIT 1);

/*
Gold Result:
("'",)
*/

-- Prediction Query
SELECT dept_name FROM student GROUP BY dept_name ORDER BY COUNT(*) DESC, dept_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('stu_c7cb87',)
*/