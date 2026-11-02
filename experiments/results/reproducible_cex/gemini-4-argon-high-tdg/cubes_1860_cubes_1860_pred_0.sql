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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'A', 'jdoe', 'pass1', 'John', 'M', 'Doe', 'M', '400 Pine St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (2, 'T', 'asmith', 'pass2', 'Alice', 'K', 'Smith', 'F', '100 Oak St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (3, 'B', 'bbrown', 'pass3', 'Bob', 'L', 'Brown', 'M', '200 Maple Ave');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (4, 'A', 'cwhite', 'pass4', 'Carol', 'J', 'White', 'F', '100 Oak St');
INSERT INTO Subjects (subject_id, subject_name) VALUES (10, 'Computer Science');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (101, 10, 2, 'Intro to SQL', 'Basic SQL course');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (102, 10, 2, 'Advanced SQL', 'Advanced SQL course');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (103, 10, 3, 'Algorithms', 'Data structures and algorithms');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address_line_1 FROM course_authors_and_tutors ORDER BY address_line_1, course_authors_and_tutors.author_id NULLS LAST;

/*
Gold Result:
('100 Oak St',)
('100 Oak St',)
('200 Maple Ave',)
('400 Pine St',)
*/

-- Prediction Query
SELECT address_line_1 FROM Course_Authors_and_Tutors;

/*
Prediction Result:
('400 Pine St',)
('100 Oak St',)
('200 Maple Ave',)
('100 Oak St',)
*/