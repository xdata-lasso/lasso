-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("StuID", "LName", "Age") VALUES (1, 'Smith', 18);
INSERT INTO "Student" ("StuID", "LName", "Age") VALUES (2, 'Smith', 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lname FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, MIN(age) OVER () AS minage FROM student) ORDER BY age) LIMIT 1);

/*
Gold Result:
('Smith',)
*/

-- Prediction Query
SELECT LName FROM Student WHERE age = (SELECT MIN(age) FROM Student);

/*
Prediction Result:
('Smith',)
('Smith',)
*/