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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'AUT', 'auth1', 'pass1', 'Alice', 'M', 'Smith', 'F', '101 Main St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (2, 'AUT', 'auth2', 'pass2', 'Bob', 'N', 'Jones', 'M', '102 Main St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (10, 'TUT', 'auth10', 'pass10', 'Carol', 'O', 'White', 'F', '103 Main St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (99, 'ATB', 'auth99', 'pass99', 'Dan', 'P', 'Brown', 'M', '104 Main St');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Subject One');
INSERT INTO Subjects (subject_id, subject_name) VALUES (10, 'Subject Ten');
INSERT INTO Subjects (subject_id, subject_name) VALUES (20, 'Subject Twenty');
INSERT INTO Subjects (subject_id, subject_name) VALUES (99, 'Subject NinetyNine');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2023-01-01 08:00:00', '2023-06-01 09:00:00', 'stud1', 'pw1', 'Eve', 'A', 'Adams');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2023-01-02 08:00:00', '2023-06-02 09:00:00', 'stud2', 'pw2', 'Frank', 'B', 'Baker');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 99, 99, 'Wrong FK Course 1', 'Course 1 Desc');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (2, 99, 99, 'Wrong FK Course 2', 'Course 2 Desc');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (101, 10, 1, 'Zebra Biology', 'Alpha Desc');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (102, 20, 2, 'Alpha Math', 'Zebra Desc');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (103, 99, 1, 'Wrong Author Only', 'Author Match Only');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (104, 10, 99, 'Wrong Subject Only', 'Subject Match Only');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (105, 1, 10, 'Wrong Swapped Join', 'Swapped Keys');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (10, 1, 1, '2023-02-01 10:00:00', '2023-05-01 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (20, 2, 2, '2023-02-02 10:00:00', '2023-05-02 10:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (30, 1, 1, '2023-02-03 10:00:00', '2023-05-03 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, author_id, registration_id AS subject_id FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, course_id AS author_id FROM (SELECT LHS.registration_id AS registration_id, LHS.student_id AS student_id, LHS.course_id AS course_id, LHS.date_of_enrolment AS date_of_enrolment, LHS.date_of_completion AS date_of_completion, RHS.course_id AS course_id_other, RHS.course_name AS course_name, RHS.course_description AS course_description FROM student_course_enrolment AS LHS INNER JOIN courses AS RHS ON (LHS.course_id = RHS.author_id AND LHS.registration_id = RHS.subject_id)))) ORDER BY course_name;

/*
Gold Result:
('Alpha Math',)
('Zebra Biology',)
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Wrong FK Course 1',)
*/