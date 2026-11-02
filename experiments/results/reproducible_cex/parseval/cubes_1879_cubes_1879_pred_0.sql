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
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (-2147483648, 'f3b', 'cou_528ef7', 'cou_3feae2', 'cou_1c585e', 'cou_ee799e', 'cou_11b971', '1', 'cou_93c33d');

-- Inserting into table: students --
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'stu_15c23d', 'stu_9416f0', 'stu_0698f5', 'stu_bce5a9', 'stu_156c6e');

-- Inserting into table: subjects --
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (-2147483648, 'sub_1c9658');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483647, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (2, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (3, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (4, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (5, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (6, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (7, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (8, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

-- Inserting into table: student_course_enrolment --
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483647, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (2, 1, 1, '2025-02-07 06:53:31+00:00', '2021-10-06 00:40:57+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (3, 1, 1, '2021-12-31 07:20:26+00:00', '2021-12-08 15:32:00+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (4, 1, 1, '2024-02-29 12:08:41+00:00', '2022-10-15 07:04:26+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (5, 1, -2147483647, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (6, 1, 2, '2024-03-03 15:52:53+00:00', '2020-04-28 17:03:46+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (7, 1, 2, '2025-03-10 20:24:26+00:00', '2020-12-01 20:25:15+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (8, 1, 8, '2024-04-11 14:30:53+00:00', '2021-10-03 20:36:13+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, author_id, registration_id AS subject_id FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, course_id AS author_id FROM (SELECT LHS.registration_id AS registration_id, LHS.student_id AS student_id, LHS.course_id AS course_id, LHS.date_of_enrolment AS date_of_enrolment, LHS.date_of_completion AS date_of_completion, RHS.course_id AS course_id_other, RHS.course_name AS course_name, RHS.course_description AS course_description FROM student_course_enrolment AS LHS INNER JOIN courses AS RHS ON (LHS.course_id = RHS.author_id AND LHS.registration_id = RHS.subject_id)))) ORDER BY course_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('cou_042511',)
*/