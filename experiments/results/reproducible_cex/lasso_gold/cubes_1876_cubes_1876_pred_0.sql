-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1056, 'parent', 'Tina Sanders', 'senior', 'Kevin Rivas', 'Michael Turner', 'Sutton', 'support', '8651 Smith Manor
Garciastad, SC 60759');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1061, 'up', 'Sheryl Peters', 'nation', 'Angela Cortez', 'Peter Vaughn DDS', 'Henry', 'structure', '63495 Tran Key Suite 855
Nelsonview, IN 16315');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1057, '1997-02-11', '1998-03-12', 'Jessica Gross', 'rather', 'Robert Medina', 'Mr. Nicholas Adams', 'Christian');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1062, '1973-07-16', '1974-08-17', 'Emily Newton', 'sound', 'Cheryl Rodgers', 'Kevin Wolf', 'Carlson');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1058, 'Angelica Keith');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1063, 'Dr. Elizabeth Ward');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1059, 1058, 1056, 'John Bishop', 'From management foot maintain great election.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1064, 1063, 1061, 'Michael Martinez', 'Window network recently.');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1060, 1057, 1059, '1970-04-13', '1971-05-14');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1065, 1062, 1064, '1975-09-18', '1976-10-19');
INSERT INTO "student_tests_taken" ("registration_id", "date_test_taken", "test_result") VALUES (1060, '1972-06-15', 'far');
INSERT INTO "student_tests_taken" ("registration_id", "date_test_taken", "test_result") VALUES (1065, '1977-11-20', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT test_result, n AS count___ FROM (SELECT test_result, COUNT(*) AS n FROM student_tests_taken GROUP BY test_result) ORDER BY test_result, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('far', 1)
*/

-- Prediction Query
SELECT test_result, COUNT(*) FROM Student_Tests_Taken GROUP BY test_result ORDER BY COUNT(*) DESC, test_result NULLS LAST;

/*
Prediction Result:
('far', 1)
(None, 1)
*/