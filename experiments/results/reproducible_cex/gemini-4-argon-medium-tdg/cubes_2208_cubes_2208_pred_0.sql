-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (LName = 'Kim' vs others), case sensitivity, FName confusion, duplicate city_codes (DISTINCT mutants), NULL city_codes, and ORDER BY sorting.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Kim', 'John', 20, 'M', 600, 101, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Kim', 'Sara', 21, 'F', 600, 102, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Kim', 'Paul', 22, 'M', 500, 101, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Kim', 'Anna', 19, 'F', 400, 103, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Smith', 'Kim', 20, 'F', 600, 101, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'kim', 'David', 23, 'M', 600, 104, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, 'Kimble', 'Tom', 21, 'M', 500, 102, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (8, NULL, 'Mark', 20, 'M', 500, 102, 'MIA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city_code" FROM "student" WHERE ("lname" = 'Kim') ORDER BY city_code, student.stuid NULLS LAST;

/*
Gold Result:
(None,)
('BOS',)
('NYC',)
('NYC',)
*/

-- Prediction Query
SELECT city_code FROM Student WHERE LName = 'Kim';

/*
Prediction Result:
('NYC',)
('BOS',)
('NYC',)
(None,)
*/