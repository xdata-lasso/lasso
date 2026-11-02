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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'AT', 'prof_x', 'pass123', 'Xavier', 'C', 'Charles', 'M', '123 School Ln');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Mutant Studies');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (10, 1, 1, 'Intro', 'Basics');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (20, 1, 1, 'Advanced', 'Hard');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2023-01-01', '2023-01-02', 'zoe1', 'pw', 'Zoe', 'A', 'Adams');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2023-01-01', '2023-01-02', 'bob1', 'pw', 'Bob', 'B', 'Baker');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (3, '2023-01-01', '2023-01-02', 'alice1', 'pw', 'Alice', 'C', 'Clark');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (4, '2023-01-01', '2023-01-02', 'alice2', 'pw', 'Alice', 'D', 'Davis');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (100, 2, 10, '2023-02-01', '2023-05-01');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (101, 2, 20, '2023-02-01', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT personal_name FROM (SELECT * FROM students AS LHS WHERE NOT EXISTS(SELECT 1 FROM student_course_enrolment AS RHS WHERE (LHS.student_id = RHS.student_id))) ORDER BY personal_name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT personal_name FROM Students EXCEPT SELECT T1.personal_name FROM Students AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.student_id = T2.student_id;

/*
Prediction Result:
('Alice',)
('Zoe',)
*/