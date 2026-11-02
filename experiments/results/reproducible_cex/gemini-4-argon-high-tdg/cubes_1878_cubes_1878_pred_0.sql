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
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'ATB', 'auth1', 'pw1', 'Alice', 'M', 'Smith', 'F', '10 Main St');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'Computer Science');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2019-01-01 00:00:00', '2023-01-01 00:00:00', 'stud1', 'pw1', 'Bob', 'A', 'Jones');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (2, '2019-01-02 00:00:00', '2023-01-02 00:00:00', 'stud2', 'pw2', 'Carol', 'B', 'White');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (3, '2019-01-03 00:00:00', '2023-01-03 00:00:00', 'stud3', 'pw3', 'Dave', 'C', 'Black');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (4, '2019-01-04 00:00:00', '2023-01-04 00:00:00', 'stud4', 'pw4', 'Eve', 'D', 'Green');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 1, 1, 'Databases', 'Intro to SQL');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (2, 1, 1, 'Algorithms', 'Sorting and Searching');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (3, 1, 1, 'Networks', 'TCP/IP');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (4, 1, 1, 'Pass', 'Course named Pass');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1, 4, 4, '2022-11-15 10:00:00', '2023-01-10 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (2, 3, 3, '2021-05-20 09:00:00', '2023-02-15 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (3, 2, 2, '2020-02-10 08:00:00', '2023-03-20 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (4, 1, 1, '2019-08-05 07:00:00', '2023-04-25 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (5, 1, 2, '2018-01-01 00:00:00', '2018-06-01 00:00:00');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (1, '2023-01-05 12:00:00', 'Pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (2, '2023-02-10 12:00:00', 'Pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (3, '2023-03-15 12:00:00', 'Pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (4, '2023-04-20 12:00:00', 'Fail');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (4, '2023-04-21 12:00:00', 'pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (4, '2023-04-22 12:00:00', 'Passed');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (4, '2023-04-23 12:00:00', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment" FROM (SELECT "LHS"."registration_id" AS "registration_id", "LHS"."student_id" AS "student_id", "LHS"."course_id" AS "course_id", "LHS"."date_of_enrolment" AS "date_of_enrolment", "LHS"."date_of_completion" AS "date_of_completion", "RHS"."date_test_taken" AS "date_test_taken", "RHS"."test_result" AS "test_result" FROM "student_course_enrolment" AS "LHS" INNER JOIN "student_tests_taken" AS "RHS" ON ("LHS"."registration_id" = "RHS"."registration_id")) WHERE ("test_result" = 'Pass') ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST;

/*
Gold Result:
('2020-02-10 08:00:00',)
('2021-05-20 09:00:00',)
('2022-11-15 10:00:00',)
*/

-- Prediction Query
SELECT T1.date_of_enrolment FROM Student_Course_Enrolment AS T1 JOIN Student_Tests_Taken AS T2 ON T1.registration_id = T2.registration_id WHERE T2.test_result = 'Pass';

/*
Prediction Result:
('2022-11-15 10:00:00',)
('2021-05-20 09:00:00',)
('2020-02-10 08:00:00',)
*/