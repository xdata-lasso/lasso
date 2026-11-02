-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Doe', 'Jane', 21, 'F', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (30, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (40, 'Brown', 'Bob', 22, 'M', 520, 1148, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (50, 'White', 'Amy', 19, 'F', 520, 1148, 'BOS');
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (1, 'Dog', 3, 25.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (2, 'Cat', 2, 8.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (3, 'Dog', 5, 40.0);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (4, 'Bird', 1, 0.5);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (5, 'Cat', 4, 10.2);
INSERT INTO "Pets" ("PetID", "PetType", "pet_age", "weight") VALUES (6, 'Fish', 1, 0.1);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (40, 4);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (40, 5);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (10, 1);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (10, 2);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (10, 3);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (30, 1);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (20, 2);
INSERT INTO "Has_Pet" ("StuID", "PetID") VALUES (20, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, stuid FROM (SELECT stuid, COUNT(*) AS n FROM (SELECT LHS.stuid AS stuid, LHS.petid AS petid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.advisor AS advisor, RHS.city_code AS city_code FROM has_pet AS LHS LEFT JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) GROUP BY stuid) ORDER BY count___, stuid NULLS LAST;

/*
Gold Result:
(1, 30)
(2, 20)
(2, 40)
(3, 10)
*/

-- Prediction Query
SELECT COUNT(*), t1.stuid FROM student AS t1 JOIN has_pet AS t2 ON t1.stuid = t2.stuid GROUP BY t1.stuid;

/*
Prediction Result:
(3, 10)
(2, 20)
(1, 30)
(2, 40)
*/