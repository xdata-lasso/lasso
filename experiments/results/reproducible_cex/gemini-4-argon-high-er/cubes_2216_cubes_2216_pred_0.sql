-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Milk', 'Food');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'Zack', 20, 'M', 100, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Jones', 'Alice', 21, 'F', 100, 1, 'LAX');
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Milk', NULL);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Milk', 1);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Milk', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname", "city_code" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."allergy" AS "allergy", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT * FROM "has_allergy" WHERE ("allergy" = 'Milk' OR "allergy" = 'Cat')) AS LHS LEFT JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY fname, "fname" NULLS LAST, "city_code" NULLS LAST;

/*
Gold Result:
(None, None)
('Alice', 'LAX')
('Zack', 'NYC')
*/

-- Prediction Query
SELECT DISTINCT T1.fname, T1.city_code FROM Student AS T1 JOIN Has_Allergy AS T2 ON T1.stuid = T2.stuid WHERE T2.Allergy = 'Milk' OR T2.Allergy = 'Cat';

/*
Prediction Result:
('Zack', 'NYC')
('Alice', 'LAX')
*/