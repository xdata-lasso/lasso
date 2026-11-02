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
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'AUT', 'jdoe', 'pass123', 'John', 'M', 'Doe', 'M', '123 Main St');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (10, 'Z_Physics');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (20, 'A_History');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (30, 'M_Biology');
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (40, 'Unused_Art');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (101, 10, 1, 'Physics I', 'Intro to Physics');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (102, 10, 1, 'Physics II', 'Advanced Physics');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (201, 20, 1, 'World History', 'Ancient to Modern');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (202, 20, 1, 'European History', 'Renaissance');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (203, 20, 1, 'Asian History', 'Dynasties');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (301, 30, 1, 'Cell Biology', 'Intro to Cells');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT subject_id, subject_name, n AS count___ FROM (SELECT LHS.subject_id AS subject_id, LHS.n AS n, RHS.subject_name AS subject_name FROM (SELECT subject_id, COUNT(*) AS n FROM courses GROUP BY subject_id) AS LHS INNER JOIN subjects AS RHS ON (LHS.subject_id = RHS.subject_id)) ORDER BY subject_id, subject_name NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(10, 'Z_Physics', 2)
(20, 'A_History', 3)
(30, 'M_Biology', 1)
*/

-- Prediction Query
SELECT T1.subject_id, T2.subject_name, COUNT(*) FROM Courses AS T1 JOIN Subjects AS T2 ON T1.subject_id = T2.subject_id GROUP BY T1.subject_id ORDER BY COUNT(*) ASC, T1.subject_id NULLS LAST, T2.subject_name NULLS LAST;

/*
Prediction Result:
(30, 'M_Biology', 1)
(10, 'Z_Physics', 2)
(20, 'A_History', 3)
*/