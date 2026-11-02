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
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (1, 'WiFi');
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 1);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 100, 901, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Doe', 'Jane', 21, 'F', 50, 902, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, NULL, NULL, NULL, NULL, 50, NULL, NULL);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Brown', 'Charlie', 19, 'M', NULL, 903, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'White', 'Lucy', 22, 'F', NULL, NULL, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Green', 'David', 20, 'M', 10, 901, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Black', 'Eva', 23, 'F', 10, 904, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (8, 'Hall', 'Frank', 18, 'M', 5, 905, 'DEN');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (9, 'Adams', 'Grace', 21, 'F', 5, 905, 'DEN');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Baker', 'Henry', 20, 'M', 5, 906, 'MIA');
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (1, 1, 101);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (1, 1, 102);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (1, 6, 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, major FROM (SELECT major, COUNT(*) AS n FROM student GROUP BY major) ORDER BY count___, major NULLS LAST;

/*
Gold Result:
(1, 100)
(2, 10)
(2, 50)
(2, None)
(3, 5)
*/

-- Prediction Query
SELECT COUNT(*), major FROM student GROUP BY major;

/*
Prediction Result:
(2, None)
(3, 5)
(2, 10)
(2, 50)
(1, 100)
*/