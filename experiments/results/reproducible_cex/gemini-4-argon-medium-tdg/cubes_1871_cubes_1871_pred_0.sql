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
-- Tests basic matching, WHERE filtering (exact match vs partial/case sensitivity), and ASC ordering.
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'Computer Science');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'A', 'z_login', 'pass1', 'Zack', 'M', 'Smith', 'M', '123 St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (2, 'T', 'a_login', 'pass2', 'Alice', 'J', 'Doe', 'F', '456 St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (3, 'B', 'm_login', 'pass3', 'Bob', 'K', 'Brown', 'M', '789 St');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (10, 1, 1, 'advanced database', 'advanced database');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (11, 1, 2, 'advanced database', 'other description');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (12, 1, 3, 'Advanced Database', 'advanced database');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (13, 1, 3, 'intro to advanced database', 'desc');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "login_name" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."author_id" AS "author_id", "LHS"."subject_id" AS "subject_id", "LHS"."course_name" AS "course_name", "LHS"."course_description" AS "course_description", "RHS"."author_tutor_atb" AS "author_tutor_atb", "RHS"."login_name" AS "login_name", "RHS"."password" AS "password", "RHS"."personal_name" AS "personal_name", "RHS"."middle_name" AS "middle_name", "RHS"."family_name" AS "family_name", "RHS"."gender_mf" AS "gender_mf", "RHS"."address_line_1" AS "address_line_1" FROM (SELECT * FROM "courses" WHERE ("course_name" = 'advanced database')) AS LHS LEFT JOIN course_authors_and_tutors AS RHS ON (LHS.author_id = RHS.author_id)) ORDER BY login_name, "login_name" NULLS LAST;

/*
Gold Result:
('a_login',)
('z_login',)
*/

-- Prediction Query
SELECT T1.login_name FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id = T2.author_id WHERE T2.course_name = 'advanced database';

/*
Prediction Result:
('z_login',)
('a_login',)
*/