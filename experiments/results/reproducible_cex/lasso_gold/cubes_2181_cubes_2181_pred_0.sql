-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1050, 'Robinson', 'Lydia', NULL, 'white', 1058, 1062, 'Jasonfort');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1051, 'Nguyen', 'Linda', NULL, 'white', 1071.0, 1077.0, 'Wilkersonmouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1052, 'Tate', 'Richard', NULL, 'white', 1084.0, 1092.0, 'West Donald');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1053, 'Brown', 'Carl', NULL, 'white', 1097.0, 1107.0, 'Juliechester');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT stuid FROM (SELECT * FROM (SELECT * FROM (SELECT sex, stuid, MAX(age) AS maxage FROM student GROUP BY sex, stuid) ORDER BY maxage DESC) LIMIT 1);

/*
Gold Result:
(1050,)
*/

-- Prediction Query
SELECT StuID FROM Student WHERE age = (SELECT MAX(age) FROM Student);

/*
Prediction Result:
*/