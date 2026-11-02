-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course_authors_and_tutors --
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (-2147483648, 'f3b', 'cou_528ef7', 'cou_3feae2', 'cou_1c585e', 'cou_ee799e', 'cou_11b971', '1', 'cou_93c33d');

-- Inserting into table: subjects --
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (-2147483648, 'sub_1c9658');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483648, -2147483648, -2147483648, 'cou_3db317', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, -2147483648, -2147483648, 'database', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (2, -2147483648, -2147483648, 'cou_3db317', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (3, -2147483648, -2147483648, 'cou_3db317', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483646, -2147483648, -2147483648, 'database', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483643, -2147483648, -2147483648, 'cou_3db317', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483642, -2147483648, -2147483648, NULL, 'cou_085990');
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
('cou_085990',)
('cou_085990',)
*/