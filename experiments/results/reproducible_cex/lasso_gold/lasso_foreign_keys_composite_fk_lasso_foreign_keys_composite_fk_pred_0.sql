-- Schema DDL
CREATE TABLE UNIVERSITIES (UNI_ID INTEGER PRIMARY KEY, NAME TEXT);

CREATE TABLE STUDENTS (STUDENT_ID INTEGER PRIMARY KEY, UNI_ID INTEGER NOT NULL, NAME TEXT, FOREIGN KEY (UNI_ID) REFERENCES UNIVERSITIES (UNI_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "universities" ("uni_id", "name") VALUES (5, 'Allison Hill');
INSERT INTO "students" ("student_id", "uni_id", "name") VALUES (1001, 5, 'Noah Rhodes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM STUDENTS WHERE UNI_ID = 5;

/*
Gold Result:
('Noah Rhodes',)
*/

-- Prediction Query
SELECT UNIVERSITIES.NAME FROM STUDENTS JOIN UNIVERSITIES ON STUDENTS.UNI_ID = UNIVERSITIES.UNI_ID WHERE STUDENTS.UNI_ID = 5;

/*
Prediction Result:
('Allison Hill',)
*/