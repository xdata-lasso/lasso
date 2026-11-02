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
-- DATASET 1
-- Tests basic functionality: COUNT(DISTINCT) vs COUNT(*), GROUP BY other_details vs other columns, ORDER BY ASC vs DESC, and duplicate output counts (SELECT vs SELECT DISTINCT in outer query).
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1, 'Computer Science', 'CS Dept', 'Dept1');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (2, 'Mathematics', 'Math Dept', 'Dept2');
-- Group 'D_Three' -> 3 distinct names ('BS', 'MS', 'PhD') out of 4 rows.
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1, 1, 'BS', 'Bachelor', 'D_Three');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (2, 1, 'BS', 'Bachelor Dup', 'D_Three');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (3, 2, 'MS', 'Master', 'D_Three');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (4, 2, 'PhD', 'Doctorate', 'D_Three');
-- Group 'A_One' -> 1 distinct name ('BS') out of 2 rows.
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (5, 1, 'BS', 'Bachelor', 'A_One');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (6, 2, 'BS', 'Bachelor', 'A_One');
-- Group 'B_Two' -> 2 distinct names ('BA', 'MA') out of 2 rows.
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (7, 1, 'BA', 'Bachelor Arts', 'B_Two');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (8, 1, 'MA', 'Master Arts', 'B_Two');
-- Group 'C_Two_Dup' -> 2 distinct names ('BSc', 'MSc') to produce duplicate count (2) in outer query.
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (9, 2, 'BSc', 'Bachelor Science', 'C_Two_Dup');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (10, 2, 'MSc', 'Master Science', 'C_Two_Dup');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_degree_summary_name_ FROM (SELECT other_details, COUNT(DISTINCT degree_summary_name) AS n_distinct FROM degree_programs GROUP BY other_details) ORDER BY count_distinct_degree_summary_name_;

/*
Gold Result:
(1,)
(2,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT degree_summary_name) FROM Degree_Programs;

/*
Prediction Result:
(7,)
*/