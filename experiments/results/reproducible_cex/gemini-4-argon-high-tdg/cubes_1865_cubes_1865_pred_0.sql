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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'T', 'login_c', 'pass_2', 'Charlie', 'Mid_B', 'Smith', 'M', '300 Oak St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (2, 'A', 'login_a', 'pass_4', 'Alice', 'Mid_D', 'Adams', 'F', '100 Pine St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (10, 'B', 'login_d', 'pass_1', 'David', 'Mid_A', 'Wilson', 'M', '400 Maple St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (20, 'ATB', 'login_b', 'pass_3', 'Bob', 'Mid_C', 'Baker', 'F', '200 Cedar St');
INSERT INTO Subjects (subject_id, subject_name) VALUES (100, 'Computer Science');
INSERT INTO Subjects (subject_id, subject_name) VALUES (200, 'Mathematics');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (101, 100, 2, 'Algorithms', 'Intro to Algorithms');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (102, 100, 10, 'Databases', 'Relational Databases');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (103, 200, 10, 'Linear Algebra', 'Matrix Theory');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2022-01-10 08:00:00', '2022-05-10 09:00:00', 'stu_x', 'spass1', 'Xavier', 'M_X', 'Young');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2022-02-15 10:00:00', '2022-06-15 11:00:00', 'stu_y', 'spass2', 'Yara', 'M_Y', 'Zimmerman');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1001, 1, 101, '2022-01-12 00:00:00', '2022-04-12 00:00:00');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1002, 2, 102, '2022-02-20 00:00:00', NULL);
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (1001, '2022-03-01 14:00:00', 'Pass');
INSERT INTO Student_Tests_Taken (registration_id, date_test_taken, test_result) VALUES (1002, '2022-04-01 15:00:00', 'Fail');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author_id, author_tutor_atb, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1 FROM course_authors_and_tutors ORDER BY author_id;

/*
Gold Result:
(1, 'T', 'login_c', 'pass_2', 'Charlie', 'Mid_B', 'Smith', 'M', '300 Oak St')
(2, 'A', 'login_a', 'pass_4', 'Alice', 'Mid_D', 'Adams', 'F', '100 Pine St')
(10, 'B', 'login_d', 'pass_1', 'David', 'Mid_A', 'Wilson', 'M', '400 Maple St')
(20, 'ATB', 'login_b', 'pass_3', 'Bob', 'Mid_C', 'Baker', 'F', '200 Cedar St')
*/

-- Prediction Query
SELECT * FROM Course_Authors_and_Tutors ORDER BY personal_name, Course_Authors_and_Tutors.author_id NULLS LAST;

/*
Prediction Result:
(2, 'A', 'login_a', 'pass_4', 'Alice', 'Mid_D', 'Adams', 'F', '100 Pine St')
(20, 'ATB', 'login_b', 'pass_3', 'Bob', 'Mid_C', 'Baker', 'F', '200 Cedar St')
(1, 'T', 'login_c', 'pass_2', 'Charlie', 'Mid_B', 'Smith', 'M', '300 Oak St')
(10, 'B', 'login_d', 'pass_1', 'David', 'Mid_A', 'Wilson', 'M', '400 Maple St')
*/