-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'John', 18, 'M', 100, 1121, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Doe', 'Jane', 19, 'F', 100, 1121, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1003, 'Brown', 'Bob', 20, 'M', 100, 1121, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1004, 'White', 'Alice', 21, 'F', 200, 1121, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1005, 'Green', 'Tom', 22, 'M', 300, 1121, 'SFO');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1006, 'Black', 'Sara', 20, 'F', 300, 1121, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1007, 'Hall', 'Mike', 19, 'M', 400, 1121, 'DEN');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1008, 'King', 'Nina', 21, 'F', 400, 1121, 'MIA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1009, 'Lee', 'Chris', 20, 'M', 100, 1120, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1010, 'Kim', 'Grace', 22, 'F', 1121, 1122, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1121, 'Young', 'Paul', 23, 'M', 500, 9999, 'CHI');
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (1, 'Bistro One', '10 Main St', 5);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (2, 'Cafe Two', '20 Oak Ave', 4);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (1, 1001, '2023-01-10 12:00:00', 15.50);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (2, 1001, '2023-01-11 18:30:00', 22.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT advisor, major, COUNT(*) AS n FROM student GROUP BY advisor, major) WHERE (advisor = 1121 OR n > 1121) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Student WHERE Advisor = 1121;

/*
Prediction Result:
(8,)
*/