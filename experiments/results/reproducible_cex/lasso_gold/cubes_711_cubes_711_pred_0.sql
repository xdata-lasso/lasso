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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1028, 'could', 'movement', 'while', 'Port Colleenhaven', '80319', 'Illinois', 'Cape Verde', '809 Burns Creek
Natashaport, IA 08093');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1055, 'apply', 'pattern', 'me', 'North Susan', '11001', 'Idaho', 'Bangladesh', '1939 Christine Manor
Sarahborough, TN 94373');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1037, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1064, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1029, 'Keith Miller', 'Staff within mouth call process water close.', 'almost');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1030, 'Keith Miller', 'Their institution deep much role cut find.', 'trade');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1031, 'Keith Miller', 'Just military building different full open.', 'give');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1032, 'Keith Miller', 'Open according remain arrive attack.', 'avoid');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1056, NULL, 'Lead upon very act perform.', 'both');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1057, NULL, 'You available defense enter value thing these.', 'situation');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1058, NULL, 'Expect just myself few worker southern.', 'on');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1059, NULL, 'Account stage federal professional voice care break.', 'clearly');
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1033, 'Diana Washington', 'Car very number line six space couple.', 'bill');
INSERT INTO "departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1060, 'Larry Robbins', 'Reach table measure economy traditional.', 'approach');
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (1034, 'Heather Jenkins', 'Pull worker better.', 'interesting');
INSERT INTO "semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (1061, 'Jeff Hill', 'Four capital woman.', 'color');
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1035, 1033, 'Song body court movie cell contain.', 'Economic type kitchen technology nearly anything yourself.', 'think');
INSERT INTO "degree_programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (1062, 1060, 'Necessary into act away third tough.', 'Along hard need involve among half value.', 'traditional');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1036, 1028, 1037, 'Alexis', 'Paul Young', 'Russell', '936.402.6064x7468', 'kennethnovak@example.net', 'simply', '1972-03-03', '1973-04-04', 'occur');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1063, 1055, 1064, 'Bill', 'Michael Estrada', 'Gomez', '+1-469-723-2260', 'vpham@example.org', 'example', '1974-05-05', '1975-06-06', 'collection');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1038, 1036, 1034, 1035, 'ask');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1039, 1036, 1034, 1035, 'small');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1040, 1036, 1034, 1035, 'former');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1041, 1036, 1034, 1035, 'art');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1065, 1063, 1061, 1062, 'store');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1066, 1063, 1061, 1062, 'science');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1067, 1063, 1061, 1062, 'box');
INSERT INTO "student_enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (1068, 1063, 1061, 1062, 'idea');
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1051, 1038, 1029);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1052, 1038, 1029);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1053, 1038, 1029);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1054, 1038, 1029);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1078, 1065, 1056);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1079, 1065, 1056);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1080, 1065, 1056);
INSERT INTO "student_enrolment_courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (1081, 1065, 1056);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT * FROM (SELECT * FROM (SELECT course_name, COUNT(*) AS n FROM (SELECT LHS.student_course_id AS student_course_id, LHS.course_id AS course_id, LHS.student_enrolment_id AS student_enrolment_id, RHS.course_name AS course_name, RHS.course_description AS course_description, RHS.other_details AS other_details FROM student_enrolment_courses AS LHS INNER JOIN courses AS RHS ON (LHS.course_id = RHS.course_id)) GROUP BY course_name) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Enrolment_Courses AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Keith Miller',)
*/