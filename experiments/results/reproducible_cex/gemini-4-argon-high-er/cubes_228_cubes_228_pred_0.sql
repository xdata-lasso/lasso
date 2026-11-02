-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (StuID, Age) VALUES (1, 20);
INSERT INTO Pets (PetID) VALUES (1);
INSERT INTO Has_Pet (StuID, PetID) VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT stuid FROM student WHERE (age = 20) INTERSECT SELECT stuid FROM has_pet)) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid WHERE T1.age > 20;

/*
Prediction Result:
(0,)
*/