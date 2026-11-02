-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 25, 'M', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Smith', 'John', 24, 'M', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Doe', 'Jane', 23, 'F', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Brown', 'Bob', 22, 'M', 103, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Taylor', 'Eve', 21, 'F', 104, 1004, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Miller', 'Tom', 20, 'M', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Wilson', 'Sara', 19, 'F', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (8, 'Moore', 'Mike', 18, 'M', 103, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (9, 'Clark', 'Anna', 17, 'F', 104, 1004, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Hall', 'Paul', 16, 'M', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (11, 'Lee', 'Kim', 15, 'F', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (12, 'Allen', 'Dan', 14, 'M', 103, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (13, 'Young', 'Zoe', 13, 'F', 104, 1004, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (14, 'King', 'Max', 12, 'M', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (15, 'Wright', 'Mia', 11, 'F', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (16, 'Scott', 'Leo', 10, 'M', 103, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (17, 'Green', 'Lily', 9, 'F', 104, 1004, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (18, 'Baker', 'Sam', 8, 'M', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (19, 'Adams', 'Nora', 7, 'F', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Nelson', 'Ben', 6, 'M', 103, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (21, 'Carter', 'Chloe', 5, 'F', 104, 1004, 'BOS');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (1, 'Alpha', 100, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (2, 'Beta', 100, 'F');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (1, 'WiFi');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (2, 'Gym');
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 1);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (1, 1, 101);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (2, 3, 201);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, AVG(age) OVER () AS meanage FROM student) ORDER BY age) LIMIT 19);

/*
Gold Result:
('Chloe', 'Carter')
('Ben', 'Nelson')
('Nora', 'Adams')
('Sam', 'Baker')
('Lily', 'Green')
('Leo', 'Scott')
('Mia', 'Wright')
('Max', 'King')
('Zoe', 'Young')
('Dan', 'Allen')
('Kim', 'Lee')
('Paul', 'Hall')
('Anna', 'Clark')
('Mike', 'Moore')
('Sara', 'Wilson')
('Tom', 'Miller')
('Eve', 'Taylor')
('Bob', 'Brown')
('Jane', 'Doe')
*/

-- Prediction Query
SELECT fname, lname FROM student WHERE age < (SELECT AVG(age) FROM student);

/*
Prediction Result:
('Dan', 'Allen')
('Zoe', 'Young')
('Max', 'King')
('Mia', 'Wright')
('Leo', 'Scott')
('Lily', 'Green')
('Sam', 'Baker')
('Nora', 'Adams')
('Ben', 'Nelson')
('Chloe', 'Carter')
*/