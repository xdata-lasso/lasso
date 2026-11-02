-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'AUT', 'aneuman', 'secret', 'Alfred', 'E', 'Neuman', 'M', '456 Elm St');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2023-02-01 00:00:00', '2023-02-15 00:00:00', 's1', 'p1', 'Carol', 'C', 'White');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2023-02-02 00:00:00', '2023-02-16 00:00:00', 's2', 'p2', 'Dave', 'D', 'Green');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (3, '2023-02-03 00:00:00', '2023-02-17 00:00:00', 's3', 'p3', 'Eve', 'E', 'Black');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Mathematics');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 1, 1, 'Calculus', 'Differential and Integral');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (10, 1, 1, '2023-02-05 00:00:00', '2023-03-01 00:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (20, 2, 1, '2023-02-06 00:00:00', '2023-03-02 00:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (30, 3, 1, '2023-02-07 00:00:00', '2023-03-03 00:00:00');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (10, '2023-02-10 10:00:00', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (20, '2023-02-11 10:00:00', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (10, '2023-02-12 10:00:00', 'Incomplete');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (20, '2023-02-13 10:00:00', 'Incomplete');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (30, '2023-02-14 10:00:00', 'Incomplete');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (30, '2023-02-15 10:00:00', 'Fail');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT test_result, n AS count___ FROM (SELECT test_result, COUNT(*) AS n FROM student_tests_taken GROUP BY test_result) ORDER BY test_result, count___ NULLS LAST;

/*
Gold Result:
('Fail', 1)
('Incomplete', 3)
('Pass', 2)
*/

-- Prediction Query
SELECT test_result, COUNT(*) FROM Student_Tests_Taken GROUP BY test_result ORDER BY COUNT(*) DESC, test_result NULLS LAST;

/*
Prediction Result:
('Incomplete', 3)
('Pass', 2)
('Fail', 1)
*/