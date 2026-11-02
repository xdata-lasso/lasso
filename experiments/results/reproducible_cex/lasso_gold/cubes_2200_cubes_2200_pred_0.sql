-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('his', 'traditional');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('way', 'among');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('worker', 'help');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('style', 'develop');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('doctor', 'magazine');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('decision', 'hard');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('technology', 'focus');
INSERT INTO "allergy_type" ("allergy", "allergytype") VALUES ('why', 'tend');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1193, 'Fleming', 'Nancy', 1197, 'economic', 1201, 1205, 'South Angel');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1194, 'Estrada', 'Terri', 1206.0, 'commercial', 1214.0, 1220.0, 'Kimberlychester');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1195, 'Gomez', 'Kara', 1215.0, 'such', 1227.0, 1235.0, 'West Erik');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1196, 'Castro', 'Sara', 1224.0, 'talk', 1240.0, 1250.0, 'South Monicafort');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1209, 'Pope', 'Mark', 1213, 'instead', 1217, 1221, 'Sheilaville');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1210, 'Perez', 'Michelle', 1222.0, 'respond', 1230.0, 1236.0, 'Gregoryview');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1211, 'Johnson', 'Tammy', 1231.0, 'threat', 1243.0, 1251.0, 'North Candacestad');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1212, 'Lee', 'Darlene', 1240.0, 'not', 1256.0, 1266.0, 'Samuelhaven');
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES (NULL, 1193);
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES (NULL, 1194);
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES (NULL, 1195);
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES (NULL, 1196);
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('doctor', 1209);
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('doctor', 1210);
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('doctor', 1211);
INSERT INTO "has_allergy" ("allergy", "stuid") VALUES ('doctor', 1212);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergy FROM (SELECT * FROM (SELECT * FROM (SELECT allergy, COUNT(*) AS n FROM has_allergy GROUP BY allergy) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Allergy FROM Has_allergy GROUP BY Allergy ORDER BY COUNT(*) DESC, Allergy NULLS LAST LIMIT 1;

/*
Prediction Result:
('doctor',)
*/