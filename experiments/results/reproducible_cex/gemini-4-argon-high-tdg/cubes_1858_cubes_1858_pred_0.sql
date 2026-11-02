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
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (1, 'A', 'charlie_l', 'pass1', 'Zack', 'M1', 'Baker', 'M', '101 Main St');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (2, 'T', 'alice_l', 'pass2', 'Yara', 'M2', 'Carter', 'F', '202 Oak Ave');
INSERT INTO Course_Authors_and_Tutors (author_id, author_tutor_ATB, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1) VALUES (3, 'B', 'bob_l', 'pass3', 'Xavier', 'M3', 'Adams', 'M', '303 Pine Rd');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (10, '2023-01-01 10:00:00', '2023-01-05 12:00:00', 'stu_login', 'spass1', 'Sam', 'S', 'StudentFam');
INSERT INTO Subjects (subject_id, subject_name) VALUES (100, 'Computer Science');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1001, 100, 1, 'Databases', 'Intro to SQL');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1002, 100, 1, 'Algorithms', 'Intro to Algos');
INSERT INTO Courses (course_id, subject_id, author_id, course_name, course_description) VALUES (1003, 100, 2, 'Networks', 'Intro to Net');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT login_name, family_name FROM course_authors_and_tutors ORDER BY login_name, course_authors_and_tutors.author_id NULLS LAST;

/*
Gold Result:
('alice_l', 'Carter')
('bob_l', 'Adams')
('charlie_l', 'Baker')
*/

-- Prediction Query
SELECT login_name, family_name FROM Course_Authors_and_Tutors;

/*
Prediction Result:
('charlie_l', 'Baker')
('alice_l', 'Carter')
('bob_l', 'Adams')
*/