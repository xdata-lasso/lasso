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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'AUT', 'jdoe', 'pass1', 'John', 'A', 'Doe', 'M', '100 Main St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (2, 'TUT', 'asmith', 'pass2', 'Alice', 'B', 'Smith', 'F', '200 Oak Ave');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Computer Science');
INSERT INTO Subjects (subject_id, subject_name) VALUES (2, 'Mathematics');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2023-01-01 08:00:00', '2023-06-01 09:00:00', 'stud1', 'pw1', 'Tom', 'C', 'Brown');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2023-01-02 08:00:00', '2023-06-02 09:00:00', 'stud2', 'pw2', 'Sara', 'D', 'Miller');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (3, '2023-01-03 08:00:00', '2023-06-03 09:00:00', 'stud3', 'pw3', 'Liam', 'E', 'Wilson');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (4, '2023-01-04 08:00:00', '2023-06-04 09:00:00', 'stud4', 'pw4', 'Emma', 'F', 'Taylor');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 1, 1, 'Zero Enrolments', 'Course with 0 students');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (2, 1, 1, 'One Enrolment', 'Course with 1 student');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (3, 2, 2, 'Two Enrolments', 'Course with 2 students');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (4, 2, 2, 'Zeta Course', 'Alpha Description');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (5, 1, 2, 'Beta Course', 'Omega Description');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (6, 2, 1, 'Beta Course', 'Delta Description');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (101, 1, 2, '2023-02-01 10:00:00', '2023-05-01 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (102, 1, 3, '2023-02-01 10:00:00', '2023-05-01 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (103, 2, 3, '2023-02-02 10:00:00', '2023-05-02 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (104, 1, 4, '2023-02-01 10:00:00', '2023-05-01 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (105, 2, 4, '2023-02-02 10:00:00', '2023-05-02 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (106, 3, 4, '2023-02-03 10:00:00', '2023-05-03 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (107, 1, 5, '2023-02-01 10:00:00', '2023-05-01 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (108, 2, 5, '2023-02-02 10:00:00', '2023-05-02 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (109, 3, 5, '2023-02-03 10:00:00', '2023-05-03 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (110, 4, 5, '2023-02-04 10:00:00', '2023-05-04 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (111, 1, 6, '2023-02-01 10:00:00', '2023-05-01 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (112, 2, 6, '2023-02-02 10:00:00', '2023-05-02 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (113, 3, 6, '2023-02-03 10:00:00', '2023-05-03 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name AS course_description, course_description AS course_name FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.n AS n FROM courses AS LHS LEFT JOIN (SELECT course_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY course_id) AS RHS ON (LHS.course_id = RHS.course_id)) WHERE (n > 2) ORDER BY course_description, course_name NULLS LAST;

/*
Gold Result:
('Beta Course', 'Delta Description')
('Beta Course', 'Omega Description')
('Zeta Course', 'Alpha Description')
*/

-- Prediction Query
SELECT T1.course_description, T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name HAVING COUNT(*) > 2;

/*
Prediction Result:
('Omega Description', 'Beta Course')
('Alpha Description', 'Zeta Course')
*/