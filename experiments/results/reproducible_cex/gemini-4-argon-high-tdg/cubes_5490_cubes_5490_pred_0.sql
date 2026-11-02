-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (30, 'Oak Hall', 100, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (20, 'Pine Hall', 150, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (10, 'Maple Hall', 120, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (5, 'Cedar Hall', 110, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (40, 'Birch Hall', 99, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (50, 'Elm Hall', 200, 'F');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (1, 'Wifi');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (2, 'Gym');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (3, 'Study Room');
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 30);
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 20);
INSERT INTO Has_amenity (amenid, dormid) VALUES (2, 20);
INSERT INTO Has_amenity (amenid, dormid) VALUES (2, 10);
INSERT INTO Has_amenity (amenid, dormid) VALUES (3, 10);
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 5);
INSERT INTO Has_amenity (amenid, dormid) VALUES (2, 5);
INSERT INTO Has_amenity (amenid, dormid) VALUES (3, 5);
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 40);
INSERT INTO Has_amenity (amenid, dormid) VALUES (2, 40);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Smith', 'John', 20, 'M', 1, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Doe', 'Jane', 21, 'F', 2, 11, 'LAX');
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (50, 101, 101);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (50, 102, 102);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (30, 101, 201);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (30, 102, 202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, dormid FROM (SELECT dormid, COUNT(*) AS n FROM (SELECT * FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, RHS.amenid AS amenid FROM dorm AS LHS INNER JOIN has_amenity AS RHS ON (LHS.dormid = RHS.dormid)) WHERE (student_capacity >= 100)) GROUP BY dormid) ORDER BY count___, dormid NULLS LAST;

/*
Gold Result:
(1, 30)
(2, 10)
(2, 20)
(3, 5)
*/

-- Prediction Query
SELECT COUNT(*), T1.dormid FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid = T2.dormid WHERE T1.student_capacity > 100 GROUP BY T1.dormid;

/*
Prediction Result:
(3, 5)
(2, 10)
(2, 20)
*/