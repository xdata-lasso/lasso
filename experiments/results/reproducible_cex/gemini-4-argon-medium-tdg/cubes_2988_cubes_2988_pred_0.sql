-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (10, 'Zeta Hall', 300, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (20, 'Alpha Hall', 301, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (30, 'Beta Hall', 299, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (40, 'Gamma Hall', NULL, 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM dorm WHERE (student_capacity >= 300) ORDER BY dorm_name, dorm.dormid NULLS LAST;

/*
Gold Result:
('Alpha Hall',)
('Zeta Hall',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm WHERE student_capacity > 300;

/*
Prediction Result:
('Alpha Hall',)
*/