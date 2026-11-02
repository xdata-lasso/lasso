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
-- Target: Basic sorting order (ASC vs DESC), duplicate retention (SELECT vs SELECT DISTINCT), and NULL handling in address_line_1 and author_id.
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (10, 'AUT', 'user1', 'pass1', 'John', 'A', 'Doe', 'M', '200 Oak St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (20, 'TUT', 'user2', 'pass2', 'Jane', 'B', 'Smith', 'F', '100 Main St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (5, 'ATB', 'user3', 'pass3', 'Alice', 'C', 'Jones', 'F', '100 Main St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (30, 'AUT', 'user4', 'pass4', 'Bob', 'D', 'Brown', 'M', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address_line_1 FROM course_authors_and_tutors ORDER BY address_line_1, course_authors_and_tutors.author_id NULLS LAST;

/*
Gold Result:
(None,)
('100 Main St',)
('100 Main St',)
('200 Oak St',)
*/

-- Prediction Query
SELECT address_line_1 FROM Course_Authors_and_Tutors;

/*
Prediction Result:
('100 Main St',)
('200 Oak St',)
('100 Main St',)
(None,)
*/