-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1054, 'Morales', 'Jennifer', 1074, 'question', 1078, 1082, 'Lake Jenniferside');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1055, 'Jones', 'Jason', 1067.0, 'low', 1075.0, 1081.0, 'Juliechester');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1056, 'Gentry', 'Victor', 1076.0, 'character', 1088.0, 1096.0, 'Coxberg');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1057, 'Bradley', 'Nicole', 1085.0, 'evidence', 1101.0, 1111.0, 'Daviston');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1070, 'Callahan', 'Candace', 1058, 'enter', 1062, 1066, 'East Julie');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1071, 'Hernandez', 'Paul', 1083.0, 'on', 1091.0, 1097.0, 'Kaylamouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1072, 'Moore', 'Caitlin', 1092.0, 'traditional', 1104.0, 1112.0, 'West Ryanmouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1073, 'Becker', 'Taylor', 1101.0, 'yes', 1117.0, 1127.0, 'Lake Nancyview');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, COUNT(*) OVER () AS n FROM student) ORDER BY stuid) LIMIT 1);

/*
Gold Result:
(1078,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major ORDER BY COUNT(*) DESC, major NULLS LAST LIMIT 1;

/*
Prediction Result:
(1062,)
*/