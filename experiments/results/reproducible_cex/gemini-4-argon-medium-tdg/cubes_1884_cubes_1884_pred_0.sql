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
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (10, 'ATB', 'auth1', 'pass1', 'John', 'M', 'Doe', 'M', '123 Main St');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (20, 'Languages');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (21, 'Spanish');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (30, '2020-01-01 00:00:00', '2020-01-02 00:00:00', 'stud1', 'pw1', 'Alice', 'A', 'Smith');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (31, '2020-02-01 00:00:00', '2020-02-02 00:00:00', 'stud2', 'pw2', 'Bob', 'B', 'Jones');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 20, 10, 'Spanish', 'Intro to French');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (2, 21, 10, 'French', 'Spanish');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (3, 20, 10, 'Spanish', 'Advanced Spanish');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (100, 30, 1, '2023-05-10 10:00:00', '2023-06-10 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (101, 31, 1, '2023-01-15 08:30:00', '2023-02-15 08:30:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (102, 30, 3, '2023-01-15 08:30:00', '2023-04-01 12:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (103, 31, 2, '2022-11-20 09:00:00', '2022-12-20 09:00:00');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (100, '2023-05-20 10:00:00', 'Pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (100, '2023-05-25 10:00:00', 'Pass');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."author_id" AS "author_id", "LHS"."subject_id" AS "subject_id", "LHS"."course_name" AS "course_name", "LHS"."course_description" AS "course_description", "RHS"."registration_id" AS "registration_id", "RHS"."student_id" AS "student_id", "RHS"."date_of_enrolment" AS "date_of_enrolment", "RHS"."date_of_completion" AS "date_of_completion" FROM "courses" AS "LHS" INNER JOIN "student_course_enrolment" AS "RHS" ON ("LHS"."course_id" = "RHS"."course_id")) WHERE ("course_name" = 'Spanish') ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST;

/*
Gold Result:
('2023-01-15 08:30:00',)
('2023-01-15 08:30:00',)
('2023-05-10 10:00:00',)
*/

-- Prediction Query
SELECT T2.date_of_enrolment FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id WHERE T1.course_name = 'Spanish';

/*
Prediction Result:
('2023-05-10 10:00:00',)
('2023-01-15 08:30:00',)
('2023-01-15 08:30:00',)
*/