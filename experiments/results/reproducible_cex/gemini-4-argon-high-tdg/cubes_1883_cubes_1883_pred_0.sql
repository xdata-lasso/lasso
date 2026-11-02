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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'ATB', 'jdoe', 'pass123', 'John', 'A', 'Doe', 'M', '123 Main St');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Computer Science');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 1, 1, 'Databases 101', 'Intro to SQL');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2020-01-01 08:00:00', '2023-12-01 08:00:00', 'alice', 'pw1', 'Alice', 'B', 'Smith');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (10, 1, 1, '2023-03-01 10:00:00', '2023-04-01 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (20, 1, 1, '2023-01-15 09:00:00', '2023-02-20 12:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (30, 1, 1, '2023-01-15 09:00:00', '2023-02-10 08:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (40, 1, 1, '2023-03-01 10:00:00', '2023-04-01 10:00:00');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (10, '2023-03-15 10:00:00', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (10, '2023-03-20 10:00:00', 'Pass');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_enrolment, date_of_completion FROM student_course_enrolment ORDER BY date_of_enrolment, student_course_enrolment.registration_id NULLS LAST;

/*
Gold Result:
('2023-01-15 09:00:00', '2023-02-20 12:00:00')
('2023-01-15 09:00:00', '2023-02-10 08:00:00')
('2023-03-01 10:00:00', '2023-04-01 10:00:00')
('2023-03-01 10:00:00', '2023-04-01 10:00:00')
*/

-- Prediction Query
SELECT date_of_enrolment, date_of_completion FROM Student_Course_Enrolment;

/*
Prediction Result:
('2023-03-01 10:00:00', '2023-04-01 10:00:00')
('2023-01-15 09:00:00', '2023-02-20 12:00:00')
('2023-01-15 09:00:00', '2023-02-10 08:00:00')
('2023-03-01 10:00:00', '2023-04-01 10:00:00')
*/