-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Doe', 'John', 20, 'M', 100, 200, 'NYC');
INSERT INTO Restaurant (ResID, ResName, Address, Rating) VALUES (1, 'Subway', '123 Main St', 5);
INSERT INTO Visits_Restaurant (ResID, StuID, Time, Spent) VALUES (1, 1, '2023-01-01 12:00:00', 10.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "resid" AS "count___" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resname" AS "resname", "LHS"."address" AS "address", "LHS"."rating" AS "rating", "RHS"."n" AS "n" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resname" AS "resname", "RHS"."address" AS "address", "RHS"."rating" AS "rating" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "visits_restaurant" AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith')) AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "restaurant" WHERE ("resname" = 'Subway')) AS "RHS" ON ("LHS"."resid" = "RHS"."resid")) AS "LHS" INNER JOIN (SELECT "age", "fname", COUNT(*) AS "n" FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith') GROUP BY age, fname) AS RHS ON (LHS.fname = RHS.fname AND LHS.age = RHS.age)) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID JOIN Restaurant ON Visits_Restaurant.ResID = Restaurant.ResID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith' AND Restaurant.ResName = 'Subway';

/*
Prediction Result:
(0,)
*/