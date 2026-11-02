-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1238, 'evidence', 1239, 1240.5);
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (1242, 'evidence', 1239, 1240.5);
INSERT INTO "has_pet" ("stuid", "petid") VALUES (NULL, 1238);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, stuid FROM (SELECT stuid, COUNT(*) AS n FROM (SELECT LHS.stuid AS stuid, LHS.petid AS petid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.advisor AS advisor, RHS.city_code AS city_code FROM has_pet AS LHS LEFT JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) GROUP BY stuid) ORDER BY count___, stuid NULLS LAST;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), t1.stuid FROM student AS t1 JOIN has_pet AS t2 ON t1.stuid = t2.stuid GROUP BY t1.stuid;

/*
Prediction Result:
*/