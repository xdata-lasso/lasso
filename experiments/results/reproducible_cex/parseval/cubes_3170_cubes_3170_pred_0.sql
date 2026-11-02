-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Restaurant" ("ResID" INTEGER PRIMARY KEY, "ResName" TEXT(100), "Address" TEXT(100), "Rating" INTEGER);

CREATE TABLE "Type_Of_Restaurant" ("ResTypeID" INTEGER, "ResID" INTEGER, FOREIGN KEY ("ResTypeID") REFERENCES "Restaurant_Type" ("ResTypeID"), FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"));

CREATE TABLE "Restaurant_Type" ("ResTypeID" INTEGER PRIMARY KEY, "ResTypeName" TEXT(40), "ResTypeDescription" TEXT(100));

CREATE TABLE "Visits_Restaurant" ("ResID" INTEGER, "StuID" INTEGER, "Time" TIMESTAMP, "Spent" REAL, FOREIGN KEY ("ResID") REFERENCES "Restaurant" ("ResID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: restaurant --
INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (1, 'Subway', 'res_281969', 1);

INSERT INTO "restaurant" ("resid", "resname", "address", "rating") VALUES (-2147483647, 'Subway', 'res_3d3768', 1);

-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'A', '!', 1, 'stu_59b53a', 1, 1, 'stu_9c77e6');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'A', 'A', 1, 'stu_ca3cdc', 1, 1, 'stu_0b3921');

-- Inserting into table: visits_restaurant --
INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, -2147483647, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, NULL, 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "visits_restaurant" ("resid", "stuid", "time", "spent") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "resid" AS "count___" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."resname" AS "resname", "LHS"."address" AS "address", "LHS"."rating" AS "rating", "RHS"."n" AS "n" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."resname" AS "resname", "RHS"."address" AS "address", "RHS"."rating" AS "rating" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."resid" AS "resid", "LHS"."time" AS "time", "LHS"."spent" AS "spent", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM "visits_restaurant" AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith')) AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" INNER JOIN (SELECT * FROM "restaurant" WHERE ("resname" = 'Subway')) AS "RHS" ON ("LHS"."resid" = "RHS"."resid")) AS "LHS" INNER JOIN (SELECT "age", "fname", COUNT(*) AS "n" FROM "student" WHERE ("fname" <> 'Linda' OR "lname" = 'Smith') GROUP BY age, fname) AS RHS ON (LHS.fname = RHS.fname AND LHS.age = RHS.age)) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Student JOIN Visits_Restaurant ON Student.StuID = Visits_Restaurant.StuID JOIN Restaurant ON Visits_Restaurant.ResID = Restaurant.ResID WHERE Student.Fname = 'Linda' AND Student.Lname = 'Smith' AND Restaurant.ResName = 'Subway';

/*
Prediction Result:
(0,)
*/