-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1054, 'Nelson', 'Sara', 1055, 'F', 1056, 1057, 'Lake Mark');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1058, 'Tate', 'Carl', 1056, 'F', 1057, 1058, 'Port Leslieview');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname", "age" FROM "student" WHERE ("sex" = 'F') ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Carl', 'Tate', 1056)
('Sara', 'Nelson', 1055)
*/

-- Prediction Query
SELECT Fname, Lname, Age FROM Student WHERE Sex = 'F';

/*
Prediction Result:
('Sara', 'Nelson', 1055)
('Carl', 'Tate', 1056)
*/