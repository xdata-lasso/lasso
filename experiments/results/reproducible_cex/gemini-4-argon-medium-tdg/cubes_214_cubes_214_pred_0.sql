-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT across different students (same Fname and Age, different StuID/LName), and secondary sort on Age with same Fname
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Alice', 20, 'F', 100, 1000, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Adams', 'Alice', 20, 'F', 102, 1002, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Alice', 19, 'F', 100, 1000, 'NYC');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (10, 'Dog', 3, 15.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (11, 'Cat', 2, 8.0);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (1, 10);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (2, 11);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (3, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT fname, age FROM (SELECT LHS.stuid AS stuid, LHS.petid AS petid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.advisor AS advisor, RHS.city_code AS city_code FROM has_pet AS LHS INNER JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY fname, age NULLS LAST;

/*
Gold Result:
('Alice', 19)
('Alice', 20)
*/

-- Prediction Query
SELECT DISTINCT T1.fname, T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid;

/*
Prediction Result:
('Alice', 20)
('Alice', 19)
*/