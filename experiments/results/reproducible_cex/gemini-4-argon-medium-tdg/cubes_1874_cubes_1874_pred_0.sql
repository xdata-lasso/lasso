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
-- Tests basic ordering, anti-correlation between subject_id and subject_name, duplicate subject_names (to kill DISTINCT mutants), and unreferenced subjects vs multiple courses per subject (to kill INNER JOIN / LEFT JOIN mutants).
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'ATB', 'jdoe', 'pass123', 'John', 'M', 'Doe', 'M', '123 Main St');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (10, 'Zoology');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (20, 'Mathematics');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (30, 'History');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (40, 'Mathematics');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (50, 'Art');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (101, 20, 1, 'Calc I', 'Intro to Calculus');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (102, 20, 1, 'Calc II', 'Advanced Calculus');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (103, 10, 1, 'Zoo 101', 'Intro to Zoology');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject_name FROM subjects ORDER BY subject_name, subjects.subject_id NULLS LAST;

/*
Gold Result:
('Art',)
('History',)
('Mathematics',)
('Mathematics',)
('Zoology',)
*/

-- Prediction Query
SELECT subject_name FROM SUBJECTS;

/*
Prediction Result:
('Zoology',)
('Mathematics',)
('History',)
('Mathematics',)
('Art',)
*/