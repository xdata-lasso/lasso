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
INSERT INTO Departments (department_id, department_name, department_description, other_details) VALUES (1, 'Computer Science', 'CS Dept', 'None');
INSERT INTO Degree_Programs (degree_program_id, department_id, degree_summary_name, degree_summary_description, other_details) VALUES (1, 1, 'Bachelor', 'BS Degree', 'Details 1');
INSERT INTO Degree_Programs (degree_program_id, department_id, degree_summary_name, degree_summary_description, other_details) VALUES (2, 1, 'Master', 'MS Degree', 'Details 2');
INSERT INTO Semesters (semester_id, semester_name, semester_description, other_details) VALUES (1, 'Fall 2023', 'Fall Semester', 'None');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '123 Main St', NULL, NULL, 'Boston', '02101', 'MA', 'USA', NULL);
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (1, 1, 1, 'Alice', 'M', 'Smith', '555-0101', 'alice@example.com', '111-11-1111', '2023-09-01', NULL, NULL);
INSERT INTO Student_Enrolment (student_enrolment_id, student_id, semester_id, degree_program_id, other_details) VALUES (1, 1, 1, 1, 'Enrolment 1');
INSERT INTO Student_Enrolment (student_enrolment_id, student_id, semester_id, degree_program_id, other_details) VALUES (2, 1, NULL, 1, 'Enrolment with NULL semester');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT degree_summary_name FROM (SELECT LHS.degree_program_id AS degree_program_id, LHS.department_id AS department_id, LHS.degree_summary_name AS degree_summary_name, LHS.degree_summary_description AS degree_summary_description, LHS.other_details AS other_details FROM degree_programs AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM (SELECT semester_id FROM student_enrolment INTERSECT SELECT semester_id FROM student_enrolment)) AS RHS ON (LHS.degree_program_id = RHS.n)) ORDER BY degree_summary_name;

/*
Gold Result:
('Master',)
*/

-- Prediction Query
SELECT T1.degree_summary_name FROM Degree_Programs AS T1 JOIN Student_Enrolment AS T2 ON T1.degree_program_id = T2.degree_program_id GROUP BY T1.degree_summary_name ORDER BY COUNT(*) DESC, T1.degree_summary_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bachelor',)
*/