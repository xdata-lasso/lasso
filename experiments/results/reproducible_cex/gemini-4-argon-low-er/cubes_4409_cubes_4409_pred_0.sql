-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Students (student_id, login_name) VALUES (1, 'user1');
INSERT INTO Students (student_id, login_name) VALUES (2, 'user2');
INSERT INTO Subjects (subject_id, subject_name) VALUES (1, 'Math');
INSERT INTO Course_Authors_and_Tutors (author_id, login_name) VALUES (1, 'author1');
INSERT INTO Courses (course_id, subject_id, author_id, course_name) VALUES (1, 1, 1, 'Course1');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id) VALUES (1, 1, 1);
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id) VALUES (2, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id, login_name FROM (SELECT LHS.student_id AS student_id, LHS.date_of_registration AS date_of_registration, LHS.date_of_latest_logon AS date_of_latest_logon, LHS.login_name AS login_name, LHS.password AS password, LHS.personal_name AS personal_name, LHS.middle_name AS middle_name, LHS.family_name AS family_name, LHS.n AS n FROM (SELECT LHS.student_id AS student_id, LHS.date_of_registration AS date_of_registration, LHS.date_of_latest_logon AS date_of_latest_logon, LHS.login_name AS login_name, LHS.password AS password, LHS.personal_name AS personal_name, LHS.middle_name AS middle_name, LHS.family_name AS family_name, RHS.n AS n FROM students AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY student_id) AS RHS ON (LHS.student_id = RHS.student_id)) AS LHS INNER JOIN (SELECT student_id, MAX(n) OVER () AS n FROM (SELECT student_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY student_id)) AS RHS ON (LHS.student_id = RHS.student_id AND LHS.n = RHS.n)) ORDER BY student_id, login_name NULLS LAST;

/*
Gold Result:
(1, 'user1')
(2, 'user2')
*/

-- Prediction Query
SELECT T1.student_id, T2.login_name FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id GROUP BY T1.student_id ORDER BY COUNT(*) DESC, T1.student_id NULLS LAST, T2.login_name NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 'user1')
*/