-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'Smith Hall', 100, 'M');
INSERT INTO "Dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'Jones Hall', 120, 'F');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (10, 'WiFi');
INSERT INTO "Dorm_amenity" ("amenid", "amenity_name") VALUES (20, 'Gym');
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (10, 1);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (20, 1);
INSERT INTO "Has_amenity" ("amenid", "dormid") VALUES (10, 2);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Adams', 'John', 30, 'M', 600, 111, 'AAA');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1002, 'Baker', 'Alice', 20, 'F', 600, 111, 'BBB');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1003, 'Clark', 'Bob', 20, 'M', 500, 222, 'BBB');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1004, 'Davis', 'Eve', 23, 'F', 500, 222, 'BBB');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1005, 'Evans', 'Tom', 18, 'M', 400, 333, 'CCC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1006, 'Frank', 'Sara', 19, 'F', 400, 333, 'CCC');
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1001, 101);
INSERT INTO "Lives_in" ("dormid", "stuid", "room_number") VALUES (2, 1002, 202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, city_code FROM (SELECT city_code, AVG(age) AS meanage FROM student GROUP BY city_code) ORDER BY avg_age_, city_code NULLS LAST;

/*
Gold Result:
(18.5, 'CCC')
(21.0, 'BBB')
(30.0, 'AAA')
*/

-- Prediction Query
SELECT AVG(age), city_code FROM student GROUP BY city_code;

/*
Prediction Result:
(30.0, 'AAA')
(21.0, 'BBB')
(18.5, 'CCC')
*/