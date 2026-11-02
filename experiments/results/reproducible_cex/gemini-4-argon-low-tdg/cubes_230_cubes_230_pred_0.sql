-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 600, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Doe', 'Jane', 22, 'F', 600, 1002, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (103, 'Brown', 'Charlie', 19, 'M', 500, 1001, 'CHI');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (1, 'Dog', 3, 25.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (2, 'Cat', 2, 8.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (3, 'Bird', 1, 0.5);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (102, 1);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (101, 2);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (101, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, stuid FROM (SELECT stuid, COUNT(*) AS n FROM (SELECT LHS.stuid AS stuid, LHS.petid AS petid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.advisor AS advisor, RHS.city_code AS city_code FROM has_pet AS LHS LEFT JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) GROUP BY stuid) ORDER BY count___, stuid NULLS LAST;

/*
Gold Result:
(1, 102)
(2, 101)
*/

-- Prediction Query
SELECT COUNT(*), t1.stuid FROM student AS t1 JOIN has_pet AS t2 ON t1.stuid = t2.stuid GROUP BY t1.stuid;

/*
Prediction Result:
(2, 101)
(1, 102)
*/