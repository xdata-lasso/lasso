-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests three-valued logic (NULLs in filtering columns), non-M/F sex values, and NULLS LAST in ORDER BY
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'X_Nyc_Old', 'Xena', 25, 'X', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'X_Null_Null', 'Yuri', NULL, 'X', 100, 1, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'NullSex_Bal', 'Zack', 18, NULL, 100, 1, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'NullSex_Old', 'Wanda', 25, NULL, 100, 1, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'F_Bal_NullAge', 'Vera', NULL, 'F', 100, 1, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'M_Bal_NullAge', 'Umar', NULL, 'M', 100, 1, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, NULL, 'NullLname1', 18, 'M', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (8, NULL, 'NullLname2', 22, 'F', 100, 1, 'BAL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "lname" FROM (SELECT * FROM "student" WHERE ("sex" <> 'F' OR "city_code" = 'BAL')) WHERE ("sex" <> 'M' OR age < 20) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
(None,)
('F_Bal_NullAge',)
('NullSex_Bal',)
('X_Null_Null',)
('X_Nyc_Old',)
*/

-- Prediction Query
SELECT lname FROM student WHERE sex = 'F' AND city_code = 'BAL' UNION SELECT lname FROM student WHERE sex = 'M' AND age < 20;

/*
Prediction Result:
(None,)
('F_Bal_NullAge',)
*/