-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('F' vs 'M', 'f', NULL), primary sorting on Fname, and secondary tie-breaker sorting on StuID.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'Alice', 20, 'F', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Jones', 'Bob', 21, 'M', 600, 1121, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (103, 'Brown', 'Charlie', 22, 'f', 600, 1121, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (104, 'Davis', 'Diana', 19, NULL, 600, 1121, 'HOU');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (105, 'Wilson', 'Zoe', 23, 'F', 500, 1122, 'PHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (106, 'Miller', 'Amy', 18, 'F', 500, 1122, 'PHX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (100, 'Taylor', 'Alice', 22, 'F', 500, 1122, 'SAN');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname", "age" FROM "student" WHERE ("sex" = 'F') ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Alice', 'Taylor', 22)
('Alice', 'Smith', 20)
('Amy', 'Miller', 18)
('Zoe', 'Wilson', 23)
*/

-- Prediction Query
SELECT Fname, Lname, Age FROM Student WHERE Sex = 'F';

/*
Prediction Result:
('Alice', 'Taylor', 22)
('Alice', 'Smith', 20)
('Zoe', 'Wilson', 23)
('Amy', 'Miller', 18)
*/