-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1034, 'Galloway', 'Shawn', 1038, 'religious', 1042, 1046, 'New Cynthiaside');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1035, 'Wyatt', 'Mary', 1047.0, 'example', 1055.0, 1061.0, 'East Steven');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1036, 'Delacruz', 'Francisco', 1056.0, 'science', 1068.0, 1076.0, 'Veronicaside');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1037, 'James', 'Michael', 1065.0, 'write', 1081.0, 1091.0, 'Lake Mark');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1050, 'Tate', 'Richard', NULL, 'serious', 1058, 1062, 'Fostermouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1051, 'Brown', 'Carl', NULL, 'forward', 1071.0, 1077.0, 'West Donald');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1052, 'Underwood', 'Robin', NULL, 'difference', 1084.0, 1092.0, 'Juliechester');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1053, 'Trujillo', 'Ashley', NULL, 'reality', 1097.0, 1107.0, 'Coxberg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lname FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, MIN(age) OVER () AS minage FROM student) ORDER BY age) LIMIT 1);

/*
Gold Result:
('Tate',)
*/

-- Prediction Query
SELECT LName FROM Student WHERE age = (SELECT MIN(age) FROM Student);

/*
Prediction Result:
('Galloway',)
*/