-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT behavior (one student with both a dog and a cat, and two different students sharing the same Fname) and LName vs Fname projection.
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Anderson', 'Zack', 20, 'M', 600, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Zimmerman', 'Aaron', 21, 'M', 600, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Miller', 'Zack', 22, 'M', 500, 1001, 'CHI');
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (201, 'dog', 4, 40.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (202, 'cat', 3, 8.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (203, 'dog', 1, 15.0);
INSERT INTO Has_Pet (StuID, PetID) VALUES (1, 201);
INSERT INTO Has_Pet (StuID, PetID) VALUES (1, 202);
INSERT INTO Has_Pet (StuID, PetID) VALUES (2, 202);
INSERT INTO Has_Pet (StuID, PetID) VALUES (3, 203);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."pettype" AS "pettype", "RHS"."pet_age" AS "pet_age", "RHS"."weight" AS "weight" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."petid" AS "petid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "has_pet" AS "LHS" INNER JOIN "student" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN "pets" AS "RHS" ON ("LHS"."petid" = "RHS"."petid")) WHERE ("pettype" = 'dog' OR "pettype" = 'cat') ORDER BY fname, "fname" NULLS LAST;

/*
Gold Result:
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT T1.Fname FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid JOIN pets AS T3 ON T3.petid = T2.petid WHERE T3.pettype = 'cat' OR T3.pettype = 'dog';

/*
Prediction Result:
('Zack',)
('Aaron',)
*/