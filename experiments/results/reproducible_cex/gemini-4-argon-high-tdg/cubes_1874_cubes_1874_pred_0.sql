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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'AUT', 'jdoe', 'pass123', 'John', 'A', 'Doe', 'M', '123 Main St');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2023-01-10 09:00:00', '2023-02-01 10:00:00', 'asmith', 'sec123', 'Alice', 'B', 'Smith');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Mathematics');
INSERT INTO Subjects (subject_id, subject_name) VALUES (2, 'Computer Science');
INSERT INTO Subjects (subject_id, subject_name) VALUES (3, 'Art');
INSERT INTO Subjects (subject_id, subject_name) VALUES (4, 'Mathematics');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (101, 1, 1, 'Calculus I', 'Intro to Calculus');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (102, 1, 1, 'Linear Algebra', 'Matrices and Vectors');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (103, 3, 1, 'Modern Art', 'Art history');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (104, 4, 1, 'Discrete Math', 'Logic and sets');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1001, 1, 101, '2023-01-15 00:00:00', '2023-05-15 00:00:00');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (1001, '2023-03-01 00:00:00', 'Pass');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject_name FROM subjects ORDER BY subject_name, subjects.subject_id NULLS LAST;

/*
Gold Result:
('Art',)
('Computer Science',)
('Mathematics',)
('Mathematics',)
*/

-- Prediction Query
SELECT subject_name FROM SUBJECTS;

/*
Prediction Result:
('Mathematics',)
('Computer Science',)
('Art',)
('Mathematics',)
*/