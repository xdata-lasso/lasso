-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Smith', 'Alice', 20, 'F', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Adams', 'Alice', 22, 'F', 100, 1, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Baker', 'Alice', 19, 'F', 200, 2, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Clark', 'Bob', 21, 'M', 300, 3, 'BOS');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 10);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM student ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Alice', 'Adams')
('Alice', 'Smith')
('Alice', 'Baker')
('Bob', 'Clark')
*/

-- Prediction Query
SELECT Fname, Lname FROM Student;

/*
Prediction Result:
('Bob', 'Clark')
('Alice', 'Adams')
('Alice', 'Smith')
('Alice', 'Baker')
*/