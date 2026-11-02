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
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'ATB', 'auth1', 'pass1', 'John', 'M', 'Doe', 'M', '123 St');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'CS');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 1, 1, 'SQL 101', 'Intro to SQL');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2018-01-01', '2018-01-02', 'stud1', 'pass1', 'Alice', 'A', 'Smith');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (10, 1, 1, '2022-05-10 00:00:00', '2022-06-10 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (20, 1, 1, '2020-01-15 00:00:00', '2020-02-15 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (30, 1, 1, '2021-03-20 00:00:00', '2021-04-20 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (40, 1, 1, '2019-11-11 00:00:00', '2019-12-11 00:00:00');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (10, '2022-06-01 00:00:00', 'Pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (20, '2020-02-01 00:00:00', 'Pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (20, '2020-02-05 00:00:00', 'Pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (30, '2021-04-01 00:00:00', 'Fail');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment" FROM (SELECT "LHS"."registration_id" AS "registration_id", "LHS"."student_id" AS "student_id", "LHS"."course_id" AS "course_id", "LHS"."date_of_enrolment" AS "date_of_enrolment", "LHS"."date_of_completion" AS "date_of_completion", "RHS"."date_test_taken" AS "date_test_taken", "RHS"."test_result" AS "test_result" FROM "student_course_enrolment" AS "LHS" INNER JOIN "student_tests_taken" AS "RHS" ON ("LHS"."registration_id" = "RHS"."registration_id")) WHERE ("test_result" = 'Pass') ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST;

/*
Gold Result:
('2020-01-15 00:00:00',)
('2020-01-15 00:00:00',)
('2022-05-10 00:00:00',)
*/

-- Prediction Query
SELECT T1.date_of_enrolment FROM Student_Course_Enrolment AS T1 JOIN Student_Tests_Taken AS T2 ON T1.registration_id = T2.registration_id WHERE T2.test_result = 'Pass';

/*
Prediction Result:
('2022-05-10 00:00:00',)
('2020-01-15 00:00:00',)
('2020-01-15 00:00:00',)
*/