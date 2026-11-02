-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1" TEXT(80), "line_2" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "People" ("person_id" INTEGER PRIMARY KEY, "first_name" TEXT(255), "middle_name" TEXT(255), "last_name" TEXT(255), "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "login_name" TEXT(40), "password" TEXT(40));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "student_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Courses" ("course_id" TEXT(100) PRIMARY KEY, "course_name" TEXT(120), "course_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "People_Addresses" ("person_address_id" INTEGER PRIMARY KEY, "address_id" INTEGER, "person_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("person_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Student_Course_Registrations" ("student_id" INTEGER UNIQUE, "course_id" INTEGER UNIQUE, "registration_date" DATETIME, PRIMARY KEY ("student_id", "course_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"));

CREATE TABLE "Student_Course_Attendance" ("student_id" INTEGER, "course_id" INTEGER, "date_of_attendance" DATETIME, PRIMARY KEY ("student_id", "course_id"), FOREIGN KEY ("student_id") REFERENCES "Student_Course_Registrations" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Student_Course_Registrations" ("course_id"));

CREATE TABLE "Candidates" ("candidate_id" INTEGER PRIMARY KEY, "candidate_details" TEXT(255), FOREIGN KEY ("candidate_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Candidate_Assessments" ("candidate_id" INTEGER, "qualification" TEXT(15), "assessment_date" DATETIME, "asessment_outcome_code" TEXT(15), PRIMARY KEY ("candidate_id", "qualification"), FOREIGN KEY ("candidate_id") REFERENCES "Candidates" ("candidate_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering where insertion order, student_id order, registration_date order, and course_id order all conflict.
-- Also includes unregistered students/courses and attendance records to catch incorrect table usages or inner joins.
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (1, 'Alice', 'Smith');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (10, 'Bob', 'Jones');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (20, 'Charlie', 'Brown');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (30, 'David', 'White');
INSERT INTO "Students" ("student_id", "student_details") VALUES (1, 'Unregistered Student');
INSERT INTO "Students" ("student_id", "student_details") VALUES (10, 'Student 10');
INSERT INTO "Students" ("student_id", "student_details") VALUES (20, 'Student 20');
INSERT INTO "Students" ("student_id", "student_details") VALUES (30, 'Student 30');
INSERT INTO "Courses" ("course_id", "course_name") VALUES ('1', 'Unregistered Course');
INSERT INTO "Courses" ("course_id", "course_name") VALUES ('100', 'Math');
INSERT INTO "Courses" ("course_id", "course_name") VALUES ('200', 'History');
INSERT INTO "Courses" ("course_id", "course_name") VALUES ('300', 'Physics');
-- Insertion order: course_id 200, then 300, then 100.
-- Min student_id is 10 (course 300).
-- Min registration_date is 2023-01-01 (course 200, student 20).
-- Min course_id is 100 (student 30) -> Gold query returns 30.
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (20, 200, '2023-01-01 10:00:00');
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (10, 300, '2023-02-01 10:00:00');
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (30, 100, '2023-03-01 10:00:00');
-- Attendance only for student 10 and 20 (student 30 has no attendance, catching mutants that join or query Student_Course_Attendance).
INSERT INTO "Student_Course_Attendance" ("student_id", "course_id", "date_of_attendance") VALUES (20, 200, '2023-01-02 10:00:00');
INSERT INTO "Student_Course_Attendance" ("student_id", "course_id", "date_of_attendance") VALUES (10, 300, '2023-02-02 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM (SELECT * FROM (SELECT * FROM (SELECT student_id, course_id, registration_date, COUNT(*) OVER () AS n FROM student_course_registrations) ORDER BY course_id) LIMIT 1);

/*
Gold Result:
(30,)
*/

-- Prediction Query
SELECT student_id FROM student_course_registrations GROUP BY student_id ORDER BY COUNT(*), student_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/