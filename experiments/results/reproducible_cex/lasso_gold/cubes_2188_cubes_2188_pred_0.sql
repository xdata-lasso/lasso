-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1010, 'Barnes', 'Matthew', 1011, 'fall', 1012, 1013, 'New Jamesside');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1014, 'Davis', 'Jesse', 1012, 'play', 1013, 1014, 'Port Lindachester');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM student ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Jesse', 'Davis')
('Matthew', 'Barnes')
*/

-- Prediction Query
SELECT Fname, Lname FROM Student;

/*
Prediction Result:
('Matthew', 'Barnes')
('Jesse', 'Davis')
*/