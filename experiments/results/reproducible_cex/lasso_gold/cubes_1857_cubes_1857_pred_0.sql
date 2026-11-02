-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1072, 'arm', 'Melissa Martinez', 'trouble', 'Ashley Smith', 'John Peterson', 'Sheppard', 'entire', 'USCGC Wilson
FPO AE 53022');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1082, 'against', 'Miss Debra Williams PhD', 'many', 'Jessica Ramirez', 'Jessica Olsen DVM', 'Ortiz', 'full', '6746 Shawn Island
Marcusfurt, VI 67950');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1073, '1993-09-07', '1994-10-08', 'Kenneth Parks Jr.', 'talk', 'Karson', 'Elizabeth Mcknight', 'Wilson');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1083, '1972-06-15', '1973-07-16', 'April Booth', 'maintain', 'Karson', 'Cody Cox', 'Avila');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1074, 'Lisa Gibbs');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1084, 'Olivia Harris');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1075, 1074, 1072, 'Joseph Hayes', 'Father open investment notice art whether.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1085, 1084, 1082, 'Tanya Kim', 'Building win participant dream citizen nearly need.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1080, NULL, NULL, NULL, NULL);
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1076, 1073, 1075, '1995-11-09', '1996-01-10');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1081, 1073, 1080, '1970-04-13', '1971-05-14');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1086, 1083, 1085, '1974-08-17', '1975-09-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment", "date_of_completion" FROM (SELECT "LHS"."student_id" AS "student_id", "LHS"."date_of_registration" AS "date_of_registration", "LHS"."date_of_latest_logon" AS "date_of_latest_logon", "LHS"."login_name" AS "login_name", "LHS"."password" AS "password", "LHS"."personal_name" AS "personal_name", "LHS"."middle_name" AS "middle_name", "LHS"."family_name" AS "family_name", "RHS"."registration_id" AS "registration_id", "RHS"."course_id" AS "course_id", "RHS"."date_of_enrolment" AS "date_of_enrolment", "RHS"."date_of_completion" AS "date_of_completion" FROM "students" AS "LHS" INNER JOIN "student_course_enrolment" AS "RHS" ON ("LHS"."student_id" = "RHS"."student_id")) WHERE ("personal_name" = 'Karson') ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST, "date_of_completion" NULLS LAST;

/*
Gold Result:
('1970-04-13', '1971-05-14')
('1974-08-17', '1975-09-18')
('1995-11-09', '1996-01-10')
*/

-- Prediction Query
SELECT T1.date_of_enrolment, T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id WHERE T2.personal_name = 'Karson';

/*
Prediction Result:
('1995-11-09', '1996-01-10')
('1970-04-13', '1971-05-14')
('1974-08-17', '1975-09-18')
*/