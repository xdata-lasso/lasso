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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1210, 'couple', 'conference', 'continue', 'New Monicabury', '65731', 'Pennsylvania', 'Cambodia', '4074 Charles Key Suite 647
Jamesfurt, PR 63836');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1232, 'test', 'pull', 'yard', 'Danielbury', '62298', 'Alaska', 'Niger', '317 Banks Crescent Apt. 004
Wilsonbury, FM 70958');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1220, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1242, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1211, 'James Howard', 'Yeah far within probably ever.', 'treatment');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1233, 'Jesse Santiago', 'Industry score choice increase between majority impact.', 'far');
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1212, 'Natasha Williams', 'Seat strategy total simply discover soon despite couple.', 'enough');
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1234, 'Jacob Ramos', 'Talk between rate name within.', 'her');
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (1213, 'Michelle Hopkins', 'Pick tough position final.', 'let');
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (1235, 'Donald Donaldson', 'Begin deep police wife anything four writer.', 'stop');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1214, '1998-03-12', 'along');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1215, '1998-03-13', 'particularly');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1216, '1998-03-14', 'his');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1217, '1998-03-15', 'sign');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1236, '1975-09-18', 'other');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1237, '1975-09-19', 'describe');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1238, '1975-09-20', 'authority');
INSERT INTO "transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (1239, '1975-09-21', 'themselves');
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1218, 1212, 'Bed far section compare.', 'Skill theory hand maybe.', 'explain');
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1240, 1234, 'Debate democratic thank forget challenge too able.', 'Would music sometimes body.', 'trial');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1219, 1210, 1220, 'Maria', 'Roger Olson', 'Drake', '001-651-371-2368x5160', 'vrichardson@example.net', 'everybody', '1973-07-16', '1974-08-17', 'pattern');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1241, 1232, 1242, 'Anthony', 'Richard Young', 'Morris', '(940)726-8117', 'hayesjeffrey@example.net', 'animal', '1979-02-22', '1980-03-23', 'short');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1221, 1219, 1213, 1218, 'I');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1243, 1241, 1235, 1240, 'step');
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1222, 1221, 1211);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1223, 1221, 1211);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1224, 1221, 1211);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1225, 1221, 1211);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1244, 1243, 1233);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1245, 1243, 1233);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1246, 1243, 1233);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1247, 1243, 1233);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1214, 1222);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1215, 1222);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1216, 1222);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1217, 1222);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1236, NULL);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1237, NULL);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1238, NULL);
INSERT INTO "transcript_contents" ("transcript_id", "student_course_id") VALUES (1239, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, student_course_id FROM (SELECT * FROM (SELECT * FROM (SELECT student_course_id, COUNT(*) AS n FROM transcript_contents GROUP BY student_course_id) ORDER BY student_course_id) LIMIT 1);

/*
Gold Result:
(4, None)
*/

-- Prediction Query
SELECT COUNT(*), student_course_id FROM Transcript_Contents GROUP BY student_course_id ORDER BY COUNT(*) DESC, student_course_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(4, 1222)
*/