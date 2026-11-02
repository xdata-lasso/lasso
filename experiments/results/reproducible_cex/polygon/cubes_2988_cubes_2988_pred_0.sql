-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (13, '9', '9', 9, '9', 9, 9, '9');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (NULL, NULL, 300, NULL);
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (9, NULL, 301, '16');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (12, '9');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (11, '9');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (12, 9);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (12, 9);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (9, 13, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM dorm WHERE (student_capacity >= 300) ORDER BY dorm_name, dorm.dormid NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT dorm_name FROM dorm WHERE student_capacity > 300;

/*
Prediction Result:
(None,)
*/