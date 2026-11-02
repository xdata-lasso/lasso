-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1010, 'product', 'Michael Carlson', 'image', 'Zachary Rice', 'Shannon Smith', 'Le', 'rest', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1013, 'development', 'Nicole Vaughn', 'sell', 'Zachary Santos', 'Joseph Martinez', 'Walker', 'ground', '301 Jeremy Bypass
Chadbury, KY 88185');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1011, '1978-09-09', '1979-10-10', 'Phillip Ryan', 'start', 'Tamara George', 'Brian Cox DVM', 'Roman');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1014, '1982-02-13', '1983-03-14', 'Mr. Nathaniel Khan', 'part', 'Richard Aguirre', 'Brent Jordan', 'Henderson');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1012, 'David Bradley');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1015, 'Nicholas Nunez');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1010, 1012, 1010, 'Nicholas Cabrera', 'She campaign little near enter their institution.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1013, 1015, 1013, 'Mrs. Jennifer Morgan', 'Eat couple large instead.');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1012, 1011, 1010, '1980-11-11', '1981-01-12');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1015, 1014, 1013, '1984-04-15', '1985-05-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT course_name, MAX(n) AS n FROM (SELECT course_name, COUNT(*) AS n FROM (SELECT course_id, author_id, subject_id, course_name, course_description, student_id, date_of_enrolment, date_of_completion, subject_id AS registration_id FROM (SELECT author_id AS course_id, author_id, subject_id, course_name, course_description, student_id, date_of_enrolment, date_of_completion FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.student_id AS student_id, RHS.date_of_enrolment AS date_of_enrolment, RHS.date_of_completion AS date_of_completion FROM courses AS LHS INNER JOIN student_course_enrolment AS RHS ON (LHS.author_id = RHS.course_id AND LHS.subject_id = RHS.registration_id)))) GROUP BY course_name) GROUP BY course_name) ORDER BY course_name;

/*
Gold Result:
('Mrs. Jennifer Morgan',)
('Nicholas Cabrera',)
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Mrs. Jennifer Morgan',)
*/