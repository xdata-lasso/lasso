-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Students (student_id, personal_name, family_name) VALUES (1, 'Bernie', 'Zieme');
INSERT INTO Course_Authors_and_Tutors (author_id) VALUES (1);
INSERT INTO Subjects (subject_id) VALUES (1);
INSERT INTO Courses (course_id, subject_id, author_id) VALUES (1, 1, 1);
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (1, 1, 1, '2023-02-01', '2023-03-01');
INSERT INTO Student_Course_Enrolment (registration_id, student_id, course_id, date_of_enrolment, date_of_completion) VALUES (2, 1, 1, '2023-01-01', '2023-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_enrolment", "date_of_completion" FROM (SELECT "LHS"."registration_id" AS "registration_id", "LHS"."student_id" AS "student_id", "LHS"."course_id" AS "course_id", "LHS"."date_of_enrolment" AS "date_of_enrolment", "LHS"."date_of_completion" AS "date_of_completion", "RHS"."date_of_registration" AS "date_of_registration", "RHS"."date_of_latest_logon" AS "date_of_latest_logon", "RHS"."login_name" AS "login_name", "RHS"."password" AS "password", "RHS"."personal_name" AS "personal_name", "RHS"."middle_name" AS "middle_name", "RHS"."family_name" AS "family_name" FROM "student_course_enrolment" AS "LHS" INNER JOIN (SELECT * FROM "students" WHERE ("family_name" = 'Zieme' AND "personal_name" = 'Bernie')) AS RHS ON (LHS.student_id = RHS.student_id)) ORDER BY date_of_enrolment, "date_of_enrolment" NULLS LAST, "date_of_completion" NULLS LAST;

/*
Gold Result:
('2023-01-01', '2023-02-01')
('2023-02-01', '2023-03-01')
*/

-- Prediction Query
SELECT T1.date_of_enrolment, T1.date_of_completion FROM Student_Course_Enrolment AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id WHERE T2.family_name = 'Zieme' AND T2.personal_name = 'Bernie';

/*
Prediction Result:
('2023-02-01', '2023-03-01')
('2023-01-01', '2023-02-01')
*/