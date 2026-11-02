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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (10, 'AUT', 'jdoe', 'pass1', 'John', 'A', 'Doe', 'M', '123 Main St');
INSERT INTO Subjects (subject_id, subject_name) VALUES (20, 'Computer Science');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (100, '2023-01-01', '2023-01-10', 's1', 'p1', 'Alice', 'B', 'Smith');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (101, '2023-01-02', '2023-01-11', 's2', 'p2', 'Bob', 'C', 'Jones');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 20, 10, 'Database Systems', 'Intro to DB');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (2, 20, 10, 'Database Systems', 'Advanced DB');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (3, 20, 10, 'Algorithms', 'Intro to Algo');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (4, 20, 10, 'Unenrolled Course', 'No students');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1001, 100, 1, '2023-02-01', '2023-03-01');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1002, 101, 1, '2023-02-02', NULL);
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1003, 100, 2, '2023-02-03', '2023-03-05');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1004, 100, 3, '2023-02-04', '2023-03-10');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1005, 100, 3, '2023-03-15', NULL);
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1006, 101, 3, '2023-03-16', '2023-04-01');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (1001, '2023-02-15', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (1001, '2023-02-20', 'Pass');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT course_name, n AS count___ FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, LHS.registration_id AS registration_id, LHS.student_id AS student_id, LHS.date_of_enrolment AS date_of_enrolment, LHS.date_of_completion AS date_of_completion, RHS.n AS n FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.registration_id AS registration_id, RHS.student_id AS student_id, RHS.date_of_enrolment AS date_of_enrolment, RHS.date_of_completion AS date_of_completion FROM courses AS LHS INNER JOIN student_course_enrolment AS RHS ON (LHS.course_id = RHS.course_id)) AS LHS INNER JOIN (SELECT course_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY course_id) AS RHS ON (LHS.course_id = RHS.course_id)) ORDER BY course_name, count___ NULLS LAST;

/*
Gold Result:
('Algorithms', 3)
('Database Systems', 1)
('Database Systems', 2)
*/

-- Prediction Query
SELECT T1.course_name, COUNT(*) FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name;

/*
Prediction Result:
('Algorithms', 3)
('Database Systems', 3)
*/