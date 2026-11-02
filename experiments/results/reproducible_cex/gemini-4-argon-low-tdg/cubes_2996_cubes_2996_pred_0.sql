-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exclusion of dorms without amenities, exclusion of dorms with NULL dorm_name or gender, and ordering by student_capacity ASC vs DESC.
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (1, 'SmallestNoAmen', 50, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (2, 'NullNameAmen', NULL, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (3, 'NullGenderAmen', 75, NULL);
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (4, 'ValidSmallAmen', 100, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (5, 'ValidLargeAmen', 300, 'M');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (10, 'WiFi');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (20, 'Pool');
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 2);
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 3);
INSERT INTO Has_amenity (amenid, dormid) VALUES (10, 4);
INSERT INTO Has_amenity (amenid, dormid) VALUES (20, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name, student_capacity FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, LHS.amenid AS amenid, LHS.amenity_name AS amenity_name, RHS.n AS n FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, LHS.amenid AS amenid, LHS.amenity_name AS amenity_name FROM (SELECT LHS.dormid AS dormid, LHS.dorm_name AS dorm_name, LHS.student_capacity AS student_capacity, LHS.gender AS gender, RHS.amenid AS amenid, RHS.amenity_name AS amenity_name FROM dorm AS LHS CROSS JOIN dorm_amenity AS RHS) AS LHS INNER JOIN has_amenity AS RHS ON (LHS.dormid = RHS.dormid AND LHS.amenid = RHS.amenid)) AS LHS INNER JOIN (SELECT dorm_name, gender, COUNT(*) AS n FROM dorm GROUP BY dorm_name, gender) AS RHS ON (LHS.dorm_name = RHS.dorm_name AND LHS.gender = RHS.gender)) ORDER BY student_capacity) LIMIT 1);

/*
Gold Result:
('NullNameAmen', None)
*/

-- Prediction Query
SELECT T1.dorm_name, T1.student_capacity FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid = T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid = T3.amenid GROUP BY T2.dormid ORDER BY COUNT(*), T1.dorm_name NULLS LAST, T1.student_capacity NULLS LAST LIMIT 1;

/*
Prediction Result:
('NullGenderAmen', 75)
*/