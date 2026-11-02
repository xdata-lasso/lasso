-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1004, 'hear', 'Derek Zuniga', 'past', 'Daniel Bright', 'Ann Williams', 'Rodriguez', 'product', '166 Rice Plaza Apt. 184
Danielchester, GA 59971');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1003, 'option', 'Nicole Patterson', 'raise', 'Mark Ferguson', 'Joel Nelson', 'Schaefer', 'rise', '30564 Jason Port Suite 376
Thomasberg, IA 98148');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author_id, author_tutor_atb, login_name, password, personal_name, middle_name, family_name, gender_mf, address_line_1 FROM course_authors_and_tutors ORDER BY author_id;

/*
Gold Result:
(1003, 'option', 'Nicole Patterson', 'raise', 'Mark Ferguson', 'Joel Nelson', 'Schaefer', 'rise', '30564 Jason Port Suite 376\nThomasberg, IA 98148')
(1004, 'hear', 'Derek Zuniga', 'past', 'Daniel Bright', 'Ann Williams', 'Rodriguez', 'product', '166 Rice Plaza Apt. 184\nDanielchester, GA 59971')
*/

-- Prediction Query
SELECT * FROM Course_Authors_and_Tutors ORDER BY personal_name, Course_Authors_and_Tutors.author_id NULLS LAST;

/*
Prediction Result:
(1004, 'hear', 'Derek Zuniga', 'past', 'Daniel Bright', 'Ann Williams', 'Rodriguez', 'product', '166 Rice Plaza Apt. 184\nDanielchester, GA 59971')
(1003, 'option', 'Nicole Patterson', 'raise', 'Mark Ferguson', 'Joel Nelson', 'Schaefer', 'rise', '30564 Jason Port Suite 376\nThomasberg, IA 98148')
*/