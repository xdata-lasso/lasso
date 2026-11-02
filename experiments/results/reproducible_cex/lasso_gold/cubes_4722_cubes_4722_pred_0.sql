-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1232, 'Bentley', 'Kevin', 1236, 'law', 1240, NULL, 'Stevenmouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1233, 'Byrd', 'Amy', 1245.0, 'stock', 1253.0, NULL, 'New Thomas');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1234, 'Orr', 'Aaron', 1254.0, 'particularly', 1266.0, NULL, 'Lake Christopher');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1235, 'Gilbert', 'Justin', 1263.0, 'policy', 1279.0, NULL, 'Clarencebury');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1245, 'Chambers', 'John', 1249, 'join', 1253, 1257, 'Lake Heather');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1246, 'Walker', 'Thomas', 1258.0, 'various', 1266.0, 1257, 'Rossberg');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1247, 'Gonzalez', 'Melissa', 1267.0, 'professional', 1279.0, 1257, 'Port Michelleville');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1248, 'Johnson', 'Charles', 1276.0, 'parent', 1292.0, 1257, 'Robinsonhaven');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT advisor FROM (SELECT * FROM (SELECT * FROM (SELECT advisor, MAX(n) AS n FROM (SELECT advisor, COUNT(*) AS n FROM student GROUP BY advisor) GROUP BY advisor) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT advisor FROM Student GROUP BY advisor ORDER BY COUNT(*) DESC, advisor NULLS LAST LIMIT 1;

/*
Prediction Result:
(1257,)
*/