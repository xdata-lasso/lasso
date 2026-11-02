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
-- Tests basic ordering by personal_name, secondary ordering by student_id (with negative and positive values), duplicate rows (to catch DISTINCT mutants), and other tables (Course_Authors_and_Tutors, Student_Course_Enrolment) to catch wrong table or unnecessary JOIN mutants.
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'A', 'auth1', 'pass', 'Xander', 'M', 'Cage', 'M', '123 St');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'Math');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 1, 1, 'Algebra', 'Basic Algebra');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (10, '2023-01-01 00:00:00', '2023-01-02 00:00:00', 'zack1', 'p1', 'Zack', 'M1', 'Adams');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (20, '2023-01-01 00:00:00', '2023-01-02 00:00:00', 'alice20', 'p2', 'Alice', 'M2', 'Baker');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (5, '2023-01-01 00:00:00', '2023-01-02 00:00:00', 'alice5', 'p3', 'Alice', 'M3', 'Clark');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (-1, '2023-01-01 00:00:00', '2023-01-02 00:00:00', 'alice_neg', 'p4', 'Alice', 'M4', 'Davis');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (30, '2023-01-01 00:00:00', '2023-01-02 00:00:00', 'bob1', 'p5', 'Bob', 'M5', 'Evans');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (40, '2023-01-01 00:00:00', '2023-01-02 00:00:00', 'bob2', 'p6', 'Bob', 'M6', 'Evans');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (100, 10, 1, '2023-01-05 00:00:00', '2023-02-05 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (101, 10, 1, '2023-02-06 00:00:00', '2023-03-06 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT personal_name, family_name FROM students ORDER BY personal_name, students.student_id NULLS LAST;

/*
Gold Result:
('Alice', 'Davis')
('Alice', 'Clark')
('Alice', 'Baker')
('Bob', 'Evans')
('Bob', 'Evans')
('Zack', 'Adams')
*/

-- Prediction Query
SELECT personal_name, family_name FROM Students ORDER BY family_name, Students.student_id NULLS LAST;

/*
Prediction Result:
('Zack', 'Adams')
('Alice', 'Baker')
('Alice', 'Clark')
('Alice', 'Davis')
('Bob', 'Evans')
('Bob', 'Evans')
*/