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
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'ATB', 'auth1', 'pass1', 'Carlos', 'M', 'Ruiz', 'M', '10 Main St');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (2, 'TUT', 'auth2', 'pass2', 'Claire', 'A', 'Dupont', 'F', '20 Oak Ave');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2020-01-01 09:00:00', '2023-06-01 10:00:00', 'stud1', 'pw1', 'Alice', 'B', 'Smith');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (2, '2020-02-01 09:00:00', '2023-05-01 10:00:00', 'stud2', 'pw2', 'Bob', 'C', 'Jones');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "middle_name", "personal_name", "family_name") VALUES (3, '2020-03-01 09:00:00', '2023-04-01 10:00:00', 'stud3', 'pw3', 'D', 'Charlie', 'Brown');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'Languages');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (2, 'Spanish');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (10, 1, 1, 'Spanish', 'Beginner Spanish');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (20, 2, 1, 'Spanish', 'Advanced Spanish');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (30, 1, 2, 'French', 'Spanish');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (40, 2, 2, 'Spanish 101', 'Introductory course');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (50, 2, 1, 'Grammar', 'Spanish Grammar');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (101, 3, 10, '2022-09-15 10:00:00', '2022-10-01 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (102, 1, 10, '2022-01-10 10:00:00', '2022-12-01 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (103, 2, 20, '2022-05-20 10:00:00', '2022-11-01 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (104, 1, 20, '2022-05-20 10:00:00', '2022-08-01 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (105, 2, 30, '2021-03-01 10:00:00', '2021-06-01 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (106, 3, 40, '2021-04-01 10:00:00', '2021-07-01 10:00:00');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (107, 1, 50, '2021-05-01 10:00:00', '2021-08-01 10:00:00');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (101, '2022-09-25 12:00:00', 'Pass');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (101, '2022-09-30 12:00:00', 'Distinction');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment" FROM (SELECT "LHS"."course_id" AS "course_id", "LHS"."author_id" AS "author_id", "LHS"."subject_id" AS "subject_id", "LHS"."course_name" AS "course_name", "LHS"."course_description" AS "course_description", "RHS"."registration_id" AS "registration_id", "RHS"."student_id" AS "student_id", "RHS"."date_of_enrolment" AS "date_of_enrolment", "RHS"."date_of_completion" AS "date_of_completion" FROM "courses" AS "LHS" INNER JOIN "student_course_enrolment" AS "RHS" ON ("LHS"."course_id" = "RHS"."course_id")) WHERE ("course_name" = 'Spanish') ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST;

/*
Gold Result:
('2022-01-10 10:00:00',)
('2022-05-20 10:00:00',)
('2022-05-20 10:00:00',)
('2022-09-15 10:00:00',)
*/

-- Prediction Query
SELECT T2.date_of_enrolment FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id WHERE T1.course_name = 'Spanish';

/*
Prediction Result:
('2022-09-15 10:00:00',)
('2022-01-10 10:00:00',)
('2022-05-20 10:00:00',)
('2022-05-20 10:00:00',)
*/