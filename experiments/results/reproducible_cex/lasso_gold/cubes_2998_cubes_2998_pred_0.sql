-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1020, 'Barnes', 'Shane', 1021, 'fall', 1022, 1023, 'Port Lindachester');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1024, 'Peterson', 'Eric', NULL, 'source', 1026, 1027, 'Curtisfurt');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1028, 'Davis', 'Melanie', 1029, 'PM', 1030, 1031, 'Curtisfurt');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, city_code FROM (SELECT city_code, AVG(age) AS meanage FROM student GROUP BY city_code) ORDER BY avg_age_, city_code NULLS LAST;

/*
Gold Result:
(1021.0, 'Port Lindachester')
(1029.0, 'Curtisfurt')
*/

-- Prediction Query
SELECT AVG(age), city_code FROM student GROUP BY city_code;

/*
Prediction Result:
(1029.0, 'Curtisfurt')
(1021.0, 'Port Lindachester')
*/