-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Linda', 20, 'F', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Smith', 'John', 21, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Doe', 'Linda', 22, 'F', 500, 1122, 'NYC');
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (101, 'Subway', '123 Main St', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (102, 'Bistro', '456 Oak Ave', 5);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (101, 1, '2023-01-01 12:00:00', 25.5);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (102, 1, '2023-01-02 18:30:00', 10.0);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (101, 2, '2023-01-01 13:00:00', 15.0);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (102, 3, '2023-01-03 19:00:00', 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "spent" AS "sum_spent_" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."sumspent" AS "sumspent" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."sumspent" AS "sumspent" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resid" AS "resid", "RHS"."time" AS "time", "RHS"."spent" AS "spent" FROM "student" AS "LHS" INNER JOIN "visits_restaurant" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT "stuid", "resid", "time", "spent", SUM("spent") OVER () AS "sumspent" FROM "visits_restaurant") AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."resid" = "RHS"."resid" AND "LHS"."time" = "RHS"."time" AND "LHS"."spent" = "RHS"."spent")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" = 'Linda' AND "lname" = 'Smith')) AS RHS ON (LHS.stuid = RHS.stuid AND LHS.lname = RHS.lname AND LHS.fname = RHS.fname AND LHS.age = RHS.age AND LHS.sex = RHS.sex AND LHS.major = RHS.major AND LHS.advisor = RHS.advisor AND LHS.city_code = RHS.city_code)) ORDER BY sum_spent_;

/*
Gold Result:
(10.0,)
(25.5,)
*/

-- Prediction Query
SELECT SUM(Spent) FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith';

/*
Prediction Result:
(35.5,)
*/