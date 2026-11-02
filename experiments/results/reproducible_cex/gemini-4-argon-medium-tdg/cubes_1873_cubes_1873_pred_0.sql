-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, column vs alias resolution (course_name aliased as course_description), and DISTINCT vs ALL with multiple matching rows.
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'Computer Science');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (2, 'database');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'A', 'auth1', 'pass1', 'Alice', 'M', 'Smith', 'F', '123 Main St');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (10, 1, 1, 'database', 'Intro to SQL');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (20, 1, 1, 'database', 'Advanced SQL');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (30, 2, 1, 'Data Structures', 'database');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (40, 2, 1, 'Database', 'Case sensitivity check');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "course_name" AS "course_description" FROM "courses" WHERE ("course_name" = 'database') ORDER BY course_description, courses.course_id NULLS LAST;

/*
Gold Result:
('database',)
('database',)
*/

-- Prediction Query
SELECT course_description FROM COURSES WHERE course_name = 'database';

/*
Prediction Result:
('Intro to SQL',)
('Advanced SQL',)
*/