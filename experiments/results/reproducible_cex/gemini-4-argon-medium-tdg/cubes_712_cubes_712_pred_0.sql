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
-- Tests:
-- 1. Inner Join vs Exists (Course 101 has multiple enrolments; INNER JOIN without DISTINCT will return duplicate 'Algorithms').
-- 2. Left Join vs Exists (Course 103 has 0 enrolments; LEFT JOIN will include 'Compilers').
-- 3. Duplicate course_name across different course_ids (Courses 102 and 104 are both named 'Databases' and both enrolled; SELECT DISTINCT course_name will collapse them to 1 row, whereas the Gold Query returns 2 rows).
-- 4. ORDER BY course_name (Courses inserted in reverse alphabetical order relative to course_id to kill missing ORDER BY, ORDER BY DESC, or ORDER BY course_id).
-- 5. Wrong column projection (course_description and other_details differ from course_name).
-- 6. Wrong table/column join (e.g., joining on student_course_id or student_enrolment_id, or checking Sections instead of Student_Enrolment_Courses).
INSERT INTO Addresses (address_id, line_1, city, country) VALUES (1, '123 Main St', 'Metropolis', 'USA');
INSERT INTO Departments (department_id, department_name) VALUES (1, 'Computer Science');
INSERT INTO Degree_Programs (degree_program_id, department_id, degree_summary_name) VALUES (1, 1, 'BSc CS');
INSERT INTO Semesters (semester_id, semester_name) VALUES (1, 'Fall 2023');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, last_name) VALUES (1, 1, 1, 'Alice', 'Smith');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES (101, 'Zoology', 'Desc Z', 'Detail Z');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES (102, 'Databases', 'Desc D1', 'Detail D1');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES (103, 'Compilers', 'Desc C', 'Detail C');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES (104, 'Databases', 'Desc D2', 'Detail D2');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES (105, 'Algorithms', 'Desc A', 'Detail A');
INSERT INTO Sections (section_id, course_id, section_name) VALUES (1, 103, 'Section 1');
INSERT INTO Student_Enrolment (student_enrolment_id, student_id, semester_id, degree_program_id) VALUES (500, 1, 1, 1);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (901, 500, 101);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (902, 500, 101);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (903, 500, 102);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (904, 500, 104);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (905, 500, 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT * FROM courses AS LHS WHERE EXISTS(SELECT 1 FROM student_enrolment_courses AS RHS WHERE (LHS.course_id = RHS.course_id))) ORDER BY course_name;

/*
Gold Result:
('Algorithms',)
('Databases',)
('Databases',)
('Zoology',)
*/

-- Prediction Query
SELECT DISTINCT T1.course_name FROM Courses AS T1 JOIN Student_Enrolment_Courses AS T2 ON T1.course_id = T2.course_id;

/*
Prediction Result:
('Zoology',)
('Databases',)
('Algorithms',)
*/