-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Kim', 'John', 20, 'M', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Smith', 'Kim', 21, 'F', 600, 1121, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'kim', 'Alice', 19, 'F', 520, 1148, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Kimball', 'Bob', 22, 'M', 520, 1148, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Kim', 'Sara', 18, 'F', 600, 1121, 'ATL');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city_code" FROM "student" WHERE ("lname" = 'Kim') ORDER BY city_code, student.stuid NULLS LAST;

/*
Gold Result:
('ATL',)
('NYC',)
*/

-- Prediction Query
SELECT city_code FROM Student WHERE LName = 'Kim';

/*
Prediction Result:
('NYC',)
('ATL',)
*/