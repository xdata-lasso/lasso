-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests predicate boundaries (<100, =100, >100, NULL), INNER vs LEFT JOIN (0 amenities), and ORDER BY (count___ ASC, dormid ASC with ties).
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (1, 'Alpha', 99, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (2, 'Beta', 100, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (3, 'Gamma', 150, 'X');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (4, 'Delta', 200, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (5, 'Epsilon', 120, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (6, 'Zeta', NULL, 'X');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (10, 'WiFi');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (20, 'Gym');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (30, 'Pool');
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 1);
INSERT INTO Has_amenity (amenid, dormid) VALUES (20, 1);
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 2);
INSERT INTO Has_amenity (amenid, dormid) VALUES (20, 2);
INSERT INTO Has_amenity (amenid, dormid) VALUES (30, 3);
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 4);
INSERT INTO Has_amenity (amenid, dormid) VALUES (20, 4);
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, dormid FROM (SELECT dormid, COUNT(*) AS n FROM (SELECT * FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, RHS.amenid AS amenid FROM dorm AS LHS INNER JOIN has_amenity AS RHS ON (LHS.dormid = RHS.dormid)) WHERE (student_capacity >= 100)) GROUP BY dormid) ORDER BY count___, dormid NULLS LAST;

/*
Gold Result:
(1, 3)
(2, 2)
(2, 4)
*/

-- Prediction Query
SELECT COUNT(*), T1.dormid FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid = T2.dormid WHERE T1.student_capacity > 100 GROUP BY T1.dormid;

/*
Prediction Result:
(1, 3)
(2, 4)
*/