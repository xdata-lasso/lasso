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
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_53345e', 'lhs_85333a', 'lhs_7edaf7', 'lhs_cae18d', 'lhs_467dcb');

INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (-2147483647, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_edba44', 'lhs_4ef409', 'lhs_e8df62', 'lhs_4c0055', 'lhs_179bb6');

INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (-2147483646, '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00', 'stu_15c23d', 'stu_9416f0', 'q_0_2b2547', 'stu_bce5a9', 'stu_156c6e');

INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (-2147483645, '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00', 'stu_15c23d', 'stu_9416f0', 'q_0_2b2547', 'stu_bce5a9', 'stu_156c6e');

INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (2, '2024-02-22 05:22:28+00:00', '2021-05-28 17:00:04+00:00', 'stu_15c23d', 'stu_9416f0', 'stu_0698f5', 'stu_bce5a9', 'stu_156c6e');

INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (3, '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'stu_15c23d', 'stu_9416f0', 'stu_0698f5', 'stu_bce5a9', 'stu_156c6e');

-- Inserting into table: subjects --
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (-2147483648, 'sub_1c9658');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483648, -2147483648, -2147483648, 'cou_042511', 'cou_085990');

-- Inserting into table: student_course_enrolment --
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (4, 2, -2147483648, '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (5, 3, -2147483648, '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT personal_name FROM (SELECT * FROM students AS LHS WHERE NOT EXISTS(SELECT 1 FROM student_course_enrolment AS RHS WHERE (LHS.student_id = RHS.student_id))) ORDER BY personal_name;

/*
Gold Result:
('lhs_7edaf7',)
('lhs_e8df62',)
('q_0_2b2547',)
('q_0_2b2547',)
*/

-- Prediction Query
SELECT personal_name FROM Students EXCEPT SELECT T1.personal_name FROM Students AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.student_id = T2.student_id;

/*
Prediction Result:
('lhs_7edaf7',)
('lhs_e8df62',)
('q_0_2b2547',)
*/