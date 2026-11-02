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
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1, '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00', 'stu_15c23d', 'stu_9416f0', 'stu_0698f5', 'stu_bce5a9', 'stu_156c6e');

-- Inserting into table: subjects --
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1, 'sub_1c9658');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1, 1, 1, 'lhs_9ecfc7', 'lhs_0d2698');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483647, 1, 1, 'lhs_1d7336', 'lhs_0e008f');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (2, 1, 1, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (4, 1, 1, 'cou_042511', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483644, 1, 1, 'q_4_1bd4c0', 'cou_085990');

INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (-2147483643, 1, 1, 'q_4_1bd4c0', 'cou_085990');

-- Inserting into table: student_course_enrolment --
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (-2147483647, 1, -2147483647, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (3, 1, -2147483643, '2020-01-15 18:18:33+00:00', '2023-10-02 15:43:02+00:00');

INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (5, 1, -2147483647, '2022-10-06 13:20:05+00:00', '2023-05-25 17:04:36+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT course_name, MAX(n) AS n FROM (SELECT course_name, COUNT(*) AS n FROM (SELECT course_id, author_id, subject_id, course_name, course_description, student_id, date_of_enrolment, date_of_completion, subject_id AS registration_id FROM (SELECT author_id AS course_id, author_id, subject_id, course_name, course_description, student_id, date_of_enrolment, date_of_completion FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.student_id AS student_id, RHS.date_of_enrolment AS date_of_enrolment, RHS.date_of_completion AS date_of_completion FROM courses AS LHS INNER JOIN student_course_enrolment AS RHS ON (LHS.author_id = RHS.course_id AND LHS.subject_id = RHS.registration_id)))) GROUP BY course_name) GROUP BY course_name) ORDER BY course_name;

/*
Gold Result:
('cou_042511',)
('lhs_1d7336',)
('lhs_9ecfc7',)
('q_4_1bd4c0',)
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('lhs_1d7336',)
*/