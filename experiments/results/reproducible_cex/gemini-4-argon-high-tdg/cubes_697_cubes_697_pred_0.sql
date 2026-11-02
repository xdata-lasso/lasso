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
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES (101, 'Database Systems', 'Core DB course', 'Level 3');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES (102, 'Algorithms', 'Core CS course', 'Level 2');
INSERT INTO Departments (department_id, department_name, department_description, other_details) VALUES (1, 'Computer Science', 'CS Department', 'Building A');
INSERT INTO Degree_Programs (degree_program_id, department_id, degree_summary_name, degree_summary_description, other_details) VALUES (10, 1, 'BSc CS', 'Undergraduate CS', '3 Years');
INSERT INTO Semesters (semester_id, semester_name, semester_description, other_details) VALUES (201, 'Fall 2023', 'Autumn Term', 'Active');
INSERT INTO Sections (section_id, course_id, section_name, section_description, other_details) VALUES (1, 101, 'Section C', 'Evening lecture', 'Room 301');
INSERT INTO Sections (section_id, course_id, section_name, section_description, other_details) VALUES (2, 101, 'Section B', 'Z-Afternoon lab', 'Room 102');
INSERT INTO Sections (section_id, course_id, section_name, section_description, other_details) VALUES (3, 102, 'Section A', 'Morning lecture', 'Room 201');
INSERT INTO Sections (section_id, course_id, section_name, section_description, other_details) VALUES (4, 102, 'Section B', 'A-Morning lab', 'Room 105');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT section_name, section_description FROM sections ORDER BY section_name, sections.section_id NULLS LAST;

/*
Gold Result:
('Section A', 'Morning lecture')
('Section B', 'Z-Afternoon lab')
('Section B', 'A-Morning lab')
('Section C', 'Evening lecture')
*/

-- Prediction Query
SELECT section_name, section_description FROM Sections;

/*
Prediction Result:
('Section C', 'Evening lecture')
('Section B', 'Z-Afternoon lab')
('Section A', 'Morning lecture')
('Section B', 'A-Morning lab')
*/