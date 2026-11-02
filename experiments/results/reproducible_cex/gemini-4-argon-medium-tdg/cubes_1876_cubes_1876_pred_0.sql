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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'ATB', 'auth1', 'pass1', 'John', 'A', 'Doe', 'M', '123 St');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2023-01-01', '2023-01-02', 'stud1', 'pass1', 'Jane', 'B', 'Smith');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Math');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 1, 1, 'Algebra', 'Basic Algebra');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1, 1, 1, '2023-01-05', '2023-02-05');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (2, 1, 1, '2023-02-10', '2023-03-10');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (1, '2023-01-15', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (1, '2023-01-15', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (2, '2023-02-20', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (1, '2023-01-20', 'Fail');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT test_result, n AS count___ FROM (SELECT test_result, COUNT(*) AS n FROM student_tests_taken GROUP BY test_result) ORDER BY test_result, count___ NULLS LAST;

/*
Gold Result:
('Fail', 1)
('Pass', 3)
*/

-- Prediction Query
SELECT test_result, COUNT(*) FROM Student_Tests_Taken GROUP BY test_result ORDER BY COUNT(*) DESC, test_result NULLS LAST;

/*
Prediction Result:
('Pass', 3)
('Fail', 1)
*/