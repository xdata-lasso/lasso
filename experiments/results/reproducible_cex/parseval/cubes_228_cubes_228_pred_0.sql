-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_5554fd', 'stu_ebb0d7', 20, 'f', -55602865, -59984348, 'db6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_5554fd', 'stu_ebb0d7', 20, 'f', -1022641847, -1726781632, 'db6');

-- Inserting into table: pets --
INSERT INTO "pets" ("petid", "pettype", "pet_age", "weight") VALUES (-2147483648, 'pet_c4475b', -664303813, 833.684115);

-- Inserting into table: has_pet --
INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, -2147483648);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, -2147483648);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, -2147483648);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, -2147483648);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, -2147483648);

INSERT INTO "has_pet" ("stuid", "petid") VALUES (1, -2147483648);
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