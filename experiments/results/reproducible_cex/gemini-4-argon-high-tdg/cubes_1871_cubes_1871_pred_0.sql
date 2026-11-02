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
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'Aut', 'wrong_by_course_id', 'pw1', 'Carl', 'A', 'Reed', 'M', '10 First St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (2, 'Aut', 'wrong_by_subject_id', 'pw2', 'Sara', 'B', 'Lane', 'F', '20 Second St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (10, 'Aut', 'zoe_login', 'pw10', 'Zoe', 'C', 'Adams', 'F', '100 Main St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (20, 'Tut', 'amy_login', 'pw20', 'Amy', 'D', 'Baker', 'F', '200 Oak St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (30, 'ATB', 'bob_login', 'pw30', 'Bob', 'E', 'Clark', 'M', '300 Pine St');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (2, 'computer science');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (5, 'advanced database');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 2, 10, 'advanced database', 'graduate db course');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (2, 2, 20, 'advanced database', 'distributed db course');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (3, 5, 30, 'introductory sql', 'advanced database');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (100, '2023-01-01 09:00:00', '2023-06-01 10:00:00', 'student_login_1', 'spw1', 'Tom', 'J', 'Hall');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (200, '2023-01-02 09:00:00', '2023-06-02 10:00:00', 'student_login_2', 'spw2', 'Eva', 'K', 'King');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1000, 100, 1, '2023-02-01 00:00:00', '2023-05-01 00:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (2000, 200, 2, '2023-02-01 00:00:00', '2023-05-01 00:00:00');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (1000, '2023-04-15 12:00:00', 'Pass');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "login_name" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."author_id" AS "author_id", "LHS"."subject_id" AS "subject_id", "LHS"."course_name" AS "course_name", "LHS"."course_description" AS "course_description", "RHS"."author_tutor_atb" AS "author_tutor_atb", "RHS"."login_name" AS "login_name", "RHS"."password" AS "password", "RHS"."personal_name" AS "personal_name", "RHS"."middle_name" AS "middle_name", "RHS"."family_name" AS "family_name", "RHS"."gender_mf" AS "gender_mf", "RHS"."address_line_1" AS "address_line_1" FROM (SELECT * FROM "courses" WHERE ("course_name" = 'advanced database')) AS LHS LEFT JOIN course_authors_and_tutors AS RHS ON (LHS.author_id = RHS.author_id)) ORDER BY login_name, "login_name" NULLS LAST;

/*
Gold Result:
('amy_login',)
('zoe_login',)
*/

-- Prediction Query
SELECT T1.login_name FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id = T2.author_id WHERE T2.course_name = 'advanced database';

/*
Prediction Result:
('zoe_login',)
('amy_login',)
*/