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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1415, 'arrive', 'challenge', 'most', 'Jimshire', '42300', 'Oregon', 'Netherlands Antilles', '42836 Hill Point Apt. 687
West Shellyfurt, WY 69243');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1433, 'these', 'else', 'money', 'Jonathanfort', '95339', 'Tennessee', 'Saint Vincent and the Grenadines', '522 White Plains
New Arthurland, GU 88085');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1424, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1442, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1416, 'Jason Hernandez', 'Contain Mrs drive different tax certain.', 'major');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1434, 'Aaron Taylor', 'Discuss religious across media health pay project pattern.', 'meeting');
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1417, 'Kristina Faulkner', 'Morning home effort form bad last he.', 'north');
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1435, 'Alexis Patel', 'Activity morning ever within admit spend.', 'represent');
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (1418, 'Cheryl Adams', 'Owner them could seven right next look thank.', 'go');
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (1436, 'Todd White', 'Modern drive people education.', 'health');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1419, '1992-11-18', 'floor');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1420, '1992-11-19', 'when');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1421, '1992-11-20', 'administration');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1437, NULL, 'stuff');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1438, '1997-05-24', 'industry');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1439, '1997-05-25', 'bar');
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1422, 1417, 'View while bring yourself look.', 'Receive region however dream focus.', 'fear');
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1440, 1435, 'Where learn during recently feel stock.', 'President teach service behavior.', 'huge');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1423, 1415, 1424, 'Oscar', 'Heather Green', 'Hunt', '271.675.3556x0932', 'mphillips@example.com', 'drug', '1995-03-21', '1996-04-22', 'hundred');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1441, 1433, 1442, 'Angela', 'Adam Jackson', 'Porter', '(259)418-0339x74014', 'alexis39@example.org', 'soldier', '1971-08-03', '1972-09-04', 'tend');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1425, 1423, 1418, 1422, 'over');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1443, 1441, 1436, 1440, 'seem');
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1426, 1425, 1416);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1427, 1425, 1416);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1428, 1425, 1416);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1444, 1443, 1434);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1445, 1443, 1434);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1446, 1443, 1434);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1419, 1426);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1419, 1427);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1419, 1428);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1437, 1444);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1437, 1445);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1437, 1446);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transcript_date, transcript_id FROM (SELECT LHS.transcript_id AS transcript_id, LHS.transcript_date AS transcript_date, LHS.other_details AS other_details, RHS.n AS n FROM transcripts AS LHS INNER JOIN (SELECT transcript_id, COUNT(*) AS n FROM transcript_contents GROUP BY transcript_id) AS RHS ON (LHS.transcript_id = RHS.transcript_id)) WHERE (n >= 2) ORDER BY transcript_date, transcript_id NULLS LAST;

/*
Gold Result:
(None, 1437)
('1992-11-18', 1419)
*/

-- Prediction Query
SELECT T2.transcript_date, T1.transcript_id FROM Transcript_Contents AS T1 JOIN Transcripts AS T2 ON T1.transcript_id = T2.transcript_id GROUP BY T1.transcript_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('1992-11-18', 1419)
(None, 1437)
*/