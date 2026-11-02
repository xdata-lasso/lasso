-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1023, 'X', 1024, 'save');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "meanstudent_capacity" AS "avg_student_capacity_", SUM("student_capacity") OVER () AS "sum_student_capacity_" FROM (SELECT "dormid", "dorm_name", "student_capacity", "gender", AVG("student_capacity") OVER () AS "meanstudent_capacity" FROM (SELECT * FROM "dorm" WHERE ("gender" = 'X'))) ORDER BY avg_student_capacity_, sum_student_capacity_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(student_capacity), SUM(student_capacity) FROM dorm WHERE gender = 'X';

/*
Prediction Result:
(None, None)
*/