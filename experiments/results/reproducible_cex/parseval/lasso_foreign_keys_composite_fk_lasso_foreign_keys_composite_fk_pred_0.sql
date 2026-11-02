-- Schema DDL
CREATE TABLE UNIVERSITIES (UNI_ID INTEGER PRIMARY KEY, NAME TEXT);

CREATE TABLE STUDENTS (STUDENT_ID INTEGER PRIMARY KEY, UNI_ID INTEGER NOT NULL, NAME TEXT, FOREIGN KEY (UNI_ID) REFERENCES UNIVERSITIES (UNI_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: universities --
INSERT INTO "universities" ("uni_id", "name") VALUES (5, '5k5swwqcgs');

INSERT INTO "universities" ("uni_id", "name") VALUES (1, '9n8');

-- Inserting into table: students --
INSERT INTO "students" ("student_id", "uni_id", "name") VALUES (-2147483648, 5, 'stu_ce6b60');

INSERT INTO "students" ("student_id", "uni_id", "name") VALUES (2, 5, 'stu_ce6b60');

INSERT INTO "students" ("student_id", "uni_id", "name") VALUES (3, 5, 'stu_ce6b60');

INSERT INTO "students" ("student_id", "uni_id", "name") VALUES (-2147483645, 1, 'stu_ce6b60');

INSERT INTO "students" ("student_id", "uni_id", "name") VALUES (-2147483644, 5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM STUDENTS WHERE UNI_ID = 5;

/*
Gold Result:
('stu_ce6b60',)
(None,)
('stu_ce6b60',)
('stu_ce6b60',)
*/

-- Prediction Query
SELECT UNIVERSITIES.NAME FROM STUDENTS JOIN UNIVERSITIES ON STUDENTS.UNI_ID = UNIVERSITIES.UNI_ID WHERE STUDENTS.UNI_ID = 5;

/*
Prediction Result:
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
('5k5swwqcgs',)
*/