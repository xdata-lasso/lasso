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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (5, 'AUT', 'auth5', 'pass5', 'Alice', 'M', 'Smith', 'F', '10 Main St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (10, 'AUT', 'auth10', 'pass10', 'Bob', 'J', 'Jones', 'M', '20 Oak St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (20, 'TUT', 'auth20', 'pass20', 'Carol', 'A', 'White', 'F', '30 Pine St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (30, 'ATB', 'auth30', 'pass30', 'Dan', 'B', 'Brown', 'M', '40 Elm St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (99, 'AUT', 'auth99', 'pass99', 'Eve', 'C', 'Davis', 'F', '50 Maple St');
INSERT INTO Subjects (subject_id, subject_name) VALUES (10, 'Mathematics');
INSERT INTO Subjects (subject_id, subject_name) VALUES (15, 'Physics');
INSERT INTO Subjects (subject_id, subject_name) VALUES (20, 'Computer Science');
INSERT INTO Subjects (subject_id, subject_name) VALUES (25, 'Chemistry');
INSERT INTO Subjects (subject_id, subject_name) VALUES (30, 'Biology');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (30, '2023-01-01 09:00:00', '2023-06-01 10:00:00', 'stud30', 'spass30', 'Frank', 'D', 'Miller');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 20, 10, 'Gold_Match', 'Exact match for author_id=10 and subject_id=20');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (10, 20, 99, 'Decoy_FK_And_Subj', 'Matches course_id=10 and subject_id=20 but author_id=99');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (2, 20, 5, 'Decoy_Author_Less', 'Matches subject_id=20 with author_id<10');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (3, 15, 10, 'Decoy_Subj_Less', 'Matches author_id=10 with subject_id<20');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (4, 25, 10, 'Decoy_Subj_Greater', 'Matches author_id=10 with subject_id>20');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (5, 10, 20, 'Decoy_Swapped', 'Matches swapped author_id=20 and subject_id=10');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (6, 20, 30, 'Decoy_Student_Author', 'Matches author_id=student_id=30 and subject_id=20');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (7, 30, 10, 'Decoy_Student_Subj', 'Matches author_id=10 and subject_id=student_id=30');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (20, 30, 10, '2023-02-01 00:00:00', '2023-05-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT course_name, MAX(n) AS n FROM (SELECT course_name, COUNT(*) AS n FROM (SELECT course_id, author_id, subject_id, course_name, course_description, student_id, date_of_enrolment, date_of_completion, subject_id AS registration_id FROM (SELECT author_id AS course_id, author_id, subject_id, course_name, course_description, student_id, date_of_enrolment, date_of_completion FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.student_id AS student_id, RHS.date_of_enrolment AS date_of_enrolment, RHS.date_of_completion AS date_of_completion FROM courses AS LHS INNER JOIN student_course_enrolment AS RHS ON (LHS.author_id = RHS.course_id AND LHS.subject_id = RHS.registration_id)))) GROUP BY course_name) GROUP BY course_name) ORDER BY course_name;

/*
Gold Result:
('Gold_Match',)
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Decoy_FK_And_Subj',)
*/