-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Adams', 'Aaron', 39, 'M', 600, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Baker', 'Beth', 38, 'F', 600, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Clark', 'Carl', 37, 'M', 520, 1001, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Davis', 'Diana', 25, 'F', 520, 1003, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Evans', 'Eric', 18, 'M', 540, 1002, 'SFO');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Frank', 'Fiona', 36, 'F', 540, 1004, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Green', 'George', 19, 'M', 600, 1001, 'MIA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (8, 'Hall', 'Hannah', 35, 'F', 550, 1005, 'DAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (9, 'Irwin', 'Ian', 20, 'M', 550, 1003, 'DEN');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Jones', 'Julia', 34, 'F', 600, 1002, 'ATL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (11, 'King', 'Kevin', 21, 'M', 520, 1004, 'PHX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (12, 'Lewis', 'Laura', 33, 'F', 540, 1005, 'DET');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (13, 'Moore', 'Mike', 22, 'M', 600, 1001, 'MSP');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (14, 'Nash', 'Nina', 32, 'F', 520, 1003, 'SAN');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (15, 'Owens', 'Oscar', 23, 'M', 550, 1002, 'TPA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (16, 'Perez', 'Paula', 31, 'F', 540, 1004, 'PDX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (17, 'Quinn', 'Quentin', 24, 'M', 600, 1005, 'STL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (18, 'Reed', 'Rachel', 30, 'F', 520, 1001, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (19, 'Scott', 'Sam', 26, 'M', 550, 1003, 'CLT');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Turner', 'Tina', 29, 'F', 600, 1002, 'PIT');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (21, 'Upton', 'Ulysses', 27, 'M', 540, 1004, 'RDU');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (22, 'Vance', 'Vera', 28, 'F', 520, 1005, 'CLE');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (101, 'Oak Hall', 100, 'M');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (102, 'Pine Hall', 120, 'F');
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (101, 1, 201);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (101, 5, 105);
INSERT INTO Lives_in (dormid, stuid, room_number) VALUES (102, 2, 302);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, AVG(age) OVER () AS meanage FROM student) ORDER BY age) LIMIT 19);

/*
Gold Result:
('Eric', 'Evans')
('George', 'Green')
('Ian', 'Irwin')
('Kevin', 'King')
('Mike', 'Moore')
('Oscar', 'Owens')
('Quentin', 'Quinn')
('Diana', 'Davis')
('Sam', 'Scott')
('Ulysses', 'Upton')
('Vera', 'Vance')
('Tina', 'Turner')
('Rachel', 'Reed')
('Paula', 'Perez')
('Nina', 'Nash')
('Laura', 'Lewis')
('Julia', 'Jones')
('Hannah', 'Hall')
('Fiona', 'Frank')
*/

-- Prediction Query
SELECT fname, lname FROM student WHERE age < (SELECT AVG(age) FROM student);

/*
Prediction Result:
('Diana', 'Davis')
('Eric', 'Evans')
('George', 'Green')
('Ian', 'Irwin')
('Kevin', 'King')
('Mike', 'Moore')
('Oscar', 'Owens')
('Quentin', 'Quinn')
('Sam', 'Scott')
('Ulysses', 'Upton')
('Vera', 'Vance')
*/