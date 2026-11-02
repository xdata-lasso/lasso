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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'A', 'auth1', 'pass1', 'John', 'A', 'Doe', 'M', '123 St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (2, 'A', 'auth2', 'pass2', 'Jane', 'B', 'Smith', 'F', '456 St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (3, 'A', 'auth3', 'pass3', 'Jim', 'C', 'Bean', 'M', '789 St');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Math');
INSERT INTO Subjects (subject_id, subject_name) VALUES (2, 'Science');
INSERT INTO Subjects (subject_id, subject_name) VALUES (3, 'History');
INSERT INTO Subjects (subject_id, subject_name) VALUES (4, 'Art');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2020-01-01', '2020-01-02', 'stud1', 'pass1', 'Alice', 'D', 'Wonder');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2020-01-01', '2020-01-02', 'stud2', 'pass2', 'Bob', 'E', 'Builder');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1, 1, 2, 'Course_Match_Both_Z', 'Matches registration 1, course 2');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (2, 1, 3, 'Course_Match_Subject_Only', 'Matches registration 1, but author is 3');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (3, 3, 2, 'Course_Match_Author_Only', 'Author is 2, but subject is 3');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (4, 2, 1, 'Course_Swapped_Join', 'Subject is 2 (matches course_id), Author is 1 (matches reg_id)');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (5, 4, 1, 'Course_Match_Both_A', 'Matches registration 4, course 1');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1, 1, 2, '2021-01-01', '2021-06-01');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (4, 2, 1, '2021-02-01', '2021-07-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, author_id, registration_id AS subject_id FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, course_id AS author_id FROM (SELECT LHS.registration_id AS registration_id, LHS.student_id AS student_id, LHS.course_id AS course_id, LHS.date_of_enrolment AS date_of_enrolment, LHS.date_of_completion AS date_of_completion, RHS.course_id AS course_id_other, RHS.course_name AS course_name, RHS.course_description AS course_description FROM student_course_enrolment AS LHS INNER JOIN courses AS RHS ON (LHS.course_id = RHS.author_id AND LHS.registration_id = RHS.subject_id)))) ORDER BY course_name;

/*
Gold Result:
('Course_Match_Both_A',)
('Course_Match_Both_Z',)
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Course_Match_Both_Z',)
*/