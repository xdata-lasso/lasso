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
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (-2147483648, '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'stu_15c23d', 'stu_9416f0', 'stu_0698f5', 'stu_bce5a9', 'stu_156c6e');

-- Inserting into table: subjects --
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (-2147483648, 'sub_1c9658');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, -2147483648, -2147483648, 't1__630378', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (3, -2147483648, -2147483648, 't1__630378', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483647, -2147483648, -2147483648, 't1__630378', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (2, -2147483648, -2147483648, 't1__630378', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (4, -2147483648, -2147483648, 't1__630378', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (5, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (6, -2147483648, -2147483648, 't1__a9527d', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (7, -2147483648, -2147483648, 't1__a9527d', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (8, -2147483648, -2147483648, NULL, 'cou_085990');

-- Inserting into table: student_course_enrolment --
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483648, -2147483648, 1, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483647, -2147483648, 1, '2020-11-05 04:59:51+00:00', '2025-11-08 19:01:33+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483646, -2147483648, 1, '2024-06-06 00:28:47+00:00', '2022-10-19 03:44:42+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483645, -2147483648, 5, '2022-01-21 14:23:36+00:00', '2022-10-06 13:20:05+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483644, -2147483648, 5, '2022-01-03 02:42:55+00:00', '2024-04-12 00:38:47+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483643, -2147483648, 5, '2022-08-02 13:58:36+00:00', '2021-01-23 18:11:33+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (2, -2147483648, 1, '2021-12-31 07:20:26+00:00', '2021-12-08 15:32:00+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (3, -2147483648, 1, '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483640, -2147483648, 1, '2022-09-29 20:25:58+00:00', '2021-08-19 01:10:02+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483639, -2147483648, 1, '2021-09-24 11:50:48+00:00', '2025-01-09 01:18:18+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (5, -2147483648, 6, '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (4, -2147483648, 3, '2022-06-28 11:34:24+00:00', '2021-06-17 14:22:38+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (6, -2147483648, 8, '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT course_name, n AS count___ FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, LHS.registration_id AS registration_id, LHS.student_id AS student_id, LHS.date_of_enrolment AS date_of_enrolment, LHS.date_of_completion AS date_of_completion, RHS.n AS n FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.registration_id AS registration_id, RHS.student_id AS student_id, RHS.date_of_enrolment AS date_of_enrolment, RHS.date_of_completion AS date_of_completion FROM courses AS LHS INNER JOIN student_course_enrolment AS RHS ON (LHS.course_id = RHS.course_id)) AS LHS INNER JOIN (SELECT course_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY course_id) AS RHS ON (LHS.course_id = RHS.course_id)) ORDER BY course_name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('cou_042511', 3)
('t1__630378', 1)
('t1__630378', 7)
('t1__a9527d', 1)
*/

-- Prediction Query
SELECT T1.course_name, COUNT(*) FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name;

/*
Prediction Result:
(None, 1)
('cou_042511', 3)
('t1__630378', 8)
('t1__a9527d', 1)
*/