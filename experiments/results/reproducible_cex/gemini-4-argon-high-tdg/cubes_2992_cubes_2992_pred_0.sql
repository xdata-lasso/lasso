-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (401, 'NSexPass', 'Pat', 19, NULL, 200, 4001, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (402, 'NSexFailC', 'Chris', 19, NULL, 200, 4001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (403, 'NSexFailA', 'Alex', 20, NULL, 200, 4001, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (404, 'NCityPassM', 'Max', 18, 'M', 200, 4001, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (405, 'NCityFailF', 'Fay', 18, 'F', 200, 4001, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (406, 'NAgePassF', 'Joy', NULL, 'F', 200, 4001, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (407, 'NAgeFailM', 'Roy', NULL, 'M', 200, 4001, 'BAL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "lname" FROM (SELECT * FROM "student" WHERE ("sex" <> 'F' OR "city_code" = 'BAL')) WHERE ("sex" <> 'M' OR age < 20) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('NAgePassF',)
('NCityPassM',)
('NSexPass',)
*/

-- Prediction Query
SELECT lname FROM student WHERE sex = 'F' AND city_code = 'BAL' UNION SELECT lname FROM student WHERE sex = 'M' AND age < 20;

/*
Prediction Result:
('NAgePassF',)
('NCityPassM',)
*/