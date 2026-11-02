-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (1, 'Alpha Hall', 99, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (2, 'Beta Hall', 100, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (3, 'Gamma Hall', 299, 'X');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (4, 'Delta Hall', 300, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (5, 'Epsilon Hall', 301, 'M');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name, gender FROM dorm WHERE (student_capacity >= 300 OR student_capacity < 100) ORDER BY dorm_name, dorm.dormid NULLS LAST;

/*
Gold Result:
('Alpha Hall', 'F')
('Delta Hall', 'F')
('Epsilon Hall', 'M')
*/

-- Prediction Query
SELECT dorm_name, gender FROM dorm WHERE student_capacity > 300 OR student_capacity < 100;

/*
Prediction Result:
('Alpha Hall', 'F')
('Epsilon Hall', 'M')
*/