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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1015, 'land', 'development', 'woman', 'Lake Larry', '88540', 'Tennessee', 'Holy See (Vatican City State)', '33150 Brianna Avenue Apt. 031
Port Markhaven, IA 37001');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1021, 'small', 'former', 'art', 'New Thomashaven', '21136', 'Arkansas', 'Malawi', '91361 Beth Canyon
South Dianeshire, NC 41968');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1019, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1025, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1016, 'Cindy Anderson', 'Office drug list imagine behind probably great.', 'item');
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1022, 'Christina Moran', 'Enter capital population lead upon.', 'would');
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (1017, 'Nicholas Nunez', 'Art rock song body.', 'dark');
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (1023, 'Jimmy Murillo', 'Available defense enter value.', 'upon');
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1, 1016, 'Movie cell contain leg themselves.', 'Kitchen technology nearly anything.', 'now');
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1027, 1022, 'These hard citizen street.', 'Particularly would pressure account stage.', 'firm');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1018, 1015, 1019, 'Mary', 'Tammy Allison', 'Martin', '973.460.2606x4746', 'kennethnovak@example.net', 'simply', '1974-05-05', '1975-06-06', 'occur');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1024, 1021, 1025, 'Sarah', 'Shawn Baker', 'Preston', '001-282-344-9353x4874', 'ccalderon@example.org', 'goal', '1976-07-07', '1977-08-08', 'spend');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1020, 1018, 1017, 1, 'ask');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1026, 1024, 1023, 1, 'case');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT degree_summary_name FROM (SELECT LHS.degree_program_id AS degree_program_id, LHS.department_id AS department_id, LHS.degree_summary_name AS degree_summary_name, LHS.degree_summary_description AS degree_summary_description, LHS.other_details AS other_details FROM degree_programs AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM (SELECT semester_id FROM student_enrolment INTERSECT SELECT semester_id FROM student_enrolment)) AS RHS ON (LHS.degree_program_id = RHS.n)) ORDER BY degree_summary_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.degree_summary_name FROM Degree_Programs AS T1 JOIN Student_Enrolment AS T2 ON T1.degree_program_id = T2.degree_program_id GROUP BY T1.degree_summary_name ORDER BY COUNT(*) DESC, T1.degree_summary_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Movie cell contain leg themselves.',)
*/