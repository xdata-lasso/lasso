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
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (1, '2020-01-10 09:00:00', '2023-05-10 12:00:00', 'user1', 'pass1', 'Alice', 'M', 'Jaskolski');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (2, '2021-06-15 10:00:00', '2021-03-15 08:30:00', 'user2', 'pass2', 'Bob', 'N', 'Langosh');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (3, '2019-02-20 11:00:00', '2022-01-01 00:00:00', 'Jaskolski', 'pass3', 'Jaskolski', 'Langosh', 'Smith');
INSERT INTO Students (student_id, date_of_registration, date_of_latest_logon, login_name, password, personal_name, middle_name, family_name) VALUES (4, '2022-08-01 14:00:00', '2020-12-31 23:59:59', 'Langosh', 'pass4', 'Langosh', 'Jaskolski', 'Miller');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_latest_logon" FROM "students" WHERE ("family_name" = 'Jaskolski' OR "family_name" = 'Langosh') ORDER BY date_of_latest_logon, students.student_id NULLS LAST;

/*
Gold Result:
('2021-03-15 08:30:00',)
('2023-05-10 12:00:00',)
*/

-- Prediction Query
SELECT date_of_latest_logon FROM Students WHERE family_name = 'Jaskolski' OR family_name = 'Langosh';

/*
Prediction Result:
('2023-05-10 12:00:00',)
('2021-03-15 08:30:00',)
*/