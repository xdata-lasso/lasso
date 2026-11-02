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

-- Inserting into table: students --
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (-2147483648, '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00', 'stu_15c23d', 'stu_9416f0', 'stu_0698f5', 'stu_bce5a9', 'stu_156c6e');

-- Inserting into table: subjects --
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1, 'sub_1c9658');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 1, 1, 'lhs_4dcb46', 'lhs_aee23f');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483647, 1, 1, 'lhs_be4550', 'lhs_e46333');

-- Inserting into table: student_course_enrolment --
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483648, -2147483648, 1, '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483647, -2147483648, 1, '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483646, -2147483648, 1, '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483645, -2147483648, 1, '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483644, -2147483648, 1, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483643, -2147483648, 1, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483642, -2147483648, 1, '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483641, -2147483648, 1, '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483640, -2147483648, 1, '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483639, -2147483648, 1, '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483638, -2147483648, 1, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483637, -2147483648, 1, '2022-10-06 13:20:05+00:00', '2023-05-25 17:04:36+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483636, -2147483648, 1, '2022-07-05 02:28:20+00:00', '2025-08-22 00:34:24+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483635, -2147483648, 1, '2022-12-20 09:53:17+00:00', '2020-04-05 14:43:51+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483634, -2147483648, 1, '2022-01-03 02:42:55+00:00', '2024-04-12 00:38:47+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483633, -2147483648, 1, '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483632, -2147483648, 1, '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483631, -2147483648, 1, '2021-01-23 18:11:33+00:00', '2021-07-20 10:41:36+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483630, -2147483648, 1, '2025-02-07 06:53:31+00:00', '2021-10-06 00:40:57+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483629, -2147483648, 1, '2022-04-12 01:47:28+00:00', '2021-08-20 16:50:24+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483628, -2147483648, 1, '2021-12-31 07:20:26+00:00', '2021-12-08 15:32:00+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483627, -2147483648, 1, '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483626, -2147483648, 1, '2024-02-29 12:08:41+00:00', '2022-10-15 07:04:26+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483625, -2147483648, 1, '2022-12-10 02:38:39+00:00', '2024-05-04 23:07:19+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483624, -2147483648, 1, '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483623, -2147483648, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483622, -2147483648, 1, '2025-05-02 19:47:39+00:00', '2023-07-26 05:50:21+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name AS course_description, course_description AS course_name FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.n AS n FROM courses AS LHS LEFT JOIN (SELECT course_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY course_id) AS RHS ON (LHS.course_id = RHS.course_id)) WHERE (n > 2) ORDER BY course_description, course_name NULLS LAST;

/*
Gold Result:
('lhs_4dcb46', 'lhs_aee23f')
*/

-- Prediction Query
SELECT T1.course_description, T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name HAVING COUNT(*) > 2;

/*
Prediction Result:
('lhs_aee23f', 'lhs_4dcb46')
*/