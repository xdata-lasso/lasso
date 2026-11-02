-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Doe', 'Jane', 19, 'F', 600, 1121, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1003, 'Lee', 'Chris', 22, 'M', 520, 1148, 'BOS');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (2, 'Delta Hall', 500, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (100, 'Charlie Tower', 200, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (1, 'Alpha House', 300, 'X');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (9, 'Zulu Lodge', 50, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (50, 'Bravo Court', 100, 'A');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (10, 'WiFi');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (20, 'Gym');
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 50);
INSERT INTO Has_amenity (amenid, dormid) VALUES (20, 50);
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 1);
INSERT INTO Has_amenity (amenid, dormid) VALUES (20, 9);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (50, 1001, 101);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (50, 1002, 102);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (1, 1003, 201);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM (SELECT * FROM (SELECT * FROM dorm ORDER BY dormid DESC) LIMIT 1);

/*
Gold Result:
('Charlie Tower',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC, dorm.dormid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Delta Hall',)
*/