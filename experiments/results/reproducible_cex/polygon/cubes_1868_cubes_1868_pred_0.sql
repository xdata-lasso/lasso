-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (34, 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (18, 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (20, 37, 37, 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (19, 37, 37, 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37', 'Computer Science37');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (37, 'Computer Science');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (21, 'Computer Science');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (33, 37, 34, NULL, 'Computer Science39');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (35, 37, NULL, 'Computer Science40', 'Computer Science41');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (23, 19, 33, 37, 37);
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (22, 19, 33, 37, 37);
INSERT INTO "Student_Tests_Taken" ("registration_id", "date_test_taken", "test_result") VALUES (22, 37, 'Computer Science37');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "course_name", "course_description" FROM (SELECT "LHS"."subject_id" AS "subject_id", "LHS"."subject_name" AS "subject_name", "RHS"."course_id" AS "course_id", "RHS"."author_id" AS "author_id", "RHS"."course_name" AS "course_name", "RHS"."course_description" AS "course_description" FROM "subjects" AS "LHS" LEFT JOIN "courses" AS "RHS" ON ("LHS"."subject_id" = "RHS"."subject_id")) WHERE ("subject_name" = 'Computer Science') ORDER BY course_name, "course_name" NULLS LAST, "course_description" NULLS LAST;

/*
Gold Result:
(None, 'Computer Science39')
(None, None)
('Computer Science40', 'Computer Science41')
*/

-- Prediction Query
SELECT T1.course_name, T1.course_description FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id = T2.subject_id WHERE T2.subject_name = 'Computer Science';

/*
Prediction Result:
(None, 'Computer Science39')
('Computer Science40', 'Computer Science41')
*/