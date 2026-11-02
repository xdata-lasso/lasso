-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'Linda', 20, 'F', 600, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Brown', 'Linda', 21, 'F', 600, 1121, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Smith', 'John', 22, 'M', 520, 1148, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Linda', 'Smith', 19, 'F', 520, 1148, 'LAX');
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (1, 'Burger King', '100 Main St', 3);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (2, 'Subway', '200 Oak Ave', 4);
INSERT INTO "Restaurant" ("ResID", "ResName", "Address", "Rating") VALUES (3, 'Taco Bell', '300 Pine Rd', 2);
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (1, 'Fast Food', 'Quick service');
INSERT INTO "Restaurant_Type" ("ResTypeID", "ResTypeName", "ResTypeDescription") VALUES (2, 'Sandwich', 'Subs and wraps');
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 1);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (1, 2);
INSERT INTO "Type_Of_Restaurant" ("ResTypeID", "ResID") VALUES (2, 2);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (1, 1, '2023-03-10 12:00:00', 45.5);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (2, 1, '2023-03-11 13:30:00', 9.75);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (3, 1, '2023-03-12 19:00:00', 20.0);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (1, 2, '2023-03-10 14:00:00', 100.0);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (2, 3, '2023-03-11 18:00:00', 85.25);
INSERT INTO "Visits_Restaurant" ("ResID", "StuID", "Time", "Spent") VALUES (3, 4, '2023-03-12 20:00:00', 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "spent" AS "sum_spent_" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."sumspent" AS "sumspent" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."sumspent" AS "sumspent" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resid" AS "resid", "RHS"."time" AS "time", "RHS"."spent" AS "spent" FROM "student" AS "LHS" INNER JOIN "visits_restaurant" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT "stuid", "resid", "time", "spent", SUM("spent") OVER () AS "sumspent" FROM "visits_restaurant") AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."resid" = "RHS"."resid" AND "LHS"."time" = "RHS"."time" AND "LHS"."spent" = "RHS"."spent")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" = 'Linda' AND "lname" = 'Smith')) AS RHS ON (LHS.stuid = RHS.stuid AND LHS.lname = RHS.lname AND LHS.fname = RHS.fname AND LHS.age = RHS.age AND LHS.sex = RHS.sex AND LHS.major = RHS.major AND LHS.advisor = RHS.advisor AND LHS.city_code = RHS.city_code)) ORDER BY sum_spent_;

/*
Gold Result:
(9.75,)
(20.0,)
(45.5,)
*/

-- Prediction Query
SELECT SUM(Spent) FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith';

/*
Prediction Result:
(75.25,)
*/