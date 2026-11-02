-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Subjects" ("subject_id", "subject_name") VALUES (1, 'Math');
INSERT INTO "Course_Authors_and_Tutors" ("author_id", "author_tutor_ATB", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1, 'ATB', 'user1', 'pass1', 'John', 'M', 'Doe', 'M', '123 Street');
INSERT INTO "Students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2023-01-01', '2023-01-02', 'stud1', 'pass1', 'Alice', 'A', 'Smith');
INSERT INTO "Courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 1, 1, 'Algebra', 'Basic Algebra');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1, 1, 1, '2023-01-01', '2023-02-01');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (2, 1, 1, '2023-02-01', '2023-03-01');
INSERT INTO "Student_Course_Enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (3, 1, 1, '2023-03-01', '2023-04-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name AS course_description, course_description AS course_name FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.n AS n FROM courses AS LHS LEFT JOIN (SELECT course_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY course_id) AS RHS ON (LHS.course_id = RHS.course_id)) WHERE (n > 2) ORDER BY course_description, course_name NULLS LAST;

/*
Gold Result:
('Algebra', 'Basic Algebra')
*/

-- Prediction Query
SELECT T1.course_description, T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name HAVING COUNT(*) > 2;

/*
Prediction Result:
('Basic Algebra', 'Algebra')
*/