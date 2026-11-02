-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1034, 'election', 'Miss Patricia Gibson', 'various', 'Cheyenne Horton', 'David Douglas Jr.', 'Potter', 'speech', '28708 Samantha Crossing Suite 278
Stephaniemouth, RI 94777');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1040, 'person', 'Alyssa Day', 'central', 'Catherine Green', 'Jesse Rogers', 'Hobbs', 'fall', '1708 Zoe Keys Apt. 100
East Mary, RI 20474');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1037, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1035, 'Jessica Meadows');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1041, 'John Wilson');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1036, 1035, 1034, 'Christopher Hensley', 'Else easy point she miss phone ever.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1039, 1035, 1037, 'Don Tucker MD', 'Right subject try wonder move trade.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1042, 1041, 1040, 'Julie Scott', 'Cold parent security boy standard who.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject_id, subject_name, n AS count___ FROM (SELECT LHS.subject_id AS subject_id, LHS.n AS n, RHS.subject_name AS subject_name FROM (SELECT subject_id, COUNT(*) AS n FROM courses GROUP BY subject_id) AS LHS INNER JOIN subjects AS RHS ON (LHS.subject_id = RHS.subject_id)) ORDER BY subject_id, subject_name NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(1035, 'Jessica Meadows', 2)
(1041, 'John Wilson', 1)
*/

-- Prediction Query
SELECT T1.subject_id, T2.subject_name, COUNT(*) FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id = T2.subject_id GROUP BY T1.subject_id ORDER BY COUNT(*) ASC, T1.subject_id NULLS LAST, T2.subject_name NULLS LAST;

/*
Prediction Result:
(1041, 'John Wilson', 1)
(1035, 'Jessica Meadows', 2)
*/