-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Dust', 'Environmental');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Smith', 'John', 25, 'M', 300, 1002, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Adams', 'Amy', 18, 'F', 100, 1001, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (30, 'Baker', 'Bob', 22, 'M', 200, 1003, 'LAX');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 20);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Dust', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, COUNT(*) OVER () AS n FROM student) ORDER BY stuid) LIMIT 1);

/*
Gold Result:
(300,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major ORDER BY COUNT(*) DESC, major NULLS LAST LIMIT 1;

/*
Prediction Result:
(100,)
*/