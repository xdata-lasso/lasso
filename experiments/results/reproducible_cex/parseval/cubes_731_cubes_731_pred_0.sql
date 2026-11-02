-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1" TEXT(255), "line_2" TEXT(255), "line_3" TEXT(255), "city" TEXT(255), "zip_postcode" TEXT(20), "state_province_county" TEXT(255), "country" TEXT(255), "other_address_details" TEXT(255));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "course_name" TEXT(255), "course_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "Departments" ("department_id" INTEGER PRIMARY KEY, "department_name" TEXT(255), "department_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "Degree_Programs" ("degree_program_id" INTEGER PRIMARY KEY, "department_id" INTEGER, "degree_summary_name" TEXT(255), "degree_summary_description" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("department_id") REFERENCES "Departments" ("department_id"));

CREATE TABLE "Sections" ("section_id" INTEGER PRIMARY KEY, "course_id" INTEGER, "section_name" TEXT(255), "section_description" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Semesters" ("semester_id" INTEGER PRIMARY KEY, "semester_name" TEXT(255), "semester_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "permanent_address_id" INTEGER, "current_address_id" INTEGER, "first_name" TEXT(80), "middle_name" TEXT(40), "last_name" TEXT(40), "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "ssn" TEXT(40), "date_first_registered" DATETIME, "date_left" DATETIME, "other_student_details" TEXT(255), FOREIGN KEY ("permanent_address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("current_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Student_Enrolment" ("student_enrolment_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "semester_id" INTEGER, "degree_program_id" INTEGER, "other_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("semester_id") REFERENCES "Semesters" ("semester_id"), FOREIGN KEY ("degree_program_id") REFERENCES "Degree_Programs" ("degree_program_id"));

CREATE TABLE "Student_Enrolment_Courses" ("student_course_id" INTEGER PRIMARY KEY, "student_enrolment_id" INTEGER, "course_id" INTEGER, FOREIGN KEY ("student_enrolment_id") REFERENCES "Student_Enrolment" ("student_enrolment_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Transcripts" ("transcript_id" INTEGER PRIMARY KEY, "transcript_date" DATETIME, "other_details" TEXT(255));

CREATE TABLE "Transcript_Contents" ("transcript_id" INTEGER, "student_course_id" INTEGER, FOREIGN KEY ("transcript_id") REFERENCES "Transcripts" ("transcript_id"), FOREIGN KEY ("student_course_id") REFERENCES "Student_Enrolment_Courses" ("student_course_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 'add_92aefd', 'NorthCarolina', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483647, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 'add_92aefd', 'NorthCarolina', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (2, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 'add_92aefd', 'NorthCarolina', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (3, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 'add_92aefd', 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (4, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 'add_92aefd', NULL, 'add_0b134e', 'add_ea5be5');

-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (-2147483648, 'dep_f95b49', 'dep_596df0', 'dep_74e813');

-- Inserting into table: degree_programs --
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (-2147483648, -2147483648, 'deg_f9b1e5', 'deg_d94ec8', 'deg_531e7c');

-- Inserting into table: semesters --
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (-2147483648, 'sem_11aed7', 'sem_0596c9', 'sem_ee4acd');

-- Inserting into table: students --
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483648, 1, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1, 1, 1, 'stu_314a8f', 'stu_bce5a9', 't3__e7a0c2', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (3, 1, 1, 'stu_314a8f', 'stu_bce5a9', 't3__e7a0c2', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-06-28 11:34:24+00:00', '2021-06-17 14:22:38+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (2, -2147483647, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483645, 1, -2147483647, 'stu_314a8f', 'stu_bce5a9', 't3__e7a0c2', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483643, -2147483647, 3, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-01-21 14:23:36+00:00', '2022-10-06 13:20:05+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483642, -2147483647, 3, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483641, -2147483647, 3, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-01-18 15:57:55+00:00', '2022-04-12 01:47:28+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483640, 3, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-10-15 07:04:26+00:00', '2021-11-09 05:42:50+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483639, 2, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2024-03-03 15:52:53+00:00', '2020-04-28 17:03:46+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483638, -2147483647, 3, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483637, -2147483647, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2025-01-09 01:18:18+00:00', '2022-05-20 13:35:30+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483636, -2147483647, 3, 'stu_314a8f', 'stu_bce5a9', 't3__e7a0c2', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2025-09-22 03:26:15+00:00', '2023-10-05 06:38:23+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483635, 3, 2, 'stu_314a8f', 'stu_bce5a9', 't3__e7a0c2', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2023-03-22 03:47:49+00:00', '2024-10-18 05:00:47+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483634, 3, -2147483647, 'stu_314a8f', 'stu_bce5a9', 't3__e7a0c2', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2021-07-01 18:29:24+00:00', '2020-08-18 16:30:34+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483633, -2147483647, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2025-02-02 04:37:17+00:00', '2024-06-18 00:42:26+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483632, 2, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-03-25 08:00:08+00:00', '2023-09-08 22:37:16+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483631, 3, 3, 'stu_314a8f', 'stu_bce5a9', 't3__e7a0c2', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2025-02-03 05:21:58+00:00', '2022-01-16 00:33:03+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483630, 2, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2021-05-26 08:15:06+00:00', '2020-10-15 10:13:01+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483629, -2147483647, 1, 'stu_314a8f', 'stu_bce5a9', 't1__b0834f', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2020-08-21 23:51:43+00:00', '2020-10-30 07:33:08+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483628, 3, 1, 'stu_314a8f', 'stu_bce5a9', NULL, 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2021-01-22 00:53:52+00:00', '2023-01-02 20:56:29+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (4, 4, 4, 'stu_314a8f', 'stu_bce5a9', 'stu_84974d', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2025-11-23 07:28:46+00:00', '2025-10-14 06:39:08+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (5, 4, 3, 'stu_314a8f', 'stu_bce5a9', NULL, 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483625, 2, 2, 'stu_314a8f', 'stu_bce5a9', 'O', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483624, 2, -2147483647, 'stu_314a8f', 'stu_bce5a9', 'A', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2024-11-14 12:35:58+00:00', '2024-09-28 03:06:45+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483623, -2147483647, 4, 'stu_314a8f', 'stu_bce5a9', 'O', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2024-07-26 19:47:18+00:00', '2020-04-30 23:22:06+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483622, 3, -2147483647, 'stu_314a8f', 'stu_bce5a9', 'A', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2020-11-05 04:59:51+00:00', '2025-11-08 19:01:33+00:00', 'stu_713836');

-- Inserting into table: student_enrolment --
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483648, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483647, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483646, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483645, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483644, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483643, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483642, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483641, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483640, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483639, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483638, 2, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483637, 2, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483636, 2, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483635, 2, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483634, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483633, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483632, 2, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483631, 2, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483630, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483629, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483628, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483627, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483626, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483625, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (2, 2, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (3, 2, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483622, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483621, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483620, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483619, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483618, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483617, 1, -2147483648, -2147483648, 'stu_174fbf');

INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (4, 5, -2147483648, -2147483648, 'stu_174fbf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "last_name" FROM (SELECT "student_id", "current_address_id", "permanent_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details", "current_address_id" AS "address_id" FROM (SELECT "LHS"."student_id" AS "student_id", "LHS"."current_address_id" AS "current_address_id", "LHS"."permanent_address_id" AS "permanent_address_id", "LHS"."first_name" AS "first_name", "LHS"."middle_name" AS "middle_name", "LHS"."last_name" AS "last_name", "LHS"."cell_mobile_number" AS "cell_mobile_number", "LHS"."email_address" AS "email_address", "LHS"."ssn" AS "ssn", "LHS"."date_first_registered" AS "date_first_registered", "LHS"."date_left" AS "date_left", "LHS"."other_student_details" AS "other_student_details", "RHS"."line_1" AS "line_1", "RHS"."line_2" AS "line_2", "RHS"."line_3" AS "line_3", "RHS"."city" AS "city", "RHS"."zip_postcode" AS "zip_postcode", "RHS"."state_province_county" AS "state_province_county", "RHS"."country" AS "country", "RHS"."other_address_details" AS "other_address_details" FROM (SELECT * FROM "students" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM "student_enrolment" AS "RHS" WHERE ("LHS"."student_id" = "RHS"."student_id"))) AS "LHS" INNER JOIN "addresses" AS "RHS" ON ("LHS"."current_address_id" = "RHS"."address_id"))) WHERE ("state_province_county" = 'NorthCarolina') ORDER BY last_name, "last_name" NULLS LAST;

/*
Gold Result:
(None,)
('A',)
('A',)
('O',)
('t1__b0834f',)
('t1__b0834f',)
('t1__b0834f',)
('t1__b0834f',)
('t1__b0834f',)
('t1__b0834f',)
('t1__b0834f',)
('t1__b0834f',)
('t3__e7a0c2',)
('t3__e7a0c2',)
('t3__e7a0c2',)
('t3__e7a0c2',)
*/

-- Prediction Query
SELECT T1.last_name FROM Students AS T1 JOIN Addresses AS T2 ON T1.current_address_id = T2.address_id WHERE T2.state_province_county = 'NorthCarolina' EXCEPT SELECT DISTINCT T3.last_name FROM Students AS T3 JOIN Student_Enrolment AS T4 ON T3.student_id = T4.student_id;

/*
Prediction Result:
('A',)
('O',)
*/