-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Dust', 'Environmental');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (201, 'Zane', 'Zack', 18, 'M', 100, 2001, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (202, 'Zane', 'Zoe', 18, 'F', 200, 2002, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (203, 'Young', 'Yara', 20, 'F', 100, 2001, 'DEN');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Dust', 201);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Dust', 202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lname FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, MIN(age) OVER () AS minage FROM student) ORDER BY age) LIMIT 1);

/*
Gold Result:
('Zane',)
*/

-- Prediction Query
SELECT LName FROM Student WHERE age = (SELECT MIN(age) FROM Student);

/*
Prediction Result:
('Zane',)
('Zane',)
*/