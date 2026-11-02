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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'T', 'tutor2', 'pass2', 'Thomas', 'K', 'White', 'M', '200 Oak Ave');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Physics');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (10, 1, 1, 'Mechanics', 'Classical Mechanics');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2023-01-01 00:00:00', '2023-01-02 00:00:00', 'liam1', 'p1', 'Liam', 'A', 'Miller');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2023-01-03 00:00:00', '2023-01-04 00:00:00', 'liam2', 'p2', 'Liam', 'B', 'Wilson');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (3, '2023-01-05 00:00:00', '2023-01-06 00:00:00', 'noah1', 'p3', 'Noah', 'C', 'Moore');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (4, '2023-01-07 00:00:00', '2023-01-08 00:00:00', 'noah2', 'p4', 'Noah', 'D', 'Taylor');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (5, '2023-01-09 00:00:00', '2023-01-10 00:00:00', 'ava1', 'p5', 'Ava', 'E', 'Anderson');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (100, 4, 10, '2023-01-15 00:00:00', '2023-04-15 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT personal_name FROM (SELECT * FROM students AS LHS WHERE NOT EXISTS(SELECT 1 FROM student_course_enrolment AS RHS WHERE (LHS.student_id = RHS.student_id))) ORDER BY personal_name;

/*
Gold Result:
('Ava',)
('Liam',)
('Liam',)
('Noah',)
*/

-- Prediction Query
SELECT personal_name FROM Students EXCEPT SELECT T1.personal_name FROM Students AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.student_id = T2.student_id;

/*
Prediction Result:
('Ava',)
('Liam',)
*/