-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (1, 'Smith Hall', 100, 'M');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (10, 'WiFi');
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 1);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Adams', 'John', 18, 'M', 100, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Baker', 'Alice', 19, 'F', 200, 2, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (103, 'Clark', 'Bob', 20, 'M', 300, 3, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (104, 'Davis', 'Eve', 18, 'M', 100, 1, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (105, 'Evans', 'Grace', 21, 'F', 400, 4, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (106, 'Frank', 'Hank', 22, 'M', 500, 5, 'ATL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (107, 'Green', 'Ivy', 19, 'F', 600, 6, 'ATL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (108, 'Hall', 'Jack', 23, 'M', 700, 7, 'ATL');
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (1, 101, 101);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (1, 104, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, city_code FROM (SELECT city_code, COUNT(*) AS n FROM student GROUP BY city_code) WHERE (n > 1) ORDER BY count___, city_code NULLS LAST;

/*
Gold Result:
(2, 'BOS')
(2, 'CHI')
(3, 'ATL')
*/

-- Prediction Query
SELECT COUNT(*), city_code FROM student GROUP BY city_code HAVING COUNT(*) > 1;

/*
Prediction Result:
(3, 'ATL')
(2, 'BOS')
(2, 'CHI')
*/