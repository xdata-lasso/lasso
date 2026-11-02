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
INSERT INTO Addresses (address_id, line_1, city, country) VALUES (1, '10 Main St', 'Boston', 'USA');
INSERT INTO Departments (department_id, department_name) VALUES (1, 'Computer Science');
INSERT INTO Degree_Programs (degree_program_id, department_id, degree_summary_name) VALUES (1, 1, 'BSc CS');
INSERT INTO Semesters (semester_id, semester_name) VALUES (1, 'Fall 2021');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, last_name) VALUES (1, 1, 1, 'Alice', 'Smith');
INSERT INTO Courses (course_id, course_name) VALUES (1, 'Databases');
INSERT INTO Student_Enrolment (student_enrolment_id, student_id, semester_id, degree_program_id) VALUES (1, 1, 1, 1);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (101, 1, 1);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (102, 1, 1);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (103, 1, 1);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (104, 1, 1);
INSERT INTO Student_Enrolment_Courses (student_course_id, student_enrolment_id, course_id) VALUES (105, 1, 1);
INSERT INTO Transcripts (transcript_id, transcript_date, other_details) VALUES (1, '2021-01-10 10:00:00', 'd1');
INSERT INTO Transcripts (transcript_id, transcript_date, other_details) VALUES (2, '2021-03-15 09:30:00', 'd2');
INSERT INTO Transcripts (transcript_id, transcript_date, other_details) VALUES (3, '2021-06-20 14:00:00', 'd3');
INSERT INTO Transcripts (transcript_id, transcript_date, other_details) VALUES (4, '2021-02-01 08:00:00', 'd4');
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (1, 101);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (2, 101);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (2, 102);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (2, 103);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (3, 101);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (3, 102);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (3, 103);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (3, 104);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (3, 105);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (4, 101);
INSERT INTO Transcript_Contents (transcript_id, student_course_id) VALUES (4, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transcript_date, n AS transcript_id FROM (SELECT transcript_id, transcript_date, other_details, transcript_id AS n FROM (SELECT LHS.transcript_id AS transcript_id, LHS.transcript_date AS transcript_date, LHS.other_details AS other_details, LHS.n AS n FROM (SELECT transcript_id, transcript_date, other_details, COUNT(*) OVER () AS n FROM transcripts) AS LHS INNER JOIN (SELECT transcript_id, COUNT(*) AS n FROM transcript_contents GROUP BY transcript_id) AS RHS ON (LHS.transcript_id = RHS.n AND LHS.n = RHS.transcript_id))) ORDER BY transcript_date, transcript_id NULLS LAST;

/*
Gold Result:
('2021-03-15 09:30:00', 2)
*/

-- Prediction Query
SELECT T2.transcript_date, T1.transcript_id FROM Transcript_Contents AS T1 JOIN Transcripts AS T2 ON T1.transcript_id = T2.transcript_id GROUP BY T1.transcript_id ORDER BY COUNT(*) ASC, T2.transcript_date NULLS LAST, T1.transcript_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('2021-01-10 10:00:00', 1)
*/