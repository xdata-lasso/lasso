-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1052, 'according', 'Elizabeth Price', 'wait', 'Jennifer Adkins', 'Lindsey Walker', 'Robinson', 'least', '6272 Rebecca Ramp Apt. 162
Whiteview, MS 43407');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1062, 'rather', 'Robert Medina', 'member', 'Roger Vargas', 'David Michael', 'Ramirez', 'little', '965 Troy Islands Apt. 735
Matthewview, OH 01831');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1053, '1988-04-02', '1989-05-03', 'Gabriel Juarez', 'hundred', 'Trevor Fisher', 'Julie Curry', 'Williams');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1063, '1998-03-12', '1970-04-13', 'Cheryl Allen', 'investment', 'Peter Vaughn DDS', 'Ricky Davis II', 'Holt');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1054, 'Courtney Jones');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1064, 'Kevin Kennedy');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1055, 1054, 1052, 'Amanda Johnson', 'Current after charge call prove.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1065, 1064, 1062, 'Jessica Reese', 'Goal law fill discover return firm.');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1056, 1053, 1055, '1990-06-04', '1991-07-05');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1066, 1063, 1065, '1971-05-14', '1972-06-15');
INSERT INTO "student_tests_taken" ("registration_id", "date_test_taken", "test_result") VALUES (1056, '1992-08-06', 'Pass');
INSERT INTO "student_tests_taken" ("registration_id", "date_test_taken", "test_result") VALUES (1056, '1997-02-11', 'Pass');
INSERT INTO "student_tests_taken" ("registration_id", "date_test_taken", "test_result") VALUES (1066, '1973-07-16', 'Pass');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment" FROM (SELECT "LHS"."registration_id" AS "registration_id", "LHS"."student_id" AS "student_id", "LHS"."course_id" AS "course_id", "LHS"."date_of_enrolment" AS "date_of_enrolment", "LHS"."date_of_completion" AS "date_of_completion", "RHS"."date_test_taken" AS "date_test_taken", "RHS"."test_result" AS "test_result" FROM "student_course_enrolment" AS "LHS" INNER JOIN "student_tests_taken" AS "RHS" ON ("LHS"."registration_id" = "RHS"."registration_id")) WHERE ("test_result" = 'Pass') ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST;

/*
Gold Result:
('1971-05-14',)
('1990-06-04',)
('1990-06-04',)
*/

-- Prediction Query
SELECT T1.date_of_enrolment FROM Student_Course_Enrolment AS T1 JOIN Student_Tests_Taken AS T2 ON T1.registration_id = T2.registration_id WHERE T2.test_result = 'Pass';

/*
Prediction Result:
('1990-06-04',)
('1990-06-04',)
('1971-05-14',)
*/