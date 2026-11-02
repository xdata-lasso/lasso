-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Pollen', 'Environmental');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 18, 'M', 100, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 2, 'F', 100, 10, 'LA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 2, 'M', 200, 20, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'White', 'Alice', 2, 'F', 200, 20, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Green', 'Tom', 3, 'M', 300, 30, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Black', 'Sara', 3, 'F', 300, 30, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, 'Hall', 'Sam', 3, 'M', 300, 30, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (8, 'King', 'Liz', 4, 'F', 400, 40, 'MIA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (9, 'Lee', 'Dan', 4, 'M', 400, 40, 'MIA');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 1);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Pollen', 1);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT age, COUNT(*) AS n FROM student GROUP BY age) WHERE (age = 18 OR n > age) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Student WHERE age = 18;

/*
Prediction Result:
(1,)
*/