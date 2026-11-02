-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1061, 'fall', 1062, 1063.5);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1064, 'Chavez', 'Mary', 1065, 'commercial', 1066, 1067, 'Michaelview');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1074, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "has_pet" ("stuid", "petid") VALUES (1064, 1061);
INSERT INTO "has_pet" ("stuid", "petid") VALUES (1074, 1061);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT fname, age FROM (SELECT LHS.stuid AS stuid, LHS.petid AS petid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.advisor AS advisor, RHS.city_code AS city_code FROM has_pet AS LHS INNER JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY fname, age NULLS LAST;

/*
Gold Result:
(None, None)
('Mary', 1065)
*/

-- Prediction Query
SELECT DISTINCT T1.fname, T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid;

/*
Prediction Result:
('Mary', 1065)
(None, None)
*/