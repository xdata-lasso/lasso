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
-- Tests ties for the maximum number of enrollments, ensuring queries using LIMIT 1 fail.
-- Also tests ordering by student_id and handling of un-enrolled students.
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'ATB', 'auth1', 'pass', 'John', 'A', 'Doe', 'M', '123 St');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'CS');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (10, 1, 1, 'C1', 'D1');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (20, 1, 1, 'C2', 'D2');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2020-01-01', '2020-01-02', 'charlie', 'p1', 'Charlie', 'C', 'Brown');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2020-01-01', '2020-01-02', 'alice', 'p2', 'Alice', 'A', 'Smith');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (3, '2020-01-01', '2020-01-02', 'bob', 'p3', 'Bob', 'B', 'Jones');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (4, '2020-01-01', '2020-01-02', 'david', 'p4', 'David', 'D', 'White');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (101, 1, 10, '2020-02-01', '2020-03-01');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (102, 2, 10, '2020-02-01', '2020-03-01');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (103, 2, 20, '2020-02-01', '2020-03-01');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (104, 3, 10, '2020-02-01', '2020-03-01');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (105, 3, 20, '2020-02-01', '2020-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id, login_name FROM (SELECT LHS.student_id AS student_id, LHS.date_of_registration AS date_of_registration, LHS.date_of_latest_logon AS date_of_latest_logon, LHS.login_name AS login_name, LHS.password AS password, LHS.personal_name AS personal_name, LHS.middle_name AS middle_name, LHS.family_name AS family_name, LHS.n AS n FROM (SELECT LHS.student_id AS student_id, LHS.date_of_registration AS date_of_registration, LHS.date_of_latest_logon AS date_of_latest_logon, LHS.login_name AS login_name, LHS.password AS password, LHS.personal_name AS personal_name, LHS.middle_name AS middle_name, LHS.family_name AS family_name, RHS.n AS n FROM students AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY student_id) AS RHS ON (LHS.student_id = RHS.student_id)) AS LHS INNER JOIN (SELECT student_id, MAX(n) OVER () AS n FROM (SELECT student_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY student_id)) AS RHS ON (LHS.student_id = RHS.student_id AND LHS.n = RHS.n)) ORDER BY student_id, login_name NULLS LAST;

/*
Gold Result:
(2, 'alice')
(3, 'bob')
*/

-- Prediction Query
SELECT T1.student_id, T2.login_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id GROUP BY T1.student_id ORDER BY COUNT(*) DESC, T1.student_id NULLS LAST, T2.login_name NULLS LAST LIMIT 1;

/*
Prediction Result:
(2, 'alice')
*/