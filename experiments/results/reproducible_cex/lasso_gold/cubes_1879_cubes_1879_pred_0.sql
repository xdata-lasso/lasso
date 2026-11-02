-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1004, 'early', 'Jamie Chavez', 'they', 'Jacob Clark', 'Timothy Wong', 'Lynch', 'Congress', '76483 Cameron Trail
East Lydiamouth, MO 35594');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1008, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1005, '1974-05-05', '1975-06-06', 'Thomas Bradley', 'serious', 'Matthew Foster', 'Judy Baker', 'Wright');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1006, 'Deborah Richards');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1007, NULL);
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1004, 1006, 1004, 'Jennifer Robinson', 'Meeting before another body.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1009, 1007, 1008, 'Jennifer Robinson', 'Meeting before another body.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1008, NULL, NULL, NULL, NULL);
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1006, 1005, 1004, '1976-07-07', '1977-08-08');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1007, 1005, 1008, '1976-07-07', '1977-08-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, author_id, registration_id AS subject_id FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, course_id AS author_id FROM (SELECT LHS.registration_id AS registration_id, LHS.student_id AS student_id, LHS.course_id AS course_id, LHS.date_of_enrolment AS date_of_enrolment, LHS.date_of_completion AS date_of_completion, RHS.course_id AS course_id_other, RHS.course_name AS course_name, RHS.course_description AS course_description FROM student_course_enrolment AS LHS INNER JOIN courses AS RHS ON (LHS.course_id = RHS.author_id AND LHS.registration_id = RHS.subject_id)))) ORDER BY course_name;

/*
Gold Result:
('Jennifer Robinson',)
('Jennifer Robinson',)
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Jennifer Robinson',)
*/