-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Pollen', 'Environmental');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Smith', 'Zoe', 21, 'F', 101, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Adams', 'Alice', 25, 'F', 102, 1002, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Zimmer', 'Alice', 30, 'F', 103, 1003, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (30, 'Brown', 'Bob', 22, 'M', 104, 1004, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (40, 'Clark', 'Carol', 23, 'O', 105, 1005, 'SEA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (50, 'Davis', 'Diana', 24, NULL, 106, 1006, 'MIA');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 20);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Pollen', 20);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname", "age" FROM "student" WHERE ("sex" = 'F') ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Alice', 'Zimmer', 30)
('Alice', 'Adams', 25)
('Zoe', 'Smith', 21)
*/

-- Prediction Query
SELECT Fname, Lname, Age FROM Student WHERE Sex = 'F';

/*
Prediction Result:
('Alice', 'Zimmer', 30)
('Zoe', 'Smith', 21)
('Alice', 'Adams', 25)
*/