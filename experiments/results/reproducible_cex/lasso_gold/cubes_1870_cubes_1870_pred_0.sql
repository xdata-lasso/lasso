-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1045, 'office', 'Stephanie Freeman', 'explain', 'Julio', 'Allen Rogers', 'Shelton', 'interview', '98069 Christopher Meadow Apt. 720
Nicholasborough, NH 43341');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1051, 'recently', 'Jonathan Peterson', 'time', 'Julio', 'John Hamilton', 'Cox', 'vote', '2849 Marshall Views
Marcusbury, MP 11860');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1046, 'Shawn Ramirez');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1052, 'Jerry Christensen');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1049, NULL);
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1047, 1046, 1045, 'Jennifer Conley', 'Affect much yourself glass practice sit prepare.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1050, 1049, 1045, 'Sarah Burke', 'Someone not American mouth.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1053, 1052, 1051, 'Mary Rogers', 'Surface consider deep something future they red.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "course_name" FROM (SELECT * FROM "courses" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "course_authors_and_tutors" WHERE ("personal_name" <> 'Julio')) AS RHS WHERE (LHS.author_id = RHS.author_id))) ORDER BY course_name, "course_name" NULLS LAST;

/*
Gold Result:
('Jennifer Conley',)
('Mary Rogers',)
('Sarah Burke',)
*/

-- Prediction Query
SELECT T2.course_name FROM Course_Authors_and_Tutors AS T1 JOIN Courses AS T2 ON T1.author_id = T2.author_id WHERE T1.personal_name = 'Julio';

/*
Prediction Result:
('Jennifer Conley',)
('Sarah Burke',)
('Mary Rogers',)
*/