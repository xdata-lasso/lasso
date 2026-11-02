-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (9, '14', '14', '14', '14', '14', '14', '14', '14');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (11, 14, 14, '14', '14', '14', '14', '14');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (10, 14, 14, '14', '14', '14', '14', '14');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (12, '14');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (13, 12, 9, '14', '14');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (15, 10, 13, 14, 14);
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (14, 11, NULL, 14, 14);
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (14, 14, '14');
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (14, 14, '14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_course_id_ FROM student_course_enrolment ORDER BY count_course_id_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(course_id) FROM Student_Course_Enrolment;

/*
Prediction Result:
(1,)
*/