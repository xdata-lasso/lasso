-- Schema DDL
CREATE TABLE "COURSE_AUTHORS_AND_TUTORS" (
    "AUTHOR_ID" INT,
    "AUTHOR_TUTOR_ATB" TEXT,
    "LOGIN_NAME" TEXT,
    "PASSWORD" TEXT,
    "PERSONAL_NAME" TEXT,
    "MIDDLE_NAME" TEXT,
    "FAMILY_NAME" TEXT,
    "GENDER_MF" TEXT,
    "ADDRESS_LINE_1" TEXT,
    PRIMARY KEY ("AUTHOR_ID")
);
CREATE TABLE "STUDENTS" (
    "STUDENT_ID" INT,
    "DATE_OF_REGISTRATION" DATETIME,
    "DATE_OF_LATEST_LOGON" DATETIME,
    "LOGIN_NAME" TEXT,
    "PASSWORD" TEXT,
    "PERSONAL_NAME" TEXT,
    "MIDDLE_NAME" TEXT,
    "FAMILY_NAME" TEXT,
    PRIMARY KEY ("STUDENT_ID")
);
CREATE TABLE "SUBJECTS" (
    "SUBJECT_ID" INT,
    "SUBJECT_NAME" TEXT,
    PRIMARY KEY ("SUBJECT_ID")
);
CREATE TABLE "COURSES" (
    "COURSE_ID" INT,
    "SUBJECT_ID" INT,
    "AUTHOR_ID" INT,
    "COURSE_NAME" TEXT,
    "COURSE_DESCRIPTION" TEXT,
    PRIMARY KEY ("COURSE_ID"),
    FOREIGN KEY ("SUBJECT_ID") REFERENCES "SUBJECTS"("SUBJECT_ID"),
    FOREIGN KEY ("AUTHOR_ID") REFERENCES "COURSE_AUTHORS_AND_TUTORS"("AUTHOR_ID")
);
CREATE TABLE "STUDENT_COURSE_ENROLMENT" (
    "REGISTRATION_ID" INT,
    "STUDENT_ID" INT,
    "COURSE_ID" INT,
    "DATE_OF_ENROLMENT" DATETIME,
    "DATE_OF_COMPLETION" DATETIME,
    PRIMARY KEY ("REGISTRATION_ID"),
    FOREIGN KEY ("STUDENT_ID") REFERENCES "STUDENTS"("STUDENT_ID"),
    FOREIGN KEY ("COURSE_ID") REFERENCES "COURSES"("COURSE_ID")
);
CREATE TABLE "STUDENT_TESTS_TAKEN" (
    "REGISTRATION_ID" INT,
    "DATE_TEST_TAKEN" DATETIME,
    "TEST_RESULT" TEXT,
    FOREIGN KEY ("REGISTRATION_ID") REFERENCES "STUDENT_COURSE_ENROLMENT"("REGISTRATION_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COURSE_AUTHORS_AND_TUTORS VALUES (-2, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO COURSE_AUTHORS_AND_TUTORS VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO STUDENTS VALUES (1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO STUDENTS VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO SUBJECTS VALUES (0, 0);
INSERT INTO SUBJECTS VALUES (2, 0);
INSERT INTO COURSES VALUES (-1, 2, -2, -1, 28);
INSERT INTO COURSES VALUES (-2, 0, 0, 0, 31);
INSERT INTO STUDENT_COURSE_ENROLMENT VALUES (3, 0, -2, 29, 30);
INSERT INTO STUDENT_COURSE_ENROLMENT VALUES (1, 1, -1, 32, 33);
INSERT INTO STUDENT_TESTS_TAKEN VALUES (1, 0, 0);
INSERT INTO STUDENT_TESTS_TAKEN VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, author_id, registration_id AS subject_id FROM (SELECT registration_id, student_id, course_id, date_of_enrolment, date_of_completion, course_id_other, course_name, course_description, course_id AS author_id FROM (SELECT LHS.registration_id AS registration_id, LHS.student_id AS student_id, LHS.course_id AS course_id, LHS.date_of_enrolment AS date_of_enrolment, LHS.date_of_completion AS date_of_completion, RHS.course_id AS course_id_other, RHS.course_name AS course_name, RHS.course_description AS course_description FROM student_course_enrolment AS LHS INNER JOIN courses AS RHS ON (LHS.course_id = RHS.author_id AND LHS.registration_id = RHS.subject_id)))) ORDER BY course_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.course_name FROM Courses AS T1 JOIN Student_Course_Enrolment AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(*) DESC, T1.course_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/