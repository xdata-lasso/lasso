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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'ATB', 'jdoe', 'pass123', 'John', 'M', 'Doe', 'M', '123 Main St');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2020-01-01 08:00:00', '2020-05-01 09:00:00', 'alice', 'sec123', 'Alice', 'A', 'Smith');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2020-02-01 08:00:00', '2020-06-01 09:00:00', 'bob', 'sec456', 'Bob', 'B', 'Jones');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Computer Science');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 1, 1, 'Database Systems', 'Intro to SQL');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (101, 1, 1, '2021-01-10 10:00:00', '2021-05-10 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (102, 2, 1, '2021-02-10 10:00:00', '2021-06-10 10:00:00');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (102, '2022-11-05 10:00:00', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (101, '2022-01-15 09:30:00', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (101, '2022-03-10 11:00:00', 'Fail');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (102, '2022-06-20 14:15:00', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (101, '2022-06-20 14:15:00', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (102, '2022-04-01 12:00:00', 'Pending');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (101, '2022-02-01 12:00:00', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_test_taken" FROM "student_tests_taken" WHERE ("test_result" = 'Pass') ORDER BY date_test_taken, student_tests_taken.registration_id NULLS LAST, student_tests_taken.test_result NULLS LAST;

/*
Gold Result:
('2022-01-15 09:30:00',)
('2022-06-20 14:15:00',)
('2022-06-20 14:15:00',)
('2022-11-05 10:00:00',)
*/

-- Prediction Query
SELECT date_test_taken FROM Student_Tests_Taken WHERE test_result = 'Pass';

/*
Prediction Result:
('2022-11-05 10:00:00',)
('2022-01-15 09:30:00',)
('2022-06-20 14:15:00',)
('2022-06-20 14:15:00',)
*/