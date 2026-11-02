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
-- Tests basic matching ('Julio'), non-matching ('Maria'), and case sensitivity ('julio') alongside duplicate course names and ordering.
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'Computer Science');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "personal_name", "middle_name", "family_name") VALUES (1, 'Julio', 'A', 'Iglesias');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "personal_name", "middle_name", "family_name") VALUES (2, 'Maria', 'B', 'Carey');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "personal_name", "middle_name", "family_name") VALUES (3, 'julio', 'C', 'Lower');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (101, 1, 1, 'Zeta Course', 'Taught by Julio');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (102, 1, 1, 'Alpha Course', 'Taught by Julio');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (103, 1, 1, 'Alpha Course', 'Duplicate course name by Julio');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (104, 1, 2, 'Beta Course', 'Taught by Maria');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (105, 1, 3, 'Gamma Course', 'Taught by lowercase julio');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "course_name" FROM (SELECT * FROM "courses" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "course_authors_and_tutors" WHERE ("personal_name" <> 'Julio')) AS RHS WHERE (LHS.author_id = RHS.author_id))) ORDER BY course_name, "course_name" NULLS LAST;

/*
Gold Result:
('Alpha Course',)
('Alpha Course',)
('Zeta Course',)
*/

-- Prediction Query
SELECT T2.course_name FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id = T2.author_id WHERE T1.personal_name = 'Julio';

/*
Prediction Result:
('Zeta Course',)
('Alpha Course',)
('Alpha Course',)
*/