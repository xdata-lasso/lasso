-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'OtherSexOld', 'Pat', 25, 'X', 300, 3, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'OtherSexYng', 'Sam', 18, 'O', 300, 3, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'NullSexBalYng', 'Chris', 19, NULL, 300, 3, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'NullSexBalOld', 'Terry', 22, NULL, 300, 3, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'NullSexNycYng', 'Morgan', 18, NULL, 300, 3, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'NullAgeMBal', 'Jordan', NULL, 'M', 300, 3, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, 'NullAgeFBal', 'Taylor', NULL, 'F', 300, 3, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (8, 'NullCityMYng', 'Casey', 19, 'M', 300, 3, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (9, 'NullCityFYng', 'Riley', 19, 'F', 300, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "lname" FROM (SELECT * FROM "student" WHERE ("sex" <> 'F' OR "city_code" = 'BAL')) WHERE ("sex" <> 'M' OR age < 20) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('NullAgeFBal',)
('NullCityMYng',)
('NullSexBalYng',)
('OtherSexOld',)
('OtherSexYng',)
*/

-- Prediction Query
SELECT lname FROM student WHERE sex = 'F' AND city_code = 'BAL' UNION SELECT lname FROM student WHERE sex = 'M' AND age < 20;

/*
Prediction Result:
('NullAgeFBal',)
('NullCityMYng',)
*/