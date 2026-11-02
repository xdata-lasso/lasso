-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'ATB', 'auth1', 'pass1', 'Alice', 'M', 'Wonder', 'F', '123 St');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'CS');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 1, 1, 'CS101', 'Intro');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (2, 1, 1, 'CS102', 'Advanced');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2021-01-01 00:00:00', '2021-02-01 00:00:00', 'karson1', 'pw1', 'Karson', 'X', 'Alpha');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (2, '2021-01-02 00:00:00', '2021-02-02 00:00:00', 'karson2', 'pw2', 'Karson', 'Y', 'Beta');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1, 1, 1, '2022-03-01 00:00:00', '2022-04-02 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (2, 1, 2, '2022-03-01 00:00:00', '2022-04-01 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (3, 1, 1, '2022-03-01 00:00:00', '2022-04-01 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (4, 2, 1, '2022-01-01 00:00:00', NULL);
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (5, 2, 2, '2022-01-01 00:00:00', '2022-02-01 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (6, 2, 1, NULL, '2022-05-01 00:00:00');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (1, '2022-03-15 00:00:00', 'A');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (1, '2022-03-20 00:00:00', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment", "date_of_completion" FROM (SELECT "LHS"."student_id" AS "student_id", "LHS"."date_of_registration" AS "date_of_registration", "LHS"."date_of_latest_logon" AS "date_of_latest_logon", "LHS"."login_name" AS "login_name", "LHS"."password" AS "password", "LHS"."personal_name" AS "personal_name", "LHS"."middle_name" AS "middle_name", "LHS"."family_name" AS "family_name", "RHS"."registration_id" AS "registration_id", "RHS"."course_id" AS "course_id", "RHS"."date_of_enrolment" AS "date_of_enrolment", "RHS"."date_of_completion" AS "date_of_completion" FROM "students" AS "LHS" INNER JOIN "student_course_enrolment" AS "RHS" ON ("LHS"."student_id" = "RHS"."student_id")) WHERE ("personal_name" = 'Karson') ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST, "date_of_completion" NULLS LAST;

/*
Gold Result:
(None, '2022-05-01 00:00:00')
('2022-01-01 00:00:00', '2022-02-01 00:00:00')
('2022-01-01 00:00:00', None)
('2022-03-01 00:00:00', '2022-04-01 00:00:00')
('2022-03-01 00:00:00', '2022-04-01 00:00:00')
('2022-03-01 00:00:00', '2022-04-02 00:00:00')
*/

-- Prediction Query
SELECT T1.date_of_enrolment, T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id WHERE T2.personal_name = 'Karson';

/*
Prediction Result:
('2022-03-01 00:00:00', '2022-04-02 00:00:00')
('2022-03-01 00:00:00', '2022-04-01 00:00:00')
('2022-03-01 00:00:00', '2022-04-01 00:00:00')
('2022-01-01 00:00:00', None)
('2022-01-01 00:00:00', '2022-02-01 00:00:00')
(None, '2022-05-01 00:00:00')
*/