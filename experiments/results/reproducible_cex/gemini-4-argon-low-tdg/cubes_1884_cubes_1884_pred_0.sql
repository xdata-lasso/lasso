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
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (10, 'Languages');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (100, 'ATB', 'auth1', 'pass', 'Carlos', 'M', 'Gomez', 'M', '123 St');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2022-01-01 10:00:00', '2022-01-05 10:00:00', 'stu1', 'pass1', 'Alice', 'A', 'Smith');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (2, '2022-02-01 10:00:00', '2022-02-05 10:00:00', 'stu2', 'pass2', 'Bob', 'B', 'Jones');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (50, 10, 100, 'Spanish', 'Intro to Spanish');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (51, 10, 100, 'Spanish', 'Advanced Spanish');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (52, 10, 100, 'French', 'Intro to French');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (53, 10, 100, 'spanish', 'Lowercase spanish');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (54, 10, 100, 'Spanish 101', 'Spanish 101 Desc');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1001, 1, 50, '2023-05-10 09:00:00', '2023-08-10 09:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1002, 2, 50, '2023-01-15 09:00:00', '2023-04-15 09:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1003, 1, 50, '2023-01-15 09:00:00', '2023-06-15 09:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1004, 2, 50, NULL, '2023-12-01 09:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1005, 1, 52, '2023-03-01 09:00:00', '2023-07-01 09:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1006, 1, 53, '2023-02-01 09:00:00', '2023-05-01 09:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1007, 2, 54, '2023-04-01 09:00:00', '2023-09-01 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."author_id" AS "author_id", "LHS"."subject_id" AS "subject_id", "LHS"."course_name" AS "course_name", "LHS"."course_description" AS "course_description", "RHS"."registration_id" AS "registration_id", "RHS"."student_id" AS "student_id", "RHS"."date_of_enrolment" AS "date_of_enrolment", "RHS"."date_of_completion" AS "date_of_completion" FROM "courses" AS "LHS" INNER JOIN "student_course_enrolment" AS "RHS" ON ("LHS"."course_id" = "RHS"."course_id")) WHERE ("course_name" = 'Spanish') ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST;

/*
Gold Result:
(None,)
('2023-01-15 09:00:00',)
('2023-01-15 09:00:00',)
('2023-05-10 09:00:00',)
*/

-- Prediction Query
SELECT T2.date_of_enrolment FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id WHERE T1.course_name = 'Spanish';

/*
Prediction Result:
('2023-05-10 09:00:00',)
('2023-01-15 09:00:00',)
('2023-01-15 09:00:00',)
(None,)
*/