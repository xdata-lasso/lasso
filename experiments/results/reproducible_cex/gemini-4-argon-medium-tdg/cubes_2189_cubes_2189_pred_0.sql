-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Dust', 'Environmental');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Baker', 'Tom', 20, 'M', 100, 101, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Baker', 'Sam', 19, 'M', 200, 102, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (30, 'Baker', 'Ann', 19, 'F', 300, 103, 'SEA');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Dust', 10);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Dust', 20);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Dust', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lname FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, MIN(age) OVER () AS minage FROM student) ORDER BY age) LIMIT 1);

/*
Gold Result:
('Baker',)
*/

-- Prediction Query
SELECT LName FROM Student WHERE age = (SELECT MIN(age) FROM Student);

/*
Prediction Result:
('Baker',)
('Baker',)
*/