-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Doe', 'Jane', 22, 'F', 600, 1121, 'BOS');
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (1, 'Aaron Diner', '500 Fifth Ave', 5);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (2, 'Zesty Spoon', '900 Ninth Ave', 1);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (3, 'Bistro Alpha', '100 First Ave', 4);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (4, 'Crown Grill', '300 Third Ave', 3);
INSERT INTO Restaurant_Type (ResTypeID, ResTypeName, ResTypeDescription) VALUES (1, 'Diner', 'Casual American diner');
INSERT INTO Restaurant_Type (ResTypeID, ResTypeName, ResTypeDescription) VALUES (2, 'Steakhouse', 'Fine dining steakhouse');
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (1, 1);
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (2, 2);
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (2, 4);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (1, 101, '2023-05-01 12:00:00', 25.50);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (2, 102, '2023-05-02 18:30:00', 40.00);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (4, 101, '2023-05-03 19:00:00', 55.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resname, rating FROM (SELECT * FROM (SELECT * FROM restaurant ORDER BY address, restaurant.resid NULLS LAST) LIMIT 1);

/*
Gold Result:
('Bistro Alpha', 4)
*/

-- Prediction Query
SELECT ResName, Rating FROM Restaurant ORDER BY Rating DESC, Restaurant.resid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Aaron Diner', 5)
*/