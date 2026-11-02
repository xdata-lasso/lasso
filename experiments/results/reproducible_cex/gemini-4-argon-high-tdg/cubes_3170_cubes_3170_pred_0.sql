-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'Linda', 20, 'F', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Jones', 'Linda', 21, 'F', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Smith', 'John', 22, 'M', 101, 1001, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Doe', 'John', 23, 'M', 103, 1003, 'BOS');
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (10, 'Subway', '100 Main St', 4);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (20, 'Subway', '200 Oak Ave', 3);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (30, 'Subway', '300 Pine Rd', 5);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (40, 'Subway', '400 Elm St', 2);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (50, 'Burger King', '500 Maple Dr', 4);
INSERT INTO Restaurant_Type (ResTypeID, ResTypeName, ResTypeDescription) VALUES (1, 'Sandwich', 'Submarine sandwiches');
INSERT INTO Restaurant_Type (ResTypeID, ResTypeName, ResTypeDescription) VALUES (2, 'Fast Food', 'Quick service');
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (1, 10);
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (1, 20);
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (1, 30);
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (1, 40);
INSERT INTO Type_Of_Restaurant (ResTypeID, ResID) VALUES (2, 50);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (10, 1, '2023-05-01 12:00:00', 12.50);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (20, 2, '2023-05-02 13:00:00', 10.00);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (30, 3, '2023-05-03 14:00:00', 15.75);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (40, 4, '2023-05-04 15:00:00', 9.25);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (50, 4, '2023-05-05 16:00:00', 11.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "resid" AS "count___" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resname" AS "resname", "LHS"."address" AS "address", "LHS"."rating" AS "rating", "RHS"."n" AS "n" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resname" AS "resname", "RHS"."address" AS "address", "RHS"."rating" AS "rating" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "visits_restaurant" AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith')) AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "restaurant" WHERE ("resname" = 'Subway')) AS "RHS" ON ("LHS"."resid" = "RHS"."resid")) AS "LHS" INNER JOIN (SELECT "age", "fname", COUNT(*) AS "n" FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith') GROUP BY age, fname) AS RHS ON (LHS.fname = RHS.fname AND LHS.age = RHS.age)) ORDER BY count___;

/*
Gold Result:
(10,)
(30,)
(40,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID JOIN Restaurant ON Visits_Restaurant.ResID = Restaurant.ResID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith' AND Restaurant.ResName = 'Subway';

/*
Prediction Result:
(1,)
*/