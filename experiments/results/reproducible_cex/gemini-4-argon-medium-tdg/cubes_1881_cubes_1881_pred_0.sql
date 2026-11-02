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
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2023-01-01 10:00:00', '2023-01-02 10:00:00', 'z_ward', 'pass1', 'Alice', 'Beta', 'Ward');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (2, '2023-01-01 11:00:00', '2023-01-02 11:00:00', 'a_ward', 'pass2', 'Bob', 'Charlie', 'Ward');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (3, '2023-01-01 12:00:00', '2023-01-02 12:00:00', 'a_ward', 'pass3', 'David', 'Edward', 'Ward');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (4, '2023-01-01 13:00:00', '2023-01-02 13:00:00', 'not_ward', 'pass4', 'Ward', 'Ward', 'Smith');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'ATB', 'tutor_ward', 'tpass', 'Tom', 'M', 'Ward', 'M', '123 St');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "login_name" FROM "students" WHERE ("family_name" = 'Ward') ORDER BY login_name, students.student_id NULLS LAST;

/*
Gold Result:
('a_ward',)
('a_ward',)
('z_ward',)
*/

-- Prediction Query
SELECT login_name FROM Students WHERE family_name = 'Ward';

/*
Prediction Result:
('z_ward',)
('a_ward',)
('a_ward',)
*/