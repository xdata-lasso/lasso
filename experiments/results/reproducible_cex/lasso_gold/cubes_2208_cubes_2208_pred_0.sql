-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1054, 'Kim', 'Jeffrey', 1055, 'common', 1056, 1057, 'Grayside');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1058, 'Kim', 'Jessica', 1056, 'garden', 1057, 1058, 'Adamsborough');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city_code" FROM "student" WHERE ("lname" = 'Kim') ORDER BY city_code, student.stuid NULLS LAST;

/*
Gold Result:
('Adamsborough',)
('Grayside',)
*/

-- Prediction Query
SELECT city_code FROM Student WHERE LName = 'Kim';

/*
Prediction Result:
('Grayside',)
('Adamsborough',)
*/