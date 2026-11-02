-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty intersection (result count = 0). Kills mutants using UNION, EXCEPT, or omitting the WHERE/INTERSECT clauses.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Adams', 'Amy', 20, 'F', 101, 201, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Baker', 'Ben', 22, 'M', 102, 202, 'DEN');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (1, 'Dog', 5, 30.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT stuid FROM student WHERE (age = 20) INTERSECT SELECT stuid FROM has_pet)) ORDER BY count___;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid WHERE T1.age > 20;

/*
Prediction Result:
(1,)
*/