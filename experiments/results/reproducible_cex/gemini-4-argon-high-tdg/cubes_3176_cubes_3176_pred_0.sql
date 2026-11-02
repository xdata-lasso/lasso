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
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Brown', 'Linda', 21, 'F', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Smith', 'David', 22, 'M', 101, 1001, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Brown', 'David', 19, 'M', 103, 1003, 'BOS');
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (1, 'Subway', '100 Main St', 4);
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (2, 'Burger King', '200 Oak Ave', 3);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (1, 1, '2023-04-10 12:00:00', 12.50);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (1, 2, '2023-01-10 12:00:00', 9.75);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (1, 3, '2023-03-10 12:00:00', 15.00);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (1, 4, '2023-02-10 12:00:00', 8.25);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (2, 1, '2023-05-10 12:00:00', 11.00);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (2, 4, '2023-06-10 12:00:00', 14.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."resname" AS "resname", "RHS"."address" AS "address", "RHS"."rating" AS "rating" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resid" AS "resid", "RHS"."time" AS "time", "RHS"."spent" AS "spent" FROM "student" AS "LHS" INNER JOIN "visits_restaurant" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith')) AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."lname" = "RHS"."lname" AND "LHS"."fname" = "RHS"."fname" AND "LHS"."age" = "RHS"."age" AND "LHS"."sex" = "RHS"."sex" AND "LHS"."major" = "RHS"."major" AND "LHS"."advisor" = "RHS"."advisor" AND "LHS"."city_code" = "RHS"."city_code")) AS "LHS" INNER JOIN (SELECT * FROM "restaurant" WHERE ("resname" = 'Subway')) AS RHS ON (LHS.resid = RHS.resid)) ORDER BY TIME, "time" NULLS LAST;

/*
Gold Result:
('2023-02-10 12:00:00',)
('2023-03-10 12:00:00',)
('2023-04-10 12:00:00',)
*/

-- Prediction Query
SELECT TIME FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID JOIN Restaurant ON Visits_Restaurant.ResID = Restaurant.ResID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith' AND Restaurant.ResName = 'Subway';

/*
Prediction Result:
('2023-04-10 12:00:00',)
*/