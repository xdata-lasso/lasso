-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests student filter boundary conditions: 'Linda' vs 'Smith' vs other names, AND vs OR mutations, and restaurant name filter.
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (1, 'Subway', '100 Main St', 5);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (2, 'Burger King', '200 Main St', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (3, 'Subway', '300 Oak St', 3);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Linda', 20, 'F', 101, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Jones', 'Linda', 21, 'F', 102, 1002, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Smith', 'John', 22, 'M', 103, 1003, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Doe', 'John', 23, 'M', 104, 1004, 'BOS');
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (1, 1, '2023-01-01 12:00:00', 10.5);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (3, 2, '2023-01-02 12:00:00', 12.0);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (1, 3, '2023-01-03 12:00:00', 8.0);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (3, 4, '2023-01-04 12:00:00', 9.5);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (2, 1, '2023-01-05 12:00:00', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "resid" AS "count___" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resname" AS "resname", "LHS"."address" AS "address", "LHS"."rating" AS "rating", "RHS"."n" AS "n" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resname" AS "resname", "RHS"."address" AS "address", "RHS"."rating" AS "rating" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "visits_restaurant" AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith')) AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "restaurant" WHERE ("resname" = 'Subway')) AS "RHS" ON ("LHS"."resid" = "RHS"."resid")) AS "LHS" INNER JOIN (SELECT "age", "fname", COUNT(*) AS "n" FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith') GROUP BY age, fname) AS RHS ON (LHS.fname = RHS.fname AND LHS.age = RHS.age)) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID JOIN Restaurant ON Visits_Restaurant.ResID = Restaurant.ResID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith' AND Restaurant.ResName = 'Subway';

/*
Prediction Result:
(1,)
*/