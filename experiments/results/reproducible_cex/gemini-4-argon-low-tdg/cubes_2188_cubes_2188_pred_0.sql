-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate (Fname, LName) pairs to kill mutants that mistakenly use SELECT DISTINCT or GROUP BY.
-- Also tests diverse Age, Sex, Major, Advisor, and city_code values to kill mutants that add arbitrary WHERE clauses.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Doe', 'John', 18, 'M', 200, 2001, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Doe', 'John', 25, 'M', 300, 2002, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Brown', 'Charlie', 21, 'F', 400, 2003, 'MIA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM student ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Charlie', 'Brown')
('John', 'Doe')
('John', 'Doe')
*/

-- Prediction Query
SELECT Fname, Lname FROM Student;

/*
Prediction Result:
('John', 'Doe')
('John', 'Doe')
('Charlie', 'Brown')
*/