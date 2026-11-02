-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course_authors_and_tutors --
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'f3b', 'cou_528ef7', 'cou_3feae2', 'cou_1c585e', 'cou_ee799e', 'cou_11b971', '1', 'cou_93c33d');

-- Inserting into table: subjects --
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1, 'Computer Science');

INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (-2147483647, 'Computer Science');

INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (3, 'Computer Science');

INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (2, 'sub_1c9658');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 1, 1, 'rhs_94bf00', 'rhs_4f2802');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483647, 1, 1, 'rhs_580ec9', 'rhs_cbbc15');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (3, 1, 1, 'rhs_580ec9', 'rhs_cbbc15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "course_name", "course_description" FROM (SELECT "LHS"."subject_id" AS "subject_id", "LHS"."subject_name" AS "subject_name", "RHS"."course_id" AS "course_id", "RHS"."author_id" AS "author_id", "RHS"."course_name" AS "course_name", "RHS"."course_description" AS "course_description" FROM "subjects" AS "LHS" LEFT JOIN "courses" AS "RHS" ON ("LHS"."subject_id" = "RHS"."subject_id")) WHERE ("subject_name" = 'Computer Science') ORDER BY course_name, "course_name" NULLS LAST, "course_description" NULLS LAST;

/*
Gold Result:
(None, None)
(None, None)
('rhs_580ec9', 'rhs_cbbc15')
('rhs_580ec9', 'rhs_cbbc15')
('rhs_94bf00', 'rhs_4f2802')
*/

-- Prediction Query
SELECT T1.course_name, T1.course_description FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id = T2.subject_id WHERE T2.subject_name = 'Computer Science';

/*
Prediction Result:
('rhs_580ec9', 'rhs_cbbc15')
('rhs_94bf00', 'rhs_4f2802')
('rhs_580ec9', 'rhs_cbbc15')
*/