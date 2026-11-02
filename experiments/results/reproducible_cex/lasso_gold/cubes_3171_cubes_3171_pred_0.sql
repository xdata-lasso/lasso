-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1008, 'Sean Blake', '4235 Christopher Court Suite 594
Lake Stephenville, MS 10829', 1009);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1010, 'Smith', 'Linda', 1011, 'old', 1012, 1013, 'Mariastad');
INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1008, 1010, '1971-02-02', 1016.5);
INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1008, 1010, '1971-02-02', 1019.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "spent" AS "sum_spent_" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."sumspent" AS "sumspent" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."sumspent" AS "sumspent" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resid" AS "resid", "RHS"."time" AS "time", "RHS"."spent" AS "spent" FROM "student" AS "LHS" INNER JOIN "visits_restaurant" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT "stuid", "resid", "time", "spent", SUM("spent") OVER () AS "sumspent" FROM "visits_restaurant") AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."resid" = "RHS"."resid" AND "LHS"."time" = "RHS"."time" AND "LHS"."spent" = "RHS"."spent")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" = 'Linda' AND "lname" = 'Smith')) AS RHS ON (LHS.stuid = RHS.stuid AND LHS.lname = RHS.lname AND LHS.fname = RHS.fname AND LHS.age = RHS.age AND LHS.sex = RHS.sex AND LHS.major = RHS.major AND LHS.advisor = RHS.advisor AND LHS.city_code = RHS.city_code)) ORDER BY sum_spent_;

/*
Gold Result:
(1016.5,)
(1019.5,)
*/

-- Prediction Query
SELECT SUM(Spent) FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith';

/*
Prediction Result:
(2036.0,)
*/