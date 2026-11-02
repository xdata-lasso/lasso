-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1015, 'product', 'Michael Carlson', 'image', 'Zachary Rice', 'Shannon Smith', 'Le', 'rest', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1021, 'development', 'Nicole Vaughn', 'sell', 'Zachary Santos', 'Joseph Martinez', 'Walker', 'ground', '301 Jeremy Bypass
Chadbury, KY 88185');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1016, '1982-02-13', '1983-03-14', 'Phillip Ryan', 'start', 'Tamara George', 'Brian Cox DVM', 'Roman');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1022, '1988-08-19', '1989-09-20', 'Mr. Nathaniel Khan', 'part', 'Richard Aguirre', 'Brent Jordan', 'Henderson');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1017, 'David Bradley');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1023, 'Nicholas Nunez');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1018, 1017, 1015, 'Nicholas Cabrera', 'She campaign little near enter their institution.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1024, 1023, 1021, 'Mrs. Jennifer Morgan', 'Eat couple large instead.');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1019, 1016, 1018, '1984-04-15', '1985-05-16');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1020, 1016, 1018, '1986-06-17', '1987-07-18');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1025, 1022, 1024, '1990-10-21', '1991-11-22');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1026, 1022, 1024, '1992-01-23', '1993-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id, login_name FROM (SELECT LHS.student_id AS student_id, LHS.date_of_registration AS date_of_registration, LHS.date_of_latest_logon AS date_of_latest_logon, LHS.login_name AS login_name, LHS.password AS password, LHS.personal_name AS personal_name, LHS.middle_name AS middle_name, LHS.family_name AS family_name, LHS.n AS n FROM (SELECT LHS.student_id AS student_id, LHS.date_of_registration AS date_of_registration, LHS.date_of_latest_logon AS date_of_latest_logon, LHS.login_name AS login_name, LHS.password AS password, LHS.personal_name AS personal_name, LHS.middle_name AS middle_name, LHS.family_name AS family_name, RHS.n AS n FROM students AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY student_id) AS RHS ON (LHS.student_id = RHS.student_id)) AS LHS INNER JOIN (SELECT student_id, MAX(n) OVER () AS n FROM (SELECT student_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY student_id)) AS RHS ON (LHS.student_id = RHS.student_id AND LHS.n = RHS.n)) ORDER BY student_id, login_name NULLS LAST;

/*
Gold Result:
(1016, 'Phillip Ryan')
(1022, 'Mr. Nathaniel Khan')
*/

-- Prediction Query
SELECT T1.student_id, T2.login_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id GROUP BY T1.student_id ORDER BY COUNT(*) DESC, T1.student_id NULLS LAST, T2.login_name NULLS LAST LIMIT 1;

/*
Prediction Result:
(1016, 'Phillip Ryan')
*/