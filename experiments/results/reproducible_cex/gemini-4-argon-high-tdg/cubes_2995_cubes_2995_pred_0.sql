-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2001, 'Brown', 'Chris', 22, 'X', 100, 2100, 'CHI');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (10, 'North Quad', 120, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (20, 'South Quad', 180, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (30, 'East Quad', 250, 'x');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (40, 'West Quad', 150, NULL);
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (1, 'Gym');
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 10);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (10, 2001, 110);
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