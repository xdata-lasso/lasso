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
-- Tests standard ordering and counting: smallest student_course_id (10) has an intermediate count (2).
-- Kills mutants that order by COUNT(*) ASC (would pick 20 with count 1), COUNT(*) DESC (would pick 30 with count 3), or student_course_id DESC (would pick 30).
-- Also includes an unreferenced student_course_id (5) in Student_Enrolment_Courses to kill mutants using LEFT JOIN from Student_Enrolment_Courses.
-- Also includes duplicate (transcript_id, student_course_id) rows to kill COUNT(DISTINCT transcript_id) mutants.
INSERT INTO Addresses (address_id, line_1) VALUES (1, '123 Main St');
INSERT INTO Courses (course_id, course_name) VALUES (100, 'CS101'), (200, 'CS102');
INSERT INTO Departments (department_id, department_name) VALUES (1, 'CS');
INSERT INTO Degree_Programs (degree_program_id, department_id, degree_summary_name) VALUES (1, 1, 'BSc');
INSERT INTO Semesters (semester_id, semester_name) VALUES (1, 'Fall');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name) VALUES (1, 1, 1, 'Alice');
INSERT INTO Student_Enrolment (student_enrolment_id, student_id, semester_id, degree_program_id) VALUES (1, 1, 1, 1);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES
(5, 1, 100),
(10, 1, 100),
(20, 1, 200),
(30, 1, 100);
INSERT INTO Transcripts (transcript_id, transcript_date) VALUES
(1, '2023-01-01'),
(2, '2023-01-02'),
(3, '2023-01-03');
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES
(1, 20),
(2, 10),
(2, 10),
(1, 30),
(2, 30),
(3, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, student_course_id FROM (SELECT * FROM (SELECT * FROM (SELECT student_course_id, COUNT(*) AS n FROM transcript_contents GROUP BY student_course_id) ORDER BY student_course_id) LIMIT 1);

/*
Gold Result:
(2, 10)
*/

-- Prediction Query
SELECT COUNT(*), student_course_id FROM Transcript_Contents GROUP BY student_course_id ORDER BY COUNT(*) DESC, student_course_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(3, 30)
*/