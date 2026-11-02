-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (20, 'Alpha Hall', 500, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (5, 'Zeta Hall', 300, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (35, 'Beta Hall', 100, 'X');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (10, 'Gamma Hall', 400, 'F');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 101, 201, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Doe', 'Jane', 21, 'F', 102, 202, 'LAX');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (1, 'WiFi');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (2, 'Gym');
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 20);
INSERT INTO Has_amenity (amenid, dormid) VALUES (2, 5);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (20, 2, 101);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (5, 1, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dorm_name FROM (SELECT * FROM (SELECT * FROM dorm ORDER BY dormid DESC) LIMIT 1);

/*
Gold Result:
('Beta Hall',)
*/

-- Prediction Query
SELECT dorm_name FROM dorm ORDER BY student_capacity DESC, dorm.dormid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha Hall',)
*/