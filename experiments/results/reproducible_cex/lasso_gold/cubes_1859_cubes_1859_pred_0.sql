-- Schema DDL
CREATE TABLE "Course_Authors_and_Tutors" ("author_id" INTEGER PRIMARY KEY, "author_tutor_ATB" TEXT(3), "login_name" TEXT(40), "password" TEXT(40), "personal_name" TEXT(80), "middle_name" TEXT(80), "family_name" TEXT(80), "gender_mf" TEXT(1), "address_line_1" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "date_of_registration" DATETIME, "date_of_latest_logon" DATETIME, "login_name" TEXT(40), "password" TEXT(10), "personal_name" TEXT(40), "middle_name" TEXT(40), "family_name" TEXT(40));

CREATE TABLE "Subjects" ("subject_id" INTEGER PRIMARY KEY, "subject_name" TEXT(120));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "subject_id" INTEGER, "author_id" INTEGER, "course_name" TEXT(120), "course_description" TEXT(255), FOREIGN KEY ("subject_id") REFERENCES "Subjects" ("subject_id"), FOREIGN KEY ("author_id") REFERENCES "Course_Authors_and_Tutors" ("author_id"));

CREATE TABLE "Student_Course_Enrolment" ("registration_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "course_id" INTEGER, "date_of_enrolment" DATETIME, "date_of_completion" DATETIME, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Student_Tests_Taken" ("registration_id" INTEGER, "date_test_taken" DATETIME, "test_result" TEXT(255), FOREIGN KEY ("registration_id") REFERENCES "Student_Course_Enrolment" ("registration_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1733, 'development', 'Beth Henderson', 'result', 'Zachary Burton', 'Deanna Bartlett', 'Sloan', 'audience', '548 Stark Bridge Suite 162
New Brianna, WV 13634');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1748, 'development', 'Beth Henderson', 'result', 'Zachary Burton', 'Deanna Bartlett', 'Sloan', 'audience', '548 Stark Bridge Suite 162
New Brianna, WV 13634');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1754, 'allow', 'John Griffin', 'truth', 'Juan Cooper', 'Deanna Rivas', 'Davis', 'ahead', '333 Joseph Lodge
Port Kimberlytown, NJ 17843');
INSERT INTO "course_authors_and_tutors" ("author_id", "author_tutor_atb", "login_name", "password", "personal_name", "middle_name", "family_name", "gender_mf", "address_line_1") VALUES (1769, 'allow', 'John Griffin', 'truth', 'Juan Cooper', 'Deanna Rivas', 'Davis', 'ahead', '333 Joseph Lodge
Port Kimberlytown, NJ 17843');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1734, '1984-03-07', '1987-06-10', 'Kristine Garcia', 'politics', 'Jamie Montgomery', 'Derrick Watson', 'Compton');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1735, '1984-03-08', '1987-06-11', 'Joseph Cooper', 'material', 'Jennifer Foster', 'Riley Collins', 'Perez');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1736, '1984-03-09', '1987-06-12', 'James Washington', 'always', 'Melissa Williams', 'Shannon Cohen', 'Turner');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1749, '1984-03-09', '1987-06-12', 'James Washington', 'always', 'Melissa Williams', 'Shannon Cohen', 'Turner');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1755, '1996-04-19', '1970-07-22', 'Lindsay Smith', 'however', 'Daniel Turner', 'Kristina Wheeler', 'Hill');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1756, '1996-04-20', '1970-07-23', 'Robert Torres', 'together', 'Loretta Silva', 'Michael Olson', 'Douglas');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1757, '1996-04-21', '1970-07-24', 'Maria Coleman', 'happy', 'Zachary Levy', 'Donald Nguyen', 'Farley');
INSERT INTO "students" ("student_id", "date_of_registration", "date_of_latest_logon", "login_name", "password", "personal_name", "middle_name", "family_name") VALUES (1770, '1996-04-21', '1970-07-24', 'Maria Coleman', 'happy', 'Zachary Levy', 'Donald Nguyen', 'Farley');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1737, 'Patricia Flores');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1750, 'Patricia Flores');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1758, 'Chelsea Holmes');
INSERT INTO "subjects" ("subject_id", "subject_name") VALUES (1771, 'Chelsea Holmes');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1738, 1737, 1733, 'Lisa Davis', 'Assume remember idea sister.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1739, 1737, 1733, 'Lisa Davis', 'These ahead cover strategy student economic lead.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1740, 1737, 1733, 'Lisa Davis', 'Relate ever statement measure play buy.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1752, 1737, 1733, 'Lisa Davis', 'Relate ever statement measure play buy.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1759, 1758, 1754, 'Lisa Davis', 'Tonight south sort outside produce.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1760, 1758, 1754, 'Lisa Davis', 'Return pretty young else.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1761, 1758, 1754, 'Lisa Davis', 'Identify say on yes staff gas.');
INSERT INTO "courses" ("course_id", "subject_id", "author_id", "course_name", "course_description") VALUES (1773, 1758, 1754, 'Lisa Davis', 'Identify say on yes staff gas.');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1745, 1734, 1738, '1990-09-13', '1993-01-16');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1746, 1734, 1738, '1990-09-14', '1993-01-17');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1747, 1734, 1738, '1990-09-15', '1993-01-18');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1753, 1734, NULL, '1990-09-15', '1993-01-18');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1766, 1755, 1759, '1973-10-02', '1976-02-05');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1767, 1755, 1759, '1973-10-03', '1976-02-06');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1768, 1755, 1759, '1973-10-04', '1976-02-07');
INSERT INTO "student_course_enrolment" ("registration_id", "student_id", "course_id", "date_of_enrolment", "date_of_completion") VALUES (1774, 1755, NULL, '1973-10-04', '1976-02-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name AS course_description, course_description AS course_name FROM (SELECT LHS.course_id AS course_id, LHS.author_id AS author_id, LHS.subject_id AS subject_id, LHS.course_name AS course_name, LHS.course_description AS course_description, RHS.n AS n FROM courses AS LHS LEFT JOIN (SELECT course_id, COUNT(*) AS n FROM student_course_enrolment GROUP BY course_id) AS RHS ON (LHS.course_id = RHS.course_id)) WHERE (n > 2) ORDER BY course_description, course_name NULLS LAST;

/*
Gold Result:
('Lisa Davis', 'Assume remember idea sister.')
('Lisa Davis', 'Tonight south sort outside produce.')
*/

-- Prediction Query
SELECT T1.course_description, T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name HAVING COUNT(*) > 2;

/*
Prediction Result:
('Assume remember idea sister.', 'Lisa Davis')
*/