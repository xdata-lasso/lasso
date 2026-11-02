-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1020, 'Barnes', 'Shane', 1021, 'fall', 1022, 1023, 'Port Lindachester');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1024, 'Peterson', 'Eric', NULL, 'source', 1026, 1027, 'Curtisfurt');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, sex FROM (SELECT sex, AVG(age) AS meanage FROM student GROUP BY sex) ORDER BY avg_age_, sex NULLS LAST;

/*
Gold Result:
(None, 'source')
(1021.0, 'fall')
*/

-- Prediction Query
SELECT AVG(age), sex FROM Student GROUP BY sex;

/*
Prediction Result:
(1021.0, 'fall')
(None, 'source')
*/