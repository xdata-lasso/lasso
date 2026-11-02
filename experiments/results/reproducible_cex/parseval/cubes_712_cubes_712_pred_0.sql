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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483648, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 'add_92aefd', 'add_7d1289', 'add_0b134e', 'add_ea5be5');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1, 'lhs_026440', 'lhs_875a03', 'lhs_8a5509');

INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (-2147483648, 'lhs_4d7b1a', 'lhs_9a1b78', 'lhs_4e4007');

INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (-2147483646, 'q_0_a74c05', 'cou_085990', 'cou_879561');

INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (-2147483645, 'q_0_a74c05', 'cou_085990', 'cou_879561');

INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (2, 'cou_042511', 'cou_085990', 'cou_879561');

INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (3, 'cou_042511', 'cou_085990', 'cou_879561');

-- Inserting into table: departments --
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (-2147483648, 'dep_f95b49', 'dep_596df0', 'dep_74e813');

-- Inserting into table: degree_programs --
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (-2147483648, -2147483648, 'deg_f9b1e5', 'deg_d94ec8', 'deg_531e7c');

-- Inserting into table: semesters --
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (-2147483648, 'sem_11aed7', 'sem_0596c9', 'sem_ee4acd');

-- Inserting into table: students --
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483648, -2147483648, -2147483648, 'stu_314a8f', 'stu_bce5a9', 'stu_84974d', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'stu_713836');

-- Inserting into table: student_enrolment --
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (-2147483648, -2147483648, -2147483648, -2147483648, 'stu_174fbf');

-- Inserting into table: student_enrolment_courses --
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (-2147483648, -2147483648, 1);

INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (-2147483647, -2147483648, 1);

INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (-2147483646, -2147483648, 1);

INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (-2147483645, -2147483648, 1);

INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (-2147483644, -2147483648, 1);

INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (-2147483643, -2147483648, 1);

INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (4, -2147483648, 2);

INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (5, -2147483648, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT * FROM courses AS LHS WHERE EXISTS(SELECT 1 FROM student_enrolment_courses AS RHS WHERE (LHS.course_id = RHS.course_id))) ORDER BY course_name;

/*
Gold Result:
('cou_042511',)
('cou_042511',)
('lhs_026440',)
*/

-- Prediction Query
SELECT DISTINCT T1.course_name FROM Courses AS T1 JOIN Student_Enrolment_Courses AS T2 ON T1.course_id = T2.course_id;

/*
Prediction Result:
('lhs_026440',)
('cou_042511',)
*/